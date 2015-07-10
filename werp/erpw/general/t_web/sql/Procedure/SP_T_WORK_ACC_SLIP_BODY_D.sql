CREATE OR REPLACE Procedure SP_T_WORK_ACC_SLIP_BODY_D
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
	lnMAKE_SLIPLINE				T_ACC_SLIP_BODY.MAKE_SLIPLINE%Type;
	lsACC_CODE					T_ACC_SLIP_BODY.ACC_CODE%Type;
	lsACC_NAME					T_ACC_CODE.ACC_NAME%Type;
	lsSUMMARY1					T_ACC_SLIP_BODY.SUMMARY1%Type;
	lnDB_AMT					T_ACC_SLIP_BODY.DB_AMT%Type;
	lnCR_AMT					T_ACC_SLIP_BODY.CR_AMT%Type;
	ldKEEP_DT					T_ACC_SLIP_BODY.KEEP_DT%Type;
	lnCnt1						T_ACC_SLIP_BODY.SLIP_ID%Type;
	lsMsg						Varchar2(4000);
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_SLIP_BODY_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_SLIP_BODY ���̺� Delete
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-12-07)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
Begin
    dssfsfs
	--���޾������� ���� CLEAR
	Select	Count(*)
	Into	lnCnt1
	From	T_FIN_PAY_CHK_BILL
	Where	SLIP_ID = AR_SLIP_ID
	And		SLIP_IDSEQ = AR_SLIP_IDSEQ
	And		RESET_SLIP_ID is Not Null;

	If Nvl(lnCnt1,0) > 0 Then
		lsMsg := '��ǥ����!!!<br>'||'�ش����޾����� ���������� �����մϴ�.<br>�ش���ǥ������ �����Ҽ� �����ϴ�.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Update T_FIN_PAY_CHK_BILL
		Set
			PUBL_DT = Null,
			EXPR_DT = Null,
			PUBL_AMT = Null,
			SLIP_ID = Null,
			SLIP_IDSEQ = Null
		Where	SLIP_ID = AR_SLIP_ID
		And		SLIP_IDSEQ = AR_SLIP_IDSEQ
		And		RESET_SLIP_ID is Null;
	End If;

	--���޾������� CLEAR
	Update T_FIN_PAY_CHK_BILL
	Set
		RESET_SLIP_ID = Null,
		RESET_SLIP_IDSEQ = Null
	Where	RESET_SLIP_ID = AR_SLIP_ID
	And		RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--������������ CLEAR
	Select	Count(*)
	Into	lnCnt1
	From	T_FIN_RECEIVE_CHK_BILL
	Where	SLIP_ID = AR_SLIP_ID
	And		SLIP_IDSEQ = AR_SLIP_IDSEQ
	And		RESET_SLIP_ID is Not Null;

	If Nvl(lnCnt1,0) > 0 Then
		lsMsg := '��ǥ��������!!!<br>'||'�ش���������� ���������� �����մϴ�.<br>�ش���ǥ������ �����Ҽ� �����ϴ�.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Delete	T_FIN_RECEIVE_CHK_BILL
		Where	SLIP_ID = AR_SLIP_ID
		And		SLIP_IDSEQ = AR_SLIP_IDSEQ
		And		RESET_SLIP_ID is Null;
	End If;


	--������������ CLEAR
	Update T_FIN_RECEIVE_CHK_BILL
	Set
		RESET_AMT = 0,
		RESET_SLIP_ID = Null,
		RESET_SLIP_IDSEQ = Null
	Where	RESET_SLIP_ID = AR_SLIP_ID
	And		RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--�������Ǽ��� CLEAR
	-- �������� �̼����ڰ� ��ϵǾ� ������ ����
	Select	Count(*)
	Into	lnCnt1
	From
		T_FIN_SECURTY A,
		T_FIN_SEC_ITR_AMT B
	Where
	A.SECU_NO = B.SECU_NO
	And	A.SLIP_ID = AR_SLIP_ID
	And	A.SLIP_IDSEQ = AR_SLIP_IDSEQ;

	If Nvl(lnCnt1,0) > 0 Then
		lsMsg := '��ǥ��������!!!<br>'||'�ش����������� �̼����ڰ� �����մϴ�.<br>�����Ҽ� �����ϴ�.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	End If;

	Select	Count(*)
	Into	lnCnt1
	From	T_FIN_SECURTY
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ
	And	RESET_SLIP_ID is Not Null;

	If Nvl(lnCnt1,0) > 0 Then
		lsMsg := '��ǥ��������!!!<br>'||'�ش����������� ���������� �����մϴ�.<br>�����Ҽ� �����ϴ�.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Delete	T_FIN_SECURTY
		Where	SLIP_ID = AR_SLIP_ID
		And	SLIP_IDSEQ = AR_SLIP_IDSEQ
		And	RESET_SLIP_ID is Null;
	End If;

	--�������ǹ��� CLEAR
	Update T_FIN_SECURTY
	Set
		SALE_AMT = NULL,
		SALE_DT = NULL,
		RETURN_DT = NULL,
		CONSIGN_BANK = NULL,
		SALE_ITR_AMT = NULL,
		SALE_TAX = NULL,
		SALE_LOSS = NULL,
		SALE_NP_ITR_AMT = NULL,
		RESET_SLIP_ID = Null,
		RESET_SLIP_IDSEQ = Null
	Where	RESET_SLIP_ID = AR_SLIP_ID
	And	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--����/��ȯ ���� ����
	Delete	T_FIN_LOAN_REFUND_LIST
	Where	LOAN_SLIP_ID = AR_SLIP_ID
	And	LOAN_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	Delete	T_FIN_LOAN_REFUND_LIST
	Where	REFUND_SLIP_ID = AR_SLIP_ID
	And	REFUND_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--���� ���Գ��� CLEAR
	Update T_DEPOSIT_PAYMENT_LIST
	Set
		PAYMENT_DT = Null,
		PAYMENT_AMT = 0,
		SLIP_ID = Null,
		SLIP_IDSEQ = Null
	Where	SLIP_ID = AR_SLIP_ID
	And		SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--CP���Լ��� CLEAR
	Select	Count(*)
	Into	lnCnt1
	From	T_FIN_CP_BUY
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ
	And	RESET_SLIP_ID is Not Null;

	If Nvl(lnCnt1,0) > 0 Then
		lsMsg := '��ǥ��������!!!<br>'||'�ش�CP������ ���������� �����մϴ�.<br>�ش���ǥ������ �����Ҽ� �����ϴ�.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Delete	T_FIN_CP_BUY
		Where	SLIP_ID = AR_SLIP_ID
		And	SLIP_IDSEQ = AR_SLIP_IDSEQ
		And	RESET_SLIP_ID is Null;
	End If;

	--CP���Թ��� CLEAR
	Update T_FIN_CP_BUY
	Set
		RESET_AMT = NULL,
		REMARKS = NULL,
		RESET_SLIP_ID = NULL,
		RESET_SLIP_IDSEQ = NULL
	Where	RESET_SLIP_ID = AR_SLIP_ID
	And	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--���ݿ�����
	Delete	T_ACC_SLIP_EXPENSE_CASH
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--ī�念���� ����
	Delete	T_ACC_SLIP_EXPENSE_CARDS
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--��ǥBODY ����
	Delete T_ACC_SLIP_BODY
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
End;
/
