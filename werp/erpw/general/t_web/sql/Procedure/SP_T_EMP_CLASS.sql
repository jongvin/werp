Create Or Replace Procedure SP_T_EMP_CLASS_I
(
	AR_EMP_CLASS_CODE                          VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_EMP_CLASS_NAME                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_EMP_CLASS_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_EMP_CLASS 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_EMP_CLASS
	(
		EMP_CLASS_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		EMP_CLASS_NAME
	)
	Values
	(
		AR_EMP_CLASS_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_EMP_CLASS_NAME
	);
End;
/
Create Or Replace Procedure SP_T_EMP_CLASS_U
(
	AR_EMP_CLASS_CODE                          VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_EMP_CLASS_NAME                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_EMP_CLASS_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_EMP_CLASS 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_EMP_CLASS
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		EMP_CLASS_NAME = AR_EMP_CLASS_NAME
	Where	EMP_CLASS_CODE = AR_EMP_CLASS_CODE;
End;
/
Create Or Replace Procedure SP_T_EMP_CLASS_D
(
	AR_EMP_CLASS_CODE                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_EMP_CLASS_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_EMP_CLASS 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_EMP_CLASS
	Where	EMP_CLASS_CODE = AR_EMP_CLASS_CODE;
End;
/
