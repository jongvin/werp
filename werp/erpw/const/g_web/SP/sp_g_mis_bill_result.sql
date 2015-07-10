/* ============================================================================= */
/* 함수명 : sp_g_mis_bill_result	                                                */
/* 기  능 : 수금실적 프로젝트 가져오기                                           */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 지급년월               ==> ad_work_yymm  (DATE)                      */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 장희선                                                               */
/* 작성일 : 2005.07.01                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_g_mis_bill_result(ad_work_yymm  IN  DATE) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error
   C_DATE              P_GEN_driver_filial_piety.WORK_YYMM%TYPE;    -- 일자
   C_LEVEL             NUMBER(20,5);  --
   C_CNT               NUMBER(20,5);  --

   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
		-- 계획
		INSERT INTO g_mis_bill_result(work_year,
									         spec_no_seq,
									         no_seq,
									         proj_name,
									         pr_div)
		        SELECT TO_DATE(ad_work_yymm, 'YYYY.MM.DD'),
            			g_spec_unq_no.nextval,
			            1,
            			b.proj_name,
            			'1'
	  			    FROM r_proj a,
	  			    	   r_proj_view_business_form b,
	  			    	   view_r_a_cash_degree c
	   		   WHERE a.proj_unq_key = b.proj_unq_key
		           and a.step = b.step
	   		     and b.proj_prog_type <> '3'
		           and b.proj_unq_key = c.proj_unq_key
	   		     and c.proj_unq_key <> 0
		           and not exists ( select work_yymm
		            					   from g_mis_decision_sp c
	            						  where a.proj_bus_type = c.proj_bus_type
												 and a.proj_prog_type  = c.proj_prog_type
												 and a.proj_unq_key = c.proj_unq_key 
												 and c.work_yymm = ad_work_yymm);
		
		-- 실적
		INSERT INTO g_mis_bill_result(work_year,
									         spec_no_seq,
									         no_seq,
									         proj_name,
									         pr_div)
		        SELECT TO_DATE(ad_work_yymm, 'YYYY.MM.DD'),
            			g_spec_unq_no.nextval,
			            1,
            			b.proj_name,
            			'2'
	  			    FROM r_proj a,
	  			    	   r_proj_view_business_form b,
	  			    	   view_r_a_cash_degree c
	   		   WHERE a.proj_unq_key = b.proj_unq_key
		           and a.step = b.step
	   		     and b.proj_prog_type <> '3'
		           and b.proj_unq_key = c.proj_unq_key
	   		     and c.proj_unq_key <> 0
		           and not exists ( select work_yymm
		            					   from g_mis_decision_sp c
	            						  where a.proj_bus_type = c.proj_bus_type
												 and a.proj_prog_type  = c.proj_prog_type
												 and a.proj_unq_key = c.proj_unq_key 
												 and c.work_yymm = ad_work_yymm);
												 
      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := 'BOM 자료집계 실패! [Line No: 159]';
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
END sp_g_mis_bill_result;
/
