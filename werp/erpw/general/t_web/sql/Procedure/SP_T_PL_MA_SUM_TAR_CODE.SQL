Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_CODE_I
(
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SUM_TAR_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_SUM_TAR_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_SUM_TAR_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_PL_MA_SUM_TAR_CODE
	(
		SUM_TAR_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SUM_TAR_NAME
	)
	Values
	(
		AR_SUM_TAR_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SUM_TAR_NAME
	);
End;
/
Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_CODE_U
(
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SUM_TAR_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_SUM_TAR_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_SUM_TAR_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_PL_MA_SUM_TAR_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SUM_TAR_NAME = AR_SUM_TAR_NAME
	Where	SUM_TAR_CODE = AR_SUM_TAR_CODE;
End;
/
Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_CODE_D
(
	AR_SUM_TAR_CODE                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_SUM_TAR_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_SUM_TAR_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_PL_MA_SUM_TAR_CODE
	Where	SUM_TAR_CODE = AR_SUM_TAR_CODE;
End;
/
