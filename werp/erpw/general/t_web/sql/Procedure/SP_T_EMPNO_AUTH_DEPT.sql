Create Or Replace Procedure SP_T_EMPNO_AUTH_DEPT_I
(
	AR_EMPNO                                   VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_EMPNO_AUTH_DEPT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_EMPNO_AUTH_DEPT 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_EMPNO_AUTH_DEPT
	(
		EMPNO,
		COMP_CODE,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_EMPNO,
		AR_COMP_CODE,
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_EMPNO_AUTH_DEPT_U
(
	AR_EMPNO                                   VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_EMPNO_AUTH_DEPT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_EMPNO_AUTH_DEPT 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_EMPNO_AUTH_DEPT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	EMPNO = AR_EMPNO
	And	COMP_CODE = AR_COMP_CODE
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_EMPNO_AUTH_DEPT_D
(
	AR_EMPNO                                   VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_EMPNO_AUTH_DEPT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_EMPNO_AUTH_DEPT 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_EMPNO_AUTH_DEPT
	Where	EMPNO = AR_EMPNO
	And	COMP_CODE = AR_COMP_CODE
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
