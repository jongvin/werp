Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_DEPT_I
(
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_SUM_TAR_DEPT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_SUM_TAR_DEPT 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_PL_MA_SUM_TAR_DEPT
	(
		SUM_TAR_CODE,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_SUM_TAR_CODE,
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_DEPT_U
(
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_SUM_TAR_DEPT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_SUM_TAR_DEPT 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_PL_MA_SUM_TAR_DEPT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	SUM_TAR_CODE = AR_SUM_TAR_CODE
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_DEPT_D
(
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_SUM_TAR_DEPT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_SUM_TAR_DEPT 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_PL_MA_SUM_TAR_DEPT
	Where	SUM_TAR_CODE = AR_SUM_TAR_CODE
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
