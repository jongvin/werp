Create Or Replace Procedure SP_T_BUDG_MON_REQ_CONF_KIND_A
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                   NUMBER,
	AR_CONFIRM_KIND                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_MON_REQ_CONF_KIND_A
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : SP_T_BUDG_MONTH_REQ 테이블  Update
/* 4. 변  경  이  력 : 한재원 작성(2005-12-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE,AR_CHG_SEQ);
	Update T_BUDG_MONTH_REQ 
	Set CONFIRM_KIND = AR_CONFIRM_KIND
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
End;
/

