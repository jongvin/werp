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
	ls_Work_Code					T_WORK_ACC_CODE.WORK_CODE%Type := 'FF000100';	--차입금
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
	lrBodyPE						T_ACC_SLIP_BODY%RowType;		--선급이자
	lrBodyIT						T_ACC_SLIP_BODY%RowType;		--당월분 이자
	lrBodyAE						T_ACC_SLIP_BODY%RowType;		--미지급비용이자 반제
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
		Raise_Application_Error(-20009,'차입 정보를 찾을 수 없습니다.');
	End;
	If lrRec.INTR_SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'이미 이자 전표가 발행되어 있습니다.');
	End If;
	Begin
		Select
			*
		Into
			lrLoan
		From	T_FIN_LOAN_SHEET
		Where	LOAN_NO = Ar_Loan_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'차입 정보를 찾을 수 없습니다.');
	End;
	If lrLoan.LOAN_KIND_CODE Is Null Then
		Raise_Application_Error(-20009,'차입종류를 입력하셔야 합니다.');
	End If;
	Begin
		Select
			*
		Into
			lrLoanKind
		From	T_FIN_LOAN_KIND
		Where	LOAN_KIND_CODE = lrLoan.LOAN_KIND_CODE;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'차입 종류코드를 찾을 수 없습니다.');
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
		Raise_Application_Error(-20009,'차입금의 은행정보를 찾을 수 없습니다.');
	End;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);

	If lrRec.ITR_TAG Is Null Then
		Raise_Application_Error(-20009,'이자전표를 발행하려면 이자구분을 선택하셔야 합니다.');
	End If;
	If lrRec.ITR_TAG = '1' Then		--선취이자
		Raise_Application_Error(-20009,'이자 구분이 선취이자차입 또는 후취이자차입인 경우는 이자전표가 아닌 차입전표를 발행하여야 합니다.');
	ElsIf lrRec.ITR_TAG = '2' Then	--후취이자
		Raise_Application_Error(-20009,'이자 구분이 선취이자차입 또는 후취이자차입인 경우는 이자전표가 아닌 차입전표를 발행하여야 합니다.');
	ElsIf lrRec.ITR_TAG = '5' Then	--원금상환
		Raise_Application_Error(-20009,'이자 구분이 원금상환인 경우는 이자전표가 아닌 상환전표를 발행하여야 합니다.');
	End If;

	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(ls_Work_Code,Ar_Make_Comp_Code);
	lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.TRANS_DT,'1','B',Ar_CrtUserNo,ls_Work_Code,lsChargePers,Ar_CrtUserNo);
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnCustSeq := PKG_MAKE_SLIP.Get_Dflt_Cust_Seq;
	If lnCustSeq Is Null Then
		Raise_Application_Error(-20009,'임의거래처가 설정되어 있지 않습니다.');
	End If;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);
	If lrRec.ITR_TAG = '3' Then	--선급이자 반제
		--선급이자 반제는 선급이자 만큼을 영업외비용 지급이자로 전환한다.
		--선급금이자비용 반제
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
			Raise_Application_Error(-20009,'선급비용 지급이자의 설정전표를 찾을 수 없습니다.');
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
	ElsIf lrRec.ITR_TAG = '4' Then	--후취이자 지급
		Null;
	Else
		Raise_Application_Error(-20009,'알수 없는 이자구분입니다.');
	End If;
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
