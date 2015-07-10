Create Or Replace Procedure SP_T_PL_FLOW_ACC_CODE_I
(
	AR_BIZ_PLAN_ITEM_NO                        NUMBER,
	AR_APPLY_SEQ                               NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SLIP_SUM_MTHD_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_SETOFF_ACC_CODE                         VARCHAR2,
	AR_SIGN_TAG                                VARCHAR2,
	AR_SUM_MTHD_TAG                            VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_FLOW_ACC_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_FLOW_ACC_CODE 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_PL_FLOW_ACC_CODE
	(
		BIZ_PLAN_ITEM_NO,
		APPLY_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SUM_MTHD_TAG,
		ACC_CODE,
		SETOFF_ACC_CODE,
		SIGN_TAG,
		SLIP_SUM_MTHD_TAG,
		REMARKS
	)
	Values
	(
		AR_BIZ_PLAN_ITEM_NO,
		AR_APPLY_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SUM_MTHD_TAG,
		AR_ACC_CODE,
		AR_SETOFF_ACC_CODE,
		AR_SIGN_TAG,
		AR_SLIP_SUM_MTHD_TAG,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_PL_FLOW_ACC_CODE_U
(
	AR_BIZ_PLAN_ITEM_NO                        NUMBER,
	AR_APPLY_SEQ                               NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SLIP_SUM_MTHD_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_SETOFF_ACC_CODE                         VARCHAR2,
	AR_SIGN_TAG                                VARCHAR2,
	AR_SUM_MTHD_TAG                            VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_FLOW_ACC_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_FLOW_ACC_CODE 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_PL_FLOW_ACC_CODE
	Set
		MODUSERNO = AR_CRTUSERNO,
		MODDATE = SYSDATE,
		SUM_MTHD_TAG = AR_SUM_MTHD_TAG,
		ACC_CODE = AR_ACC_CODE,
		SETOFF_ACC_CODE = AR_SETOFF_ACC_CODE,
		SIGN_TAG = AR_SIGN_TAG,
		SLIP_SUM_MTHD_TAG = AR_SLIP_SUM_MTHD_TAG,
		REMARKS = AR_REMARKS
	Where	BIZ_PLAN_ITEM_NO = AR_BIZ_PLAN_ITEM_NO
	And	APPLY_SEQ = AR_APPLY_SEQ;
End;
/
Create Or Replace Procedure SP_T_PL_FLOW_ACC_CODE_D
(
	AR_BIZ_PLAN_ITEM_NO                        NUMBER,
	AR_APPLY_SEQ                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_FLOW_ACC_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_FLOW_ACC_CODE 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_PL_FLOW_ACC_CODE
	Where	BIZ_PLAN_ITEM_NO = AR_BIZ_PLAN_ITEM_NO
	And	APPLY_SEQ = AR_APPLY_SEQ;
End;
/
