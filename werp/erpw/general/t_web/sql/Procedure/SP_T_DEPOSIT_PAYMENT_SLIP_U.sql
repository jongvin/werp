CREATE OR REPLACE Procedure SP_T_DEPOSIT_PAYMENT_SLIP_U
(
	AR_SLIP_ID                                    NUMBER,
	AR_SLIP_IDSEQ                                 NUMBER,
	AR_MODUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	--����
	AR_DEPOSIT_PAY_MNG                            VARCHAR2,
	AR_DEPOSIT_PAY_MNG_TG                         VARCHAR2,
	--����
	AR_DEPOSIT_ACCNO                              VARCHAR2,
	AR_PAYMENT_SEQ                                NUMBER,
	AR_PAYMENT_SCH_DT                             VARCHAR2,
	AR_PAYMENT_SCH_AMT                            NUMBER,
	AR_PAYMENT_DT                                 VARCHAR2,
	AR_PAYMENT_AMT                                NUMBER
)
Is
	lnCnt						T_ACC_SLIP_BODY.SLIP_ID%Type;
	lsMsg						Varchar2(4000);
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_BILL_SLIP
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : ���ݺ���
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-12-07)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
Begin
	--���� ���� Ŭ����
	Update T_DEPOSIT_PAYMENT_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		PAYMENT_DT = Null,
		PAYMENT_AMT = 0,
		SLIP_ID = Null,
		SLIP_IDSEQ = Null
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
	
	If (AR_DEPOSIT_PAY_MNG = 'T' And AR_PAYMENT_SEQ is Not Null) Or (AR_DEPOSIT_PAY_MNG = 'T' And AR_PAYMENT_SEQ is Not Null) Then
		If (Nvl(AR_ACC_REMAIN_POSITION,'D') = 'D' And Nvl(AR_DB_AMT, 0) > 0) Or
			(Nvl(AR_ACC_REMAIN_POSITION,'D') = 'C' And Nvl(AR_CR_AMT, 0) > 0) Then
			--���� ����
			Update T_DEPOSIT_PAYMENT_LIST
			Set
				MODUSERNO = AR_MODUSERNO,
				PAYMENT_DT = F_T_STRINGTODATE(AR_PAYMENT_DT),
				PAYMENT_AMT = AR_PAYMENT_AMT,
				SLIP_ID = AR_SLIP_ID,
				SLIP_IDSEQ = AR_SLIP_IDSEQ
			Where	ACCNO = AR_DEPOSIT_ACCNO
			AND PAYMENT_SEQ = AR_PAYMENT_SEQ;
		Else
			--���� ����
			NULL;
		End If;
	Else
		NULL;
	End If;
End;
/