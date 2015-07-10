Create Or Replace Procedure SP_T_FIN_LOAN_REFUND_LIST_I
(
	AR_LOAN_NO                                 VARCHAR2,
	AR_LOAN_REFUND_SEQ                         NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_TRANS_DT                                VARCHAR2,
	AR_LOAN_AMT                                NUMBER,
	AR_REFUND_SCH_DT                           VARCHAR2,
	AR_REFUND_SCH_ORG_AMT                      NUMBER,
	AR_REFUND_SCH_INTR_AMT                     NUMBER,
	AR_REFUND_INTR_DT                          VARCHAR2,
	AR_REFUND_AMT                              NUMBER,
	AR_INTR_AMT                                NUMBER,
	AR_INTR_START_DT                           VARCHAR2,
	AR_INTR_END_DT                             VARCHAR2,
	AR_INTR_DAY_CNT                            NUMBER,
	AR_LOAN_SLIP_ID                            NUMBER,
	AR_LOAN_SLIP_IDSEQ                         NUMBER,
	AR_ACC_CODE                                VARCHAR2,
	AR_REFUND_SLIP_ID                          NUMBER,
	AR_REFUND_SLIP_IDSEQ                       NUMBER,
	AR_INTR_SLIP_ID                            NUMBER,
	AR_INTR_SLIP_IDSEQ                         NUMBER,
	AR_PE_ITR_AMT                              NUMBER,
	AR_PE_RESET_ITR_AMT                        NUMBER,
	AR_NOE_ITR_AMT                             NUMBER,
	AR_AE_ITR_AMT                              NUMBER,
	AR_AE_RESET_ITR_AMT                        NUMBER,
	AR_PE_RESET_ITR_ID                         NUMBER,
	AR_PE_RESET_ITR_IDSEQ                      NUMBER,
	AR_AE_RESET_ITR_ID                         NUMBER,
	AR_AE_RESET_ITR_IDSEQ                      NUMBER,
	AR_ITR_TAG                                 VARCHAR2,
	AR_AE_ITR_NUM_DAYS                         NUMBER,
	AR_PE_START_DT                             VARCHAR2,
	AR_PE_END_DT                               VARCHAR2,
	AR_AE_START_DT                             VARCHAR2,
	AR_AE_END_DT                               VARCHAR2,
	AR_ITR_TAR_TAG                             VARCHAR2 Default 'X'
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_REFUND_LIST_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_REFUND_LIST 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-29)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	If AR_REFUND_INTR_DT Is Null And AR_REFUND_SCH_DT Is Null Then
		Raise_Application_Error(-20009,'차입/상환일 또는 예정일 중 하나는 반드시 입력하셔야 합니다.');
	End If;
	Insert Into T_FIN_LOAN_REFUND_LIST
	(
		LOAN_NO,
		LOAN_REFUND_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		TRANS_DT,
		LOAN_AMT,
		REFUND_SCH_DT,
		REFUND_SCH_ORG_AMT,
		REFUND_SCH_INTR_AMT,
		REFUND_INTR_DT,
		REFUND_AMT,
		INTR_AMT,
		INTR_START_DT,
		INTR_END_DT,
		INTR_DAY_CNT,
		LOAN_SLIP_ID,
		LOAN_SLIP_IDSEQ,
		ACC_CODE,
		REFUND_SLIP_ID,
		REFUND_SLIP_IDSEQ,
		INTR_SLIP_ID,
		INTR_SLIP_IDSEQ,
		PE_ITR_AMT,
		PE_RESET_ITR_AMT,
		NOE_ITR_AMT,
		AE_ITR_AMT,
		AE_RESET_ITR_AMT,
		PE_RESET_ITR_ID,
		PE_RESET_ITR_IDSEQ,
		AE_RESET_ITR_ID,
		AE_RESET_ITR_IDSEQ,
		ITR_TAG,
		AE_ITR_NUM_DAYS,
		PE_START_DT,
		PE_END_DT,
		AE_START_DT,
		AE_END_DT,
		ITR_TAR_TAG
	)
	Values
	(
		AR_LOAN_NO,
		AR_LOAN_REFUND_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		Nvl(F_T_StringToDate(AR_REFUND_INTR_DT),F_T_StringToDate(AR_REFUND_SCH_DT)),
		AR_LOAN_AMT,
		F_T_StringToDate(AR_REFUND_SCH_DT),
		AR_REFUND_SCH_ORG_AMT,
		AR_REFUND_SCH_INTR_AMT,
		F_T_StringToDate(AR_REFUND_INTR_DT),
		AR_REFUND_AMT,
		AR_INTR_AMT,
		F_T_StringToDate(AR_INTR_START_DT),
		F_T_StringToDate(AR_INTR_END_DT),
		F_T_StringToDate(AR_INTR_END_DT) - F_T_StringToDate(AR_INTR_START_DT),
		AR_LOAN_SLIP_ID,
		AR_LOAN_SLIP_IDSEQ,
		AR_ACC_CODE,
		AR_REFUND_SLIP_ID,
		AR_REFUND_SLIP_IDSEQ,
		AR_INTR_SLIP_ID,
		AR_INTR_SLIP_IDSEQ,
		AR_PE_ITR_AMT,
		AR_PE_RESET_ITR_AMT,
		AR_NOE_ITR_AMT,
		AR_AE_ITR_AMT,
		AR_AE_RESET_ITR_AMT,
		AR_PE_RESET_ITR_ID,
		AR_PE_RESET_ITR_IDSEQ,
		AR_AE_RESET_ITR_ID,
		AR_AE_RESET_ITR_IDSEQ,
		AR_ITR_TAG,
		AR_AE_ITR_NUM_DAYS,
		F_T_StringToDate(AR_PE_START_DT),
		F_T_StringToDate(AR_PE_END_DT),
		F_T_StringToDate(AR_AE_START_DT),
		F_T_StringToDate(AR_AE_END_DT),
		AR_ITR_TAR_TAG
	);
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_REFUND_LIST_U
(
	AR_LOAN_NO                                 VARCHAR2,
	AR_LOAN_REFUND_SEQ                         NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_TRANS_DT                                VARCHAR2,
	AR_LOAN_AMT                                NUMBER,
	AR_REFUND_SCH_DT                           VARCHAR2,
	AR_REFUND_SCH_ORG_AMT                      NUMBER,
	AR_REFUND_SCH_INTR_AMT                     NUMBER,
	AR_REFUND_INTR_DT                          VARCHAR2,
	AR_REFUND_AMT                              NUMBER,
	AR_INTR_AMT                                NUMBER,
	AR_INTR_START_DT                           VARCHAR2,
	AR_INTR_END_DT                             VARCHAR2,
	AR_INTR_DAY_CNT                            NUMBER,
	AR_LOAN_SLIP_ID                            NUMBER,
	AR_LOAN_SLIP_IDSEQ                         NUMBER,
	AR_ACC_CODE                                VARCHAR2,
	AR_REFUND_SLIP_ID                          NUMBER,
	AR_REFUND_SLIP_IDSEQ                       NUMBER,
	AR_INTR_SLIP_ID                            NUMBER,
	AR_INTR_SLIP_IDSEQ                         NUMBER,
	AR_PE_ITR_AMT                              NUMBER,
	AR_PE_RESET_ITR_AMT                        NUMBER,
	AR_NOE_ITR_AMT                             NUMBER,
	AR_AE_ITR_AMT                              NUMBER,
	AR_AE_RESET_ITR_AMT                        NUMBER,
	AR_PE_RESET_ITR_ID                         NUMBER,
	AR_PE_RESET_ITR_IDSEQ                      NUMBER,
	AR_AE_RESET_ITR_ID                         NUMBER,
	AR_AE_RESET_ITR_IDSEQ                      NUMBER,
	AR_ITR_TAG                                 VARCHAR2,
	AR_AE_ITR_NUM_DAYS                         NUMBER,
	AR_PE_START_DT                             VARCHAR2,
	AR_PE_END_DT                               VARCHAR2,
	AR_AE_START_DT                             VARCHAR2,
	AR_AE_END_DT                               VARCHAR2,
	AR_ITR_TAR_TAG                             VARCHAR2 Default 'X'
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_REFUND_LIST_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_REFUND_LIST 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-29)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	If AR_REFUND_INTR_DT Is Null And AR_REFUND_SCH_DT Is Null Then
		Raise_Application_Error(-20009,'차입/상환일 또는 예정일 중 하나는 반드시 입력하셔야 합니다.');
	End If;
	Update T_FIN_LOAN_REFUND_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		TRANS_DT = Nvl(F_T_StringToDate(AR_REFUND_INTR_DT),F_T_StringToDate(AR_REFUND_SCH_DT)),
		LOAN_AMT = AR_LOAN_AMT,
		REFUND_SCH_DT = F_T_StringToDate(AR_REFUND_SCH_DT),
		REFUND_SCH_ORG_AMT = AR_REFUND_SCH_ORG_AMT,
		REFUND_SCH_INTR_AMT = AR_REFUND_SCH_INTR_AMT,
		REFUND_INTR_DT = F_T_StringToDate(AR_REFUND_INTR_DT),
		REFUND_AMT = AR_REFUND_AMT,
		INTR_AMT = AR_INTR_AMT,
		INTR_START_DT = F_T_StringToDate(AR_INTR_START_DT),
		INTR_END_DT = F_T_StringToDate(AR_INTR_END_DT),
		INTR_DAY_CNT = F_T_StringToDate(AR_INTR_END_DT) - F_T_StringToDate(AR_INTR_START_DT),
		LOAN_SLIP_ID = AR_LOAN_SLIP_ID,
		LOAN_SLIP_IDSEQ = AR_LOAN_SLIP_IDSEQ,
		ACC_CODE = AR_ACC_CODE,
		REFUND_SLIP_ID = AR_REFUND_SLIP_ID,
		REFUND_SLIP_IDSEQ = AR_REFUND_SLIP_IDSEQ,
		INTR_SLIP_ID = AR_INTR_SLIP_ID,
		INTR_SLIP_IDSEQ = AR_INTR_SLIP_IDSEQ,
		PE_ITR_AMT = AR_PE_ITR_AMT,
		PE_RESET_ITR_AMT = AR_PE_RESET_ITR_AMT,
		NOE_ITR_AMT = AR_NOE_ITR_AMT,
		AE_ITR_AMT = AR_AE_ITR_AMT,
		AE_RESET_ITR_AMT = AR_AE_RESET_ITR_AMT,
		PE_RESET_ITR_ID = AR_PE_RESET_ITR_ID,
		PE_RESET_ITR_IDSEQ = AR_PE_RESET_ITR_IDSEQ,
		AE_RESET_ITR_ID = AR_AE_RESET_ITR_ID,
		AE_RESET_ITR_IDSEQ = AR_AE_RESET_ITR_IDSEQ,
		ITR_TAG = AR_ITR_TAG,
		AE_ITR_NUM_DAYS = AR_AE_ITR_NUM_DAYS,
		PE_START_DT = F_T_StringToDate(AR_PE_START_DT),
		PE_END_DT = F_T_StringToDate(AR_PE_END_DT),
		AE_START_DT = F_T_StringToDate(AR_AE_START_DT),
		AE_END_DT = F_T_StringToDate(AR_AE_END_DT),
		ITR_TAR_TAG = AR_ITR_TAR_TAG
	Where	LOAN_NO = AR_LOAN_NO
	And	LOAN_REFUND_SEQ = AR_LOAN_REFUND_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_REFUND_LIST_D
(
	AR_LOAN_NO                                 VARCHAR2,
	AR_LOAN_REFUND_SEQ                         NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_REFUND_LIST_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_REFUND_LIST 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-29)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Delete T_FIN_LOAN_REFUND_LIST
	Where	LOAN_NO = AR_LOAN_NO
	And	LOAN_REFUND_SEQ = AR_LOAN_REFUND_SEQ;
End;
/
