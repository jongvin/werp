Create Or Replace Procedure SP_T_BANK_CODE_I
(
	AR_BANK_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_BANK_NAME                               VARCHAR2,
	AR_CURACCT_CLS                             VARCHAR2,
	AR_BILL_CLS                                VARCHAR2,
	AR_CURACCT_MAX_AMT                         NUMBER,
	AR_HSELL_USE_CLS                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BANK_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BANK_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_BANK_CODE
	(
		BANK_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BANK_MAIN_CODE,
		BANK_NAME,
		CURACCT_CLS,
		BILL_CLS,
		CURACCT_MAX_AMT,
		HSELL_USE_CLS
	)
	Values
	(
		AR_BANK_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BANK_MAIN_CODE,
		AR_BANK_NAME,
		AR_CURACCT_CLS,
		AR_BILL_CLS,
		AR_CURACCT_MAX_AMT,
		AR_HSELL_USE_CLS
	);
End;
/
Create Or Replace Procedure SP_T_BANK_CODE_U
(
	AR_BANK_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_BANK_NAME                               VARCHAR2,
	AR_CURACCT_CLS                             VARCHAR2,
	AR_BILL_CLS                                VARCHAR2,
	AR_CURACCT_MAX_AMT                         NUMBER,
	AR_HSELL_USE_CLS                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BANK_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BANK_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_BANK_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BANK_MAIN_CODE = AR_BANK_MAIN_CODE,
		BANK_NAME = AR_BANK_NAME,
		CURACCT_CLS = AR_CURACCT_CLS,
		BILL_CLS = AR_BILL_CLS,
		CURACCT_MAX_AMT = AR_CURACCT_MAX_AMT,
		HSELL_USE_CLS = AR_HSELL_USE_CLS
	Where	BANK_CODE = AR_BANK_CODE;
End;
/
Create Or Replace Procedure SP_T_BANK_CODE_D
(
	AR_BANK_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BANK_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BANK_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_BANK_CODE
	Where	BANK_CODE = AR_BANK_CODE;
End;
/
