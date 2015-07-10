Create Or Replace Procedure SP_T_FIN_PAY_CHK_BILL_I
(
	AR_CHK_BILL_NO                             VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CHK_BILL_CLS                            VARCHAR2,
	AR_BILL_KIND                               VARCHAR2,
	AR_STAT_CLS                                VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_BANK_CODE                               VARCHAR2,
	AR_CUST_SEQ                                NUMBER,
	AR_ACPT_DT                                 VARCHAR2,
	AR_PUBL_DT                                 VARCHAR2,
	AR_PUBL_AMT                                NUMBER,
	AR_EXPR_DT                                 VARCHAR2,
	AR_CHG_EXPR_DT                             VARCHAR2,
	AR_DUSE_DT                                 VARCHAR2,
	AR_CUST_DOUT_DT                            VARCHAR2,
	AR_COLL_DT                                 VARCHAR2,
	AR_RETURN_DT                               VARCHAR2,
	AR_DISC_RAT                                NUMBER,
	AR_DISC_AMT                                NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_RESET_SLIP_ID                           NUMBER,
	AR_RESET_SLIP_IDSEQ                        NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_CHK_BILL_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_CHK_BILL ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-21)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	lrT_FIN_BILL_KIND							T_FIN_BILL_KIND%RowType;
	lbFound										Boolean;
	lnLoanCondNo								Number;
	lsLoanNo									T_FIN_LOAN_SHEET.LOAN_NO%Type;
Begin
	If AR_CHK_BILL_CLS = 'B' Then
		If AR_STAT_CLS = '1' Then		--�̹���
			If AR_PUBL_DT Is Not Null Then
				Raise_Application_Error(-20009,'�̹�������� �������� �Է��Ͻ� �� �����ϴ�.');
			End If;
			If Nvl(AR_PUBL_AMT,0) <> 0 Then
				Raise_Application_Error(-20009,'�̹�������� ����ݾ��� �Է��Ͻ� �� �����ϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '2' Then	--����
			Raise_Application_Error(-20009,'�����Է��� ���� ���·� �� �� �����ϴ�.');
		ElsIf AR_STAT_CLS = '3' Then	--���
			Raise_Application_Error(-20009,'�����Է��� ��� ���·� �� �� �����ϴ�.');
		ElsIf AR_STAT_CLS = '4' Then	--�н�
			Raise_Application_Error(-20009,'�����Է��� �н� ���·� �� �� �����ϴ�.');
		ElsIf AR_STAT_CLS = '9' Then	--�����ȯ
			Raise_Application_Error(-20009,'�����Է��� �����ȯ ���·� �� �� �����ϴ�.');
		ElsIf AR_STAT_CLS = '0' Then	--��������
			If AR_PUBL_DT Is Null Then
				Raise_Application_Error(-20009,'������������� �������� �Է��ϼž� �մϴ�.');
			End If;
		End If;
	ElsIf AR_CHK_BILL_CLS = 'C' Then
		If AR_STAT_CLS = '1' Then		--�̹���
			If AR_PUBL_DT Is Not Null Then
				Raise_Application_Error(-20009,'�̹����ǥ�� �������� �Է��Ͻ� �� �����ϴ�.');
			End If;
			If Nvl(AR_PUBL_AMT,0) <> 0 Then
				Raise_Application_Error(-20009,'�̹����ǥ�� ����ݾ��� �Է��Ͻ� �� �����ϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '2' Then	--����
			Raise_Application_Error(-20009,'�����Է��� ���� ���·� �� �� �����ϴ�.');
		ElsIf AR_STAT_CLS = '3' Then	--���
			Raise_Application_Error(-20009,'�����Է��� ��� ���·� �� �� �����ϴ�.');
		ElsIf AR_STAT_CLS = '4' Then	--�н�
			Raise_Application_Error(-20009,'�����Է��� �н� ���·� �� �� �����ϴ�.');
		ElsIf AR_STAT_CLS = '9' Then	--�����ȯ
			Raise_Application_Error(-20009,'�����Է��� �����ȯ ���·� �� �� �����ϴ�.');
		ElsIf AR_STAT_CLS = '0' Then	--��������
			If AR_PUBL_DT Is Null Then
				Raise_Application_Error(-20009,'���������ǥ�� �������� �Է��ϼž� �մϴ�.');
			End If;
		End If;
	End If;
	Insert Into T_FIN_PAY_CHK_BILL
	(
		CHK_BILL_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CHK_BILL_CLS,
		BILL_KIND,
		STAT_CLS,
		COMP_CODE,
		BANK_CODE,
		CUST_SEQ,
		ACPT_DT,
		PUBL_DT,
		PUBL_AMT,
		EXPR_DT,
		CHG_EXPR_DT,
		DUSE_DT,
		CUST_DOUT_DT,
		COLL_DT,
		RETURN_DT,
		DISC_RAT,
		DISC_AMT,
		SLIP_ID,
		SLIP_IDSEQ,
		RESET_SLIP_ID,
		RESET_SLIP_IDSEQ,
		REMARKS
	)
	Values
	(
		AR_CHK_BILL_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CHK_BILL_CLS,
		AR_BILL_KIND,
		AR_STAT_CLS,
		AR_COMP_CODE,
		AR_BANK_CODE,
		AR_CUST_SEQ,
		F_T_StringToDate(AR_ACPT_DT),
		F_T_StringToDate(AR_PUBL_DT),
		AR_PUBL_AMT,
		F_T_StringToDate(AR_EXPR_DT),
		F_T_StringToDate(AR_CHG_EXPR_DT),
		F_T_StringToDate(AR_DUSE_DT),
		F_T_StringToDate(AR_CUST_DOUT_DT),
		F_T_StringToDate(AR_COLL_DT),
		F_T_StringToDate(AR_RETURN_DT),
		AR_DISC_RAT,
		AR_DISC_AMT,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_RESET_SLIP_ID,
		AR_RESET_SLIP_IDSEQ,
		AR_REMARKS
	);
	If AR_CHK_BILL_CLS = 'B' Then
		Begin
			Select
				*
			Into
				lrT_FIN_BILL_KIND
			From	T_FIN_BILL_KIND a
			Where	a.BILL_KIND = AR_BILL_KIND
			And		a.REL_LOAN_KIND_CODE Is Not Null;
			lbFound := True;
		Exception When No_Data_Found Then
			lbFound := False;
		End;
		If lbFound Then
			Select
				SQ_T_LOAN_CONT_NO.NextVal
			Into
				lnLoanCondNo
			From	Dual;
			Insert Into T_FIN_LOAN_CONT
			(
				LOAN_CONT_NO,
				CRTUSERNO,
				CRTDATE,
				MODUSERNO,
				MODDATE,
				LIMIT_AMT,
				BANK_CODE,
				LOAN_CONT_NAME,
				LOAN_CONT_EXPR_DT,
				COMP_CODE,
				REMARK
			)
			Values
			(
				lnLoanCondNo,
				AR_CRTUSERNO,
				SysDate,
				Null,
				Null,
				AR_PUBL_AMT,
				AR_BANK_CODE,
				lrT_FIN_BILL_KIND.BILL_NAME,
				AR_EXPR_DT,
				AR_COMP_CODE,
				''
			);
			Select To_Char(SQ_T_LOAN_NO.NextVal,'000000000000000000000000000000') LOAN_NO 
			Into	lsLoanNo
			From Dual;
			
			Insert Into T_FIN_LOAN_SHEET
			(
				LOAN_CONT_NO,
				LOAN_NO,
				REAL_LOAN_NO,
				CRTUSERNO,
				CRTDATE,
				MODUSERNO,
				MODDATE,
				LOAN_KIND_CODE,
				COMP_CODE,
				LOAN_NAME,
				BANK_CODE,
				LOAN_AMT,
				LIMIT_AMT,
				LOAN_FDT,
				LOAN_EXPR_DT,
				CHG_EXPR_DT,
				REAL_INTR_RATE,
				TITLE_INTR_RATE,
				ORG_REFUND_YEAR,
				ORG_REFUND_DIV_YEAR,
				ORG_REFUND_MONTH,
				ORG_REFUND_FIRST_MONTH,
				INTR_MTHD,
				INTR_REFUND_DAY,
				INTR_REFUND_DIV_MONTH,
				INTR_REFUND_FIRST_DT,
				REMARK
			)
			Values
			(
				lnLoanCondNo,
				lsLoanNo,
				AR_CHK_BILL_NO,
				AR_CRTUSERNO,
				SysDate,
				Null,
				Null,
				lrT_FIN_BILL_KIND.REL_LOAN_KIND_CODE,
				AR_COMP_CODE,
				lrT_FIN_BILL_KIND.BILL_NAME,
				AR_BANK_CODE,
				AR_PUBL_AMT,
				Null,
				AR_PUBL_DT,
				AR_EXPR_DT,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null,
				Null
			);
		End If;
	End If;
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_CHK_BILL_U
(
	AR_CHK_BILL_NO                             VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CHK_BILL_CLS                            VARCHAR2,
	AR_BILL_KIND                               VARCHAR2,
	AR_STAT_CLS                                VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_BANK_CODE                               VARCHAR2,
	AR_CUST_SEQ                                NUMBER,
	AR_ACPT_DT                                 VARCHAR2,
	AR_PUBL_DT                                 VARCHAR2,
	AR_PUBL_AMT                                NUMBER,
	AR_EXPR_DT                                 VARCHAR2,
	AR_CHG_EXPR_DT                             VARCHAR2,
	AR_DUSE_DT                                 VARCHAR2,
	AR_CUST_DOUT_DT                            VARCHAR2,
	AR_COLL_DT                                 VARCHAR2,
	AR_RETURN_DT                               VARCHAR2,
	AR_DISC_RAT                                NUMBER,
	AR_DISC_AMT                                NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_RESET_SLIP_ID                           NUMBER,
	AR_RESET_SLIP_IDSEQ                        NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_CHK_BILL_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_CHK_BILL ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-21)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
Begin
	If AR_CHK_BILL_CLS = 'B' Then
		If AR_STAT_CLS = '1' Then		--�̹���
			If AR_PUBL_DT Is Not Null Then
				Raise_Application_Error(-20009,'�̹�������� �������� �Է��Ͻ� �� �����ϴ�.');
			End If;
			If Nvl(AR_PUBL_AMT,0) <> 0 Then
				Raise_Application_Error(-20009,'�̹�������� ����ݾ��� �Է��Ͻ� �� �����ϴ�.');
			End If;
			If AR_SLIP_ID Is Not Null Then
				Raise_Application_Error(-20009,'������ǥ��ȣ�� �ִ� ���� �̹�����·� ����� �� �����ϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '2' Then	--����
			If AR_PUBL_DT Is Null Then
				Raise_Application_Error(-20009,'��������� �������� �Է��ϼž� �մϴ�.');
			End If;
			If Nvl(AR_PUBL_AMT,0) = 0 Then
				Raise_Application_Error(-20009,'��������� ����ݾ��� �Է��ϼž� �մϴ�.');
			End If;
			If AR_SLIP_ID Is Null Then
				Raise_Application_Error(-20009,'������°� �Ǳ� ���ؼ��� �ݵ�� ��ǥ�� �Բ� ����Ǿ�� �մϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '3' Then	--���
			If AR_DUSE_DT Is Null Then
				Raise_Application_Error(-20009,'�������� ������� �Է��ϼž� �մϴ�.');
			End If;
			If AR_SLIP_ID Is Not Null Then
				Raise_Application_Error(-20009,'������ǥ��ȣ�� �ִ� ���� �����·� ����� �� �����ϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '4' Then	--�н�
			If AR_DUSE_DT Is Null Then
				Raise_Application_Error(-20009,'�нǾ����� �н����� �Է��ϼž� �մϴ�.');
			End If;
			If AR_SLIP_ID Is Not Null Then
				Raise_Application_Error(-20009,'������ǥ��ȣ�� �ִ� ���� �нǻ��·� ����� �� �����ϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '9' Then	--�����ȯ
			If AR_RETURN_DT Is Null Then
				Raise_Application_Error(-20009,'�����ȯ������ �����ȯ���� �Է��ϼž� �մϴ�.');
			End If;
			If AR_SLIP_ID Is Not Null Then
				Raise_Application_Error(-20009,'������ǥ��ȣ�� �ִ� ���� �����ȯ���·� ����� �� �����ϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '0' Then	--��������
			If AR_PUBL_DT Is Null Then
				Raise_Application_Error(-20009,'������������� �������� �Է��ϼž� �մϴ�.');
			End If;
			If AR_SLIP_ID Is Not Null Then
				Raise_Application_Error(-20009,'������ǥ��ȣ�� �ִ� ���� ����������·� ����� �� �����ϴ�.');
			End If;
		End If;
	End If;
	If AR_CHK_BILL_CLS = 'C' Then
		If AR_STAT_CLS = '1' Then		--�̹���
			If AR_PUBL_DT Is Not Null Then
				Raise_Application_Error(-20009,'�̹����ǥ�� �������� �Է��Ͻ� �� �����ϴ�.');
			End If;
			If Nvl(AR_PUBL_AMT,0) <> 0 Then
				Raise_Application_Error(-20009,'�̹����ǥ�� ����ݾ��� �Է��Ͻ� �� �����ϴ�.');
			End If;
			If AR_SLIP_ID Is Not Null Then
				Raise_Application_Error(-20009,'������ǥ��ȣ�� �ִ� ���� �̹�����·� ����� �� �����ϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '2' Then	--����
			If AR_PUBL_DT Is Null Then
				Raise_Application_Error(-20009,'�����ǥ�� �������� �Է��ϼž� �մϴ�.');
			End If;
			If Nvl(AR_PUBL_AMT,0) = 0 Then
				Raise_Application_Error(-20009,'�����ǥ�� ����ݾ��� �Է��ϼž� �մϴ�.');
			End If;
			If AR_SLIP_ID Is Null Then
				Raise_Application_Error(-20009,'������°� �Ǳ� ���ؼ��� �ݵ�� ��ǥ�� �Բ� ����Ǿ�� �մϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '3' Then	--���
			If AR_DUSE_DT Is Null Then
				Raise_Application_Error(-20009,'����ǥ�� ������� �Է��ϼž� �մϴ�.');
			End If;
			If AR_SLIP_ID Is Not Null Then
				Raise_Application_Error(-20009,'������ǥ��ȣ�� �ִ� ���� �����·� ����� �� �����ϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '4' Then	--�н�
			If AR_DUSE_DT Is Null Then
				Raise_Application_Error(-20009,'�нǼ�ǥ�� �н����� �Է��ϼž� �մϴ�.');
			End If;
			If AR_SLIP_ID Is Not Null Then
				Raise_Application_Error(-20009,'������ǥ��ȣ�� �ִ� ���� �нǻ��·� ����� �� �����ϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '9' Then	--�����ȯ
			If AR_RETURN_DT Is Null Then
				Raise_Application_Error(-20009,'�����ȯ��ǥ�� �����ȯ���� �Է��ϼž� �մϴ�.');
			End If;
			If AR_SLIP_ID Is Not Null Then
				Raise_Application_Error(-20009,'������ǥ��ȣ�� �ִ� ���� �����ȯ���·� ����� �� �����ϴ�.');
			End If;
		ElsIf AR_STAT_CLS = '0' Then	--��������
			If AR_PUBL_DT Is Null Then
				Raise_Application_Error(-20009,'���������ǥ�� �������� �Է��ϼž� �մϴ�.');
			End If;
			If AR_SLIP_ID Is Not Null Then
				Raise_Application_Error(-20009,'������ǥ��ȣ�� �ִ� ���� ����������·� ����� �� �����ϴ�.');
			End If;
		End If;
	End If;
	Update T_FIN_PAY_CHK_BILL
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CHK_BILL_CLS = AR_CHK_BILL_CLS,
		BILL_KIND = AR_BILL_KIND,
		STAT_CLS = AR_STAT_CLS,
		COMP_CODE = AR_COMP_CODE,
		BANK_CODE = AR_BANK_CODE,
		CUST_SEQ = AR_CUST_SEQ,
		ACPT_DT = F_T_StringToDate(AR_ACPT_DT),
		PUBL_DT = F_T_StringToDate(AR_PUBL_DT),
		PUBL_AMT = AR_PUBL_AMT,
		EXPR_DT = F_T_StringToDate(AR_EXPR_DT),
		CHG_EXPR_DT = F_T_StringToDate(AR_CHG_EXPR_DT),
		DUSE_DT = F_T_StringToDate(AR_DUSE_DT),
		CUST_DOUT_DT = F_T_StringToDate(AR_CUST_DOUT_DT),
		COLL_DT = F_T_StringToDate(AR_COLL_DT),
		RETURN_DT = F_T_StringToDate(AR_RETURN_DT),
		DISC_RAT = AR_DISC_RAT,
		DISC_AMT = AR_DISC_AMT,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ,
		RESET_SLIP_ID = AR_RESET_SLIP_ID,
		RESET_SLIP_IDSEQ = AR_RESET_SLIP_IDSEQ,
		REMARKS = AR_REMARKS
	Where	CHK_BILL_NO = AR_CHK_BILL_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_CHK_BILL_D
(
	AR_CHK_BILL_NO                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_CHK_BILL_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_CHK_BILL ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-21)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	lrRec					T_FIN_PAY_CHK_BILL%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_PAY_CHK_BILL
		Where	CHK_BILL_NO = AR_CHK_BILL_NO;
	Exception When No_Data_Found Then
		Return;
	End;
	If lrRec.CHK_BILL_CLS = 'B' Then
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'�ش� ������ ���� �� ��ǥ�� ����� ���̹Ƿ� �����Ͻ� �� �����ϴ�.');
		End If;
		If lrRec.STAT_CLS Not In ('1') Then
			Raise_Application_Error(-20009,'�̹��� ������ �����Ͻ� �� �ֽ��ϴ�.');
		End If;
	End If;
	If lrRec.CHK_BILL_CLS = 'C' Then
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'�ش� ��ǥ�� ���� �� ��ǥ�� ����� ���̹Ƿ� �����Ͻ� �� �����ϴ�.');
		End If;
		If lrRec.STAT_CLS Not In ('1') Then
			Raise_Application_Error(-20009,'�̹��� ��ǥ�� �����Ͻ� �� �ֽ��ϴ�.');
		End If;
	End If;
	Delete T_FIN_BILL_CHG_LIST
	Where	CHK_BILL_NO = AR_CHK_BILL_NO;
	Delete T_FIN_PAY_CHK_BILL
	Where	CHK_BILL_NO = AR_CHK_BILL_NO;
End;
/
