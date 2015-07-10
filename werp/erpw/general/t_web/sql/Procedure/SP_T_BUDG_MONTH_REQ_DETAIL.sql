Create Or Replace Procedure SP_T_BUDG_MONTH_REQ_DETAIL_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_RESERVED_SEQ                            NUMBER,
	AR_BUDG_YM                                 VARCHAR2,
	AR_REASON_NO                               NUMBER,
	AR_SEQ		                               NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CHG_AMT                                 NUMBER,
	AR_R_COMP_CODE                             VARCHAR2,
	AR_R_CLSE_ACC_ID                           VARCHAR2,
	AR_R_DEPT_CODE                             VARCHAR2,
	AR_R_CHG_SEQ                               NUMBER,
	AR_R_BUDG_CODE_NO                          NUMBER,
	AR_R_RESERVED_SEQ                          NUMBER,
	AR_R_BUDG_YM                               VARCHAR2,
	AR_REMARKS                                 VARCHAR2,
	AR_TAG                           		      VARCHAR2
	
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_MONTH_REQ_DETAIL_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_MONTH_REQ_DETAIL 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ);
	--SP_T_BUDG_CHECK_CONFIRM_KIND(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ, AR_BUDG_CODE_NO, AR_RESERVED_SEQ,  AR_BUDG_YM);
	SP_T_BUDG_CHECK_REQUEST(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ, AR_TAG);
	Insert Into T_BUDG_MONTH_REQ_DETAIL
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CHG_SEQ,
		BUDG_CODE_NO,
		RESERVED_SEQ,
		BUDG_YM,
		REASON_NO,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CHG_AMT,
		R_COMP_CODE,
		R_CLSE_ACC_ID,
		R_DEPT_CODE,
		R_CHG_SEQ,
		R_BUDG_CODE_NO,
		R_RESERVED_SEQ,
		R_BUDG_YM,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_CHG_SEQ,
		AR_BUDG_CODE_NO,
		AR_RESERVED_SEQ,
		to_date(AR_BUDG_YM,'YYYY-MM'),
		AR_REASON_NO,
		AR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CHG_AMT,
		AR_R_COMP_CODE,
		AR_R_CLSE_ACC_ID,
		AR_R_DEPT_CODE,
		AR_R_CHG_SEQ,
		AR_R_BUDG_CODE_NO,
		AR_R_RESERVED_SEQ,
		to_date(AR_R_BUDG_YM,'YYYY-MM'),
		AR_REMARKS
	);
End;
/
CREATE OR REPLACE Procedure SP_T_BUDG_MONTH_REQ_DETAIL_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_RESERVED_SEQ                            NUMBER,
	AR_BUDG_YM                                 VARCHAR2,
	AR_REASON_NO                               NUMBER,
	AR_SEQ		                               NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CHG_AMT                                 NUMBER,
	AR_R_COMP_CODE                             VARCHAR2,
	AR_R_CLSE_ACC_ID                           VARCHAR2,
	AR_R_DEPT_CODE                             VARCHAR2,
	AR_R_CHG_SEQ                               NUMBER,
	AR_R_BUDG_CODE_NO                          NUMBER,
	AR_R_RESERVED_SEQ                          NUMBER,
	AR_R_BUDG_YM                               VARCHAR2,
	AR_REMARKS                                 VARCHAR2,
	AR_TAG                           		      VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_MONTH_REQ_DETAIL_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_MONTH_REQ_DETAIL 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ);
	--SP_T_BUDG_CHECK_CONFIRM_KIND(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ, AR_BUDG_CODE_NO, AR_RESERVED_SEQ,  AR_BUDG_YM);
	SP_T_BUDG_CHECK_REQUEST(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ, AR_TAG);
	
	
	Update T_BUDG_MONTH_REQ_DETAIL
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CHG_AMT = AR_CHG_AMT,
		R_COMP_CODE = AR_R_COMP_CODE,
		R_CLSE_ACC_ID = AR_R_CLSE_ACC_ID,
		R_DEPT_CODE = AR_R_DEPT_CODE,
		R_CHG_SEQ = AR_R_CHG_SEQ,
		R_BUDG_CODE_NO = AR_R_BUDG_CODE_NO,
		R_RESERVED_SEQ = AR_R_RESERVED_SEQ,
		R_BUDG_YM = to_date(AR_R_BUDG_YM,'YYYY-MM'),
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	RESERVED_SEQ = AR_RESERVED_SEQ
	And	BUDG_YM = to_date(AR_BUDG_YM,'YYYY-MM')
	And	REASON_NO = AR_REASON_NO
	And	SEQ		    = AR_SEQ;
	
End;
/
Create Or Replace Procedure SP_T_BUDG_MONTH_REQ_DETAIL_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_RESERVED_SEQ                            NUMBER,
	AR_BUDG_YM                                 VARCHAR2,
	AR_REASON_NO                               NUMBER,
	AR_SEQ		                               NUMBER,
	AR_TAG                           		      VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_MONTH_REQ_DETAIL_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_MONTH_REQ_DETAIL 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ);
	--SP_T_BUDG_CHECK_CONFIRM_KIND(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ, AR_BUDG_CODE_NO, AR_RESERVED_SEQ,  AR_BUDG_YM);
	SP_T_BUDG_CHECK_REQUEST(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ, AR_TAG);
	
	Delete T_BUDG_MONTH_REQ_DETAIL
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	RESERVED_SEQ = AR_RESERVED_SEQ
	And	BUDG_YM = to_date(AR_BUDG_YM,'YYYY-MM')
	And	REASON_NO = AR_REASON_NO
	And	SEQ		    = AR_SEQ;
End;
/
