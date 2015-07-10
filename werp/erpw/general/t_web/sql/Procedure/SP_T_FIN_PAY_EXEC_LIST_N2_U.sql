Create Or Replace Procedure SP_T_FIN_PAY_EXEC_LIST_N2_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_EXEC_KIND_TAG                           VARCHAR2,
	AR_TARGET_SLIP_ID                          NUMBER,
	AR_TARGET_SLIP_IDSEQ                       NUMBER,
	AR_EXEC_AMT                                NUMBER,
	AR_OUT_ACC_NO                              VARCHAR2,
	AR_IN_BANK_MAIN_CODE                       VARCHAR2,
	AR_IN_ACC_NO                               VARCHAR2,
	AR_SLIP_PUB_SEQ                            NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_CHK_BILL_NO                             VARCHAR2,
	AR_ACCNO_OWNER                             VARCHAR2,
	AR_EXPR_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_EXEC_LIST_N_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_EXEC_LIST 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	If Nvl(AR_EXEC_AMT,0) = 0 Then
		return;
	End If;
	Insert Into T_FIN_PAY_EXEC_LIST_TMP
	(
		COMP_CODE,
		WORK_DT,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		EXEC_KIND_TAG,
		TARGET_SLIP_ID,
		TARGET_SLIP_IDSEQ,
		EXEC_AMT,
		OUT_ACC_NO,
		IN_BANK_MAIN_CODE,
		IN_ACC_NO,
		SLIP_PUB_SEQ,
		SLIP_ID,
		SLIP_IDSEQ,
		CHK_BILL_NO,
		ACCNO_OWNER,
		EXPR_DT
	)
	Values
	(
		AR_COMP_CODE,
		F_T_StringToDate(AR_WORK_DT),
		SQ_T_PAY_EXEC_LIST_SEQ.NextVal,
		AR_MODUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_EXEC_KIND_TAG,
		AR_TARGET_SLIP_ID,
		AR_TARGET_SLIP_IDSEQ,
		AR_EXEC_AMT,
		AR_OUT_ACC_NO,
		AR_IN_BANK_MAIN_CODE,
		AR_IN_ACC_NO,
		AR_SLIP_PUB_SEQ,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_CHK_BILL_NO,
		AR_ACCNO_OWNER,
		F_T_StringToDate(AR_EXPR_DT)
	);
End;
/
