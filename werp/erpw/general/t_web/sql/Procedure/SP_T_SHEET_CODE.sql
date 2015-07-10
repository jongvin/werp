Create Or Replace Procedure SP_T_SHEET_CODE_I
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SHEET_NAME                              VARCHAR2,
	AR_SHEET_PRINT_NAME                        VARCHAR2,
	AR_SHEET_ENG_NAME                          VARCHAR2,
	AR_SHEET_TYPE                              VARCHAR2,
	AR_AMTUNIT                                 NUMBER,
	AR_INDENTCNT                               NUMBER,
	AR_ROUND_CLS                               VARCHAR2,
	AR_COST_CODE                               VARCHAR2,
	AR_ZERO_CLS                                VARCHAR2,
	AR_MONTH_SUM_TAG                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_SHEET_CODE
	(
		SHEET_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SHEET_NAME,
		SHEET_PRINT_NAME,
		SHEET_ENG_NAME,
		SHEET_TYPE,
		AMTUNIT,
		INDENTCNT,
		ROUND_CLS,
		COST_CODE,
		ZERO_CLS,
		MONTH_SUM_TAG
	)
	Values
	(
		AR_SHEET_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SHEET_NAME,
		AR_SHEET_PRINT_NAME,
		AR_SHEET_ENG_NAME,
		AR_SHEET_TYPE,
		AR_AMTUNIT,
		AR_INDENTCNT,
		AR_ROUND_CLS,
		AR_COST_CODE,
		AR_ZERO_CLS,
		Nvl(AR_MONTH_SUM_TAG,'F')
	);
End;
/
Create Or Replace Procedure SP_T_SHEET_CODE_U
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SHEET_NAME                              VARCHAR2,
	AR_SHEET_PRINT_NAME                        VARCHAR2,
	AR_SHEET_ENG_NAME                          VARCHAR2,
	AR_SHEET_TYPE                              VARCHAR2,
	AR_AMTUNIT                                 NUMBER,
	AR_INDENTCNT                               NUMBER,
	AR_ROUND_CLS                               VARCHAR2,
	AR_COST_CODE                               VARCHAR2,
	AR_ZERO_CLS                                VARCHAR2,
	AR_MONTH_SUM_TAG                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_SHEET_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SHEET_NAME = AR_SHEET_NAME,
		SHEET_PRINT_NAME = AR_SHEET_PRINT_NAME,
		SHEET_ENG_NAME = AR_SHEET_ENG_NAME,
		SHEET_TYPE = AR_SHEET_TYPE,
		AMTUNIT = AR_AMTUNIT,
		INDENTCNT = AR_INDENTCNT,
		ROUND_CLS = AR_ROUND_CLS,
		COST_CODE = AR_COST_CODE,
		ZERO_CLS = AR_ZERO_CLS,
		MONTH_SUM_TAG = Nvl(AR_MONTH_SUM_TAG,'F')
	Where	SHEET_CODE = AR_SHEET_CODE;
End;
/
Create Or Replace Procedure SP_T_SHEET_CODE_D
(
	AR_SHEET_CODE                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_SHEET_CODE
	Where	SHEET_CODE = AR_SHEET_CODE;
End;
/
