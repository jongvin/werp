Create Or Replace Procedure SP_T_MAKE_DFLT_PAY_TAX_SLIP
(
	Ar_Work_Slip_Id					Number,
	Ar_Work_Slip_IdSeq				Number,
	Ar_Work_Code					Varchar2,
	Ar_Make_Comp_Code				Varchar2,
	Ar_Dept_Code					Varchar2,
	Ar_WorkDt						Varchar2,
	Ar_Amt							Number,
	Ar_CrtUserNo					Varchar2
)
Is
	lddt_WorkDt						Date;
	lnAmt							Number;
	lrT_WORK_ACC_CODE				T_WORK_ACC_CODE%ROWTYPE;
	lrT_DEPT_CODE_ORG				T_DEPT_CODE_ORG%ROWTYPE;
	lrT_DEPT_CLASS_CODE				T_DEPT_CLASS_CODE%ROWTYPE;
	lnSum							Number;
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;
	lnCustSeq						T_CUST_CODE.CUST_SEQ%Type;
	lsCustName						T_ACC_SLIP_BODY.CUST_NAME%Type;
Begin
	lddt_WorkDt := F_T_STRINGTODATE(Ar_WorkDt);
	lnSum := Ar_Amt;

	BEGIN
		SELECT
			*
		INTO
			lrT_DEPT_CODE_ORG
		FROM	T_DEPT_CODE_ORG
		WHERE	DEPT_CODE=Ar_Dept_Code;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		--NULL;
		RAISE_APPLICATION_ERROR(-20009,'�������� �ʴ� �μ��ڵ��Դϴ�');
	END;
	IF lrT_DEPT_CODE_ORG.COST_DEPT_KND_TAG IS NULL THEN
		RAISE_APPLICATION_ERROR(-20009,'['||lrT_DEPT_CODE_ORG.DEPT_CODE||']'||lrT_DEPT_CODE_ORG.DEPT_NAME||'�� �������屸���� ��ϵ��� �ʾҽ��ϴ�.');
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
		RAISE_APPLICATION_ERROR(-20009,'�ش� �ڵ���ǥ�� ������������ ������ �� �����ϴ�.');
	END;
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
		DB_AMT,
		CR_AMT,
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
		lrT_WORK_ACC_CODE.SUMMARY1,
		lrT_WORK_ACC_CODE.SUMMARY2,
		lrT_WORK_ACC_CODE.VAT_CODE,
		lrT_DEPT_CODE_ORG.TAX_COMP_CODE,
		lrT_DEPT_CODE_ORG.COMP_CODE,
		lrT_DEPT_CODE_ORG.DEPT_CODE,
		0,
		lnSum,
		lsClassCode,
		Ar_CrtUserNo,
		lnCustSeq,
		lsCustName
	);
End;
/