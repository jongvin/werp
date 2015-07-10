Create Or Replace Procedure SP_T_BUDG_CLOSE_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               NUMBER,
	AR_REQ_CLSE_CLS                            VARCHAR2,
	AR_REQ_CLSE_DT                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_CLOSE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_CLOSE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-12-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_CLOSE
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		REQ_CLSE_CLS,
		REQ_CLSE_DT
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_REQ_CLSE_CLS,
		F_T_StringToDate(AR_REQ_CLSE_DT)
	);
End;
/
Create Or Replace Procedure SP_T_BUDG_CLOSE_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               NUMBER,
	AR_REQ_CLSE_CLS                            VARCHAR2,
	AR_REQ_CLSE_DT                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_CLOSE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_CLOSE 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2005-12-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_BUDG_CLOSE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		REQ_CLSE_CLS = AR_REQ_CLSE_CLS,
		REQ_CLSE_DT = F_T_StringToDate(AR_REQ_CLSE_DT)
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_BUDG_CLOSE_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_CLOSE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_CLOSE 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2005-12-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_BUDG_CLOSE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
