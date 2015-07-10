Create Or Replace Procedure SP_T_CLASS_CODE_I
(
	AR_CLASS_CODE                              VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CLASS_CODE_NAME                         VARCHAR2,
	AR_USE_CLS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CLASS_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CLASS_CODE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-12-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_CLASS_CODE
	(
		CLASS_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CLASS_CODE_NAME,
		USE_CLS
	)
	Values
	(
		AR_CLASS_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CLASS_CODE_NAME,
		AR_USE_CLS
	);
End;
/
Create Or Replace Procedure SP_T_CLASS_CODE_U
(
	AR_CLASS_CODE                              VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CLASS_CODE_NAME                         VARCHAR2,
	AR_USE_CLS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CLASS_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CLASS_CODE 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2005-12-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_CLASS_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CLASS_CODE_NAME = AR_CLASS_CODE_NAME,
		USE_CLS = AR_USE_CLS
	Where	CLASS_CODE = AR_CLASS_CODE;
End;
/
Create Or Replace Procedure SP_T_CLASS_CODE_D
(
	AR_CLASS_CODE                              VARCHAR2
)
Is
	row_cnt						NUMBER;
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CLASS_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CLASS_CODE 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2005-12-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_CLASS_CODE
	Where	CLASS_CODE = AR_CLASS_CODE;
End;
/
