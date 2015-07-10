Create Or Replace Procedure SP_T_AUTO_BILL_FURNI_SUM_I
(
	AR_AUTO_B_F_FURNI_SUM_SEQ                  NUMBER,
	AR_WORK_SEQ                                NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_SUM_DT_FROM                             VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_DEPREC_AMT                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FURNI_SUM_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_BILL_FURNI_SUM 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-02-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_AUTO_BILL_FURNI_SUM
	(
		AUTO_B_F_FURNI_SUM_SEQ,
		WORK_SEQ,
		FIX_ASSET_SEQ,
		DEPT_CODE,
		SUM_DT_FROM,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE,
		DEPREC_AMT
	)
	Values
	(
		AR_AUTO_B_F_FURNI_SUM_SEQ,
		AR_WORK_SEQ,
		AR_FIX_ASSET_SEQ,
		AR_DEPT_CODE,
		F_T_StringToDate(AR_SUM_DT_FROM),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_CODE,
		AR_DEPREC_AMT
	);
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FURNI_SUM_U
(
	AR_AUTO_B_F_FURNI_SUM_SEQ                  NUMBER,
	AR_WORK_SEQ                                NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_SUM_DT_FROM                             VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_DEPREC_AMT                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FURNI_SUM_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_BILL_FURNI_SUM 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-02-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_AUTO_BILL_FURNI_SUM
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_CODE = AR_ACC_CODE,
		DEPREC_AMT = AR_DEPREC_AMT
	Where	AUTO_B_F_FURNI_SUM_SEQ = AR_AUTO_B_F_FURNI_SUM_SEQ
	And	WORK_SEQ = AR_WORK_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ
	And	DEPT_CODE = AR_DEPT_CODE
	And	SUM_DT_FROM = F_T_StringToDate(AR_SUM_DT_FROM);
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FURNI_SUM_D
(
	AR_AUTO_B_F_FURNI_SUM_SEQ                  NUMBER,
	AR_WORK_SEQ                                NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_SUM_DT_FROM                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FURNI_SUM_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_BILL_FURNI_SUM 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-02-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_AUTO_BILL_FURNI_SUM
	Where	AUTO_B_F_FURNI_SUM_SEQ = AR_AUTO_B_F_FURNI_SUM_SEQ
	And	WORK_SEQ = AR_WORK_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ
	And	DEPT_CODE = AR_DEPT_CODE
	And	SUM_DT_FROM = F_T_StringToDate(AR_SUM_DT_FROM);
End;
/
