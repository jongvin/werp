/* ============================================================================= */
/* 함수명 : y_sp_s_prgs_close                                                    */
/* 기  능 : 외주기성정산 처리.                                                   */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 기성년월               ==> adt_yymm(datetime)                        */
/*        : 기성순번               ==> ai_seq(Integer)                           */
/*        : 발주번호               ==> ai_order_number(Integer)                  */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.04.28                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_prgs_close(as_dept_code    IN   VARCHAR2,
                                             adt_yymm        IN   DATE,
                                             ai_seq          IN   INTEGER,
                                             ai_order_number IN   INTEGER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   C_CNT                   NUMBER(20,5);  -- 
   C_RT                    NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
		C_RT := 100;

		UPDATE s_prgs_detail  a
		  SET (a.tot_prgs_qty,a.tot_prgs_amt,a.tot_prgs_rt ) =
            ( SELECT b.sub_qty,b.sub_amt,C_RT
							  from s_cn_detail b
							 where a.dept_code    = b.dept_code 
                        and a.order_number = b.order_number
								and a.spec_no_seq  = b.spec_no_seq
								and a.detail_unq_num = b.detail_unq_num 
								and a.dept_code    = as_dept_code
								and a.yymm         = adt_yymm
								and a.seq          = ai_seq
								and a.order_number = ai_order_number)
		 WHERE a.dept_code    = as_dept_code
			AND a.yymm         = adt_yymm
			AND a.seq          = ai_seq
			AND a.order_number = ai_order_number
			AND EXISTS (SELECT b.sub_qty
							  from s_cn_detail b
							 where a.dept_code    = b.dept_code 
                        and a.order_number = b.order_number
								and a.spec_no_seq  = b.spec_no_seq
								and a.detail_unq_num = b.detail_unq_num 
								and a.dept_code    = as_dept_code
								and a.yymm         = adt_yymm
								and a.seq          = ai_seq
								and a.order_number = ai_order_number);

		UPDATE s_prgs_parent  a
		  SET (a.tot_prgs_qty,a.tot_prgs_amt,a.tot_prgs_rt ) =
            ( SELECT b.sub_qty,b.sub_amt,C_RT
							  from s_cn_parent b
							 where a.dept_code    = b.dept_code 
                        and a.order_number = b.order_number
								and a.spec_no_seq  = b.spec_no_seq
								and a.dept_code    = as_dept_code
								and a.yymm         = adt_yymm
								and a.seq          = ai_seq
								and a.order_number = ai_order_number)
		 WHERE a.dept_code    = as_dept_code
			AND a.yymm         = adt_yymm
			AND a.seq          = ai_seq
			AND a.order_number = ai_order_number
			AND EXISTS (SELECT b.sub_qty
							  from s_cn_parent b
							 where a.dept_code    = b.dept_code 
                        and a.order_number = b.order_number
								and a.spec_no_seq  = b.spec_no_seq
								and a.dept_code    = as_dept_code
								and a.yymm         = adt_yymm
								and a.seq          = ai_seq
								and a.order_number = ai_order_number);

      UPDATE S_PRGS_DETAIL
         SET tm_prgs_qty  = tot_prgs_qty - pre_prgs_qty,
				 tm_prgs_amt  = tot_prgs_amt - pre_prgs_amt,
				 tm_prgs_rt   = tot_prgs_rt  - pre_prgs_rt
       WHERE dept_code    = as_dept_code  
         AND order_number = ai_order_number
			and seq          = ai_seq
			and order_number = ai_order_number;

      UPDATE S_PRGS_PARENT
         SET tm_prgs_qty  = tot_prgs_qty - pre_prgs_qty,
				 tm_prgs_amt  = tot_prgs_amt - pre_prgs_amt,
				 tm_prgs_rt   = tot_prgs_rt  - pre_prgs_rt
       WHERE dept_code    = as_dept_code  
         AND order_number = ai_order_number
			and seq          = ai_seq
			and order_number = ai_order_number;


		SELECT nvl(MAX(CHG_DEGREE),1)
		  INTO C_CNT
		  FROM S_CHG_CN_LIST
		 WHERE DEPT_CODE = as_dept_code
			AND ORDER_NUMBER = ai_order_number;
 
      UPDATE S_CN_LIST
         SET close_tag  = 'Y'
       WHERE dept_code    = as_dept_code  
         AND order_number = ai_order_number;

      UPDATE S_CHG_CN_LIST
         SET close_tag  = 'Y'
       WHERE dept_code    = as_dept_code  
         AND order_number = ai_order_number
			AND chg_degree = C_CNT;
--	 END IF;

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
END y_sp_s_prgs_close;

/
