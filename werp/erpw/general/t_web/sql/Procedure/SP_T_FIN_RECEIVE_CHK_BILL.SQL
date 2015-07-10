Create Or Replace Procedure SP_T_FIN_RECEIVE_CHK_BILL_I
(
	AR_REC_CHK_BILL_NO                         VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CHK_BILL_CLS                            VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_PUBL_AMT                                NUMBER,
	AR_RESET_AMT                               NUMBER,
	AR_PUBL_DT                                 VARCHAR2,
	AR_EXPR_DT                                 VARCHAR2,
	AR_DISH_DT                                 VARCHAR2,
	AR_TRUST_DT                                VARCHAR2,
	AR_TRUST_BANK_CODE                         VARCHAR2,
	AR_DISC_DT                                 VARCHAR2,
	AR_DISC_BANK_CODE                          VARCHAR2,
	AR_DISC_RAT                                NUMBER,
	AR_DISC_AMT                                NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_RESET_SLIP_ID                           NUMBER,
	AR_RESET_SLIP_IDSEQ                        NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_RECEIVE_CHK_BILL_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_RECEIVE_CHK_BILL 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2005-12-14)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_RECEIVE_CHK_BILL
	(
		REC_CHK_BILL_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CHK_BILL_CLS,
		COMP_CODE,
		PUBL_AMT,
		RESET_AMT,
		PUBL_DT,
		EXPR_DT,
		DISH_DT,
		TRUST_DT,
		TRUST_BANK_CODE,
		DISC_DT,
		DISC_BANK_CODE,
		DISC_RAT,
		DISC_AMT,
		SLIP_ID,
		SLIP_IDSEQ,
		RESET_SLIP_ID,
		RESET_SLIP_IDSEQ
	)
	Values
	(
		AR_REC_CHK_BILL_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CHK_BILL_CLS,
		AR_COMP_CODE,
		AR_PUBL_AMT,
		AR_RESET_AMT,
		F_T_StringToDate(AR_PUBL_DT),
		F_T_StringToDate(AR_EXPR_DT),
		F_T_StringToDate(AR_DISH_DT),
		F_T_StringToDate(AR_TRUST_DT),
		AR_TRUST_BANK_CODE,
		F_T_StringToDate(AR_DISC_DT),
		AR_DISC_BANK_CODE,
		AR_DISC_RAT,
		AR_DISC_AMT,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_RESET_SLIP_ID,
		AR_RESET_SLIP_IDSEQ
	);
End;
/
Create Or Replace Procedure SP_T_FIN_RECEIVE_CHK_BILL_U
(
	AR_REC_CHK_BILL_NO                         VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CHK_BILL_CLS                            VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_PUBL_AMT                                NUMBER,
	AR_RESET_AMT                               NUMBER,
	AR_PUBL_DT                                 VARCHAR2,
	AR_EXPR_DT                                 VARCHAR2,
	AR_DISH_DT                                 VARCHAR2,
	AR_TRUST_DT                                VARCHAR2,
	AR_TRUST_BANK_CODE                         VARCHAR2,
	AR_DISC_DT                                 VARCHAR2,
	AR_DISC_BANK_CODE                          VARCHAR2,
	AR_DISC_RAT                                NUMBER,
	AR_DISC_AMT                                NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_RESET_SLIP_ID                           NUMBER,
	AR_RESET_SLIP_IDSEQ                        NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_RECEIVE_CHK_BILL_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_RECEIVE_CHK_BILL 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2005-12-14)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_RECEIVE_CHK_BILL
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CHK_BILL_CLS = AR_CHK_BILL_CLS,
		COMP_CODE = AR_COMP_CODE,
		PUBL_AMT = AR_PUBL_AMT,
		RESET_AMT = AR_RESET_AMT,
		PUBL_DT = F_T_StringToDate(AR_PUBL_DT),
		EXPR_DT = F_T_StringToDate(AR_EXPR_DT),
		DISH_DT = F_T_StringToDate(AR_DISH_DT),
		TRUST_DT = F_T_StringToDate(AR_TRUST_DT),
		TRUST_BANK_CODE = AR_TRUST_BANK_CODE,
		DISC_DT = F_T_StringToDate(AR_DISC_DT),
		DISC_BANK_CODE = AR_DISC_BANK_CODE,
		DISC_RAT = AR_DISC_RAT,
		DISC_AMT = AR_DISC_AMT,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ,
		RESET_SLIP_ID = AR_RESET_SLIP_ID,
		RESET_SLIP_IDSEQ = AR_RESET_SLIP_IDSEQ
	Where	REC_CHK_BILL_NO = AR_REC_CHK_BILL_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_RECEIVE_CHK_BILL_D
(
	AR_REC_CHK_BILL_NO                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_RECEIVE_CHK_BILL_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_RECEIVE_CHK_BILL 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2005-12-14)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_RECEIVE_CHK_BILL
	Where	REC_CHK_BILL_NO = AR_REC_CHK_BILL_NO;
End;
/
