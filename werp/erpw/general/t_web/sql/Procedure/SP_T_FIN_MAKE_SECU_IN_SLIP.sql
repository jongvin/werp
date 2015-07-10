Create Or Replace Procedure SP_T_FIN_MAKE_SECU_IN_SLIP
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
	lrBody1							T_ACC_SLIP_BODY%RowType;
	lrBody2							T_ACC_SLIP_BODY%RowType;
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;

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
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.GET_DT,'2','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	Else
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.GET_DT,'1','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	End If;
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnCustSeq := lrOther.Cust_Seq;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);

	--유가증권
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
	lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrInfo.SEC_ACC_CODE,lsClassCode,Null);
	lrBody1.DB_AMT := lrRec.INCOME_AMT;
	lrBody1.TAX_COMP_CODE := Ar_Make_Comp_Code;
	lrBody1.COMP_CODE := Ar_Make_Comp_Code;
	lrBody1.DEPT_CODE := Ar_Dept_Code;
	lrBody1.SUMMARY1 := '유가증권매입';
	lrBody1.CUST_SEQ := lnCustSeq;
	lrBody1.CUST_NAME := lsCustName;
	lrBody1.RESET_SLIP_ID := lrHead.SLIP_ID;				--설정인 경우는 자기 전표 번호입니다.
	lrBody1.RESET_SLIP_IDSEQ := lrBody1.SLIP_IDSEQ;			--설정인 경우는 자기 전표 번호입니다.
	lrBody1.SECU_NO := Ar_Secu_No;
	lrBody1.BANK_CODE := lrRec.CONSIGN_BANK;
	PKG_MAKE_SLIP.Insert_Body(lrBody1);

	--전표 발행 번호를 엎어친다.

	Update	T_FIN_SECURTY
	Set		SLIP_ID = lrHead.SLIP_ID,
			SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
	Where	SECU_NO = Ar_Secu_No;


	--상대계정 라인
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
	lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrOther.ACC_CODE,lrOther.CLASS_CODE,Null);
	PKG_MAKE_SLIP.CopySlipBodyFromTemp(lrOther,lrBody2);
	lrBody2.CR_AMT := lrRec.INCOME_AMT;
	lrBody2.TAX_COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.DEPT_CODE := Ar_Dept_Code;
	lrBody2.ACC_CODE := lrOther.ACC_CODE;
	PKG_MAKE_SLIP.Insert_Body(lrBody2);
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
