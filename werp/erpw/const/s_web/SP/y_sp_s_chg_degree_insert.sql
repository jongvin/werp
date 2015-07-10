 /* ============================================================================ */
/* 함수명 : y_sp_s_chg_degree_insert                                             */
/* 기  능 : 계약변경승인시 계약내역화일로 복사한다.                              */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 발주번호               ==> ai_order_number(integer)                  */
/*        : 변경차수               ==> ai_chg_degree(integer)                    */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.04.25                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_chg_degree_insert (as_dept_code    IN   VARCHAR2,
                                                ai_order_number IN   INTEGER,
                                                ai_chg_degree   IN   INTEGER ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_CNT               NUMBER(20,5);  --
   C_LAST_CHG_DEGREE     INTEGER;
   C_NEW_CHG_DEGREE     INTEGER;
   C_LAST_approve_class  VARCHAR2(1);
BEGIN
 BEGIN
		BEGIN
	        SELECT nvl(MAX(CHG_DEGREE),0) INTO C_LAST_CHG_DEGREE
	        FROM S_CHG_CN_LIST
			WHERE DEPT_CODE = as_dept_code AND ORDER_NUMBER = ai_order_number;
    		EXCEPTION
		        WHEN NO_DATA_FOUND THEN
        		BEGIN
                    e_msg      := '계약내용이존재하지 않습니다! [Line No: 159]';
                    Wk_errflag := -20020;
                    GOTO EXIT_ROUTINE;
		        END;
			IF C_LAST_CHG_DEGREE = 0 THEN
				e_msg      := '계약내용이존재하지 않습니다! [Line No: 159]';
				Wk_errflag := -20020;
				GOTO EXIT_ROUTINE;
			END IF;
        END;
		BEGIN
	        SELECT approve_class INTO C_LAST_approve_class
	        FROM S_CHG_CN_LIST
			WHERE DEPT_CODE = as_dept_code AND ORDER_NUMBER = ai_order_number AND CHG_DEGREE = C_LAST_CHG_DEGREE;
    		EXCEPTION
		        WHEN NO_DATA_FOUND THEN
        		BEGIN
                    e_msg      := '계약내용이존재하지 않습니다! [Line No: 159]';
                    Wk_errflag := -20020;
                    GOTO EXIT_ROUTINE;
		        END;
			IF C_LAST_approve_class != '6' THEN
				e_msg      := '최종계약이 완료되지 않았습니다! [Line No: 159]';
				Wk_errflag := -20020;
				GOTO EXIT_ROUTINE;
			END IF;
        END;
		C_NEW_CHG_DEGREE := C_LAST_CHG_DEGREE + 1;


	  INSERT INTO S_CHG_CN_LIST  
		  SELECT DEPT_CODE,ORDER_NUMBER,C_NEW_CHG_DEGREE,SBCR_CODE,'',CLOSE_TAG,'1',CHECK_DT,REQUEST_DT,   
					APPROVE_DT,ORDER_NAME,SBC_NAME,SBC_DT,SBC_SECTION,CHOICE_RIVAL,CHOICE_KIND,PROJ_SCALE,   
					CONST_PLACE,START_DT,END_DT,START_DT,END_DT,PAGE_COUNT,BOOK_COUNT,PAY_MAT,MAT_ETC,   
					CNT_AMT,EXE_AMT,SUPPLY_AMT_TAX,SUPPLY_AMT_NOTAX,MISCTAX_TAX,MISCTAX_NOTAX,PURCHASE_VAT,SBC_AMT,   
					VAT,STAMP,PRGS_CTRL_DT,PRGS_PAY_COUNT,PRGS_CASH_RT,PRGS_BILL_RT,BILL_COND,DELAY_RT,PREVIOUS_PAY_DT,   
					PREVIOUS_AMT_RT,PREVIOUS_AMT,PREVIOUS_VAT,PREVIOUS_PAY_TAG,PREVIOUS_CHECKER,PREVIOUS_CHECK_DT,   
					PREVIOUS_DEDUCTION_RT,DELAY_AMT,DELAY_DT,DELAY_PAY_DT,INSURANCE1_AMT1,INSURANCE1_AMT2,INSURANCE2_NAME,   
					INSURANCE2_AMT1,SAFETY_AMT1,SAFETY_AMT2,SBC_GUARANTEE_ISSUEDAY,SBC_GUARANTEE_RT,SBC_GUARANTEE_AMT,   
					SBC_GUARANTEE_START_DT,SBC_GUARANTEE_END_DT,SBC_GUARANTEE_NUMBER,SBC_GUARANTEE_KIND,
					WARRANT_GUARANTEE_ISSUEDAY,WARRANT_GUARANTEE_RT,WARRANT_GUARANTEE_AMT,WARRANT_GUARANTEE_START_DT,   
					WARRANT_GUARANTEE_END_DT,WARRANT_GUARANTEE_NUMBER,WARRANT_GUARANTEE_KIND,WARRANT_TERM,PAY_GUARANTEE_ISSUEDAY,   
					PAY_GUARANTEE_AMT,PAY_GUARANTEE_START_DT,PAY_GUARANTEE_END_DT,PAY_GUARANTEE_NUMBER,PAY_GUARANTEE_KIND,   
					GUARANTEE_NAME,GUARANTEE_REP_NAME,GUARANTEE_ADDRESS,SBC_GUARANTEE_NAME,SBC_GUARANTEE_REP_NAME,   
					SBC_GUARANTEE_ADDRESS,REMARK,INSURANCE_YN,TA_TAG,
					previous_pay1,cnt_previous_amt,guarantee_yn,order_class,ebid_yn,
					const_no,'','','',charge,vatcode,buy_rt,guarantee_tag1,guarantee_tag2,guarantee_tag3,guarantee_tag4,guarantee_tag5,bill_day,
				   nosend1,nosend2,nosend3,nosend4,nosend5,nosend6,nosend7,nosend8,nosend9,comm_tag,acc_tag,emp_class  
			 FROM S_CHG_CN_LIST  
			WHERE ( DEPT_CODE    = as_dept_code ) AND  
					( ORDER_NUMBER = ai_order_number ) AND CHG_DEGREE =  C_LAST_CHG_DEGREE ;
	  INSERT INTO S_CHG_CN_PARENT  
		  SELECT DEPT_CODE,ORDER_NUMBER,C_NEW_CHG_DEGREE,SPEC_NO_SEQ,SEQ,DIRECT_CLASS,LLEVEL,SUM_CODE,PARENT_SUM_CODE,   
					INVEST_CLASS,DETAIL_YN,'Y',NAME,SSIZE,UNIT,CNT_QTY,CNT_AMT,EXE_QTY,EXE_AMT,SUB_QTY,SUB_AMT,MAT_AMT,   
					LAB_AMT,EXP_AMT  
			 FROM S_CHG_CN_PARENT  
			WHERE ( DEPT_CODE    = as_dept_code ) AND  
					( ORDER_NUMBER = ai_order_number ) AND CHG_DEGREE =  C_LAST_CHG_DEGREE   ;
	  INSERT INTO S_CHG_CN_DETAIL  
		  SELECT DEPT_CODE,ORDER_NUMBER,C_NEW_CHG_DEGREE,SPEC_NO_SEQ,DETAIL_UNQ_NUM,SEQ,RES_CLASS,SPEC_UNQ_NUM,
					NAME,SSIZE,UNIT,'Y','',TAXATION_TAG,CNT_QTY,CNT_PRICE,CNT_AMT,EXE_QTY,EXE_PRICE,EXE_AMT,   
					SUB_QTY,SUB_PRICE,SUB_AMT,MAT_PRICE,MAT_AMT,LAB_PRICE,LAB_AMT,EXP_PRICE,EXP_AMT  
			 FROM S_CHG_CN_DETAIL  
			WHERE ( DEPT_CODE    = as_dept_code ) AND  
					( ORDER_NUMBER = ai_order_number ) AND CHG_DEGREE =  C_LAST_CHG_DEGREE   ;
      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '계약내역입력 실패! [Line No: 159]';
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
END y_sp_s_chg_degree_insert;
