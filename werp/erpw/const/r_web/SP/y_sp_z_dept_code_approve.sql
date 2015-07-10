 /* ============================================================================ */
/* 함수명 : y_sp_z_dept_code_approve                                             */
/* 기  능 : 계약변경승인시 계약내역화일로 복사한다.                              */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 발주번호               ==> ai_order_number(integer)                  */
/*        : 변경차수               ==> ai_chg_degree(integer)                    */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.04.25                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_z_dept_code_approve(  ai_unq_num  IN   INTEGER,
                                                 as_dept_tag   IN   VARCHAR2,
																 as_comp_code  IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------

-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Codeai_unq_num
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_RECEIVE_CODE      Z_DEPT_APPROVE.RECEIVE_CODE%TYPE;
   C_DEPT_CODE         Z_DEPT_APPROVE.DEPT_CODE%TYPE;
   C_LONG_NAME         Z_DEPT_APPROVE.LONG_NAME%TYPE;
   C_SHORT_NAME        Z_DEPT_APPROVE.SHORT_NAME%TYPE;
   C_CNT               NUMBER(20,5);  --
BEGIN
 BEGIN
	select dept_code,long_name,short_name
	  into C_DEPT_CODE,C_LONG_NAME,C_SHORT_NAME
	  from z_dept_approve
    WHERE spec_unq_num = ai_unq_num;

	IF as_dept_tag = 'H' THEN
      INSERT INTO Z_CODE_DEPT
						( DEPT_CODE,COMP_CODE,LONG_NAME,SHORT_NAME,ENGLISH_NAME,DEPT_SEQ_KEY,DEPT_LEVEL_CODE,HIGH_DEPT_CODE,   
						DEPT_PROJ_TAG,USE_TAG,HOME_FOREIGN_TAG,PROJ_NAME,PROCESS_CODE,ZIPCODE,PROJ_ADDR1,PROJ_ADDR2,PROJ_TEL,   
						MAIN_POS,MAIN_CHARGE,PROJ_POS,PROJ_CHARGE,CONTRACT_DATE,CHG_CONTRACT_DATE1,LAST_DEGREE,RECEIVE_CODE,   
						OWNER,DESIGNER,SUPERVISOR,CONST_CLASS,CONSTKIND_TAG,CONST_TAG,CONST_RATE,TAX_RATE,FREE_RATE,CNT_AMT1,   
						EXE_AMT1,EXE_RATE1,WORK_RATE,CONST_START_DATE,CONST_END_DATE,CONST_TERM,CHG_CONST_START_DATE,   
						CHG_CONST_END_DATE,CHG_CONST_TERM,GUARANTEE_FAULT1,GUARANTEE_FAULT2,AREA_PYUNG,GROUND_AREA,   
						BUILD_AREA,GROSS_FLOOR_AREA_SUM,REMARK,PROJ_UNQ_KEY,REGION_CODE,EMP_NO,FLOOR,PY_CNT,TOT_CNT,   
						DONG_CNT,GROUND_FLOOR_AREA,BUILDING_RATIO,VOLUNETRIC_RATIO,BUILDING_USE,COMPLETE_DATE,VATTAG,   
						TEST_EXEAMT,GOAL_CONST_ST,GOAL_CONST_ED,GOAL_CONST_TERM,CLASS_TAG )  
           SELECT DEPT_CODE,as_comp_code,LONG_NAME,SHORT_NAME,'',0,'','',DEPT_PROJ_TAG,'Y','','','01','','','','',   
						'','','','','','','','','','','','','','',0,0,0,0,0,0,0,'','',0,'','',0,'','',0,0,0,0,'',0,'','','','',0,   
						'',0,0,0,'','','',0,'','',0,0 
             FROM z_dept_approve
            WHERE spec_unq_num = ai_unq_num;
	ELSE
      INSERT INTO Z_CODE_DEPT
						( DEPT_CODE,COMP_CODE,LONG_NAME,SHORT_NAME,ENGLISH_NAME,DEPT_SEQ_KEY,DEPT_LEVEL_CODE,HIGH_DEPT_CODE,   
						DEPT_PROJ_TAG,USE_TAG,HOME_FOREIGN_TAG,PROJ_NAME,PROCESS_CODE,ZIPCODE,PROJ_ADDR1,PROJ_ADDR2,PROJ_TEL,   
						MAIN_POS,MAIN_CHARGE,PROJ_POS,PROJ_CHARGE,CONTRACT_DATE,CHG_CONTRACT_DATE1,LAST_DEGREE,RECEIVE_CODE,   
						OWNER,DESIGNER,SUPERVISOR,CONST_CLASS,CONSTKIND_TAG,CONST_TAG,CONST_RATE,TAX_RATE,FREE_RATE,CNT_AMT1,   
						EXE_AMT1,EXE_RATE1,WORK_RATE,CONST_START_DATE,CONST_END_DATE,CONST_TERM,CHG_CONST_START_DATE,   
						CHG_CONST_END_DATE,CHG_CONST_TERM,GUARANTEE_FAULT1,GUARANTEE_FAULT2,AREA_PYUNG,GROUND_AREA,   
						BUILD_AREA,GROSS_FLOOR_AREA_SUM,REMARK,PROJ_UNQ_KEY,REGION_CODE,EMP_NO,FLOOR,PY_CNT,TOT_CNT,   
						DONG_CNT,GROUND_FLOOR_AREA,BUILDING_RATIO,VOLUNETRIC_RATIO,BUILDING_USE,COMPLETE_DATE,VATTAG,   
						TEST_EXEAMT,GOAL_CONST_ST,GOAL_CONST_ED,GOAL_CONST_TERM,CLASS_TAG )  
           SELECT b.dept_code,as_comp_code,b.LONG_NAME,b.SHORT_NAME,'',0,'','',   
						b.DEPT_PROJ_TAG,'Y','','','01','',a.const_position,'','',   
						'','','','','','','',a.RECEIVE_CODE,   
						c.order_name,'','',a.receive_tag,a.CONSTKIND_TAG,a.join_cont_tag,a.ocomp_rate,0,0,0,   
						0,0,0,a.const_from,a.const_to,round(months_between(a.const_to,a.const_from)) ,a.const_from,   
						a.const_to,round(months_between(a.const_to,a.const_from)),'','',0,0,   
						a.const_area,a.year_area,a.REMARK,0,a.REGION_CODE,'',a.FLOOR,'',0,   
						'',0,a.bulid_rt,a.volume_rt,'',a.const_to,'1',   
						0,a.const_from,a.const_to,round(months_between(a.const_to,a.const_from)),0
             FROM r_receive_code a,
                  z_dept_approve b,
                  r_code_order c
            WHERE a.order_no = c.order_no (+)
              AND b.receive_code = a.receive_code
              AND b.spec_unq_num = ai_unq_num;

		INSERT INTO R_CONTRACT_REGISTER  
					  (DEPT_CODE,CONT_NO,CHG_DEGREE,CONTRACT_YEAR_TAG,LAST_TAG,RECEIVE_CODE,PARENT_DEPT_CODE,LEDGER_NO,   
						COMPLETION_TAG,ORDER_NO,MEMBERSHIP_NO,CONST_NAME,CONST_SHORTNAME,CONST_PROCESS_CLASS,   
						REGION_CODE,POSITION,POSITION2,FIELD_TEL,CHARGE_PM1,CHARGE_PM2,CONSTKIND_TAG,PQ_TAG,   
						CONST_TAG,RECEIVE_TAG,TENDER_TAG,ORDER_TAG,CONTRACT_TAG,TAX_TAG,CHANGE_TAG,UP_DATE,   
						CHANGE_KIND,BID_DATE,CONT_DATE,DESIGN_AMT,SURVEY_AMT,BUDGET_AMT,BID_AMT,CHANGE_SUPPLY_AMT,   
						CHANGE_VAT_AMT,CHANGE_SUM_AMT,TOT_CONT_AMT,CONST_OUTLINE1,CONST_OUTLINE2,LIMIT_CONTENTS1,   
						LIMIT_CONTENTS2,USE_SEAL_NO,ORDER_CHARGER,ORDER_TEL,ORDER_REMARK,DEMAND_CHARGER,DEMAND_TEL,   
						DEMAND_REMARK,MASTER_DEPT,START_DATE,COMPLETION_DATE,COMPLETION_TESTDATE,DELAY_RATE,   
						RESERVE_RATE,CONT_RATE,WARRANTY_RATE,WARRANTY_AMT,WARRANTY_START,WARRANTY_END,CONTROL_TAG,   
						BANKNAME,DEPOSIT_NO,CONSTAMT_PAYCOND,EXTABLISH_PAYCOND,COMPLETION_PAYCOND,DEPOSIT_PAYCOND,   
						ETC_PAYCOND,DESIGNER,ADMINISTER,PAYMENT_CONDITION,PAYMENT_METHOD,CHANGE_STATUS,OPERATION_RATE,   
						OPERATION_SUPPLY_AMT,OPERATION_VAT_AMT,OPERATION_SUM_AMT,OPERATION_TOT_CONT_AMT,PROJ_DEPUTY,DELAY_INTEREST,
						MASTERDEPT_TAG,EXEMPT_AMT,ETC_AMT )  
			  SELECT b.dept_code,1,1,'01','Y',a.receive_code,'','','N',a.order_no,c.order_name,b.long_name,b.short_name,'01',   
						a.region_code,a.const_position,'','','','',a.CONSTKIND_TAG,a.PQ_TAG,'',a.RECEIVE_TAG,a.TENDER_TAG,a.ORDER_TAG,
						'','','','','',a.BID_DATE,'',a.DESIGN_AMT,a.SURVEY_AMT,a.BUDGET_AMT,a.BID_AMT,0,0,0,0,a.CONST_OUTLINE1,
						a.CONST_OUTLINE2,a.LIMIT_CONTENTS1,a.LIMIT_CONTENTS2,'','','','','','','','',a.const_from,a.const_to,'',0,   
						0,0,0,0,'','','','','','','','','','','','','','','',0,0,0,0,0,'','',a.masterdept_tag,0,0 
             FROM r_receive_code a,
                  z_dept_approve b,
                  r_code_order c
            WHERE a.order_no1 = c.order_no (+)
              AND b.receive_code = a.receive_code
              AND b.spec_unq_num = ai_unq_num;

		select receive_code
		  into C_RECEIVE_CODE
		  from z_dept_approve
		 where spec_unq_num = ai_unq_num;

		UPDATE R_RECEIVE_CODE  
		  SET approve_class = '4'   
		WHERE receive_code = C_RECEIVE_CODE;
	END IF;

	P_T_INS_DEPT(C_DEPT_CODE,as_comp_code,C_LONG_NAME,C_SHORT_NAME);

	UPDATE z_dept_approve  
	  SET approve_class = '2',   
			create_dt  = sysdate
   WHERE spec_unq_num = ai_unq_num;

      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '현장코드생성 실패! [Line No: 159]';
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
END y_sp_z_dept_code_approve;
/

