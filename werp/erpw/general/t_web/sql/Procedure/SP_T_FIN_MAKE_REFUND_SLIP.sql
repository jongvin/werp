Create Or Replace Procedure SP_T_FIN_MAKE_REFUND_SLIP
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
	lrBodyAE						T_ACC_SLIP_BODY%RowType;		--����������
	lrBodyIT						T_ACC_SLIP_BODY%RowType;		--����� ����
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;
	lsBankName						T_BANK_MAIN.BANK_MAIN_NAME%Type;

	lrHead							T_ACC_SLIP_HEAD%RowType;
	lsChargePers					T_Acc_Slip_Head.CHARGE_PERS%Type;
	lnMakeSlipLine					Number;
	lsCustName						T_ACC_SLIP_BODY.CUST_NAME%Type;
	lnCustSeq						T_CUST_CODE.CUST_SEQ%Type;
	lnRefundAmt						Number;
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
	If lrRec.REFUND_SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'�̹� ��ȯ��ǥ�� ����Ǿ� �ֽ��ϴ�.��ǥ�� �����ϼž� �� ���� �Ͻ� �� �ֽ��ϴ�.');
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

	--���� ������ ��ȯ�Ѵ�.
	--������ǥ�� �����´�.
	lnRefundAmt := Nvl(lrRec.REFUND_AMT,0);
	If lnRefundAmt <= 0 Then
		Raise_Application_Error(-20009,'��ȯ�ݾ��� 0���� �۰ų� ���� ���� �����ϴ�.');
	End If;
	For lrA In (
		Select
			a.SLIP_ID ,
			a.SLIP_IDSEQ ,
			a.MAKE_SLIPLINE ,
			a.ACC_CODE ,
			a.DB_AMT ,
			a.CR_AMT ,
			a.SUMMARY_CODE ,
			a.TAX_COMP_CODE ,
			a.COMP_CODE ,
			a.DEPT_CODE ,
			a.CLASS_CODE ,
			a.VAT_CODE ,
			a.VAT_DT ,
			a.SUPAMT ,
			a.VATAMT ,
			a.CUST_SEQ ,
			a.CUST_NAME ,
			a.BANK_CODE ,
			a.ACCNO ,
			a.RESET_SLIP_ID ,
			a.RESET_SLIP_IDSEQ ,
			a.MAKE_COMP_CODE ,
			a.MAKE_DEPT_CODE ,
			a.MAKE_DT ,
			a.KEEP_DT ,
			a.ORG_SLIP_ID ,
			a.ORG_SLIP_IDSEQ ,
			a.SLIP_KIND_TAG ,
			a.TRANSFER_TAG ,
			a.IGNORE_SET_RESET_TAG ,
			a.CRTUSERNO ,
			a.CRTDATE ,
			a.MODUSERNO ,
			a.MODDATE ,
			a.SUMMARY1 ,
			a.SUMMARY2 ,
			a.CHK_NO ,
			a.BILL_NO ,
			a.REC_BILL_NO ,
			a.CP_NO ,
			a.SECU_NO ,
			a.LOAN_NO ,
			a.LOAN_REFUND_NO ,
			a.LOAN_REFUND_SEQ ,
			a.DEPOSIT_ACCNO ,
			a.PAYMENT_SEQ ,
			a.PAY_CON_CASH ,
			a.PAY_CON_BILL ,
			a.PAY_CON_BILL_DT ,
			a.PAY_CON_BILL_DAYS ,
			a.EMP_NO ,
			a.ANTICIPATION_DT ,
			a.MNG_ITEM_CHAR1 ,
			a.MNG_ITEM_CHAR2 ,
			a.MNG_ITEM_CHAR3 ,
			a.MNG_ITEM_CHAR4 ,
			a.MNG_ITEM_NUM1 ,
			a.MNG_ITEM_NUM2 ,
			a.MNG_ITEM_NUM3 ,
			a.MNG_ITEM_NUM4 ,
			a.MNG_ITEM_DT1 ,
			a.MNG_ITEM_DT2 ,
			a.MNG_ITEM_DT3 ,
			a.MNG_ITEM_DT4 ,
			a.FIX_ASSET_SEQ,
			Nvl(a.CR_AMT,0) - 
			Nvl((
				Select
					Nvl(Sum(cc.DB_AMT),0) + Nvl(Sum(- cc.CR_AMT),0)
				From	T_ACC_SLIP_BODY1 cc
				Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
				And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
				And		cc.KEEP_DT Is Not Null
				And
				(
						cc.SLIP_ID <> cc.RESET_SLIP_ID
					Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
				)
			),0) REMAIN_AMT
		From	T_ACC_SLIP_BODY a
		Where	a.ACC_CODE = lrLoanKind.LOAN_ACC_CODE
		And		a.KEEP_DT Is Not Null
		And		a.LOAN_REFUND_NO = lrRec.LOAN_NO
		And		a.SLIP_ID = a.RESET_SLIP_ID
		And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
		And		Nvl(a.CR_AMT,0) - 
							Nvl((
								Select
									Nvl(Sum(cc.DB_AMT),0) + Nvl(Sum(- cc.CR_AMT),0)
								From	T_ACC_SLIP_BODY1 cc
								Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
								And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
								And		cc.KEEP_DT Is Not Null
								And
								(
										cc.SLIP_ID <> cc.RESET_SLIP_ID
									Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
								)
							),0) > 0)
	Loop
		If lnRefundAmt >= Nvl(lrA.REMAIN_AMT,0) then	--���� �̹��ܾ� �� �� �۴ٸ�
			lnAmt := Nvl(lrA.REMAIN_AMT,0);
			lnRefundAmt := lnRefundAmt - lnAmt;
		Else
			lnAmt := lnRefundAmt;
			lnRefundAmt := 0;
		End If;
		--���Ա� ��ȯ ����
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.LOAN_ACC_CODE,lsClassCode,Null);
		lrBody1.DB_AMT := lnAmt;
		lrBody1.TAX_COMP_CODE := Ar_Make_Comp_Code;
		lrBody1.COMP_CODE := Ar_Make_Comp_Code;
		lrBody1.DEPT_CODE := Ar_Dept_Code;
		lrBody1.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
		lrBody1.CUST_SEQ := lnCustSeq;
		lrBody1.CUST_NAME := lsCustName;
		lrBody1.RESET_SLIP_ID := lrA.SLIP_ID;				--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
		lrBody1.RESET_SLIP_IDSEQ := lrA.SLIP_IDSEQ;			--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
		lrBody1.LOAN_REFUND_NO := Ar_Loan_No;
		lrBody1.LOAN_NO := Ar_Loan_No;
		lrBody1.BANK_CODE := lrLoan.BANK_CODE;
		lrBody1.ACCNO := lrOther.ACCNO;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
	End Loop;
	If lnRefundAmt > 0 Then
		Raise_Application_Error(-20009,'��ȯ�ݾ��� ���� �ܾ��� �ʰ��մϴ�.'||to_char(lnRefundAmt));
	End If;
	--��ǥ ���� ��ȣ�� ����ģ��.

	Update	T_FIN_LOAN_REFUND_LIST
	Set		REFUND_SLIP_ID = lrBody1.SLIP_ID,
			REFUND_SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
	Where	LOAN_NO = Ar_Loan_No
	And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;

	If lrRec.ITR_TAG = '5' Then		--�������� ���� ��ȯ
		--���� ��ȯ�� ���ڰ� �ִٸ� �̴� ������ �����̴�...�� ���� ��ȯ�� ���� ������ ���Ѵ�.
		--���� ���� �ݾ��� ���޺�뿡�� ���� �����Ǿ�� �Ѵ�
		--��� ���޺�� �ݾ��� ���� ���� �Ǿ�� �Ѵ�.
		--������ ��� ���������� �ݾ��� ���� �Ѿװ� ���ƾ� �Ѵ�.

		Declare
			lnPrevPESETSum				Number;
			lnPrevPERESETSum			Number;
			lnPrevEXDBSum				Number;
			lnTotItrAmt					Number;
			lnPERemain					Number;
			lnPEResetTarget				Number;
			lnCrAmt						Number;
			lnDbAmt						Number;
		Begin
			--���� ���޺�� ���� �հ豸�ϱ�
			Begin
				Select
					Nvl(Sum(DB_AMT),0),
					Nvl(Sum(CR_AMT),0)
				Into
					lnPrevPESETSum,
					lnPrevPERESETSum
				From	T_ACC_SLIP_BODY
				Where	LOAN_REFUND_NO = lrRec.LOAN_NO
				And		KEEP_DT Is Not Null
				And		ACC_CODE = lrLoanKind.PE_ITR_ACC_CODE;
			Exception When No_Data_Found Then	--���� �����Լ������� �� ������ �߻������� �ʽ��ϴ�.
				lnPrevPESETSum := 0;
				lnPrevPERESETSum := 0;
			End;
			--���� �����ܺ�� �������� ���ϱ�
			Begin
				Select
					Nvl(Sum(DB_AMT),0)
				Into
					lnPrevEXDBSum
				From	T_ACC_SLIP_BODY
				Where	LOAN_REFUND_NO = lrRec.LOAN_NO
				And		KEEP_DT Is Not Null
				And		ACC_CODE = lrLoanKind.ITR_ACC_CODE;
			Exception When No_Data_Found Then	--���� �����Լ������� �� ������ �߻������� �ʽ��ϴ�.
				lnPrevEXDBSum := 0;
			End;
			--�ش� ������ ���� �Ѿ��� ���Ѵ�.
			Begin
				Select
					Nvl(Sum(a.INTR_AMT),0)
				Into
					lnTotItrAmt
				From	T_FIN_LOAN_REFUND_LIST a
				Where	LOAN_NO = lrRec.LOAN_NO
				And		REFUND_INTR_DT <= lrRec.REFUND_INTR_DT;
			Exception When No_Data_Found Then	--���� �����Լ������� �� ������ �߻������� �ʽ��ϴ�.
				lnTotItrAmt := 0;
			End;
			--���� ���ڰ� �ִٸ�...
			--�̴� ���� �����̸� ���޺�� ���� �׸��̸� ������ ��뿡�� ������ �Ѵ�...
			If Nvl(lrRec.INTR_AMT,0) < 0 then
				lnPERemain := - Nvl(lrRec.INTR_AMT,0);
			Else
				lnPERemain := 0;
			End If;
			lnPEResetTarget := lnPrevPESETSum - lnPrevPERESETSum;
			If lnPEResetTarget > 0 Then		--���� �ܾ��� ���� �ִٸ�
				For lrB In (
					Select
						a.SLIP_ID ,
						a.SLIP_IDSEQ ,
						a.MAKE_SLIPLINE ,
						a.ACC_CODE ,
						a.DB_AMT ,
						a.CR_AMT ,
						a.SUMMARY_CODE ,
						a.TAX_COMP_CODE ,
						a.COMP_CODE ,
						a.DEPT_CODE ,
						a.CLASS_CODE ,
						a.VAT_CODE ,
						a.VAT_DT ,
						a.SUPAMT ,
						a.VATAMT ,
						a.CUST_SEQ ,
						a.CUST_NAME ,
						a.BANK_CODE ,
						a.ACCNO ,
						a.RESET_SLIP_ID ,
						a.RESET_SLIP_IDSEQ ,
						a.MAKE_COMP_CODE ,
						a.MAKE_DEPT_CODE ,
						a.MAKE_DT ,
						a.KEEP_DT ,
						a.ORG_SLIP_ID ,
						a.ORG_SLIP_IDSEQ ,
						a.SLIP_KIND_TAG ,
						a.TRANSFER_TAG ,
						a.IGNORE_SET_RESET_TAG ,
						a.CRTUSERNO ,
						a.CRTDATE ,
						a.MODUSERNO ,
						a.MODDATE ,
						a.SUMMARY1 ,
						a.SUMMARY2 ,
						a.CHK_NO ,
						a.BILL_NO ,
						a.REC_BILL_NO ,
						a.CP_NO ,
						a.SECU_NO ,
						a.LOAN_NO ,
						a.LOAN_REFUND_NO ,
						a.LOAN_REFUND_SEQ ,
						a.DEPOSIT_ACCNO ,
						a.PAYMENT_SEQ ,
						a.PAY_CON_CASH ,
						a.PAY_CON_BILL ,
						a.PAY_CON_BILL_DT ,
						a.PAY_CON_BILL_DAYS ,
						a.EMP_NO ,
						a.ANTICIPATION_DT ,
						a.MNG_ITEM_CHAR1 ,
						a.MNG_ITEM_CHAR2 ,
						a.MNG_ITEM_CHAR3 ,
						a.MNG_ITEM_CHAR4 ,
						a.MNG_ITEM_NUM1 ,
						a.MNG_ITEM_NUM2 ,
						a.MNG_ITEM_NUM3 ,
						a.MNG_ITEM_NUM4 ,
						a.MNG_ITEM_DT1 ,
						a.MNG_ITEM_DT2 ,
						a.MNG_ITEM_DT3 ,
						a.MNG_ITEM_DT4 ,
						a.FIX_ASSET_SEQ,
						Nvl(a.DB_AMT,0) - 
						Nvl((
							Select
								Nvl(Sum(cc.CR_AMT),0) + Nvl(Sum(- cc.DB_AMT),0)
							From	T_ACC_SLIP_BODY1 cc
							Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
							And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
							And		cc.KEEP_DT Is Not Null
							And
							(
									cc.SLIP_ID <> cc.RESET_SLIP_ID
								Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
							)
						),0) REMAIN_AMT
					From	T_ACC_SLIP_BODY a
					Where	a.ACC_CODE = lrLoanKind.PE_ITR_ACC_CODE
					And		a.KEEP_DT Is Not Null
					And		a.LOAN_REFUND_NO = lrRec.LOAN_NO
					And		a.SLIP_ID = a.RESET_SLIP_ID
					And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
					And		Nvl(a.DB_AMT,0) - 
										Nvl((
											Select
												Nvl(Sum(cc.CR_AMT),0) + Nvl(Sum(- cc.DB_AMT),0)
											From	T_ACC_SLIP_BODY1 cc
											Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
											And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
											And		cc.KEEP_DT Is Not Null
											And
											(
													cc.SLIP_ID <> cc.RESET_SLIP_ID
												Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
											)
										),0) > 0)
				Loop
					lnCrAmt := 0;
					lnDbAmt := 0;
					If lnPERemain > 0 Then		--���� ������ �κ��� ���� ���� �ִٸ�
						If lnPERemain >= Nvl(lrB.REMAIN_AMT,0) then	--���� �̹��ܾ� �� �� �۴ٸ�
							lnDbAmt := - Nvl(lrB.REMAIN_AMT,0);
							lnPERemain := lnPERemain + lnDbAmt;
							lnPEResetTarget := lnPEResetTarget + lnDbAmt;
						Else
							lnDbAmt := - lnPERemain;
							lnPERemain := 0;
							lnPEResetTarget := lnPEResetTarget + lnDbAmt;
						End If;
						--���޺�� ��������
						lnMakeSlipLine := lnMakeSlipLine + 1;
						lrBodyPE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.PE_ITR_ACC_CODE,lsClassCode,Null);
						lrBodyPE.DB_AMT := lnDbAmt;
						lrBodyPE.CR_AMT := lnCrAmt;
						lrBodyPE.TAX_COMP_CODE := Ar_Make_Comp_Code;
						lrBodyPE.COMP_CODE := Ar_Make_Comp_Code;
						lrBodyPE.DEPT_CODE := Ar_Dept_Code;
						lrBodyPE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
						lrBodyPE.CUST_SEQ := lnCustSeq;
						lrBodyPE.CUST_NAME := lsCustName;
						lrBodyPE.RESET_SLIP_ID := lrB.SLIP_ID;				--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
						lrBodyPE.RESET_SLIP_IDSEQ := lrB.SLIP_IDSEQ;			--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
						lrBodyPE.LOAN_REFUND_NO := Ar_Loan_No;
						lrBodyPE.LOAN_NO := Ar_Loan_No;
						lrBodyPE.BANK_CODE := lrLoan.BANK_CODE;
						lrBodyPE.ACCNO := lrB.ACCNO;
						PKG_MAKE_SLIP.Insert_Body(lrBodyPE);
					End If;
					lnCrAmt := 0;
					lnDbAmt := 0;
					If lnPERemain = 0 Then
						If lnPEResetTarget >= Nvl(lrB.REMAIN_AMT,0) then	--���� �̹��ܾ� �� �� �۴ٸ�
							lnCrAmt := Nvl(lrB.REMAIN_AMT,0);
							lnPEResetTarget := lnPEResetTarget - lnCrAmt;
						Else
							lnCrAmt := lnPEResetTarget;
							lnPEResetTarget := lnPEResetTarget - lnCrAmt;
						End If;
					End If;
					--���޺�� ��������
					lnMakeSlipLine := lnMakeSlipLine + 1;
					lrBodyPE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.PE_ITR_ACC_CODE,lsClassCode,Null);
					lrBodyPE.DB_AMT := lnDbAmt;
					lrBodyPE.CR_AMT := lnCrAmt;
					lrBodyPE.TAX_COMP_CODE := Ar_Make_Comp_Code;
					lrBodyPE.COMP_CODE := Ar_Make_Comp_Code;
					lrBodyPE.DEPT_CODE := Ar_Dept_Code;
					lrBodyPE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
					lrBodyPE.CUST_SEQ := lnCustSeq;
					lrBodyPE.CUST_NAME := lsCustName;
					lrBodyPE.RESET_SLIP_ID := lrB.SLIP_ID;				--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
					lrBodyPE.RESET_SLIP_IDSEQ := lrB.SLIP_IDSEQ;			--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
					lrBodyPE.LOAN_REFUND_NO := Ar_Loan_No;
					lrBodyPE.LOAN_NO := Ar_Loan_No;
					lrBodyPE.BANK_CODE := lrLoan.BANK_CODE;
					lrBodyPE.ACCNO := lrB.ACCNO;
					PKG_MAKE_SLIP.Insert_Body(lrBodyPE);
				End Loop;
			End If;
			--�����ܺ�� ���� ���� ����
			lnCrAmt := 0;
			lnDbAmt := 0;
			If lnPrevEXDBSum < lnTotItrAmt Then	--���� �Ѿ��� ���� �����ܺ�� �������ں��� ũ�ٸ�...���� ������ �ؾ�����!
				lnDbAmt := lnTotItrAmt - lnPrevEXDBSum;
			ElsIf lnPrevEXDBSum > lnTotItrAmt Then	--���� �̷� ��찡 ����� ������ ���� ���� ���ں��� �� ���� ����ߴٸ�... ��������!
				lnCrAmt := lnTotItrAmt - lnPrevEXDBSum;
			End If;
			If lnDbAmt <> 0 Or lnCrAmt <> 0  Then	--PL-SQL�� C�� C++ó�� Or������ ���̸� �ڿ� ���� ���� ���Ѵٴ� ���...
				lnMakeSlipLine := lnMakeSlipLine + 1;
				lrBodyIT := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.ITR_ACC_CODE,lsClassCode,Null);
				lrBodyIT.DB_AMT := lnDbAmt;
				lrBodyIT.CR_AMT := lnCrAmt;
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
		End;
	ElsIf lrRec.ITR_TAG = '6' Then	--�������� ���ݻ�ȯ
		--���������� ó���� �̷����ϴ�...
		--���� ���� ���� ������ �ִٸ�... �̴� �ݵ�� ������ ��� �������ڰ� �˴ϴ�.
		--������ ��� ���������� �뺯 �ܾ� �� �����ܺ�� ���������� ���� ���� �Ѿ׺��� ũ�ٸ� ���� ���� ���Դϴ�.
		--������ ��� ���������� �ܾ��� ���� �ִٸ�... �̴� �ݵ�� ������ �����Ǿ�� �մϴ�.
		--���� ���޺���� ó���� ���̰� �����ϴ�.(���븸 �ٲ�� �����Դϴ�.)
		Declare
			lnPrevPESETSum				Number;
			lnPrevPERESETSum			Number;
			lnPrevEXDBSum				Number;
			lnTotItrAmt					Number;
			lnPERemain					Number;
			lnPEResetTarget				Number;
			lnCrAmt						Number;
			lnDbAmt						Number;
		Begin
			--���� �����޺�� ����,�뺯 �հ豸�ϱ�
			Begin
				Select
					Nvl(Sum(DB_AMT),0),
					Nvl(Sum(CR_AMT),0)
				Into
					lnPrevPERESETSum,
					lnPrevPESETSum
				From	T_ACC_SLIP_BODY
				Where	LOAN_REFUND_NO = lrRec.LOAN_NO
				And		KEEP_DT Is Not Null
				And		ACC_CODE = lrLoanKind.AE_ITR_ACC_CODE;
			Exception When No_Data_Found Then	--���� �����Լ������� �� ������ �߻������� �ʽ��ϴ�.
				lnPrevPESETSum := 0;
				lnPrevPERESETSum := 0;
			End;
			--���� �����ܺ�� �������� ���ϱ�
			Begin
				Select
					Nvl(Sum(DB_AMT),0)
				Into
					lnPrevEXDBSum
				From	T_ACC_SLIP_BODY
				Where	LOAN_REFUND_NO = lrRec.LOAN_NO
				And		KEEP_DT Is Not Null
				And		ACC_CODE = lrLoanKind.ITR_ACC_CODE;
			Exception When No_Data_Found Then	--���� �����Լ������� �� ������ �߻������� �ʽ��ϴ�.
				lnPrevEXDBSum := 0;
			End;
			--�ش� ������ ���� �Ѿ��� ���Ѵ�.
			Begin
				Select
					Nvl(Sum(a.INTR_AMT),0)
				Into
					lnTotItrAmt
				From	T_FIN_LOAN_REFUND_LIST a
				Where	LOAN_NO = lrRec.LOAN_NO
				And		REFUND_INTR_DT <= lrRec.REFUND_INTR_DT;
			Exception When No_Data_Found Then	--���� �����Լ������� �� ������ �߻������� �ʽ��ϴ�.
				lnTotItrAmt := 0;
			End;
			If lnTotItrAmt < lnPrevPESETSum - lnPrevPERESETSum + lnPrevEXDBSum Then	--���� �����޺���� ���� ���Ǿ� �ִٸ�...
				lnPERemain := lnPrevPESETSum - lnPrevPERESETSum + lnPrevEXDBSum - lnTotItrAmt;
			Else
				lnPERemain := 0;
			End If;
			lnPEResetTarget := lnPrevPESETSum - lnPrevPERESETSum;
			If lnPEResetTarget > 0 Then		--���� �ܾ��� ���� �ִٸ�
				For lrB In (
					Select
						a.SLIP_ID ,
						a.SLIP_IDSEQ ,
						a.MAKE_SLIPLINE ,
						a.ACC_CODE ,
						a.DB_AMT ,
						a.CR_AMT ,
						a.SUMMARY_CODE ,
						a.TAX_COMP_CODE ,
						a.COMP_CODE ,
						a.DEPT_CODE ,
						a.CLASS_CODE ,
						a.VAT_CODE ,
						a.VAT_DT ,
						a.SUPAMT ,
						a.VATAMT ,
						a.CUST_SEQ ,
						a.CUST_NAME ,
						a.BANK_CODE ,
						a.ACCNO ,
						a.RESET_SLIP_ID ,
						a.RESET_SLIP_IDSEQ ,
						a.MAKE_COMP_CODE ,
						a.MAKE_DEPT_CODE ,
						a.MAKE_DT ,
						a.KEEP_DT ,
						a.ORG_SLIP_ID ,
						a.ORG_SLIP_IDSEQ ,
						a.SLIP_KIND_TAG ,
						a.TRANSFER_TAG ,
						a.IGNORE_SET_RESET_TAG ,
						a.CRTUSERNO ,
						a.CRTDATE ,
						a.MODUSERNO ,
						a.MODDATE ,
						a.SUMMARY1 ,
						a.SUMMARY2 ,
						a.CHK_NO ,
						a.BILL_NO ,
						a.REC_BILL_NO ,
						a.CP_NO ,
						a.SECU_NO ,
						a.LOAN_NO ,
						a.LOAN_REFUND_NO ,
						a.LOAN_REFUND_SEQ ,
						a.DEPOSIT_ACCNO ,
						a.PAYMENT_SEQ ,
						a.PAY_CON_CASH ,
						a.PAY_CON_BILL ,
						a.PAY_CON_BILL_DT ,
						a.PAY_CON_BILL_DAYS ,
						a.EMP_NO ,
						a.ANTICIPATION_DT ,
						a.MNG_ITEM_CHAR1 ,
						a.MNG_ITEM_CHAR2 ,
						a.MNG_ITEM_CHAR3 ,
						a.MNG_ITEM_CHAR4 ,
						a.MNG_ITEM_NUM1 ,
						a.MNG_ITEM_NUM2 ,
						a.MNG_ITEM_NUM3 ,
						a.MNG_ITEM_NUM4 ,
						a.MNG_ITEM_DT1 ,
						a.MNG_ITEM_DT2 ,
						a.MNG_ITEM_DT3 ,
						a.MNG_ITEM_DT4 ,
						a.FIX_ASSET_SEQ,
						Nvl(a.CR_AMT,0) - 
						Nvl((
							Select
								Nvl(Sum(cc.DB_AMT),0) + Nvl(Sum(- cc.CR_AMT),0)
							From	T_ACC_SLIP_BODY1 cc
							Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
							And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
							And		cc.KEEP_DT Is Not Null
							And
							(
									cc.SLIP_ID <> cc.RESET_SLIP_ID
								Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
							)
						),0) REMAIN_AMT
					From	T_ACC_SLIP_BODY a
					Where	a.ACC_CODE = lrLoanKind.AE_ITR_ACC_CODE
					And		a.KEEP_DT Is Not Null
					And		a.LOAN_REFUND_NO = lrRec.LOAN_NO
					And		a.SLIP_ID = a.RESET_SLIP_ID
					And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
					And		Nvl(a.CR_AMT,0) - 
										Nvl((
											Select
												Nvl(Sum(cc.DB_AMT),0) + Nvl(Sum(- cc.CR_AMT),0)
											From	T_ACC_SLIP_BODY1 cc
											Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
											And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
											And		cc.KEEP_DT Is Not Null
											And
											(
													cc.SLIP_ID <> cc.RESET_SLIP_ID
												Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
											)
										),0) > 0)
				Loop
					lnCrAmt := 0;
					lnDbAmt := 0;
					If lnPERemain > 0 Then		--���� ������ �κ��� ���� ���� �ִٸ�
						If lnPERemain >= Nvl(lrB.REMAIN_AMT,0) then	--���� �̹��ܾ� �� �� �۴ٸ�
							lnCrAmt := - Nvl(lrB.REMAIN_AMT,0);
							lnPERemain := lnPERemain + lnCrAmt;
							lnPEResetTarget := lnPEResetTarget + lnCrAmt;
						Else
							lnCrAmt := - lnPERemain;
							lnPERemain := 0;
							lnPEResetTarget := lnPEResetTarget + lnCrAmt;
						End If;
						lnMakeSlipLine := lnMakeSlipLine + 1;
						lrBodyAE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.AE_ITR_ACC_CODE,lsClassCode,Null);
						lrBodyAE.DB_AMT := lnDbAmt;
						lrBodyAE.CR_AMT := lnCrAmt;
						lrBodyAE.TAX_COMP_CODE := Ar_Make_Comp_Code;
						lrBodyAE.COMP_CODE := Ar_Make_Comp_Code;
						lrBodyAE.DEPT_CODE := Ar_Dept_Code;
						lrBodyAE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
						lrBodyAE.CUST_SEQ := lnCustSeq;
						lrBodyAE.CUST_NAME := lsCustName;
						lrBodyAE.RESET_SLIP_ID := lrB.SLIP_ID;				--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
						lrBodyAE.RESET_SLIP_IDSEQ := lrB.SLIP_IDSEQ;			--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
						lrBodyAE.LOAN_REFUND_NO := Ar_Loan_No;
						lrBodyAE.LOAN_NO := Ar_Loan_No;
						lrBodyAE.BANK_CODE := lrLoan.BANK_CODE;
						lrBodyAE.ACCNO := lrB.ACCNO;
						PKG_MAKE_SLIP.Insert_Body(lrBodyAE);
					End If;
					lnCrAmt := 0;
					lnDbAmt := 0;
					If lnPERemain = 0 Then
						If lnPEResetTarget >= Nvl(lrB.REMAIN_AMT,0) then	--���� �̹��ܾ� �� �� �۴ٸ�
							lnDbAmt := Nvl(lrB.REMAIN_AMT,0);
							lnPEResetTarget := lnPEResetTarget - lnDbAmt;
						Else
							lnDbAmt := lnPEResetTarget;
							lnPEResetTarget := lnPEResetTarget - lnDbAmt;
						End If;
					End If;
					--�����޺�� ��������
					lnMakeSlipLine := lnMakeSlipLine + 1;
					lrBodyAE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.AE_ITR_ACC_CODE,lsClassCode,Null);
					lrBodyAE.DB_AMT := lnDbAmt;
					lrBodyAE.CR_AMT := lnCrAmt;
					lrBodyAE.TAX_COMP_CODE := Ar_Make_Comp_Code;
					lrBodyAE.COMP_CODE := Ar_Make_Comp_Code;
					lrBodyAE.DEPT_CODE := Ar_Dept_Code;
					lrBodyAE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
					lrBodyAE.CUST_SEQ := lnCustSeq;
					lrBodyAE.CUST_NAME := lsCustName;
					lrBodyAE.RESET_SLIP_ID := lrB.SLIP_ID;				--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
					lrBodyAE.RESET_SLIP_IDSEQ := lrB.SLIP_IDSEQ;			--������ ���� �ڱ� ��ǥ ��ȣ�Դϴ�.
					lrBodyAE.LOAN_REFUND_NO := Ar_Loan_No;
					lrBodyAE.LOAN_NO := Ar_Loan_No;
					lrBodyAE.BANK_CODE := lrLoan.BANK_CODE;
					lrBodyAE.ACCNO := lrB.ACCNO;
					PKG_MAKE_SLIP.Insert_Body(lrBodyAE);
				End Loop;
			End If;
			--�����ܺ�� ���� ���� ����
			lnCrAmt := 0;
			lnDbAmt := 0;
			If lnPrevEXDBSum < lnTotItrAmt Then	--���� �Ѿ��� ���� �����ܺ�� �������ں��� ũ�ٸ�...���� ������ �ؾ�����!
				lnDbAmt := lnTotItrAmt - lnPrevEXDBSum;
			ElsIf lnPrevEXDBSum > lnTotItrAmt Then	--���� �̷� ��찡 ����� ������ ���� ���� ���ں��� �� ���� ����ߴٸ�... ��������!
				lnCrAmt := lnTotItrAmt - lnPrevEXDBSum;
			End If;
			If lnDbAmt <> 0 Or lnCrAmt <> 0  Then	--PL-SQL�� C�� C++ó�� Or������ ���̸� �ڿ� ���� ���� ���Ѵٴ� ���...
				lnMakeSlipLine := lnMakeSlipLine + 1;
				lrBodyIT := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.ITR_ACC_CODE,lsClassCode,Null);
				lrBodyIT.DB_AMT := lnDbAmt;
				lrBodyIT.CR_AMT := lnCrAmt;
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
		End;
	Else
		Raise_Application_Error(-20009,'��ȯ��ǥ�� ���ڱ����� ������ݻ�ȯ �Ǵ� ������ݻ�ȯ���� �����ϼž� �մϴ�.');
	End If;

	--������ ����
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrOther.ACC_CODE,lrOther.CLASS_CODE,Null);
	PKG_MAKE_SLIP.CopySlipBodyFromTemp(lrOther,lrBody2);
	lrBody2.CR_AMT := Nvl(lrRec.REFUND_AMT,0) + Nvl(lrRec.INTR_AMT,0);
	lrBody2.TAX_COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.DEPT_CODE := Ar_Dept_Code;
	PKG_MAKE_SLIP.Insert_Body(lrBody2);
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
