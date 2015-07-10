Create Or Replace Procedure SP_T_FIN_BILL_ACC_CODE_I
(
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_BILL_KIND                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_BILL_ACC_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_BILL_ACC_CODE 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_BILL_ACC_CODE
	(
		COST_DEPT_KND_TAG,
		BILL_KIND,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE
	)
	Values
	(
		AR_COST_DEPT_KND_TAG,
		AR_BILL_KIND,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_CODE
	);
End;
/
Create Or Replace Procedure SP_T_FIN_BILL_ACC_CODE_U
(
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_BILL_KIND                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_BILL_ACC_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_BILL_ACC_CODE 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_BILL_ACC_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_CODE = AR_ACC_CODE
	Where	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG
	And	BILL_KIND = AR_BILL_KIND;
End;
/
Create Or Replace Procedure SP_T_FIN_BILL_ACC_CODE_D
(
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_BILL_KIND                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_BILL_ACC_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_BILL_ACC_CODE 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_BILL_ACC_CODE
	Where	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG
	And	BILL_KIND = AR_BILL_KIND;
End;
/
