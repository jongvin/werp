CREATE OR REPLACE Procedure SP_T_FIN_RECEIVE_BILL_SLIP_IU
(
	AR_SLIP_ID                                    NUMBER,
	AR_SLIP_IDSEQ                                 NUMBER,
	AR_CRTUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_COMP_CODE                                  VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	--��������
	AR_REC_BILL_NO_MNG                            VARCHAR2,
	AR_REC_BILL_NO_MNG_TG                         VARCHAR2,
	--�������� ����
	AR_REC_BILL_NO_S                              VARCHAR2,
	AR_REC_BILL_PUBL_DT                           VARCHAR2,
	AR_REC_BILL_EXPR_DT                           VARCHAR2,
	--�������� ����
	AR_REC_BILL_NO_R                              VARCHAR2,
	AR_REC_BILL_PUBL_DT_R                         VARCHAR2,
	AR_REC_BILL_EXPR_DT_R                         VARCHAR2,
	AR_REC_BILL_DISH_DT_R         VARCHAR2,
	AR_REC_BILL_TRUST_DT_R        VARCHAR2,
	AR_REC_BILL_TRUST_BANK_CODE_R VARCHAR2,
	AR_REC_BILL_DISC_DT_R         VARCHAR2,
	AR_REC_BILL_DISC_BANK_CODE_R  VARCHAR2,
	AR_REC_BILL_DISC_RAT_R        NUMBER,
	AR_REC_BILL_DISC_AMT_R        NUMBER
)
Is
	lnCnt						Number;
	lsMsg						Varchar2(4000);
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_CHK_SLIP
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : ���¼�ǥ�M��
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-12-07)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
Begin
	--�������� ���� Ŭ����
	Select	Count(*)
	Into	lnCnt
	From	T_FIN_RECEIVE_CHK_BILL
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ
	And	RESET_SLIP_ID is Not Null;

	If Nvl(lnCnt,0) > 0 Then
		lsMsg := '��ǥ��������!!!<br>'||'�ش���������� ���������� �����մϴ�.<br>�ش���ǥ������ �����Ҽ� �����ϴ�.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Delete	T_FIN_RECEIVE_CHK_BILL
		Where	SLIP_ID = AR_SLIP_ID
		And	SLIP_IDSEQ = AR_SLIP_IDSEQ
		And	RESET_SLIP_ID is Null;
	End If;
	
	--�������� ���� Ŭ����
	Update T_FIN_RECEIVE_CHK_BILL
	Set
		MODUSERNO = AR_CRTUSERNO,
		RESET_AMT = 0,
		RESET_SLIP_ID = Null,
		RESET_SLIP_IDSEQ = Null
	Where	RESET_SLIP_ID = AR_SLIP_ID
	And	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;
		
	If (AR_REC_BILL_NO_MNG = 'T' And AR_REC_BILL_NO_S is Not Null) Or (AR_REC_BILL_NO_MNG = 'T' And AR_REC_BILL_NO_R is Not Null) Then
		If (Nvl(AR_ACC_REMAIN_POSITION,'D') = 'D' And Nvl(AR_DB_AMT, 0) > 0) Or
			(Nvl(AR_ACC_REMAIN_POSITION,'D') = 'C' And Nvl(AR_CR_AMT, 0) > 0) Then
			--�������� ����
			SP_T_FIN_RECEIVE_CHK_BILL_I
			(
				AR_REC_BILL_NO_S, -- AR_REC_CHK_BILL_NO,
				AR_CRTUSERNO,
				'B', -- AR_CHK_BILL_CLS,
				AR_COMP_CODE,
				AR_DB_AMT+AR_CR_AMT,--AR_PUBL_AMT,
				0,--AR_RESET_AMT,
				AR_REC_BILL_PUBL_DT,--AR_PUBL_DT,
				AR_REC_BILL_EXPR_DT,--AR_EXPR_DT,
				NULL,--AR_DISH_DT,
				NULL,--AR_TRUST_DT,
				NULL,--AR_TRUST_BANK_CODE,
				NULL,--AR_DISC_DT,
				NULL,--AR_DISC_BANK_CODE,
				0,--AR_DISC_RAT,
				0,--AR_DISC_AMT,
				AR_SLIP_ID,
				AR_SLIP_IDSEQ,
				NULL,--AR_RESET_SLIP_ID,
				NULL--AR_RESET_SLIP_IDSEQ
			);

		Else
			--�������� ����
			Update T_FIN_RECEIVE_CHK_BILL
			Set
				MODUSERNO = AR_CRTUSERNO,
				RESET_AMT = AR_DB_AMT+AR_CR_AMT,
				DISH_DT = AR_REC_BILL_DISH_DT_R,
				TRUST_DT = AR_REC_BILL_TRUST_DT_R,
				TRUST_BANK_CODE = AR_REC_BILL_TRUST_BANK_CODE_R,
				DISC_DT = AR_REC_BILL_DISC_DT_R,
				DISC_BANK_CODE = AR_REC_BILL_DISC_BANK_CODE_R,
				DISC_RAT = AR_REC_BILL_DISC_RAT_R,
				DISC_AMT = AR_REC_BILL_DISC_AMT_R,
				RESET_SLIP_ID = AR_SLIP_ID,
				RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ
			Where	REC_CHK_BILL_NO = AR_REC_BILL_NO_R;
		End If;
	Else
		NULL;
	End If;
End;
/
