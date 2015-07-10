Create Or Replace Procedure SP_T_ACC_CODE_EXT02_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BANK_CODE                               VARCHAR2,
	AR_BANK_NAME                               VARCHAR2,
	AR_ACCNO                                   VARCHAR2,
	AR_ACCT_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_CODE_EXT02_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_CODE_EXT02 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_ACC_CODE_EXT02
	(
		COMP_CODE,
		ACC_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BANK_CODE,
		BANK_NAME,
		ACCNO,
		ACCT_NAME
	)
	Values
	(
		AR_COMP_CODE,
		AR_ACC_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BANK_CODE,
		AR_BANK_NAME,
		AR_ACCNO,
		AR_ACCT_NAME
	);
End;
/
Create Or Replace Procedure SP_T_ACC_CODE_EXT02_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_BANK_CODE                               VARCHAR2,
	AR_BANK_NAME                               VARCHAR2,
	AR_ACCNO                                   VARCHAR2,
	AR_ACCT_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_CODE_EXT02_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_CODE_EXT02 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_ACC_CODE_EXT02
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BANK_CODE = AR_BANK_CODE,
		BANK_NAME = AR_BANK_NAME,
		ACCNO = AR_ACCNO,
		ACCT_NAME = AR_ACCT_NAME
	Where	COMP_CODE = AR_COMP_CODE
	And	ACC_CODE = AR_ACC_CODE;
End;
/
Create Or Replace Procedure SP_T_ACC_CODE_EXT02_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_CODE_EXT02_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_CODE_EXT02 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_ACC_CODE_EXT02
	Where	COMP_CODE = AR_COMP_CODE
	And	ACC_CODE = AR_ACC_CODE;
End;
/
