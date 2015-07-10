Create Or Replace Procedure SP_T_MAKE_EMP_TAX_SLIP
(
	AR_COMP_CODE						VARCHAR2,
	AR_WORK_DT							VARCHAR2,
	AR_DEPT_CODE						VARCHAR2,
	AR_CRTUSERNO						VARCHAR2,
	AR_WORK_SLIP_ID						Number,
	AR_WORK_SLIP_IDSEQ					Number,
	AR_SLIP_ID				Out			Number,
	AR_SLIP_IDSEQ			Out			Number,
	AR_MAKE_SLIPNO			Out			Varchar2,
	AR_MAKE_COMP_CODE		Out			Varchar2,
	AR_MAKE_SEQ				Out			Number,
	AR_SLIP_KIND_TAG		Out			Varchar2,
	AR_MAKE_DT_TRANS		Out			Varchar2
)
Is
	Type T_REC Is Table Of T_FIN_PAY_EXEC_LIST_TMP%RowType
		Index By Binary_Integer;
	ltRec								T_REC;
	lnCnt								Number;
	lsChargePers						T_Acc_Slip_Head.CHARGE_PERS%Type;
	lrHead								T_ACC_SLIP_HEAD%RowType;
	lddtMakeDt							Date := F_T_StringToDate(AR_WORK_DT);
	lsSlipCls							T_Acc_Slip_Head.Make_SlipCls%Type := '1' ; --��ü��ǥ
	lsSlipKindTag						T_Acc_Slip_Head.Slip_Kind_Tag%Type := 'B';--�ڵ���ǥ
	lsWorkCode							T_Acc_Slip_Head.WORK_CODE%Type := 'FP000400';--�ڱ����� ��ǥ
	lnMakeSlipLine						Number;
	liFirst								Number;
	liLast								Number;
	lnSlipPubSeq						Number;
	lrOther								T_WORK_ACC_SLIP_BODY%RowType;
	lsCustName							T_ACC_SLIP_BODY.CUST_NAME%Type;
	lnCustSeq							T_CUST_CODE.CUST_SEQ%Type;
	lrBody2								T_ACC_SLIP_BODY%RowType;
	Function	GetPayAccCode
	(
		Ar_Exec_Kind_Tag				Varchar2
	)
	Return T_ACC_CODE.ACC_CODE%Type
	Is
		lsACC_CODE			T_ACC_CODE.ACC_CODE%Type;
	Begin
		Select
			CODE_LIST_NAME
		Into
			lsACC_CODE
		From	V_T_CODE_LIST
		Where	CODE_GROUP_ID = 'PAY_ACC_CODE'
		And		CODE_LIST_ID = Ar_Exec_Kind_Tag;
		Return lsACC_CODE;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'���� �ڵ忡 PAY_ACC_CODE �׷��� ����ϰ� �ش� ���౸�п� �´� ������ �����ؾ� �մϴ�.');
	End;
	Function	GetSlipBody
	(
		Ari_Slip_Id							T_ACC_SLIP_BODY.SLIP_ID%Type,
		Ari_Slip_IdSeq						T_ACC_SLIP_BODY.SLIP_IDSEQ%Type
	)
	Return T_ACC_SLIP_BODY%RowType
	Is
		lrRet				T_ACC_SLIP_BODY%RowType;
	Begin
		Select
			*
		Into
			lrRet
		From	T_ACC_SLIP_BODY
		Where	SLIP_ID = Ari_Slip_Id
		And		SLIP_IDSEQ = Ari_Slip_IdSeq;
		Return lrRet;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'û����ǥ�� ã�� �� �����ϴ�.');
	End;
	Procedure	processResetLine
	(
		Ari_BodyOrg			In Out NoCopy	T_ACC_SLIP_BODY%RowType,
		Ari_Amt								Number
	)
	Is
		lrBody1				T_ACC_SLIP_BODY%RowType;
	Begin
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,Ari_BodyOrg.ACC_CODE,Ari_BodyOrg.CLASS_CODE,Null);
		PKG_MAKE_SLIP.CopySlipBody(Ari_BodyOrg,lrBody1);
		lrBody1.RESET_SLIP_ID			:=	Ari_BodyOrg.SLIP_ID;			--���� ��ǥ ��ȣ ����
		lrBody1.RESET_SLIP_IDSEQ		:=	Ari_BodyOrg.SLIP_IDSEQ;		--���� ��ǥ ��ȣ ����
		lrBody1.SUMMARY1				:=	SubStrb(Ari_BodyOrg.SUMMARY1||'����',1,60);
		lrBody1.EMP_NO					:=	AR_CRTUSERNO;
		lrBody1.CR_AMT := 0;
		lrBody1.DB_AMT := 0;
		If Nvl(Ari_BodyOrg.DB_AMT,0) <> 0 Then
			lrBody1.CR_AMT := Ari_Amt;
		Else
			lrBody1.DB_AMT := Ari_Amt;
		End If;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
	End;
	Procedure	processUpdateInfo
	(
		Ar_Rec			In Out NoCopy 		T_FIN_PAY_EXEC_LIST_TMP%RowType,
		Ari_Slip_Id							T_ACC_SLIP_BODY.SLIP_ID%Type,
		Ari_Slip_IdSeq						T_ACC_SLIP_BODY.SLIP_IDSEQ%Type
	)
	Is
	Begin
		AR_SLIP_IDSEQ := Ari_Slip_IdSeq;
	End;
	--���� ó��
	Procedure	processTag1
	(
		Ar_Rec			In Out NoCopy T_FIN_PAY_EXEC_LIST_TMP%RowType
	)
	Is
		lrBody1				T_ACC_SLIP_BODY%RowType;
		lrBodyOrg			T_ACC_SLIP_BODY%RowType;
		lsACC_CODE			T_ACC_CODE.ACC_CODE%Type;
		lsBANK_CODE			T_ACCNO_CODE.BANK_CODE%Type;
	Begin
		lrBodyOrg := GetSlipBody(Ar_Rec.TARGET_SLIP_ID,Ar_Rec.TARGET_SLIP_IDSEQ);
		processResetLine(lrBodyOrg,Ar_Rec.EXEC_AMT);
		processUpdateInfo(Ar_Rec,lrBody1.SLIP_ID,lrBody1.SLIP_IDSEQ);
	End;
Begin
	Delete	T_FIN_PAY_EXEC_LIST a
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_DT = lddtMakeDt
	And		Not Exists
	(
		Select
			Null
		From	T_ACC_SLIP_BODY1 b
		Where	a.TARGET_SLIP_ID = b.SLIP_ID
		And		a.TARGET_SLIP_IDSEQ = b.SLIP_IDSEQ
	);
	Delete	T_FIN_PAY_EXEC_LIST a
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_DT = lddtMakeDt
	And		Not Exists
	(
		Select
			Null
		From	T_ACC_SLIP_BODY1 b
		Where	a.SLIP_ID = b.SLIP_ID
		And		a.SLIP_IDSEQ = b.SLIP_IDSEQ
	);
	--��ǥ������ ���� ���� T_FIN_PAY_EXEC_LIST_TMP�� ��ǥ ���� ��� ���� ���ԵǾ� �ִٰ� �����Ѵ�.
	--���� ���� ��ǥ�� ����� ���� �ִ��� ã�ƺ���.
	Select
		Count(*)
	Into
		lnCnt
	From	T_FIN_PAY_EXEC_LIST_TMP a,
			T_ACC_SLIP_BODY1 b
	Where	a.SLIP_ID = b.SLIP_ID
	And		a.SLIP_IDSEQ = b.SLIP_IDSEQ;
	If lnCnt > 0 Then
		Raise_Application_Error(-2009,'�̹� ����� ��ǥ�� �� ������ �� �����ϴ�.');
	End If;
	--���õ� ���� �о���δ�.
	Select
		*
	Bulk Collect Into
		ltRec
	From	T_FIN_PAY_EXEC_LIST_TMP a
	Where	Exists
	(
		Select
			Null
		From	T_ACC_SLIP_BODY1 b
		Where	a.TARGET_SLIP_ID = b.SLIP_ID
		And		a.TARGET_SLIP_IDSEQ = b.SLIP_IDSEQ
	)
	Order By
		a.COMP_CODE ,
		a.WORK_DT ,
		a.SEQ;
	If ltRec.Count < 1 Then
		Raise_Application_Error(-20009,'������ ��ǥ�� ����� ���� �� �۾��� �ֽʽÿ�.');
	End If;
	liFirst := ltRec.First;
	liLast := ltRec.Last;

	If PKG_MAKE_SLIP.IsCashAccCode(lrOther.ACC_CODE) Then
		lsSlipCls := '2';
	Else
		lsSlipCls := '1';
	End If;

	--����� ���ϱ�
	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(lsWorkCode,AR_COMP_CODE);
	--��ǥ��� ���ϱ�
	lrHead := PKG_MAKE_SLIP.New_Head(AR_COMP_CODE,AR_DEPT_CODE,lddtMakeDt,lsSlipCls,lsSlipKindTag,AR_CRTUSERNO,lsWorkCode,lsChargePers,AR_CRTUSERNO);
	--��ǥ ��� ����
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	AR_SLIP_ID := lrHead.SLIP_ID;
	AR_MAKE_SLIPNO := lrHead.MAKE_SLIPNO;
	AR_MAKE_COMP_CODE := lrHead.MAKE_COMP_CODE;
	AR_MAKE_SEQ := lrHead.MAKE_SEQ;
	AR_SLIP_KIND_TAG := lrHead.SLIP_KIND_TAG;
	AR_MAKE_DT_TRANS := lrHead.MAKE_DT_TRANS;
	--��ǥ �¼� �ʱ�ȭ
	lnMakeSlipLine := 0;
	Begin
		Select
			*
		Into
			lrOther
		From	T_WORK_ACC_SLIP_BODY
		Where	SLIP_ID = Ar_Work_Slip_Id
		And		SLIP_IDSEQ = Ar_Work_Slip_IdSeq;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'��뺯 ������ ã�� �� �����ϴ�.'||to_char(Ar_Work_Slip_IdSeq));
	End;
	For liI In liFirst..liLast Loop
		Declare
			lrRec								T_FIN_PAY_EXEC_LIST_TMP%RowType;
		Begin
			lrRec := ltRec(liI);
			processTag1(lrRec);
		End;
	End Loop;
	lnCustSeq := lrOther.CUST_SEQ;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrOther.ACC_CODE,lrOther.CLASS_CODE,Null);
	PKG_MAKE_SLIP.CopySlipBodyFromTemp(lrOther,lrBody2);
	lrBody2.CR_AMT := lrOther.CR_AMT;
	lrBody2.TAX_COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.DEPT_CODE := Ar_Dept_Code;
	PKG_MAKE_SLIP.Insert_Body(lrBody2);
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
