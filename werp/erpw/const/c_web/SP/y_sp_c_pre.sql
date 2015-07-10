/* ============================================================================= */
/* 함수명 : y_sp_c_pre                                                      */
/* 기  능 : 추정완성금액 계산(단가/수량 구하기)        .                   */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 일자                   ==> ad_date      (date)                       */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                               */
/* 작성일 : 2005.04.10                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_pre(as_dept_code    IN   VARCHAR2,
                                            adt_yymm        IN   DATE ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
	C_DATE			 DATE;
   C_CHK           VARCHAR2(1);
   C_CNT           NUMBER(10,3);
   C_PERSON        NUMBER(20,1);
   C_SEQ           INTEGER        DEFAULT 0;
   C_UNQ_NUMBER    NUMBER(18,0);
BEGIN

   BEGIN
     
		select C_UNQ_NUM.nextval
		  into C_UNQ_NUMBER
		  from dual;

			INSERT INTO C_SPEC_CONST_CAL_TMP     -- update를 편하게하기위해서 템포러리 테이블 사용 
		     select
               C_UNQ_NUMBER,
               b.dept_code,
               adt_yymm,
               b.spec_unq_num,
               sum(b.cost_qty) cost_qty,
               sum(b.cost_mat_amt) cost_mat_amt,
               sum(b.cost_lab_amt) cost_lab_amt,
               0  cost_equ_amt,
               sum(b.cost_sub_amt) cost_sub_amt,
               sum(b.cost_exp_amt) cost_exp_amt,
               '',
               '',
               '',
					0 result_qty,
					0 result_amt 
           from (   
-- 자재  평균단가 구하기  
                SELECT C.dept_code,
                         C.spec_unq_num,
                         0 cost_qty,
                         decode(nvl(b.qty,0),0,c.mat_price,trunc(b.amt / b.qty,0)) cost_mat_amt,
                         0 cost_lab_amt,
                         0 cost_equ_amt,
                         0 cost_sub_amt,
                         0 cost_exp_amt,
								 0 result_qty,
								 0 result_amt
							  from
									(
									select dept_code, spec_unq_num,sum(qty) qty,sum(amt) amt from 
									       m_input_detail
									where dept_code = as_dept_code
									and  yymmdd < add_months(adt_yymm,1)
									group by
										dept_code, spec_unq_num
									order by dept_code,spec_unq_num
									)b,
							       y_budget_detail c,
							       C_SPEC_CONST_DETAIL d
							 where b.dept_code   = c.dept_code 
								and b.spec_unq_num  = c.spec_unq_num
							   and c.dept_code = as_dept_code
								and c.chg_no_seq = 0
								and c.unit <> '식'
								and c.dept_code  = d.dept_code
								and c.spec_unq_num  = d.spec_unq_num
								and d.yymm  = adt_yymm
								and d.sup_unit_fix = 'F' 
                 union all		
-- 외주 평균단가 구하기                  
                 SELECT c.dept_code,
                        c.spec_unq_num,
                        0,
                        0,
                        0,
                        0,
                        decode(nvl(b.sub_qty,0),0,c.sub_price,trunc(b.sub_amt / b.sub_qty,0)) sub_price,
						      0,0,0
							  from (
							        select dept_code,spec_unq_num,sum(sub_qty) sub_qty, sum(sub_amt) sub_amt
							           from s_cn_detail
							           where dept_code = as_dept_code
							           group by dept_code,spec_unq_num
                                ORDER BY DEPT_CODE,SPEC_UNQ_NUM
							        ) b,     
							       y_budget_detail c,
							       C_SPEC_CONST_DETAIL d
							 where c.dept_code = as_dept_code
								and c.chg_no_seq = 0
								and c.unit <> '식'
								and c.dept_code  = d.dept_code
								and c.spec_unq_num  = d.spec_unq_num
								and d.yymm  = adt_yymm
								and d.sup_unit_fix = 'F' 
								and b.dept_code   = c.dept_code 
								and b.spec_unq_num  = c.spec_unq_num
                         ) b
          group by b.dept_code,
                   b.spec_unq_num ;								 
 -- 추정 완성 단가  
		UPDATE c_spec_const_detail  a
		  SET (a.sup_unit_amt) = 
            ( SELECT decode(b.cost_mat_amt,0,b.cost_sub_amt,b.cost_mat_amt) 
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num 
                        and b.dept_code = as_dept_code
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER 
								and (a.sup_unit_fix <> 'T' ) )
		 WHERE a.dept_code = as_dept_code
			AND a.yymm      = adt_yymm
			and (a.sup_unit_fix <> 'T')
			AND EXISTS (SELECT decode(b.cost_mat_amt,0,b.cost_sub_amt,b.cost_mat_amt) 
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num 
                        and b.dept_code = as_dept_code
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER 
								and (a.sup_unit_fix <> 'T') ) ;
								
								
    delete from c_spec_const_cal_tmp where detail_unq_num = C_UNQ_NUMBER;										

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '추정단가(외주비)! [Line No: 2]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
   END;
   BEGIN                       
   
		UPDATE c_spec_const_detail  a
		   SET a.pre_result_amt = a.sup_unit_amt * a.sup_qty
		 WHERE a.dept_code = as_dept_code
			AND a.yymm      = adt_yymm;
   
	
-- 기성금액(금액 베이스로 계산),추정 금액  구하기
		UPDATE c_spec_const_detail 
		  SET pre_result_rate = decode(amt,0,0,decode(sign(trunc(pre_result_amt / amt * 100,0) - 999),
		                                 1,999,trunc(pre_result_amt / amt * 100,0))),
				result_amt = decode(pre_result_amt,0,0,decode(sign(((ls_cost_amt + cost_amt) / pre_result_amt) - 1),1,trunc(amt - ls_result_amt,0),
							 					  round(((ls_cost_amt + cost_amt) / pre_result_amt) * amt - ls_result_amt,0))),
				cnt_result_amt = decode(pre_result_amt,0,0,decode(sign(((ls_cost_amt + cost_amt) / pre_result_amt) - 1),1,trunc(cnt_amt - ls_cnt_result_amt,0),
							 					  round(((ls_cost_amt + cost_amt) / pre_result_amt) * cnt_amt - ls_cnt_result_amt,0)))
		 WHERE dept_code = as_dept_code
			AND yymm      = adt_yymm;

-- 기성률
		
		UPDATE c_spec_const_detail  
		  SET  result_rate = decode(amt,0,0,decode(sign(trunc((result_amt + ls_result_amt) / amt * 100,2) - 100),
									1,100 - ls_result_rate,trunc((result_amt + ls_result_amt) / amt * 100,2) - ls_result_rate )),
		       cnt_result_rate = decode(cnt_amt,0,0,decode(sign(trunc((cnt_result_amt + ls_cnt_result_amt) / cnt_amt * 100,2) - 100),
									1,100 - ls_cnt_result_rate,trunc((cnt_result_amt + ls_cnt_result_amt) / cnt_amt * 100,2) - ls_cnt_result_rate )),
		       cost_rate = decode((result_amt + ls_result_amt),0,0,decode(sign(trunc((cost_amt + ls_cost_amt) / (result_amt + ls_result_amt) * 100,2) - 999),
									1,999,trunc((cost_amt + ls_cost_amt) / (result_amt + ls_result_amt) * 100,2) - ls_cost_rate ))
		 WHERE dept_code = as_dept_code
			AND yymm      = adt_yymm;

-- 기성수량
		
		UPDATE c_spec_const_detail  
		  SET  result_qty = trunc(ROUND(qty * decode(amt,0,0,decode(sign(((result_amt + ls_result_amt) / amt * 100) - 100),
									1,100 - ls_result_rate,((result_amt + ls_result_amt) / amt * 100) - ls_result_rate )) * 0.01,9),3),
		       cnt_result_qty = trunc(ROUND(cnt_qty * decode(cnt_amt,0,0,decode(sign(((cnt_result_amt + ls_cnt_result_amt) / cnt_amt * 100) - 100),
									1,100 - ls_cnt_result_rate,((cnt_result_amt + ls_cnt_result_amt) / cnt_amt * 100) - ls_cnt_result_rate )) * 0.01,9),3)
		 WHERE dept_code = as_dept_code
			AND yymm      = adt_yymm;


      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '추정완성금액 ! [Line No: 2]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
   END;

   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   
   -- ENDING...[0.1] CURSOR CLOSE 재 확인 처리 !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- 사용자 정의 Error Message
      Wk_errflag := 0;                         -- 사용자 정의 Error Code
   ELSE 
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;

EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END y_sp_c_pre;

/
