Create Or Replace Procedure SP_T_FL_COMP_FORE_FUNCTIONSB_I
(
	AR_COMP_FOR_FUNC_NO_B                      NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_COMP_FORE_FUNCTIONSB_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_COMP_FORE_FUNCTIONS_B 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_COMP_FORE_FUNCTIONS_B
	(
		COMP_FOR_FUNC_NO_B,
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
		AR_COMP_FOR_FUNC_NO_B,
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
Create Or Replace Procedure SP_T_FL_COMP_FORE_FUNCTIONSB_U
(
	AR_COMP_FOR_FUNC_NO_B                      NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_COMP_FORE_FUNCTIONSB_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_COMP_FORE_FUNCTIONS_B 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FL_COMP_FORE_FUNCTIONS_B
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		FUNC_TITLE = AR_FUNC_TITLE,
		FUNC_NAME = AR_FUNC_NAME,
		AUTO_RECALCC_TAG = AR_AUTO_RECALCC_TAG
	Where	COMP_FOR_FUNC_NO_B = AR_COMP_FOR_FUNC_NO_B;
End;
/
Create Or Replace Procedure SP_T_FL_COMP_FORE_FUNCTIONSB_D
(
	AR_COMP_FOR_FUNC_NO_B                      NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_COMP_FORE_FUNCTIONSB_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_COMP_FORE_FUNCTIONS_B 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FL_COMP_FORE_FUNCTIONS_B
	Where	COMP_FOR_FUNC_NO_B = AR_COMP_FOR_FUNC_NO_B;
End;
/
