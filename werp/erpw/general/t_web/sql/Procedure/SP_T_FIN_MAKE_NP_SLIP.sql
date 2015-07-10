Create Or Replace Procedure SP_T_FIN_MAKE_NP_SLIP
(
	Ar_Work_No					Number,
	Ar_Make_Comp_Code			Varchar2,
	Ar_Make_Dept_Code			Varchar2,
	Ar_CrtUserNo				Varchar2
)
Is
	Type	T_table_COMP_CODE Is Table Of T_COMPANY_ORG.COMP_CODE%Type
		Index By Binary_Integer;
	type	T_table_NP_ITR_AMT Is Table Of Number
		Index By Binary_Integer;
	lt_CompCode					T_table_COMP_CODE;
	lt_NpItrAmt					T_table_NP_ITR_AMT;
	liFirst						Number;
	liLast						Number;
	lrHead						T_ACC_SLIP_HEAD%RowType;
	lrRec						T_FIN_SEC_NP_ITR_WORK%RowType;
	lsChargePers				T_Acc_Slip_Head.CHARGE_PERS%Type;
	lsAccCode1					T_Acc_Code.Acc_Code%Type;		--미수이자 계정
	lsAccCode2					T_Acc_Code.Acc_Code%Type;		--이자수익 계정
	lnMakeSlipLine				Number;
	ln_SlipId					Number := Null;
	ln_SlipIdSeq				Number := Null;
	lsCustName					T_ACC_SLIP_BODY.CUST_NAME%Type;
	lnCustSeq					T_CUST_CODE.CUST_SEQ%Type;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_SEC_NP_ITR_WORK
		Where	WORK_NO = Ar_Work_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'유가증권 미수이자 작업을 찾을 수 없습니다.');
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'이미 전표가 발행되어 있습니다.');
	End If;
	Begin
		Select
			a.ITRB_ACC_CODE,
			a.ITRP_ACC_CODE
		Into
			lsAccCode1,
			lsAccCode2
		From	T_FIN_SEC_KIND a
		Where	a.ITRP_ACC_CODE Is Not Null
		And		a.ITRB_ACC_CODE Is Not Null
		And		RowNum < 2;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'유가증권 종류에 이자수익 계정 및 미수이자 계정이 설정되어 있지 않습니다.');
	End;
	Select
		c.COMP_CODE,
		Sum(b.NP_ITR_AMT) NP_ITR_AMT
	Bulk Collect Into
		lt_CompCode,
		lt_NpItrAmt
	From	T_FIN_NP_ITR_TAR_SEC a,
			T_FIN_SEC_ITR_AMT b,
			T_FIN_SECURTY c
	Where	a.SECU_NO = b.SECU_NO
	And		a.ITR_CALC_NO = b.ITR_CALC_NO
	And		b.SECU_NO = c.SECU_NO
	And		a.WORK_NO = Ar_Work_No
	Group By
		c.COMP_CODE;
	If lt_CompCode.Count < 1 Then
		Raise_Application_Error(-20009,'작업 대상 미수이자 내역이 없습니다.');
	End If;
	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS('F',Ar_Make_Comp_Code);
	liFirst := lt_CompCode.First;
	liLast := lt_CompCode.Last;
	lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Make_Dept_Code,lrRec.CALC_DT_TO,'1','B',Ar_CrtUserNo,'F',lsChargePers,Ar_CrtUserNo);
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnCustSeq := PKG_MAKE_SLIP.Get_Dflt_Cust_Seq;
	If lnCustSeq Is Null Then
		Raise_Application_Error(-20009,'임의거래처가 설정되어 있지 않습니다.');
	End If;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);

	For liI In liFirst..liLast Loop
		Declare
			lrBody1				T_ACC_SLIP_BODY%RowType;
			lrBody2				T_ACC_SLIP_BODY%RowType;
			lsDeptCode			T_DEPT_CODE.DEPT_CODE%Type;
			lsCompCode			T_COMPANY_ORG.COMP_CODE%Type;
			lsClassCode			T_CLASS_CODE.CLASS_CODE%Type;
			lnNpItrAmt			Number;
		Begin
			--미수이자 라인
			lnMakeSlipLine := lnMakeSlipLine + 1;
			lsCompCode := lt_CompCode(liI);
			lnNpItrAmt := lt_NpItrAmt(liI);
			lnCustSeq := PKG_MAKE_SLIP.Get_Dflt_Cust_Seq;
			


			lsDeptCode := PKG_MAKE_SLIP.Get_Fin_Dept_Code(lsCompCode);
			lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lsDeptCode);
			lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsAccCode1,lsClassCode,Null);
			lrBody1.DB_AMt := lnNpItrAmt;
			lrBody1.TAX_COMP_CODE := lsCompCode;
			lrBody1.COMP_CODE := lsCompCode;
			lrBody1.DEPT_CODE := lsDeptCode;
			lrBody1.SUMMARY1 := To_Char(lrRec.CALC_DT_TO,'YYYY')||'년'||To_Char(lrRec.CALC_DT_TO,'MM')||'월미수이자';
			lrBody1.CUST_SEQ := lnCustSeq;
			lrBody1.CUST_NAME := lsCustName;
			PKG_MAKE_SLIP.Insert_Body(lrBody1);
			--이자수익 라인
			lnMakeSlipLine := lnMakeSlipLine + 1;
			lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsAccCode2,lsClassCode,Null);
			lrBody2.CR_AMt := lnNpItrAmt;
			lrBody2.TAX_COMP_CODE := lsCompCode;
			lrBody2.COMP_CODE := lsCompCode;
			lrBody2.DEPT_CODE := lsDeptCode;
			lrBody2.SUMMARY1 := To_Char(lrRec.CALC_DT_TO,'YYYY')||'년'||To_Char(lrRec.CALC_DT_TO,'MM')||'월미수이자';
			lrBody2.CUST_SEQ := lnCustSeq;
			lrBody2.CUST_NAME := lsCustName;
			PKG_MAKE_SLIP.Insert_Body(lrBody2);
			Update	T_FIN_SEC_ITR_AMT a
			Set		a.SLIP_ID = lrHead.SLIP_ID,
					a.SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
			Where	Exists
			(
				Select
					Null
				From	T_FIN_NP_ITR_TAR_SEC b,
						T_FIN_SEC_ITR_AMT c,
						T_FIN_SECURTY d
				Where	b.WORK_NO = Ar_Work_No
				And		b.SECU_NO = c.SECU_NO
				And		b.ITR_CALC_NO = c.ITR_CALC_NO
				And		d.SECU_NO = b.SECU_NO
				And		d.COMP_CODE = lsCompCode
				And		a.SECU_NO = b.SECU_NO
				And		a.ITR_CALC_NO = b.ITR_CALC_NO
			);
			If ln_SlipId Is Null Then
				ln_SlipId := lrHead.SLIP_ID;
				ln_SlipIdSeq := lrBody1.SLIP_IDSEQ;
			End If;
		End;
	End Loop;
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
	Update	T_FIN_SEC_NP_ITR_WORK
	Set		SLIP_ID = ln_SlipId,
			SLIP_IDSEQ = ln_SlipIdSeq
	Where	WORK_NO = Ar_Work_No;
End;
/
