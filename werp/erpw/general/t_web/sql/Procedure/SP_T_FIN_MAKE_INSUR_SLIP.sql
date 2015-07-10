Create Or Replace Procedure SP_T_FIN_MAKE_INSUR_SLIP
(
	Ar_Work_Slip_Id					Number,
	Ar_Work_Slip_IdSeq				Number,
	Ar_Work_Code					Varchar2,
	Ar_Make_Comp_Code				Varchar2,
	Ar_Dept_Code					Varchar2,
	Ar_Work_Dept_Code				Varchar2,
	Ar_Insur_No						Number,
	Ar_CrtUserNo					Varchar2
)
Is
	lrRec							T_SET_CONS_INSUR%RowType;
	lrT_DEPT_CODE_ORG				T_DEPT_CODE_ORG%ROWTYPE;
	lsAccCode						T_ACC_CODE.ACC_CODE%Type;
	lrOther							T_WORK_ACC_SLIP_BODY%RowType;
	lrBody1							T_ACC_SLIP_BODY%RowType;
	lrBody2							T_ACC_SLIP_BODY%RowType;
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;
	lrHead							T_ACC_SLIP_HEAD%RowType;
	lsChargePers					T_Acc_Slip_Head.CHARGE_PERS%Type;
	lnMakeSlipLine					Number;
	lsCustName						T_ACC_SLIP_BODY.CUST_NAME%Type;
	lnCustSeq						T_CUST_CODE.CUST_SEQ%Type;
Begin
	Begin
		Select
			a.CODE_LIST_ID
		Into
			lsAccCode
		From	V_T_CODE_LIST a
		Where	a.CODE_GROUP_ID = 'PRE_CONS_INSU_ACC_CODE'
		And		RowNum < 2;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'���纸��� ������ ã�� �� �����ϴ�.(�����ڵ忡 PRE_CONS_INSU_ACC_CODE �׷��� ������ Ȯ���Ͻʽÿ�.)');
	End;
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_CONS_INSUR
		Where	DEPT_CODE = Ar_Work_Dept_Code
		And		INSUR_NO = Ar_Insur_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'���纸��� ���� ������ ã�� �� �����ϴ�.');
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

	BEGIN
		SELECT
			*
		INTO
			lrT_DEPT_CODE_ORG
		FROM	T_DEPT_CODE_ORG
		WHERE	DEPT_CODE=Ar_Work_Dept_Code;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		--NULL;
		RAISE_APPLICATION_ERROR(-20009,'�������� �ʴ� �μ��ڵ��Դϴ�');
	END;


	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(Ar_Work_Code,Ar_Make_Comp_Code);
	--���Ұ����� �����̸� ������ǥ �ƴϸ� ��ä��ǥ
	If PKG_MAKE_SLIP.IsCashAccCode(lrOther.ACC_CODE) Then
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.SLIP_MAKE_DT,'2','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	Else
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.SLIP_MAKE_DT,'1','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	End If;
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnCustSeq := lrRec.CUST_SEQ;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);
	
	--��� ����
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Work_Dept_Code);
	lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsAccCode,lsClassCode,Null);
	lrBody1.DB_AMT := lrRec.INSUR_AMT;
	lrBody1.TAX_COMP_CODE := lrT_DEPT_CODE_ORG.COMP_CODE;
	lrBody1.COMP_CODE := lrT_DEPT_CODE_ORG.COMP_CODE;
	lrBody1.DEPT_CODE := Ar_Work_Dept_Code;
	lrBody1.SUMMARY1 := SubStrb(lrRec.REMARKS,1,60);
	lrBody1.CUST_SEQ := lnCustSeq;
	lrBody1.CUST_NAME := lsCustName;
	lrBody1.RESET_SLIP_ID := lrBody1.SLIP_ID;
	lrBody1.RESET_SLIP_IDSEQ := lrBody1.SLIP_IDSEQ;

	PKG_MAKE_SLIP.Insert_Body(lrBody1);

	Update	T_SET_CONS_INSUR
	Set		SLIP_ID = lrBody1.SLIP_ID,
			SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
	Where	DEPT_CODE = Ar_Work_Dept_Code
	And		INSUR_NO = Ar_Insur_No;

	--������ ����
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
	lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrOther.ACC_CODE,lrOther.CLASS_CODE,Null);
	PKG_MAKE_SLIP.CopySlipBodyFromTemp(lrOther,lrBody2);
	lrBody2.CR_AMT := lrRec.INSUR_AMT;
	lrBody2.TAX_COMP_CODE := lrT_DEPT_CODE_ORG.COMP_CODE;
	lrBody2.COMP_CODE := lrT_DEPT_CODE_ORG.COMP_CODE;
	lrBody2.DEPT_CODE := Ar_Work_Dept_Code;
	PKG_MAKE_SLIP.Insert_Body(lrBody2);
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
