/* ============================================================================= */
/* 함수명 : y_sp_c_transfer                                                      */
/* 기  능 : 원가집계시 전월자료를 이월하여 금월원가자료를생성.                   */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 일자                   ==> ad_date      (date)                       */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                               */
/* 작성일 : 2003.05.26                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_transfer(as_dept_code    IN   VARCHAR2,
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
		select count(*)
		  into C_CNT
		  from c_spec_const_closing
		 where dept_code = as_dept_code
			and yymm = adt_yymm;

		IF C_CNT < 1 THEN         --해당월에 마감테이블레코드가 없으면 삽입. 
			insert into c_spec_const_closing
				values ( as_dept_code,adt_yymm,'N','N','N','N','N','N','N','','','' );
		END IF;

		select count(*)
		  into C_CNT
		  from c_spec_const_input
		 where dept_code = as_dept_code
			and yymm = adt_yymm;

		IF C_CNT < 1 THEN         --해당월에 마감테이블레코드가 없으면 삽입. 
			insert into c_spec_const_input
				values ( as_dept_code,adt_yymm,'','','','','','','','','','','','','',0,'' );
		END IF;
		
		select count(*)
		  into C_CNT
		  from c_spec_const_closing
		 where dept_code = as_dept_code
			and yymm < adt_yymm;

		IF C_CNT > 0 THEN              --전월 최종월을 구함 
			select max(yymm)
			  into C_DATE
			  from c_spec_const_closing
			 where dept_code = as_dept_code
				and yymm < adt_yymm;
			C_CHK := 'Y';                --전월이 존재한다. 
		ELSE
			C_CHK := 'N';
		END IF;
   --당월의 단가고정및 금액기준단가 고정을 복사(원가 재작업시 그전에 입력된 단가고정과 금액기준고정을 복사해놓음. 
		select C_UNQ_NUM.nextval
		  into C_UNQ_NUMBER
		  from dual;

			INSERT INTO C_SPEC_CONST_CAL_TMP     -- update를 편하게하기위해서 템포러리 테이블 사용 
		     select
               C_UNQ_NUMBER,
               as_dept_code,
               adt_yymm,
               a.spec_unq_num,
               a.sup_qty cost_qty,
               a.sup_unit_amt cost_mat_amt,  -- 준공추정단가 
               a.pre_result_amt cost_lab_amt,
               0  cost_equ_amt,
               0 cost_sub_amt,
               0 cost_exp_amt,
               a.sup_unit_fix,
               a.mat_unit_fix,
               a.remark ,
					0 result_qty,
					0 result_amt
          from C_SPEC_CONST_DETAIL a
          WHERE dept_code = as_dept_code
              AND a.yymm      = adt_yymm;


 -- 당월분 원가 집계 테이블 삭제..
      DELETE FROM C_SPEC_CONST_DETAIL                
            WHERE dept_code = as_dept_code
              AND yymm      = adt_yymm;

      DELETE FROM c_spec_const_parent  
            WHERE dept_code = as_dept_code
              AND yymm      = adt_yymm;

      EXCEPTION
      WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '해당월 자료삭제 실패! [Line No: 1]';
           Wk_errflag := -20020;
        
           GOTO EXIT_ROUTINE;
        END IF;   
   END;
   BEGIN
		IF C_CHK = 'Y' THEN        -- 전월이 존재하면 전월자료를 복사하면서 전월까지 누계구한후 삽입.
			INSERT INTO c_spec_const_parent
				  select as_dept_code,adt_yymm,a.spec_no_seq,
							0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
							a.wbs_code,0,0,
							NVL(b.ls_cnt_result_qty,0)     + NVL(b.cnt_result_qty,0),    
							NVL(b.ls_cnt_result_amt,0)     + NVL(b.cnt_result_amt,0),
							NVL(b.ls_cnt_result_mat_amt,0) + NVL(b.cnt_result_mat_amt,0),
							NVL(b.ls_cnt_result_lab_amt,0) + NVL(b.cnt_result_lab_amt,0),
							NVL(b.ls_cnt_result_exp_amt,0) + NVL(b.cnt_result_exp_amt,0),
							NVL(b.ls_cnt_result_rate,0)    + NVL(b.cnt_result_rate,0),
							NVL(b.ls_result_qty,0)         + NVL(b.result_qty,0),        
							NVL(b.ls_result_amt,0)         + NVL(b.result_amt,0),
							NVL(b.ls_result_mat_amt,0)     + NVL(b.result_mat_amt,0),    
							NVL(b.ls_result_sub_amt,0)     + NVL(b.result_sub_amt,0),
							NVL(b.ls_result_lab_amt,0)     + NVL(b.result_lab_amt,0),    
							NVL(b.ls_result_equ_amt,0)     + NVL(b.result_equ_amt,0),
							NVL(b.ls_result_exp_amt,0)     + NVL(b.result_exp_amt,0),   
                     DECODE(SIGN(999 - (NVL(b.ls_result_rate,0) + NVL(b.result_rate,0))),-1,999,NVL(b.ls_result_rate,0) + NVL(b.result_rate,0)),						  
							NVL(b.ls_cost_qty,0)           + NVL(b.cost_qty,0),          
							NVL(b.ls_cost_amt,0)           + NVL(b.cost_amt,0),
							NVL(b.ls_cost_mat_amt,0)       + NVL(b.cost_mat_amt,0),      
							NVL(b.ls_cost_sub_amt,0)       + NVL(b.cost_sub_amt,0),
							NVL(b.ls_cost_lab_amt,0)       + NVL(b.cost_lab_amt,0),      
							NVL(b.ls_cost_equ_amt,0)       + NVL(b.cost_equ_amt,0),
							NVL(b.ls_cost_exp_amt,0)       + NVL(b.cost_exp_amt,0),      
                     DECODE(SIGN(999 - (NVL(b.ls_cost_rate,0) + NVL(b.cost_rate,0))),-1,999,NVL(b.ls_cost_rate,0) + NVL(b.cost_rate,0)),							  
							0,0,
							a.amt,a.mat_amt,a.lab_amt,a.exp_amt,a.equ_amt,a.sub_amt,
							a.cnt_amt,a.cnt_mat_amt,a.cnt_lab_amt,a.cnt_exp_amt
					 from y_budget_parent a,
							c_spec_const_parent b
					where a.dept_code = b.dept_code (+)
					  and a.chg_no_seq = 0
					  and a.spec_no_seq  = b.spec_no_seq (+)
					  and b.yymm (+)  = C_DATE
					  and a.dept_code = as_dept_code;
		ELSE
			INSERT INTO c_spec_const_parent
				  select as_dept_code,adt_yymm,a.spec_no_seq,
							0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
							a.wbs_code,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
							a.amt,a.mat_amt,a.lab_amt,a.exp_amt,a.equ_amt,a.sub_amt,
							a.cnt_amt,a.cnt_mat_amt,a.cnt_lab_amt,a.cnt_exp_amt
					 from y_budget_parent a
					where a.chg_no_seq = 0
					  and a.dept_code = as_dept_code;
		END IF;

        
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '원가집계 이월작업(상위) 실패! [Line No: 2]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
   END;
   BEGIN
      IF C_CHK = 'Y' THEN           -- 준공추정수량 (현실행수량 과 전월의 실행수량이 같으면 전월의 추정수량이고 같지않으면 현실행수량) 
         INSERT INTO c_spec_const_detail
              select as_dept_code,adt_yymm,a.spec_no_seq,a.spec_unq_num,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                     '',b.pre_result_amt,b.pre_result_rate,
                     NVL(b.ls_cnt_result_qty,0)     + NVL(b.cnt_result_qty,0),    
                     NVL(b.ls_cnt_result_amt,0)     + NVL(b.cnt_result_amt,0),
                     NVL(b.ls_cnt_result_mat_amt,0) + NVL(b.cnt_result_mat_amt,0),
                     NVL(b.ls_cnt_result_lab_amt,0) + NVL(b.cnt_result_lab_amt,0),
                     NVL(b.ls_cnt_result_exp_amt,0) + NVL(b.cnt_result_exp_amt,0),
                     NVL(b.ls_cnt_result_rate,0)    + NVL(b.cnt_result_rate,0),
                     NVL(b.ls_result_qty,0)         + NVL(b.result_qty,0),        
                     NVL(b.ls_result_amt,0)         + NVL(b.result_amt,0),
                     NVL(b.ls_result_mat_amt,0)     + NVL(b.result_mat_amt,0),    
                     NVL(b.ls_result_sub_amt,0)     + NVL(b.result_sub_amt,0),
                     NVL(b.ls_result_lab_amt,0)     + NVL(b.result_lab_amt,0),    
                     NVL(b.ls_result_equ_amt,0)     + NVL(b.result_equ_amt,0),
                     NVL(b.ls_result_exp_amt,0)     + NVL(b.result_exp_amt,0), 
                     DECODE(SIGN((NVL(b.ls_result_rate,0) + NVL(b.result_rate,0)) - 999),1,999,DECODE(SIGN((NVL(b.ls_result_rate,0) + NVL(b.result_rate,0)) + 999),-1,-999,NVL(b.ls_result_rate,0) + NVL(b.result_rate,0))),						  
                     NVL(b.ls_cost_qty,0)           + NVL(b.cost_qty,0),          
                     NVL(b.ls_cost_amt,0)           + NVL(b.cost_amt,0),
                     NVL(b.ls_cost_mat_amt,0)       + NVL(b.cost_mat_amt,0),      
                     NVL(b.ls_cost_sub_amt,0)       + NVL(b.cost_sub_amt,0),
                     NVL(b.ls_cost_lab_amt,0)       + NVL(b.cost_lab_amt,0),      
                     NVL(b.ls_cost_equ_amt,0)       + NVL(b.cost_equ_amt,0),
                     NVL(b.ls_cost_exp_amt,0)       + NVL(b.cost_exp_amt,0),      
                     decode(sign((NVL(b.ls_cost_rate,0) + NVL(b.cost_rate,0)) - 999),1,999,decode(sign((NVL(b.ls_cost_rate,0) + NVL(b.cost_rate,0)) + 999),-1,-999,NVL(b.ls_cost_rate,0) + NVL(b.cost_rate,0))),
                     b.sup_qty,  -- 준공 추정 수량 
                     b.sup_unit_amt,      -- 준공 추정 단가 
                     b.sup_unit_fix,
                     a.qty,
                     a.price,
							a.amt,a.mat_price,a.mat_amt,a.lab_price,a.lab_amt,a.exp_price,a.exp_amt,a.equ_price,a.equ_amt,a.sub_price,a.sub_amt,
							a.cnt_qty,a.cnt_price,a.cnt_amt,a.cnt_mat_price,a.cnt_mat_amt,a.cnt_lab_price,a.cnt_lab_amt,a.cnt_exp_price,a.cnt_exp_amt,
							NVL(b.mat_unit_fix,'F'),b.remark    -- 실행단가 적용여부 
                from y_budget_detail a,
                     c_spec_const_detail b
               where a.dept_code    = b.dept_code (+)
                 and a.spec_no_seq  = b.spec_no_seq (+)
                 and a.spec_unq_num = b.spec_unq_num (+)
					  and a.chg_no_seq   = 0
                 and b.yymm (+)     = C_DATE
                 and a.dept_code    = as_dept_code;
		ELSE
         INSERT INTO c_spec_const_detail
              select as_dept_code,adt_yymm,a.spec_no_seq,a.spec_unq_num,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
							'',a.amt,100,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
							a.qty,   -- 준공추정수량
							a.price, -- 준공추정단가 
							'F',
							a.qty,
							a.price,
							a.amt,a.mat_price,a.mat_amt,a.lab_price,a.lab_amt,a.exp_price,a.exp_amt,a.equ_price,a.equ_amt,a.sub_price,a.sub_amt,
							a.cnt_qty,a.cnt_price,a.cnt_amt,a.cnt_mat_price,a.cnt_mat_amt,a.cnt_lab_price,a.cnt_lab_amt,a.cnt_exp_price,a.cnt_exp_amt,
							'F',''
                from y_budget_detail a
               where a.chg_no_seq   = 0
                 and a.dept_code    = as_dept_code;

      END IF;
   --위에서 복사된 당월의 단가고정및 금액기준단가 고정 당월에 다시 보관   

		UPDATE c_spec_const_detail  a
		  SET (a.sup_unit_fix,a.mat_unit_fix,a.remark) = 
            ( SELECT NVL(b.sup_unit_fix,'F'),NVL(b.mat_unit_fix,'F'),b.remark
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num 
                        and b.dept_code = as_dept_code
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER )
		 WHERE a.dept_code = as_dept_code
			AND a.yymm      = adt_yymm
			AND EXISTS ( SELECT b.sup_unit_fix,b.mat_unit_fix 
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num 
                        and b.dept_code = as_dept_code
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER );

     -- 준공추정단가 복귀 
		UPDATE c_spec_const_detail  a
		  SET (a.sup_unit_amt,a.sup_qty,a.pre_result_amt ) = 
            ( SELECT b.cost_mat_amt,b.cost_qty,b.cost_lab_amt
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num 
                        and b.dept_code = as_dept_code
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER )
		 WHERE a.dept_code = as_dept_code
			AND a.yymm      = adt_yymm
			AND EXISTS ( SELECT b.cost_mat_amt
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num 
                        and b.dept_code = as_dept_code
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER );

    delete from c_spec_const_cal_tmp where detail_unq_num = C_UNQ_NUMBER;										
	IF adt_yymm < to_date('2006.04.01') THEN
		y_sp_c_cost_summary_tmp(as_dept_code,adt_yymm);
	ELSE
		y_sp_c_cost_summary(as_dept_code,adt_yymm);
	END IF;
	y_sp_c_pre(as_dept_code,adt_yymm);
	y_sp_c_summary_cmpt(as_dept_code,adt_yymm);
        
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '원가내역 이월작업(하위) 실패! [Line No: 2]';
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
END y_sp_c_transfer;

/
