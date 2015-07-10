/* ============================================================================= */
/* 함수명 : y_sp_c_cost_summary                                                  */
/* 기  능 : 원가집계 금월원가자료를생성.  							                  */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 일자                   ==> ad_date      (date)                       */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                               */
/* 작성일 : 2005.05.26                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_cost_summary(as_dept_code    IN   VARCHAR2,
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
   C_SEQ           INTEGER        DEFAULT 0;
   C_UNQ_NUMBER    NUMBER(18,0);
BEGIN
   BEGIN
		update c_spec_const_detail         --원가 컬럼 zero set
			set cost_qty = 0,
				 cost_amt = 0,
				 cost_mat_amt = 0,
				 cost_sub_amt = 0,
				 cost_lab_amt = 0,
				 cost_equ_amt = 0,
				 cost_exp_amt = 0,
				 cost_rate = 0
		 where dept_code = as_dept_code
			and yymm = adt_yymm;

		update c_spec_const_parent
			set cost_qty = 0,
				 cost_amt = 0,
				 cost_mat_amt = 0,
				 cost_sub_amt = 0,
				 cost_lab_amt = 0,
				 cost_equ_amt = 0,
				 cost_exp_amt = 0,
				 cost_rate = 0
		 where dept_code = as_dept_code
			and yymm = adt_yymm;

      EXCEPTION
      WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '해당월 자료초기화 실패! [Line No: 1]';
           Wk_errflag := -20020;
        
           GOTO EXIT_ROUTINE;
        END IF;   
   END;
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
               '' 
           from (                 
-- 노무비 자료 집계        
						  SELECT a.dept_code,
						         a.spec_unq_num,
						         0 cost_qty,
						         0 cost_mat_amt,
						         nvl(sum(a.pay_amt),0) cost_lab_amt,
						         0 cost_equ_amt,
						         0 cost_sub_amt,
						         0 cost_exp_amt
							  from l_labor_dailywork a
							 where a.dept_code    = as_dept_code 
							   and a.work_date >= adt_yymm
							   and a.work_date < add_months(adt_yymm,1)
						 group by a.dept_code,
									 a.spec_unq_num  
-- 노무비중 퇴직금액 									 
                union all
						  SELECT a.dept_code,
						         a.spec_unq_num,
						         0 cost_qty,
						         0 cost_mat_amt,
						         nvl(sum(a.resign_amt),0) cost_lab_amt,
						         0 cost_equ_amt,
						         0 cost_sub_amt,
						         0 cost_exp_amt
							  from l_resignation a
							 where a.dept_code    = as_dept_code 
							   and a.resign_date >= adt_yymm
							   and a.resign_date < add_months(adt_yymm,1)
						 group by a.dept_code,
									 a.spec_unq_num  
                union all
-- 예비비정산  자료 집계        
						  SELECT a.dept_code,
						         a.spec_unq_num,
						         0,
						         nvl(sum(decode(a.res_type,'M',a.amt,0)),0),
						         nvl(sum(decode(a.res_type,'L',a.amt,0)),0),
						         0,
						         nvl(sum(decode(a.res_type,'S',a.amt,0)),0),
						         nvl(sum(decode(a.res_type,'X',a.amt,0)),0)
							  from f_request a
							 where a.dept_code    = as_dept_code 
							   and a.rqst_date >= adt_yymm
							   and a.rqst_date < add_months(adt_yymm,1)
								and a.cost_type = '1'
						 group by a.dept_code,
									 a.spec_unq_num 
                union all
-- 미지급   자료 집계        
						  SELECT a.dept_code,
						         a.spec_unq_num,
						         0,
						         nvl(sum(decode(a.res_type,'M',a.amt,0)),0),
						         nvl(sum(decode(a.res_type,'L',a.amt,0)),0),
						         0,
						         nvl(sum(decode(a.res_type,'S',a.amt,0)),0),
						         nvl(sum(decode(a.res_type,'X',a.amt,0)),0)
							  from f_nopay_request a
							 where a.dept_code    = as_dept_code 
							   and a.request_date >= adt_yymm
							   and a.request_date < add_months(adt_yymm,1)
						 group by a.dept_code,
									 a.spec_unq_num 
                union all
-- 본사분  자료 집계        
						  SELECT a.dept_code,
						         a.spec_unq_num,
						         0,
						         0,
						         0,
						         0,
						         0,
						         nvl(sum(a.amt),0)
							  from c_invest_detail a
							 where a.dept_code    = as_dept_code 
							   and a.yymm >= adt_yymm
							   and a.yymm < add_months(adt_yymm,1)
						 group by a.dept_code,
									 a.spec_unq_num 
					union all				 
-- 자재비 자료 집계        
						  SELECT b.dept_code,
						         b.spec_unq_num,
						         nvl(sum(decode(c.unit,'식',0,decode(d.mat_unit_fix,'T',0,b.qty))),0),
						         NVL(SUM(b.amt),0),
						         0,
						         0,
						         0,
						         0
							  from m_output_detail b,
							       y_budget_detail c,
							       C_SPEC_CONST_DETAIL d
							 where b.dept_code    = as_dept_code
							   and b.yymmdd >= adt_yymm
							   and b.yymmdd < add_months(adt_yymm,1)
								and b.dept_code = c.dept_code
								and c.chg_no_seq = 0
								and b.spec_unq_num = c.spec_unq_num 
								and (b.INOUTTYPECODE = '2' or b.INOUTTYPECODE = '7')
								and b.dept_code = d.dept_code
								and b.spec_unq_num = d.spec_unq_num
								and d.yymm  = adt_yymm
						 group by b.dept_code,
									 b.spec_unq_num 
					union all				 
-- 자재비 손료  집계        
						  SELECT b.dept_code,
						         b.spec_unq_num,
						         nvl(sum(decode(c.unitcode,'식',0,decode(d.mat_unit_fix,'T',0,b.qty))),0),
						         NVL(SUM(b.amt + b.vatamt),0),
						         0,
						         0,
						         0,
						         0
							  from m_tmat_proj_rent b,
							       m_tmat_stock c,
							       C_SPEC_CONST_DETAIL d
							 where b.dept_code    = as_dept_code
							   and b.month= adt_yymm
								and b.dept_code = c.dept_code
                        and b.yymmdd = c.yymmdd
                        and b.seq = c.seq
                        and b.input_unq_num = c.input_unq_num
								and b.dept_code = d.dept_code
								and b.spec_unq_num = d.spec_unq_num
								and d.yymm  = adt_yymm
						 group by b.dept_code,
									 b.spec_unq_num 
					union all				 
-- 외주비 자료 집계        
						  SELECT c.dept_code,
						         c.spec_unq_num, 
						         nvl(sum(decode(c.unit,'식',0,decode(d.mat_unit_fix,'T',0,b.tm_prgs_qty))),0),
						         nvl(sum(decode(e.order_class,'2',b.tm_prgs_amt,0)),0),
						         0,
						         0,
						         nvl(sum(decode(e.order_class,'1',b.tm_prgs_amt,0)),0),
                           0
							  from s_prgs_detail b,
									 s_cn_detail c,
							       C_SPEC_CONST_DETAIL d,
									 s_cn_list e
							 where b.dept_code      = e.dept_code
							   and b.order_number   = e.order_number
                        and b.dept_code      = c.dept_code
								and b.order_number   = c.order_number 
								and b.spec_no_seq    = c.spec_no_seq 
								and b.detail_unq_num = c.detail_unq_num
								and c.dept_code      = d.dept_code
								and c.spec_unq_num   = d.spec_unq_num
								and b.yymm           = d.yymm
								and b.dept_code      = as_dept_code
								and b.yymm = adt_yymm
						 group by c.dept_code,
									 c.spec_unq_num ) b
          group by b.dept_code,
                   b.spec_unq_num ;		
-- 투입금액 구하기                    							 
		UPDATE c_spec_const_detail  a
		  SET (a.cost_qty,a.cost_mat_amt,a.cost_lab_amt,a.cost_equ_amt,a.cost_sub_amt,a.cost_exp_amt,cost_amt ) =
            ( SELECT b.cost_qty,b.cost_mat_amt,b.cost_lab_amt,b.cost_equ_amt,b.cost_sub_amt,b.cost_exp_amt,
                        b.cost_mat_amt+b.cost_lab_amt+b.cost_equ_amt+b.cost_sub_amt+b.cost_exp_amt
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num
								and b.dept_code = as_dept_code
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER)
		 WHERE a.dept_code = as_dept_code
			AND a.yymm      = adt_yymm
			AND EXISTS (SELECT b.cost_qty
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num 
								and b.dept_code = as_dept_code 
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER );

    delete from c_spec_const_cal_tmp where detail_unq_num = C_UNQ_NUMBER;										
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '원가투입집계작업 실패! [Line No: 2]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
   END;
   BEGIN
     -- 투입 수량 구하기    
		UPDATE c_spec_const_detail     -- cost_qty는 위에서 외주나 자재일경우는 미리 구했으므로 0 일경우에만 금액으로 qty계산
		  SET cost_qty  = decode(cost_qty,0,decode(amt,0,0,trunc(nvl(qty,0) * ( nvl(cost_amt,0) / amt ),3)),cost_qty)
		 WHERE dept_code = as_dept_code
		   AND yymm      = adt_yymm;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '원가내역 집계작업 실패! [Line No: 2]';
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
END y_sp_c_cost_summary;

/
