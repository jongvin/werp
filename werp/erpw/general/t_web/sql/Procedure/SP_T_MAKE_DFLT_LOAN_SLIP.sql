Create Or Replace Procedure SP_T_MAKE_DFLT_LOAN_SLIP
(
	Ar_Work_Slip_Id					Number,
	Ar_Work_Slip_IdSeq				Number,
	Ar_Work_Code					Varchar2,
	Ar_Dept_Code					Varchar2,
	Ar_Loan_No						Varchar2,
	Ar_Loan_Refund_Seq				Number,
	Ar_CrtUserNo					Varchar2
)
Is
	lrRec							T_FIN_LOAN_REFUND_LIST%RowType;
	lnAmt							Number;
	lrT_WORK_ACC_CODE				T_WORK_ACC_CODE%ROWTYPE;
	lrT_DEPT_CODE_ORG				T_DEPT_CODE_ORG%ROWTYPE;
	lrT_DEPT_CLASS_CODE				T_DEPT_CLASS_CODE%ROWTYPE;
	lrLoan							T_FIN_LOAN_SHEET%RowType;
	lrLoanKind						T_FIN_LOAN_KIND%RowType;
	lsBankName						T_BANK_MAIN.BANK_MAIN_NAME%Type;
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;
	lnCustSeq						T_CUST_CODE.CUST_SEQ%Type;
	lsCustName						T_ACC_SLIP_BODY.CUST_NAME%Type;
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

	If lrRec.ITR_TAG Is Null Then
		Raise_Application_Error(-20009,'차입전표를 발행하려면 이자구분을 선택하셔야 합니다.');
	End If;
	If lrRec.ITR_TAG = '1' Then		--선취이자
		lnAmt := Nvl(lrRec.LOAN_AMT,0) - Nvl(lrRec.INTR_AMT,0);		--선취의 경우 이자금액을 차감한다.
	ElsIf lrRec.ITR_TAG = '2' Then	--후취이자
		lnAmt := Nvl(lrRec.LOAN_AMT,0);		
	Else
		Raise_Application_Error(-20009,'차입전표는 이자구분을 선취이자차입 또는 후취이자차입으로 선택하셔야 합니다.');
	End If;
	If lnAmt <= 0 Then
		Raise_Application_Error(-20009,'차입금액이 0보다 작거나 같을 수는 없습니다.');
	End If;
	BEGIN
		SELECT
			*
		INTO
			lrT_DEPT_CODE_ORG
		FROM	T_DEPT_CODE_ORG
		WHERE	DEPT_CODE=Ar_Dept_Code;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		--NULL;
		RAISE_APPLICATION_ERROR(-20009,'존재하지 않는 부서코드입니다');
	END;
	IF lrT_DEPT_CODE_ORG.COST_DEPT_KND_TAG IS NULL THEN
		RAISE_APPLICATION_ERROR(-20009,'['||lrT_DEPT_CODE_ORG.DEPT_CODE||']'||lrT_DEPT_CODE_ORG.DEPT_NAME||'의 원가현장구분이 등록되지 않았습니다.');
	END IF;
	BEGIN
		Select
			*
		INTO lrT_WORK_ACC_CODE
		From
		(
			SELECT
				*
			FROM	T_WORK_ACC_CODE
			WHERE	WORK_CODE=Ar_Work_Code
			AND		COST_DEPT_KND_TAG = lrT_DEPT_CODE_ORG.COST_DEPT_KND_TAG
			AND		USE_TAG = 'T'
			Order By SEQ
		)
		WHERE		ROWNUM=1;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR(-20009,'해당 자동전표의 상대계정정보를 가져올 수 없습니다.');
	END;
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
	lnCustSeq := PKG_MAKE_SLIP.Get_Dflt_Cust_Seq;
	If lnCustSeq Is Not Null Then
		lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);
	End If;
	INSERT INTO T_WORK_ACC_SLIP_BODY
	(
		SLIP_ID,
		SLIP_IDSEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_CODE,
		ACC_CODE,
		SUMMARY_CODE,
		SUMMARY1,
		SUMMARY2,
		VAT_CODE,
		TAX_COMP_CODE,
		COMP_CODE,
		DEPT_CODE,
		CR_AMT,
		DB_AMT,
		BANK_CODE,
		CLASS_CODE,
		EMP_NO,
		CUST_SEQ,
		CUST_NAME
	)
	VALUES
	(
		Ar_Work_Slip_Id,
		Ar_Work_Slip_IdSeq,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_WORK_CODE,
		lrT_WORK_ACC_CODE.ACC_CODE,
		lrT_WORK_ACC_CODE.SUMMARY_CODE,
		lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)',
		lrT_WORK_ACC_CODE.SUMMARY2,
		lrT_WORK_ACC_CODE.VAT_CODE,
		lrT_DEPT_CODE_ORG.TAX_COMP_CODE,
		lrT_DEPT_CODE_ORG.COMP_CODE,
		lrT_DEPT_CODE_ORG.DEPT_CODE,
		0,
		lnAmt,
		lrLoan.BANK_CODE,
		lsClassCode,
		Ar_CrtUserNo,
		lnCustSeq,
		lsCustName
	);
End;
/
