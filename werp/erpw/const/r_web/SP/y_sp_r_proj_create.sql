/* ============================================================================= */
/* 함수명 : y_sp_r_proj_create                                                   */
/* 기  능 : 현장코드를 생성.             							                     */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 수주코드               ==> as_receive_code (string)                  */
/*        : 사업장코드             ==> as_comp_code  (string)                    */
/*        : 부서SEQ                ==> ai_seq_key    (number)                    */
/*        : 파트구분               ==> as_class      (string)                    */
/*        : 해당년도               ==> as_year       (string)                    */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.07.30                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_r_proj_create(as_receive_code    IN   VARCHAR2 ,
															  as_comp_code       IN   VARCHAR2,
															  ai_seq_key         IN   VARCHAR2,
															  as_class           IN   VARCHAR2,
															  as_year            IN   VARCHAR2 ) IS
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
   C_CLASS         VARCHAR2(7);
   C_DEPT_CODE     VARCHAR2(7);
   C_CODE		    VARCHAR2(7);
   C_CNT           NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN
		C_CLASS := as_class || as_year || '%';

		select MAX(dept_code),COUNT(*)
		  into C_DEPT_CODE,C_CNT
  		  from z_code_dept
 		 where dept_code like  C_CLASS;

		if C_CNT < 1 THEN
			C_CODE := as_class || as_year || '01';
		else
			C_CODE := as_class || to_char(to_number(substrb(C_DEPT_CODE,2,6)) + 1);
		end if;

		UPDATE R_RECEIVE_CODE  
		  SET APPROVE_CLASS = '4',   
				DEPT_CODE = C_CODE  
		WHERE RECEIVE_CODE = as_receive_code;

		INSERT INTO Z_CODE_DEPT  
			( DEPT_CODE,COMP_CODE,LONG_NAME,SHORT_NAME,DEPT_SEQ_KEY,DEPT_PROJ_TAG,USE_TAG,home_foreign_tag,PROJ_NAME,PROCESS_CODE,   
			  PROJ_ADDR1,RECEIVE_CODE,OWNER,CONSTKIND_TAG,CONST_TAG,CONST_START_DATE,CONST_END_DATE,   
			  CONST_TERM,CHG_CONST_START_DATE,CHG_CONST_END_DATE,CHG_CONST_TERM )  
		         select C_CODE,as_comp_code,a.name,a.const_shortname,to_number(ai_seq_key),'P','Y',a.region_code,a.name,'01',
							 a.const_position,a.receive_code,b.order_name,a.constkind_tag,a.join_cont_tag,a.const_from,a.const_to,
							 0,a.const_from,a.const_to,0
					  from r_receive_code a,
							 r_code_order b
					 where a.order_no(+)  = b.order_no
						and a.receive_code = as_receive_code ;

		INSERT INTO R_CONTRACT_REGISTER  
			( DEPT_CODE,CONT_NO,CHG_DEGREE,CONTRACT_YEAR_TAG,LAST_TAG,   
			  RECEIVE_CODE,PARENT_DEPT_CODE,LEDGER_NO,COMPLETION_TAG,
			  ORDER_NO,MEMBERSHIP_NO,CONST_NAME,CONST_SHORTNAME,CONST_PROCESS_CLASS,   
			  REGION_CODE,POSITION,CONSTKIND_TAG,PQ_TAG,CONST_TAG,RECEIVE_TAG,
			  TENDER_TAG,ORDER_TAG,BID_DATE,
			  DESIGN_AMT,SURVEY_AMT,BUDGET_AMT,BID_AMT,CHANGE_SUPPLY_AMT,   
			  CHANGE_VAT_AMT,CHANGE_SUM_AMT,TOT_CONT_AMT,   
			  CONST_OUTLINE1,CONST_OUTLINE2,LIMIT_CONTENTS1,LIMIT_CONTENTS2,START_DATE,COMPLETION_DATE )  
				select C_CODE,1,1,'N','Y',
						 receive_code,parent_dept_code,0,'N',
						 order_no,'',name,const_shortname,'01',
						 region_code,const_position,constkind_tag,pq_tag,join_cont_tag,receive_tag,
						 tender_tag,order_tag,bid_date,
						 design_amt,0,budget_amt,bid_amt,0,0,0,0,
						 const_outline1,const_outline2,limit_contents1,limit_contents2,const_from,const_to
				  from r_receive_code
				 where receive_code = as_receive_code;

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '현장코드생성 실패! [Line No: 2]';
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
END y_sp_r_proj_create;

/
