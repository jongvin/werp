Create Or Replace Procedure SP_T_DEPT_CLASS_CODE_I
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CLASS_CODE                              VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DFLT_TAG                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_CLASS_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_CLASS_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2005-12-09)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_DEPT_CLASS_CODE
	(
		DEPT_CODE,
		CLASS_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DFLT_TAG
	)
	Values
	(
		AR_DEPT_CODE,
		AR_CLASS_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DFLT_TAG
	);
End;
/
Create Or Replace Procedure SP_T_DEPT_CLASS_CODE_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CLASS_CODE                              VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_DFLT_TAG                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_CLASS_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_CLASS_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2005-12-09)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_DEPT_CLASS_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DFLT_TAG = AR_DFLT_TAG
	Where	DEPT_CODE = AR_DEPT_CODE
	And	CLASS_CODE = AR_CLASS_CODE;
End;
/
Create Or Replace Procedure SP_T_DEPT_CLASS_CODE_D
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CLASS_CODE                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_CLASS_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_CLASS_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2005-12-09)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_DEPT_CLASS_CODE
	Where	DEPT_CODE = AR_DEPT_CODE
	And	CLASS_CODE = AR_CLASS_CODE;
End;
/
