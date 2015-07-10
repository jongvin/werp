Create Or Replace Procedure SP_T_ACCNO_CODE_I
(
	AR_ACCNO                                   VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BANK_CODE                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_ACCT_NAME                               VARCHAR2,
	AR_ACCT_CLS                                VARCHAR2,
	AR_PAY_ACCNO_CLS                           VARCHAR2,
	AR_CHK_ACCNO_CLS                           VARCHAR2,
	AR_CHK_MAX_AMT                             NUMBER,
	AR_CONT_DT                                 VARCHAR2,
	AR_EXPR_DT                                 VARCHAR2,
	AR_EXPR_CHG_DT                             VARCHAR2,
	AR_MIDD_CANCEL_DT                          VARCHAR2,
	AR_ORG_AMT                                 NUMBER,
	AR_EXPR_AMT                                NUMBER,
	AR_MONTH_INTR_AMT                          NUMBER,
	AR_INTR_RATE                               NUMBER,
	AR_PAYMENT_SEQ_AMT                         NUMBER,
	AR_PAYMENT_SEQ_DAY                         VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_HSMS_USE_CLS                            VARCHAR2,
	AR_REMARKS                                 VARCHAR2,
	AR_USE_CLS                                 VARCHAR2,
	AR_FBS_ACCOUNT_CLS                         VARCHAR2,
	AR_FBS_TRANSFER_CLS                        VARCHAR2,
	AR_VIRTUAL_ACCOUNT_CLS                     VARCHAR2,
	AR_FBS_DISPLAY_ORDER                       NUMBER,
	AR_ACCOUNT_NO                              VARCHAR2,
	AR_ITR_ACC_CODE                            VARCHAR2,
	AR_ACC_OWNER                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACCNO_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACCNO_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_ACCNO_CODE
	(
		ACCNO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BANK_CODE,
		COMP_CODE,
		ACCT_NAME,
		ACCT_CLS,
		PAY_ACCNO_CLS,
		CHK_ACCNO_CLS,
		CHK_MAX_AMT,
		CONT_DT,
		EXPR_DT,
		EXPR_CHG_DT,
		MIDD_CANCEL_DT,
		ORG_AMT,
		EXPR_AMT,
		MONTH_INTR_AMT,
		INTR_RATE,
		PAYMENT_SEQ_AMT,
		PAYMENT_SEQ_DAY,
		DEPT_CODE,
		ACC_CODE,
		HSMS_USE_CLS,
		REMARKS,
		USE_CLS,
		FBS_ACCOUNT_CLS,
		FBS_TRANSFER_CLS,
		VIRTUAL_ACCOUNT_CLS,
		FBS_DISPLAY_ORDER,
		ACCOUNT_NO,
		ITR_ACC_CODE,
		ACC_OWNER
	)
	Values
	(
		AR_ACCNO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BANK_CODE,
		AR_COMP_CODE,
		AR_ACCT_NAME,
		AR_ACCT_CLS,
		AR_PAY_ACCNO_CLS,
		AR_CHK_ACCNO_CLS,
		AR_CHK_MAX_AMT,
		F_T_StringToDate(AR_CONT_DT),
		F_T_StringToDate(AR_EXPR_DT),
		F_T_StringToDate(AR_EXPR_CHG_DT),
		F_T_StringToDate(AR_MIDD_CANCEL_DT),
		AR_ORG_AMT,
		AR_EXPR_AMT,
		AR_MONTH_INTR_AMT,
		AR_INTR_RATE,
		AR_PAYMENT_SEQ_AMT,
		AR_PAYMENT_SEQ_DAY,
		AR_DEPT_CODE,
		AR_ACC_CODE,
		AR_HSMS_USE_CLS,
		AR_REMARKS,
		AR_USE_CLS,
		AR_FBS_ACCOUNT_CLS,
		AR_FBS_TRANSFER_CLS,
		AR_VIRTUAL_ACCOUNT_CLS,
		AR_FBS_DISPLAY_ORDER,
		AR_ACCOUNT_NO,
		AR_ITR_ACC_CODE,
		AR_ACC_OWNER
	);
End;
/
Create Or Replace Procedure SP_T_ACCNO_CODE_U
(
	AR_ACCNO                                   VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_BANK_CODE                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_ACCT_NAME                               VARCHAR2,
	AR_ACCT_CLS                                VARCHAR2,
	AR_PAY_ACCNO_CLS                           VARCHAR2,
	AR_CHK_ACCNO_CLS                           VARCHAR2,
	AR_CHK_MAX_AMT                             NUMBER,
	AR_CONT_DT                                 VARCHAR2,
	AR_EXPR_DT                                 VARCHAR2,
	AR_EXPR_CHG_DT                             VARCHAR2,
	AR_MIDD_CANCEL_DT                          VARCHAR2,
	AR_ORG_AMT                                 NUMBER,
	AR_EXPR_AMT                                NUMBER,
	AR_MONTH_INTR_AMT                          NUMBER,
	AR_INTR_RATE                               NUMBER,
	AR_PAYMENT_SEQ_AMT                         NUMBER,
	AR_PAYMENT_SEQ_DAY                         VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_HSMS_USE_CLS                            VARCHAR2,
	AR_REMARKS                                 VARCHAR2,
	AR_USE_CLS                                 VARCHAR2,
	AR_FBS_ACCOUNT_CLS                         VARCHAR2,
	AR_FBS_TRANSFER_CLS                        VARCHAR2,
	AR_VIRTUAL_ACCOUNT_CLS                     VARCHAR2,
	AR_FBS_DISPLAY_ORDER                       NUMBER,
	AR_ACCOUNT_NO                              VARCHAR2,
	AR_ITR_ACC_CODE                            VARCHAR2,
	AR_ACC_OWNER                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACCNO_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACCNO_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_ACCNO_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BANK_CODE = AR_BANK_CODE,
		COMP_CODE = AR_COMP_CODE,
		ACCT_NAME = AR_ACCT_NAME,
		ACCT_CLS = AR_ACCT_CLS,
		PAY_ACCNO_CLS = AR_PAY_ACCNO_CLS,
		CHK_ACCNO_CLS = AR_CHK_ACCNO_CLS,
		CHK_MAX_AMT = AR_CHK_MAX_AMT,
		CONT_DT = F_T_StringToDate(AR_CONT_DT),
		EXPR_DT = F_T_StringToDate(AR_EXPR_DT),
		EXPR_CHG_DT = F_T_StringToDate(AR_EXPR_CHG_DT),
		MIDD_CANCEL_DT = F_T_StringToDate(AR_MIDD_CANCEL_DT),
		ORG_AMT = AR_ORG_AMT,
		EXPR_AMT = AR_EXPR_AMT,
		MONTH_INTR_AMT = AR_MONTH_INTR_AMT,
		INTR_RATE = AR_INTR_RATE,
		PAYMENT_SEQ_AMT = AR_PAYMENT_SEQ_AMT,
		PAYMENT_SEQ_DAY = AR_PAYMENT_SEQ_DAY,
		DEPT_CODE = AR_DEPT_CODE,
		ACC_CODE = AR_ACC_CODE,
		HSMS_USE_CLS = AR_HSMS_USE_CLS,
		REMARKS = AR_REMARKS,
		USE_CLS = AR_USE_CLS,
		FBS_ACCOUNT_CLS = AR_FBS_ACCOUNT_CLS,
		FBS_TRANSFER_CLS = AR_FBS_TRANSFER_CLS,
		VIRTUAL_ACCOUNT_CLS = AR_VIRTUAL_ACCOUNT_CLS,
		FBS_DISPLAY_ORDER = AR_FBS_DISPLAY_ORDER,
		ACCOUNT_NO = AR_ACCOUNT_NO,
		ITR_ACC_CODE = AR_ITR_ACC_CODE,
		ACC_OWNER = AR_ACC_OWNER
	Where	ACCNO = AR_ACCNO;
End;
/
Create Or Replace Procedure SP_T_ACCNO_CODE_D
(
	AR_ACCNO                                   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACCNO_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACCNO_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_ACCNO_CODE
	Where	ACCNO = AR_ACCNO;
End;
/
