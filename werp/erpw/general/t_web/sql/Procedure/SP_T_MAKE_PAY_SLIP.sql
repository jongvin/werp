Create Or Replace Procedure SP_T_MAKE_PAY_SLIP
(
	AR_COMP_CODE						VARCHAR2,
	AR_WORK_DT							VARCHAR2,
	AR_DEPT_CODE						VARCHAR2,
	AR_CRTUSERNO						VARCHAR2,
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
	lsWorkCode							T_Acc_Slip_Head.WORK_CODE%Type := 'FP000100';--�ڱ����� ��ǥ
	lsWorkCodePay						T_Acc_Slip_Head.WORK_CODE%Type := 'FP000101';--����ī�� ��ǥ �����ڵ�
	lnMakeSlipLine						Number;
	liFirst								Number;
	liLast								Number;
	lnSlipPubSeq						Number;
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
		Begin
			Insert Into T_FIN_PAY_SUM_LIST
			(
				COMP_CODE,
				WORK_DT,
				CRTUSERNO,
				CRTDATE
			)
			Values
			(
				AR_COMP_CODE,
				lddtMakeDt,
				AR_CRTUSERNO,
				SysDate
			);
		Exception When Dup_Val_On_Index Then
			Null;
		End;
		AR_SLIP_IDSEQ := Ari_Slip_IdSeq;
		Insert Into T_FIN_PAY_EXEC_LIST
		(
			COMP_CODE,
			WORK_DT,
			SEQ,
			CRTUSERNO,
			CRTDATE,
			MODUSERNO,
			MODDATE,
			EXEC_KIND_TAG,
			TARGET_SLIP_ID,
			TARGET_SLIP_IDSEQ,
			EXEC_AMT,
			OUT_ACC_NO,
			IN_BANK_MAIN_CODE,
			IN_ACC_NO,
			SLIP_ID,
			SLIP_IDSEQ,
			CHK_BILL_NO,
			ACCNO_OWNER,
			EXPR_DT
		)
		Values
		(
			Ar_Rec.COMP_CODE,
			Ar_Rec.WORK_DT,
			Ar_Rec.SEQ,
			Ar_Rec.CRTUSERNO,
			Ar_Rec.CRTDATE,
			Ar_Rec.MODUSERNO,
			Ar_Rec.MODDATE,
			Ar_Rec.EXEC_KIND_TAG,
			Ar_Rec.TARGET_SLIP_ID,
			Ar_Rec.TARGET_SLIP_IDSEQ,
			Ar_Rec.EXEC_AMT,
			Ar_Rec.OUT_ACC_NO,
			Ar_Rec.IN_BANK_MAIN_CODE,
			Ar_Rec.IN_ACC_NO,
			Ari_Slip_Id,
			Ari_Slip_IdSeq,
			Ar_Rec.CHK_BILL_NO,
			Ar_Rec.ACCNO_OWNER,
			Ar_Rec.EXPR_DT
		);
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
		lnMakeSlipLine := lnMakeSlipLine + 1;
		Begin
			Select
				ACC_CODE,
				BANK_CODE
			Into
				lsACC_CODE,
				lsBANK_CODE
			From	T_ACCNO_CODE
			Where	ACCNO = Ar_Rec.OUT_ACC_NO;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'���� ('||Ar_Rec.OUT_ACC_NO ||')�� ���������� ã�� �� �����ϴ�.');
		End;
		If lsACC_CODE Is Null Then
			Raise_Application_Error(-20009,'���� ('||Ar_Rec.OUT_ACC_NO ||')�� ���������� ã�� �� �����ϴ�.');
		End If;
		If lsBANK_CODE Is Null Then
			Raise_Application_Error(-20009,'���� ('||Ar_Rec.OUT_ACC_NO ||')�� ���������� ã�� �� �����ϴ�.');
		End If;
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsACC_CODE,lrBodyOrg.CLASS_CODE,Null);
		lrBody1.CR_AMT := Ar_Rec.EXEC_AMT;
		lrBody1.TAX_COMP_CODE			:=	lrBodyOrg.TAX_COMP_CODE;
		lrBody1.COMP_CODE				:=	lrBodyOrg.COMP_CODE;
		lrBody1.DEPT_CODE				:=	lrBodyOrg.DEPT_CODE;
		lrBody1.CLASS_CODE				:=	lrBodyOrg.CLASS_CODE;
		lrBody1.CUST_SEQ				:=	lrBodyOrg.CUST_SEQ;
		lrBody1.CUST_NAME				:=	lrBodyOrg.CUST_NAME;
		lrBody1.BANK_CODE				:=	lsBANK_CODE;
		lrBody1.ACCNO					:=	Ar_Rec.OUT_ACC_NO;
		lrBody1.SUMMARY1				:=	SubStrb(lrBodyOrg.SUMMARY1||'����',1,60);
		lrBody1.SUMMARY2				:=	lrBodyOrg.SUMMARY2;
		lrBody1.EMP_NO					:=	AR_CRTUSERNO;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
		processUpdateInfo(Ar_Rec,lrBody1.SLIP_ID,lrBody1.SLIP_IDSEQ);
	End;
	--����ī��
	Procedure	processTag2
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
		lnMakeSlipLine := lnMakeSlipLine + 1;

		Begin
			Select
				a.ACC_CODE
			Into
				lsACC_CODE
			From	T_WORK_ACC_CODE a
			Where	a.WORK_CODE = lsWorkCodePay
			And		a.COST_DEPT_KND_TAG =
			(
				Select
					b.COST_DEPT_KND_TAG
				From	T_DEPT_CODE b
				Where	b.DEPT_CODE = lrBodyOrg.DEPT_CODE
			);
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'�μ��ڵ� ('||lrBodyOrg.DEPT_CODE ||')�� ����ī�� ������ ã�� �� �����ϴ�.(�ڵ����� ���� ���������� Ȯ���Ͻʽÿ�.)');
		End;
		Begin
			Select
				BANK_CODE
			Into
				lsBANK_CODE
			From	T_ACCNO_CODE
			Where	ACCNO = Ar_Rec.OUT_ACC_NO;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'���� ('||Ar_Rec.OUT_ACC_NO ||')�� ���������� ã�� �� �����ϴ�.');
		End;
		If lsBANK_CODE Is Null Then
			Raise_Application_Error(-20009,'���� ('||Ar_Rec.OUT_ACC_NO ||')�� ���������� ã�� �� �����ϴ�.');
		End If;
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsACC_CODE,lrBodyOrg.CLASS_CODE,Null);
		lrBody1.CR_AMT := Ar_Rec.EXEC_AMT;
		lrBody1.TAX_COMP_CODE			:=	lrBodyOrg.TAX_COMP_CODE;
		lrBody1.COMP_CODE				:=	lrBodyOrg.COMP_CODE;
		lrBody1.DEPT_CODE				:=	lrBodyOrg.DEPT_CODE;
		lrBody1.CLASS_CODE				:=	lrBodyOrg.CLASS_CODE;
		lrBody1.CUST_SEQ				:=	lrBodyOrg.CUST_SEQ;
		lrBody1.CUST_NAME				:=	lrBodyOrg.CUST_NAME;
		lrBody1.BANK_CODE				:=	lsBANK_CODE;
		lrBody1.ACCNO					:=	Ar_Rec.OUT_ACC_NO;
		lrBody1.SUMMARY1				:=	SubStrb(lrBodyOrg.SUMMARY1||'����',1,60);
		lrBody1.SUMMARY2				:=	lrBodyOrg.SUMMARY2;
		lrBody1.EMP_NO					:=	AR_CRTUSERNO;
		lrBody1.PAY_CON_BILL_DT			:=	Ar_Rec.EXPR_DT;
		lrBody1.MNG_ITEM_DT1			:=	lrBodyOrg.MNG_ITEM_DT1;			--��꼭 �������� ���� �������� �ȴ�.
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
		processUpdateInfo(Ar_Rec,lrBody1.SLIP_ID,lrBody1.SLIP_IDSEQ);
	End;
	Procedure	processTag3
	(
		Ar_Rec			In Out NoCopy T_FIN_PAY_EXEC_LIST_TMP%RowType
	)
	Is
		lrBody1				T_ACC_SLIP_BODY%RowType;
		lrBodyOrg			T_ACC_SLIP_BODY%RowType;
		lsACC_CODE			T_ACC_CODE.ACC_CODE%Type;
		lsBANK_CODE			T_ACCNO_CODE.BANK_CODE%Type;
		lrBill				T_FIN_PAY_CHK_BILL%RowType;
	Begin
		lrBodyOrg := GetSlipBody(Ar_Rec.TARGET_SLIP_ID,Ar_Rec.TARGET_SLIP_IDSEQ);
		If Ar_Rec.CHK_BILL_NO Is Null Then
			Raise_Application_Error(-20009,'�ǹ������� ������ȣ�� �Է��ϼž� �մϴ�.');
		End If;
		processResetLine(lrBodyOrg,Ar_Rec.EXEC_AMT);
		lnMakeSlipLine := lnMakeSlipLine + 1;
		Begin
			Select
				*
			Into
				lrBill
			From	T_FIN_PAY_CHK_BILL
			Where	CHK_BILL_NO = Ar_Rec.CHK_BILL_NO;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'���� ('||Ar_Rec.CHK_BILL_NO ||')�� ã�� �� �����ϴ�.');
		End;
		If Nvl(lrBill.STAT_CLS,'X') <> '1' Then
			Raise_Application_Error(-20009,'���� ('||Ar_Rec.CHK_BILL_NO ||')�� �̹� ����Ǿ��ų� ��� �нǵ� �����Դϴ�.');
		End If;
		Begin
			Select
				a.ACC_CODE
			Into
				lsACC_CODE
			From	T_FIN_BILL_ACC_CODE a,
					T_DEPT_CODE_ORG b
			Where	a.COST_DEPT_KND_TAG = b.COST_DEPT_KND_TAG
			And		a.BILL_KIND = lrBill.BILL_KIND
			And		b.DEPT_CODE = lrBodyOrg.DEPT_CODE;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'���� ('||Ar_Rec.CHK_BILL_NO ||')�� ���� ������ ã�� �� �����ϴ�.(�ͼӺμ��� �������� ���� �Ǵ� ���������� ���������� Ȯ���Ͻʽÿ�.))');
		End;
		lsBANK_CODE := lrBill.BANK_CODE;
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsACC_CODE,lrBodyOrg.CLASS_CODE,Null);
		lrBody1.CR_AMT := Ar_Rec.EXEC_AMT;
		lrBody1.TAX_COMP_CODE			:=	lrBodyOrg.TAX_COMP_CODE;
		lrBody1.COMP_CODE				:=	lrBodyOrg.COMP_CODE;
		lrBody1.DEPT_CODE				:=	lrBodyOrg.DEPT_CODE;
		lrBody1.CLASS_CODE				:=	lrBodyOrg.CLASS_CODE;
		lrBody1.CUST_SEQ				:=	lrBodyOrg.CUST_SEQ;
		lrBody1.CUST_NAME				:=	lrBodyOrg.CUST_NAME;
		lrBody1.BANK_CODE				:=	lsBANK_CODE;
		lrBody1.ACCNO					:=	Ar_Rec.OUT_ACC_NO;
		lrBody1.SUMMARY1				:=	SubStrb(lrBodyOrg.SUMMARY1||'����',1,60);
		lrBody1.SUMMARY2				:=	lrBodyOrg.SUMMARY2;
		lrBody1.EMP_NO					:=	AR_CRTUSERNO;
		lrBody1.BILL_NO					:=	Ar_Rec.CHK_BILL_NO;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
		--���� ���� ����
		Update	T_FIN_PAY_CHK_BILL
		Set		STAT_CLS = '2',			--�������
				CUST_SEQ = lrBody1.CUST_SEQ,
				PUBL_DT = lddtMakeDt,
				PUBL_AMT = Ar_Rec.EXEC_AMT,
				EXPR_DT = Ar_Rec.EXPR_DT,
				SLIP_ID = lrBody1.SLIP_ID,
				SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
		Where	CHK_BILL_NO = Ar_Rec.CHK_BILL_NO;
		processUpdateInfo(Ar_Rec,lrBody1.SLIP_ID,lrBody1.SLIP_IDSEQ);
	End;
	--������
	Procedure	processTag4
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
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lsACC_CODE := GetPayAccCode('4');
		/*
		Begin
			Select
				BANK_CODE
			Into
				lsBANK_CODE
			From	T_ACCNO_CODE
			Where	ACCNO = Ar_Rec.OUT_ACC_NO;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'���� ('||Ar_Rec.OUT_ACC_NO ||')�� ���������� ã�� �� �����ϴ�.');
		End;
		If lsBANK_CODE Is Null Then
			Raise_Application_Error(-20009,'���� ('||Ar_Rec.OUT_ACC_NO ||')�� ���������� ã�� �� �����ϴ�.');
		End If;
		*/
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsACC_CODE,lrBodyOrg.CLASS_CODE,Null);
		lrBody1.CR_AMT := Ar_Rec.EXEC_AMT;
		lrBody1.TAX_COMP_CODE			:=	lrBodyOrg.TAX_COMP_CODE;
		lrBody1.COMP_CODE				:=	lrBodyOrg.COMP_CODE;
		lrBody1.DEPT_CODE				:=	lrBodyOrg.DEPT_CODE;
		lrBody1.CLASS_CODE				:=	lrBodyOrg.CLASS_CODE;
		lrBody1.CUST_SEQ				:=	lrBodyOrg.CUST_SEQ;
		lrBody1.CUST_NAME				:=	lrBodyOrg.CUST_NAME;
		--lrBody1.BANK_CODE				:=	lsBANK_CODE;
		--lrBody1.ACCNO					:=	Ar_Rec.OUT_ACC_NO;
		lrBody1.SUMMARY1				:=	SubStrb(lrBodyOrg.SUMMARY1||'����',1,60);
		lrBody1.SUMMARY2				:=	lrBodyOrg.SUMMARY2;
		lrBody1.EMP_NO					:=	AR_CRTUSERNO;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
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
	If ltRec(liFirst).EXEC_KIND_TAG = '1' Then
		lsSlipCls := '3';	--�ڱ�
	ElsIf ltRec(liFirst).EXEC_KIND_TAG = '2' Then
		lsSlipCls := '1';	--��ü
	ElsIf ltRec(liFirst).EXEC_KIND_TAG = '3' Then
		lsSlipCls := '1';	--��ü
	ElsIf ltRec(liFirst).EXEC_KIND_TAG = '4' Then
		lsSlipCls := '2';	--����
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
	For liI In liFirst..liLast Loop
		Declare
			lrRec								T_FIN_PAY_EXEC_LIST_TMP%RowType;
		Begin
			lrRec := ltRec(liI);
			If lrRec.EXEC_KIND_TAG = '1' Then
				processTag1(lrRec);
			ElsIf lrRec.EXEC_KIND_TAG = '2' Then
				processTag2(lrRec);
			ElsIf lrRec.EXEC_KIND_TAG = '3' Then
				processTag3(lrRec);
			ElsIf lrRec.EXEC_KIND_TAG = '4' Then
				processTag4(lrRec);
			End If;
		End;
	End Loop;
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
