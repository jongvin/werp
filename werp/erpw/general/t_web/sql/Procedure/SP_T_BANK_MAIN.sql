--일단은 은행코드하고 은행간 공동전산망 코드(FBS_CODE)는 쌤쌤이라네
Create Or Replace Procedure SP_T_BANK_MAIN_I
(
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BANK_MAIN_NAME                          VARCHAR2,
	AR_BANK_CLS                                VARCHAR2,
	AR_BANK_MAIN_SHORT_NAME                    VARCHAR2,
	AR_FBS_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BANK_MAIN_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BANK_MAIN 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_BANK_MAIN
	(
		BANK_MAIN_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BANK_MAIN_NAME,
		BANK_CLS,
		BANK_MAIN_SHORT_NAME,
		FBS_CODE
	)
	Values
	(
		AR_BANK_MAIN_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BANK_MAIN_NAME,
		AR_BANK_CLS,
		AR_BANK_MAIN_SHORT_NAME,
		AR_BANK_MAIN_CODE		--이부분
	);
End;
/
Create Or Replace Procedure SP_T_BANK_MAIN_U
(
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_BANK_MAIN_NAME                          VARCHAR2,
	AR_BANK_CLS                                VARCHAR2,
	AR_BANK_MAIN_SHORT_NAME                    VARCHAR2,
	AR_FBS_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BANK_MAIN_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BANK_MAIN 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_BANK_MAIN
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BANK_MAIN_NAME = AR_BANK_MAIN_NAME,
		BANK_CLS = AR_BANK_CLS,
		BANK_MAIN_SHORT_NAME = AR_BANK_MAIN_SHORT_NAME,
		FBS_CODE = AR_BANK_MAIN_CODE
	Where	BANK_MAIN_CODE = AR_BANK_MAIN_CODE;
End;
/
Create Or Replace Procedure SP_T_BANK_MAIN_D
(
	AR_BANK_MAIN_CODE                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BANK_MAIN_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BANK_MAIN 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_BANK_MAIN
	Where	BANK_MAIN_CODE = AR_BANK_MAIN_CODE;
End;
/
