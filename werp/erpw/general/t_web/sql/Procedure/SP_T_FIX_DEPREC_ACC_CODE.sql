Create Or Replace Procedure SP_T_FIX_DEPREC_ACC_CODE_I
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_DEPREC_ACC_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_DEPREC_ACC_CODE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIX_DEPREC_ACC_CODE
	(
		ASSET_CLS_CODE,
		COST_DEPT_KND_TAG,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE
	)
	Values
	(
		AR_ASSET_CLS_CODE,
		AR_COST_DEPT_KND_TAG,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_CODE
	);
End;
/
Create Or Replace Procedure SP_T_FIX_DEPREC_ACC_CODE_U
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_DEPREC_ACC_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_DEPREC_ACC_CODE 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIX_DEPREC_ACC_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_CODE = AR_ACC_CODE
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
End;
/
Create Or Replace Procedure SP_T_FIX_DEPREC_ACC_CODE_D
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_DEPREC_ACC_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_DEPREC_ACC_CODE 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIX_DEPREC_ACC_CODE
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
End;
/
