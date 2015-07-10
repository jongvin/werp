Create Or Replace Procedure SP_T_FIN_MAKE_LOAN_SLIP
(
	Ar_Work_Slip_Id					Number,
	Ar_Work_Slip_IdSeq				Number,
	Ar_Work_Code					Varchar2,
	Ar_Make_Comp_Code				Varchar2,
	Ar_Dept_Code					Varchar2,
	Ar_Loan_No						Varchar2,
	Ar_Loan_Refund_Seq				Number,
	Ar_CrtUserNo					Varchar2
)
Is
	lrRec							T_FIN_LOAN_REFUND_LIST%RowType;
	lrLoan							T_FIN_LOAN_SHEET%RowType;
	lrLoanKind						T_FIN_LOAN_KIND%RowType;
	lrOther							T_WORK_ACC_SLIP_BODY%RowType;
	lnAmt							Number;
	lrBody1							T_ACC_SLIP_BODY%RowType;
	lrBody2							T_ACC_SLIP_BODY%RowType;
	lrBodyPE						T_ACC_SLIP_BODY%RowType;		--��������
	lrBodyIT						T_ACC_SLIP_BODY%RowType;		--����� ����
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;
	lsBankName						T_BANK_MAIN.BANK_MAIN_NAME%Type;

	lrHead						T_ACC_SLIP_HEAD%RowType;
	lsChargePers				T_Acc_Slip_Head.CHARGE_PERS%Type;
	lnMakeSlipLine				Number;
	lsCustName					T_ACC_SLIP_BODY.CUST_NAME%Type;
	lnCustSeq					T_CUST_CODE.CUST_SEQ%Type;
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
	If lrRec.ITR_TAG Is Null Then
		Raise_Application_Error(-20009,'������ǥ�� �����Ϸ��� ���ڱ����� �����ϼž� �մϴ�.');
	End If;
	If lrRec.LOAN_SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'�̹� ������ǥ�� ����Ǿ� �ֽ��ϴ�.��ǥ�� �����ϼž� �� ���� �Ͻ� �� �ֽ��ϴ�.');
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


	If lrRec.ITR_TAG = '1' Then		--��������
		lnAmt := Nvl(lrRec.LOAN_AMT,0) - Nvl(lrRec.INTR_AMT,0);		--������ ��� ���ڱݾ��� �����Ѵ�.
	ElsIf lrRec.ITR_TAG = '2' Then	--��������
		lnAmt := Nvl(lrRec.LOAN_AMT,0);
	Else
		Raise_Application_Error(-20009,'������ǥ�� ���ڱ����� ������������ �Ǵ� ���������������� �����ϼž� �մϴ�.');
	End If;
	If lnAmt <= 0 Then
		Raise_Application_Error(-20009,'���Աݾ��� 0���� �۰ų� ���� ���� �����ϴ�.');
	End If;
	Begin
		Select
			*
		Into
			lrOther
		From	T_WORK_ACC_SLIP_BODY
		Where	SLIP_ID = Ar_Work_Slip_Id
		And		SLIP_IDSEQ = Ar_Work_Slip_IdSeq;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'��뺯 ������ ã�� �� �����ϴ�.');
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

	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(Ar_Work_Code,Ar_Make_Comp_Code);
	--���Ұ����� �����̸� ������ǥ �ƴϸ� ��ä��ǥ
	If PKG_MAKE_SLIP.IsCashAccCode(lrOther.ACC_CODE) Then
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.TRANS_DT,'2','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	Else
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.TRANS_DT,'1','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	End If;
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnCustSeq := lrOther.Cust_Seq;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);

	--���Ա� ����
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
	lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.LOAN_ACC_CODE,lsClassCode,Null);
	lrBody1.CR_AMT := lrRec.LOAN_AMT;
	lrBody1.TAX_COMP_CODE := Ar_Make_Comp_Code;
	lrBody1.COMP_CODE := Ar_Make_Comp_Code;
	lrBody1.DEPT_CODE := Ar_Dept_Code;
	lrBody1.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
	lrBody1.CUST_SEQ := lnCustSeq;
	lrBody1.CUST_NAME := lsCustName;
	lrBody1.RESET_SLIP_ID := lrHead.SLIP_ID;				--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
	lrBody1.RESET_SLIP_IDSEQ := lrBody1.SLIP_IDSEQ;			--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
	lrBody1.LOAN_REFUND_NO := Ar_Loan_No;
	lrBody1.LOAN_NO := Ar_Loan_No;
	lrBody1.BANK_CODE := lrLoan.BANK_CODE;
	lrBody1.ACCNO := lrOther.ACCNO;
	PKG_MAKE_SLIP.Insert_Body(lrBody1);

	--��ǥ ���� ��ȣ�� ����ģ��.

	Update	T_FIN_LOAN_REFUND_LIST
	Set		LOAN_SLIP_ID = lrHead.SLIP_ID,
			LOAN_SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
	Where	LOAN_NO = Ar_Loan_No
	And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;

	--���������� ��� ����� ������ ���ݾװ� ��� ������ ���޺�� ������ �����Ѵ�.
	If lrRec.ITR_TAG = '1' Then		--��������
		If Nvl(lrRec.INTR_AMT,0) = 0 Then		--���� ���ڰ� ���ٸ�?	�۾� ������
			Null;
		Else
			If Nvl(lrRec.INTR_AMT,0) = Nvl(lrRec.PE_ITR_AMT,0) Then		--���ڰ� ���� �������ڶ�� ����� ���� ����� ���� ���̴�.
				Null;
			Else
				lnMakeSlipLine := lnMakeSlipLine + 1;
				lrBodyIT := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.ITR_ACC_CODE,lsClassCode,Null);
				lrBodyIT.DB_AMt := Nvl(lrRec.INTR_AMT,0) - Nvl(lrRec.PE_ITR_AMT,0);
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
			End If;
			If Nvl(lrRec.PE_ITR_AMT,0) = 0 Then		--�������ڰ� 0�̸� �������� ���� ���� ���̴�.
				Null;
			Else
				lnMakeSlipLine := lnMakeSlipLine + 1;
				lrBodyPE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.PE_ITR_ACC_CODE,lsClassCode,Null);
				lrBodyPE.DB_AMt := Nvl(lrRec.PE_ITR_AMT,0);
				lrBodyPE.TAX_COMP_CODE := Ar_Make_Comp_Code;
				lrBodyPE.COMP_CODE := Ar_Make_Comp_Code;
				lrBodyPE.DEPT_CODE := Ar_Dept_Code;
				lrBodyPE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
				lrBodyPE.CUST_SEQ := lnCustSeq;
				lrBodyPE.CUST_NAME := lsCustName;
				lrBodyPE.RESET_SLIP_ID := lrBodyPE.SLIP_ID;				--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
				lrBodyPE.RESET_SLIP_IDSEQ := lrBodyPE.SLIP_IDSEQ;		--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
				lrBodyPE.LOAN_REFUND_NO := Ar_Loan_No;
				lrBodyPE.LOAN_NO := Ar_Loan_No;
				lrBodyPE.BANK_CODE := lrLoan.BANK_CODE;
				lrBodyPE.ACCNO := lrOther.ACCNO;
				PKG_MAKE_SLIP.Insert_Body(lrBodyPE);
			End If;
		End If;
	End If;

	--������ ����
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
	lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrOther.ACC_CODE,lrOther.CLASS_CODE,Null);
	PKG_MAKE_SLIP.CopySlipBodyFromTemp(lrOther,lrBody2);
	lrBody2.DB_AMT := lnAmt;
	lrBody2.TAX_COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.DEPT_CODE := Ar_Dept_Code;
	PKG_MAKE_SLIP.Insert_Body(lrBody2);
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
