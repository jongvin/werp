Create Or Replace Procedure SP_T_FIN_MAKE_SECU_RET_SLIP
(
	Ar_Work_Slip_Id					Number,
	Ar_Work_Slip_IdSeq				Number,
	Ar_Work_Code					Varchar2,
	Ar_Make_Comp_Code				Varchar2,
	Ar_Dept_Code					Varchar2,
	Ar_Secu_No						Varchar2,
	Ar_CrtUserNo					Varchar2
)
Is
	lrRec							T_FIN_SECURTY%RowType;
	lrInfo							T_FIN_SEC_KIND%RowType;
	lrOther							T_WORK_ACC_SLIP_BODY%RowType;
	lrOld							T_ACC_SLIP_BODY%RowType;
	lrBody1							T_ACC_SLIP_BODY%RowType;
	lrBody2							T_ACC_SLIP_BODY%RowType;
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;
	lsAccCode						T_ACC_CODE.ACC_CODE%Type;
	lnItrAmt						Number;		--미수이자 금액

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
		From	T_FIN_SECURTY
		Where	SECU_NO = Ar_Secu_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'유가증권 정보를 찾을 수 없습니다.');
	End;
	Begin
		Select
			*
		Into
			lrInfo
		From	T_FIN_SEC_KIND
		Where	SEC_KIND_CODE = lrRec.SEC_KIND_CODE;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'유가증권 구분 정보를 찾을 수 없습니다.');
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
		Raise_Application_Error(-20009,'상대변 정보를 찾을 수 없습니다.');
	End;

	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(Ar_Work_Code,Ar_Make_Comp_Code);
	--지불계정이 현금이면 현금전표 아니면 대채전표
	If PKG_MAKE_SLIP.IsCashAccCode(lrOther.ACC_CODE) Then
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.RETURN_DT,'2','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	Else
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.RETURN_DT,'1','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	End If;
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnCustSeq := lrOther.Cust_Seq;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);

	--유가증권 반제
	Begin
		Select
			*
		Into
			lrOld
		From	T_ACC_SLIP_BODY
		Where	SLIP_ID = lrRec.SLIP_ID
		And		SLIP_IDSEQ = lrRec.SLIP_IDSEQ;
	Exception When No_Data_Found Then
		Raise_Application_Error(-2000,'유가증권 설정전표를 찾을 수 없습니다.');
	End;
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
	lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrOld.ACC_CODE,lrOld.CLASS_CODE,Null);
	PKG_MAKE_SLIP.CopySlipBody(lrOld,lrBody1);

	lrBody1.CR_AMT := lrRec.INCOME_AMT;		--취득금액
	lrBody1.TAX_COMP_CODE := Ar_Make_Comp_Code;
	lrBody1.COMP_CODE := Ar_Make_Comp_Code;
	lrBody1.DEPT_CODE := Ar_Dept_Code;
	lrBody1.SUMMARY1 := '유가증권 상환';
	lrBody1.RESET_SLIP_ID := lrOld.SLIP_ID;
	lrBody1.RESET_SLIP_IDSEQ := lrOld.SLIP_IDSEQ;
	PKG_MAKE_SLIP.Insert_Body(lrBody1);

	--전표 발행 번호를 엎어친다.

	Update	T_FIN_SECURTY
	Set		RESET_SLIP_ID = lrHead.SLIP_ID,
			RESET_SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
	Where	SECU_NO = Ar_Secu_No;
	Begin
		Select
			Nvl(Sum(NP_ITR_AMT),0)
		Into
			lnItrAmt
		From	T_FIN_SEC_ITR_AMT
		Where	SECU_NO = lrRec.SECU_NO;
	Exception When No_Data_Found Then
		lnItrAmt := 0;
	End;
	--만약 미수이자가 있다면
	If lnItrAmt <> 0 Then
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrInfo.ITRP_ACC_CODE,lsClassCode,Null);
		lrBody1.CR_AMT := lnItrAmt;
		lrBody1.TAX_COMP_CODE := Ar_Make_Comp_Code;
		lrBody1.COMP_CODE := Ar_Make_Comp_Code;
		lrBody1.DEPT_CODE := Ar_Dept_Code;
		lrBody1.SUMMARY1 := '유가 증권 상환시 미수이자';
		lrBody1.CUST_SEQ := lnCustSeq;
		lrBody1.CUST_NAME := lsCustName;
		lrBody1.SECU_NO := Ar_Secu_No;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
		Update	T_FIN_SECURTY
		Set		SALE_NP_ITR_AMT = lnItrAmt
		Where	SECU_NO = Ar_Secu_No;
	End If;
	--상환시 이자와 미수이자의 차액 만큼이 이자수익이 된다.
	If Nvl(lrRec.SALE_ITR_AMT,0) - lnItrAmt <> 0 Then
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrInfo.ITRB_ACC_CODE,lsClassCode,Null);
		lrBody1.CR_AMT := Nvl(lrRec.SALE_ITR_AMT,0) - lnItrAmt;
		lrBody1.TAX_COMP_CODE := Ar_Make_Comp_Code;
		lrBody1.COMP_CODE := Ar_Make_Comp_Code;
		lrBody1.DEPT_CODE := Ar_Dept_Code;
		lrBody1.SUMMARY1 := '유가 증권 상환시 이자수익';
		lrBody1.CUST_SEQ := lnCustSeq;
		lrBody1.CUST_NAME := lsCustName;
		lrBody1.SECU_NO := Ar_Secu_No;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
	End If;
	--만약 선급법인세가 있으면 설정한다.
	If Nvl(lrRec.SALE_TAX,0) <> 0 Then
		Begin
			Select
				a.CODE_LIST_ID
			Into
				lsAccCode
			From	V_T_CODE_LIST a
			Where	a.CODE_GROUP_ID = 'SECU_TAX_ACC_CODE'
			And		RowNum < 2;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'공통코드에 유가증권이자 선급법인세 계정이 등록되어 있지 않습니다.(SECU_TAX_ACC_CODE).');
		End;
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsAccCode,lsClassCode,Null);
		lrBody1.DB_AMT := lrRec.SALE_TAX;
		lrBody1.TAX_COMP_CODE := Ar_Make_Comp_Code;
		lrBody1.COMP_CODE := Ar_Make_Comp_Code;
		lrBody1.DEPT_CODE := Ar_Dept_Code;
		lrBody1.SUMMARY1 := '유가 증권 상환시 이자 법인세';
		lrBody1.CUST_SEQ := lnCustSeq;
		lrBody1.CUST_NAME := lsCustName;
		lrBody1.SECU_NO := Ar_Secu_No;
		lrBody1.RESET_SLIP_ID := lrBody1.SLIP_ID;
		lrBody1.RESET_SLIP_IDSEQ := lrBody1.SLIP_IDSEQ;
		lrBody1.BANK_CODE := lrRec.CONSIGN_BANK;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
	End If;
	--상대계정 라인
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
	lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrOther.ACC_CODE,lrOther.CLASS_CODE,Null);
	PKG_MAKE_SLIP.CopySlipBodyFromTemp(lrOther,lrBody2);
	lrBody2.DB_AMT := Nvl(lrRec.INCOME_AMT,0)+Nvl(lrRec.SALE_ITR_AMT,0) - Nvl(lrRec.SALE_TAX,0);
	lrBody2.TAX_COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.DEPT_CODE := Ar_Dept_Code;
	PKG_MAKE_SLIP.Insert_Body(lrBody2);
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
