Create Or Replace Procedure SP_T_PL_MA_USER_FUNCTIONS_I
(
	AR_FUNC_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_USER_FUNCTIONS_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_USER_FUNCTIONS 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_PL_MA_USER_FUNCTIONS
	(
		FUNC_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		FUNC_TITLE,
		FUNC_NAME,
		AUTO_RECALCC_TAG
	)
	Values
	(
		AR_FUNC_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_FUNC_TITLE,
		AR_FUNC_NAME,
		AR_AUTO_RECALCC_TAG
	);
End;
/
Create Or Replace Procedure SP_T_PL_MA_USER_FUNCTIONS_U
(
	AR_FUNC_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_USER_FUNCTIONS_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_USER_FUNCTIONS 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_PL_MA_USER_FUNCTIONS
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		FUNC_TITLE = AR_FUNC_TITLE,
		FUNC_NAME = AR_FUNC_NAME,
		AUTO_RECALCC_TAG = AR_AUTO_RECALCC_TAG
	Where	FUNC_NO = AR_FUNC_NO;
End;
/
Create Or Replace Procedure SP_T_PL_MA_USER_FUNCTIONS_D
(
	AR_FUNC_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_USER_FUNCTIONS_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_USER_FUNCTIONS 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_PL_MA_USER_FUNCTIONS
	Where	FUNC_NO = AR_FUNC_NO;
End;
/
