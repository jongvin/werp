Create Or Replace Procedure SP_T_FIN_MAKE_AEITR_SLIP
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
	lrOtherSlip						T_ACC_SLIP_BODY%rowType;
	lnAmt							Number;
	lrBody1							T_ACC_SLIP_BODY%RowType;
	lrBody2							T_ACC_SLIP_BODY%RowType;
	lrBodyPE						T_ACC_SLIP_BODY%RowType;		--��������
	lrBodyAE						T_ACC_SLIP_BODY%RowType;		--������ ����
	lrBodyIT						T_ACC_SLIP_BODY%RowType;		--����� ����
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;
	lsBankName						T_BANK_MAIN.BANK_MAIN_NAME%Type;

	lrHead							T_ACC_SLIP_HEAD%RowType;
	lsChargePers					T_Acc_Slip_Head.CHARGE_PERS%Type;
	lnMakeSlipLine					Number;
	lsCustName						T_ACC_SLIP_BODY.CUST_NAME%Type;
	lnCustSeq						T_CUST_CODE.CUST_SEQ%Type;
	lnRemainAmt						Number;
	lrReset							T_ACC_SLIP_BODY%Rowtype;
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

	lnAmt := Nvl(lrRec.INTR_AMT,0);

	If lnAmt <= 0 Then
		Raise_Application_Error(-20009,'���ڱݾ��� 0���� �۰ų� ���� ���� �����ϴ�.');
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
	lnCustSeq := lrOther.CUST_SEQ;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);

	If lrRec.ITR_TAG = '4' Then	--�������� ����
		--���� ���� ������ ����� ������ �̸� �����մϴ�.
		If lrRec.AE_RESET_ITR_ID Is Not Null Then
			Begin
				Select
					*
				Into
					lrReset
				From	T_ACC_SLIP_BODY
				Where	SLIP_ID = lrRec.AE_RESET_ITR_ID
				And		SLIP_IDSEQ = lrRec.AE_RESET_ITR_IDSEQ;
				Begin
					Select
						Nvl(a.CR_AMT,0) - 
						(
							Select
								Nvl(Nvl(Sum(cc.DB_AMT),0) + Nvl(Sum(- cc.CR_AMT),0),0)
							From	T_ACC_SLIP_BODY1 cc
							Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
							And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
							And		cc.KEEP_DT Is Not Null
							And
							(
									cc.SLIP_ID <> cc.RESET_SLIP_ID
								Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
							)
						)
					Into
						lnRemainAmt
					From	T_ACC_SLIP_BODY1 a
					Where	a.SLIP_ID = lrRec.AE_RESET_ITR_ID
					And		a.SLIP_IDSEQ = lrRec.AE_RESET_ITR_IDSEQ;
				Exception When No_Data_Found Then
					lnRemainAmt := 0;
				End;
				lnMakeSlipLine := lnMakeSlipLine + 1;
				lrBodyAE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.AE_ITR_ACC_CODE,lsClassCode,Null);
				lrBodyAE.DB_AMT := lnRemainAmt;
				lrBodyAE.TAX_COMP_CODE := Ar_Make_Comp_Code;
				lrBodyAE.COMP_CODE := Ar_Make_Comp_Code;
				lrBodyAE.DEPT_CODE := Ar_Dept_Code;
				lrBodyAE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
				lrBodyAE.CUST_SEQ := lnCustSeq;
				lrBodyAE.CUST_NAME := lsCustName;
				lrBodyAE.RESET_SLIP_ID := lrRec.AE_RESET_ITR_ID;
				lrBodyAE.RESET_SLIP_IDSEQ := lrRec.AE_RESET_ITR_IDSEQ;
				lrBodyAE.LOAN_REFUND_NO := Ar_Loan_No;
				lrBodyAE.LOAN_NO := Ar_Loan_No;
				lrBodyAE.BANK_CODE := lrLoan.BANK_CODE;
				lrBodyAE.ACCNO := lrReset.ACCNO;
				PKG_MAKE_SLIP.Insert_Body(lrBodyAE);
			Exception When No_Data_Found Then
				Null;
			End;
		End If;
		--�����ܺ�� ���� ���� ����
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lrBodyIT := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.ITR_ACC_CODE,lsClassCode,Null);
		lrBodyIT.DB_AMT := Nvl(lrRec.INTR_AMT,0) - Nvl(lnRemainAmt,0);
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
		--���� ����
		--������ ����
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
		lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrOther.ACC_CODE,lrOther.CLASS_CODE,Null);
		PKG_MAKE_SLIP.CopySlipBodyFromTemp(lrOther,lrBody2);
		lrBody2.CR_AMT := lnAmt;
		lrBody2.TAX_COMP_CODE := Ar_Make_Comp_Code;
		lrBody2.COMP_CODE := Ar_Make_Comp_Code;
		lrBody2.DEPT_CODE := Ar_Dept_Code;
		lrBody2.FIX_ASSET_SEQ := lrOther.FIX_ASSET_SEQ;
		PKG_MAKE_SLIP.Insert_Body(lrBody2);
	
		--��ǥ ���� ��ȣ�� ����ģ��.
	
		Update	T_FIN_LOAN_REFUND_LIST
		Set		INTR_SLIP_ID = lrBody2.SLIP_ID,
				INTR_SLIP_IDSEQ = lrBody2.SLIP_IDSEQ
		Where	LOAN_NO = Ar_Loan_No
		And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;
		
		If Nvl(lrRec.AE_ITR_AMT,0) <> 0 Then	--������ ������ �ִٸ�...
			--�����ܺ�� ���� ���� ����(�����޺�)
			lnMakeSlipLine := lnMakeSlipLine + 1;
			lrBodyIT := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.ITR_ACC_CODE,lsClassCode,Null);
			lrBodyIT.DB_AMT := Nvl(lrRec.AE_ITR_AMT,0);
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
			--
			lnMakeSlipLine := lnMakeSlipLine + 1;
			lrBodyAE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.AE_ITR_ACC_CODE,lsClassCode,Null);
			lrBodyAE.CR_AMT := Nvl(lrRec.AE_ITR_AMT,0);
			lrBodyAE.TAX_COMP_CODE := Ar_Make_Comp_Code;
			lrBodyAE.COMP_CODE := Ar_Make_Comp_Code;
			lrBodyAE.DEPT_CODE := Ar_Dept_Code;
			lrBodyAE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
			lrBodyAE.CUST_SEQ := lnCustSeq;
			lrBodyAE.CUST_NAME := lsCustName;
			lrBodyAE.RESET_SLIP_ID := lrBodyAE.SLIP_ID;
			lrBodyAE.RESET_SLIP_IDSEQ := lrBodyAE.SLIP_IDSEQ;
			lrBodyAE.LOAN_REFUND_NO := Ar_Loan_No;
			lrBodyAE.LOAN_NO := Ar_Loan_No;
			lrBodyAE.BANK_CODE := lrLoan.BANK_CODE;
			lrBodyAE.ACCNO := lrOther.ACCNO;
			PKG_MAKE_SLIP.Insert_Body(lrBodyAE);
		End If;
	ElsIf lrRec.ITR_TAG = '7' Then	--�������� ����
		--���� �������ڰ� ������ �̸� �����Ѵ�
		If lrRec.PE_RESET_ITR_ID Is Not Null Then
			lnMakeSlipLine := lnMakeSlipLine + 1;
			Begin
				Select
					*
				Into
					lrOtherSlip
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
			lrBodyPE.ACCNO := lrOtherSlip.ACCNO;
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
			lrBodyIT.ACCNO := lrOtherSlip.ACCNO;
			PKG_MAKE_SLIP.Insert_Body(lrBodyIT);
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
				lrBodyIT.ACCNO := lrOtherSlip.ACCNO;
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
				lrBodyPE.ACCNO := lrOtherSlip.ACCNO;
				PKG_MAKE_SLIP.Insert_Body(lrBodyPE);
			End If;
			--���� ����
			--������ ����
			lnMakeSlipLine := lnMakeSlipLine + 1;
			lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
			lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrOther.ACC_CODE,lrOther.CLASS_CODE,Null);
			PKG_MAKE_SLIP.CopySlipBodyFromTemp(lrOther,lrBody2);
			lrBody2.CR_AMT := lnAmt;
			lrBody2.TAX_COMP_CODE := Ar_Make_Comp_Code;
			lrBody2.COMP_CODE := Ar_Make_Comp_Code;
			lrBody2.DEPT_CODE := Ar_Dept_Code;
			lrBody2.FIX_ASSET_SEQ := lrOther.FIX_ASSET_SEQ;
			PKG_MAKE_SLIP.Insert_Body(lrBody2);
			Update	T_FIN_LOAN_REFUND_LIST
			Set		INTR_SLIP_ID = lrBodyPE.SLIP_ID,
					INTR_SLIP_IDSEQ = lrBodyPE.SLIP_IDSEQ
			Where	LOAN_NO = Ar_Loan_No
			And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;
		End If;
	End If;
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
