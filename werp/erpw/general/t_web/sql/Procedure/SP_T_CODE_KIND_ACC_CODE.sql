Create Or Replace Procedure SP_T_CODE_KIND_ACC_CODE_I
(
	AR_MAIN_ACC_CODE                           VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CODE_KIND_ACC_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CODE_KIND_ACC_CODE 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_CODE_KIND_ACC_CODE
	(
		MAIN_ACC_CODE,
		COST_DEPT_KND_TAG,
		ACC_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_MAIN_ACC_CODE,
		AR_COST_DEPT_KND_TAG,
		AR_ACC_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_CODE_KIND_ACC_CODE_U
(
	AR_MAIN_ACC_CODE                           VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CODE_KIND_ACC_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CODE_KIND_ACC_CODE 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_CODE_KIND_ACC_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	MAIN_ACC_CODE = AR_MAIN_ACC_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG
	And	ACC_CODE = AR_ACC_CODE;
End;
/
Create Or Replace Procedure SP_T_CODE_KIND_ACC_CODE_D
(
	AR_MAIN_ACC_CODE                           VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CODE_KIND_ACC_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CODE_KIND_ACC_CODE 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_CODE_KIND_ACC_CODE
	Where	MAIN_ACC_CODE = AR_MAIN_ACC_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG
	And	ACC_CODE = AR_ACC_CODE;
End;
/
