Create Or Replace Procedure SP_T_PL_VIRTUAL_REAL_DEPT_I
(
	AR_V_DEPT_CODE                             VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_R_DEPT_CODE                             VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_VIRTUAL_REAL_DEPT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_VIRTUAL_REAL_DEPT 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_PL_VIRTUAL_REAL_DEPT
	(
		V_DEPT_CODE,
		COMP_CODE,
		CLSE_ACC_ID,
		R_DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_V_DEPT_CODE,
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_R_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_PL_VIRTUAL_REAL_DEPT_U
(
	AR_V_DEPT_CODE                             VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_R_DEPT_CODE                             VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_VIRTUAL_REAL_DEPT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_VIRTUAL_REAL_DEPT 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_PL_VIRTUAL_REAL_DEPT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	V_DEPT_CODE = AR_V_DEPT_CODE
	And	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	R_DEPT_CODE = AR_R_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_PL_VIRTUAL_REAL_DEPT_D
(
	AR_V_DEPT_CODE                             VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_R_DEPT_CODE                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_VIRTUAL_REAL_DEPT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_VIRTUAL_REAL_DEPT 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_PL_VIRTUAL_REAL_DEPT
	Where	V_DEPT_CODE = AR_V_DEPT_CODE
	And	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	R_DEPT_CODE = AR_R_DEPT_CODE;
End;
/
