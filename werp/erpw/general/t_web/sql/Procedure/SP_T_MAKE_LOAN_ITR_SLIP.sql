Create Or Replace Procedure SP_T_MAKE_LOAN_ITR_SLIP
(
	Ar_Loan_No						Varchar2,
	Ar_Loan_Refund_Seq				Number,
	Ar_Make_Comp_Code				Varchar2,
	Ar_Dept_Code					Varchar2,
	Ar_CrtUserNo					Varchar2
)
Is
	lrRec							T_FIN_LOAN_REFUND_LIST%RowType;
	ls_Work_Code					T_WORK_ACC_CODE.WORK_CODE%Type := 'FF000100';	--���Ա�
	lnAmt							Number;
	lrT_WORK_ACC_CODE				T_WORK_ACC_CODE%ROWTYPE;
	lrT_DEPT_CODE_ORG				T_DEPT_CODE_ORG%ROWTYPE;
	lrT_DEPT_CLASS_CODE				T_DEPT_CLASS_CODE%ROWTYPE;
	lrLoan							T_FIN_LOAN_SHEET%RowType;
	lrLoanKind						T_FIN_LOAN_KIND%RowType;
	lsBankName						T_BANK_MAIN.BANK_MAIN_NAME%Type;
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;
	lrHead							T_ACC_SLIP_HEAD%RowType;
	lsChargePers					T_Acc_Slip_Head.CHARGE_PERS%Type;
	lnMakeSlipLine					Number;
	lsCustName						T_ACC_SLIP_BODY.CUST_NAME%Type;
	lnCustSeq						T_CUST_CODE.CUST_SEQ%Type;
	lrBodyPE						T_ACC_SLIP_BODY%RowType;		--��������
	lrBodyIT						T_ACC_SLIP_BODY%RowType;		--����� ����
	lrBodyAE						T_ACC_SLIP_BODY%RowType;		--�����޺������ ����
	lrOther							T_ACC_SLIP_BODY%RowType;
	lnRemainAmt						Number := 0;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_LOAN_REFUND_LIST
		Where	LOAN_NO = Ar_Loan_No
		And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'���� ������ ã�� �� �����ϴ�.');
	End;
	If lrRec.INTR_SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'�̹� ���� ��ǥ�� ����Ǿ� �ֽ��ϴ�.');
	End If;
	Begin
		Select
			*
		Into
			lrLoan
		From	T_FIN_LOAN_SHEET
		Where	LOAN_NO = Ar_Loan_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'���� ������ ã�� �� �����ϴ�.');
	End;
	If lrLoan.LOAN_KIND_CODE Is Null Then
		Raise_Application_Error(-20009,'���������� �Է��ϼž� �մϴ�.');
	End If;
	Begin
		Select
			*
		Into
			lrLoanKind
		From	T_FIN_LOAN_KIND
		Where	LOAN_KIND_CODE = lrLoan.LOAN_KIND_CODE;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'���� �����ڵ带 ã�� �� �����ϴ�.');
	End;
	Begin
		Select
			BANK_MAIN_NAME
		Into
			lsBankName
		From	t_bank_main a,
				t_bank_code b
		Where	b.BANK_MAIN_CODE = a.BANK_MAIN_CODE
		And		b.BANK_CODE = lrLoan.BANK_CODE;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'���Ա��� ���������� ã�� �� �����ϴ�.');
	End;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);

	If lrRec.ITR_TAG Is Null Then
		Raise_Application_Error(-20009,'������ǥ�� �����Ϸ��� ���ڱ����� �����ϼž� �մϴ�.');
	End If;
	If lrRec.ITR_TAG = '1' Then		--��������
		Raise_Application_Error(-20009,'���� ������ ������������ �Ǵ� �������������� ���� ������ǥ�� �ƴ� ������ǥ�� �����Ͽ��� �մϴ�.');
	ElsIf lrRec.ITR_TAG = '2' Then	--��������
		Raise_Application_Error(-20009,'���� ������ ������������ �Ǵ� �������������� ���� ������ǥ�� �ƴ� ������ǥ�� �����Ͽ��� �մϴ�.');
	ElsIf lrRec.ITR_TAG = '5' Then	--���ݻ�ȯ
		Raise_Application_Error(-20009,'���� ������ ���ݻ�ȯ�� ���� ������ǥ�� �ƴ� ��ȯ��ǥ�� �����Ͽ��� �մϴ�.');
	End If;

	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(ls_Work_Code,Ar_Make_Comp_Code);
	lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.TRANS_DT,'1','B',Ar_CrtUserNo,ls_Work_Code,lsChargePers,Ar_CrtUserNo);
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnCustSeq := PKG_MAKE_SLIP.Get_Dflt_Cust_Seq;
	If lnCustSeq Is Null Then
		Raise_Application_Error(-20009,'���ǰŷ�ó�� �����Ǿ� ���� �ʽ��ϴ�.');
	End If;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);
	If lrRec.ITR_TAG = '3' Then	--�������� ����
		--�������� ������ �������� ��ŭ�� �����ܺ�� �������ڷ� ��ȯ�Ѵ�.
		--���ޱ����ں�� ����
		lnMakeSlipLine := lnMakeSlipLine + 1;
		Begin
			Select
				*
			Into
				lrOther
			From	T_ACC_SLIP_BODY
			Where	SLIP_ID = lrRec.PE_RESET_ITR_ID
			And		SLIP_IDSEQ = lrRec.PE_RESET_ITR_IDSEQ;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'���޺�� ���������� ������ǥ�� ã�� �� �����ϴ�.');
		End;
		lrBodyPE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.PE_ITR_ACC_CODE,lsClassCode,Null);
		lrBodyPE.CR_AMt := Nvl(lrRec.PE_RESET_ITR_AMT,0);
		lrBodyPE.TAX_COMP_CODE := Ar_Make_Comp_Code;
		lrBodyPE.COMP_CODE := Ar_Make_Comp_Code;
		lrBodyPE.DEPT_CODE := Ar_Dept_Code;
		lrBodyPE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
		lrBodyPE.CUST_SEQ := lnCustSeq;
		lrBodyPE.CUST_NAME := lsCustName;
		lrBodyPE.RESET_SLIP_ID := lrRec.PE_RESET_ITR_ID;
		lrBodyPE.RESET_SLIP_IDSEQ := lrRec.PE_RESET_ITR_IDSEQ;
		lrBodyPE.LOAN_REFUND_NO := Ar_Loan_No;
		lrBodyPE.LOAN_NO := Ar_Loan_No;
		lrBodyPE.BANK_CODE := lrLoan.BANK_CODE;
		lrBodyPE.ACCNO := lrOther.ACCNO;
		PKG_MAKE_SLIP.Insert_Body(lrBodyPE);

		lnMakeSlipLine := lnMakeSlipLine + 1;
		lrBodyIT := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.ITR_ACC_CODE,lsClassCode,Null);
		lrBodyIT.DB_AMt := Nvl(lrRec.PE_RESET_ITR_AMT,0);
		lrBodyIT.TAX_COMP_CODE := Ar_Make_Comp_Code;
		lrBodyIT.COMP_CODE := Ar_Make_Comp_Code;
		lrBodyIT.DEPT_CODE := Ar_Dept_Code;
		lrBodyIT.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
		lrBodyIT.CUST_SEQ := lnCustSeq;
		lrBodyIT.CUST_NAME := lsCustName;
		lrBodyIT.LOAN_REFUND_NO := Ar_Loan_No;
		lrBodyIT.LOAN_NO := Ar_Loan_No;
		lrBodyIT.BANK_CODE := lrLoan.BANK_CODE;
		lrBodyIT.ACCNO := lrOther.ACCNO;
		PKG_MAKE_SLIP.Insert_Body(lrBodyIT);
		Update	T_FIN_LOAN_REFUND_LIST
		Set		INTR_SLIP_ID = lrBodyPE.SLIP_ID,
				INTR_SLIP_IDSEQ = lrBodyPE.SLIP_IDSEQ
		Where	LOAN_NO = Ar_Loan_No
		And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;
	ElsIf lrRec.ITR_TAG = '4' Then	--�������� ����
		Null;
	Else
		Raise_Application_Error(-20009,'�˼� ���� ���ڱ����Դϴ�.');
	End If;
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
