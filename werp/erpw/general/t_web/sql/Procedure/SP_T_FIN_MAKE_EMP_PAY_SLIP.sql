Create Or Replace Procedure SP_T_FIN_MAKE_EMP_PAY_SLIP
(
	Ar_Work_Slip_Id					Number,
	Ar_Work_Slip_IdSeq				Number,
	Ar_Work_Code					Varchar2,
	Ar_Make_Comp_Code				Varchar2,
	Ar_Dept_Code					Varchar2,
	Ar_WorkDt						Varchar2,
	Ar_Work_Seq						Number,
	Ar_CrtUserNo					Varchar2
)
Is
	lddt_WorkDt						Date;
	lrRec							T_FIN_EMP_PAY_MAIN%RowType;
	lnSum							Number := 0;
	lrOther							T_WORK_ACC_SLIP_BODY%RowType;
	lrBody1							T_ACC_SLIP_BODY%RowType;
	lrBody2							T_ACC_SLIP_BODY%RowType;
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;
	lsBankName						T_BANK_MAIN.BANK_MAIN_NAME%Type;
	lrHead						T_ACC_SLIP_HEAD%RowType;
	lsChargePers				T_Acc_Slip_Head.CHARGE_PERS%Type;
	lnMakeSlipLine				Number;
	lsCustName					T_ACC_SLIP_BODY.CUST_NAME%Type;
	lnCustSeq					T_CUST_CODE.CUST_SEQ%Type;
Begin
	lddt_WorkDt := F_T_STRINGTODATE(Ar_WorkDt);
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_EMP_PAY_MAIN
		Where	COMP_CODE = Ar_Make_Comp_Code
		And		WORK_DT = lddt_WorkDt
		And		WORK_SEQ = Ar_Work_Seq;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'복리후생비 작업 정보를 찾을 수 없습니다.');
	End;

	If lrRec.COST_ACC_CODE Is Null Then
		Raise_Application_Error(-20009,'비용계정을 선택하셔야 합니다.');
	End If;

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
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.WORK_DT,'2','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	Else
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.WORK_DT,'1','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	End If;

	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnCustSeq := lrOther.CUST_SEQ;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);
	
	For lrA In (
					Select
						b.DEPT_CODE,
						Sum(a.EXEC_AMT) EXEC_AMT
					From	T_FIN_EMP_PAY_LIST a,
							(
								Select
									a.EMP_NO,
									a.DEPT_CODE
								From
									(
										Select
											a.EMP_NO,
											a.DEPT_CODE,
											Row_Number() Over ( Partition By a.EMP_NO Order By a.EMP_NO,a.ORDER_DT desc ,a.ORDER_SEQ desc ) rn
										From	T_FIN_EMP_ORDER a
										Order By
											a.EMP_NO,a.ORDER_DT desc ,a.ORDER_SEQ
									) a
								Where	rn = 1
							) b
					Where	a.COMP_CODE = Ar_Make_Comp_Code
					And		a.WORK_SEQ = Ar_Work_Seq
					And		a.WORK_DT = lddt_WorkDt
					And		a.EMP_NO = b.EMP_NO
					Group By
						b.DEPT_CODE
				)
	Loop
		--비용 라인
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrRec.COST_ACC_CODE,lsClassCode,Null);
		lrBody1.DB_AMT := lrA.EXEC_AMT;
		lrBody1.TAX_COMP_CODE := PKG_MAKE_SLIP.Get_Comp_Code(lrA.DEPT_CODE);
		lrBody1.COMP_CODE := lrBody1.TAX_COMP_CODE;
		lrBody1.DEPT_CODE := lrA.DEPT_CODE;
		lrBody1.SUMMARY1 := SubStrb(lrRec.CONTENTS,1,60);
		lrBody1.CUST_SEQ := lnCustSeq;
		lrBody1.CUST_NAME := lsCustName;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
		lnSum := lnSum + Nvl(lrA.EXEC_AMT,0);
	End Loop;


	--전표 발행 번호를 엎어친다.

	Update	T_FIN_EMP_PAY_MAIN
	Set		SLIP_ID = lrHead.SLIP_ID
	Where	COMP_CODE = Ar_Make_Comp_Code
	And		WORK_DT = lddt_WorkDt
	And		WORK_SEQ = Ar_Work_Seq;


	--상대계정 라인
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);
	lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrOther.ACC_CODE,lrOther.CLASS_CODE,Null);
	PKG_MAKE_SLIP.CopySlipBodyFromTemp(lrOther,lrBody2);
	lrBody2.CR_AMT := lnSum;
	lrBody2.TAX_COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.DEPT_CODE := Ar_Dept_Code;
	If PKG_MAKE_SLIP.IsRemainAccCode(lrOther.ACC_CODE) Then
		lrBody2.RESET_SLIP_ID := lrBody2.SLIP_ID;
		lrBody2.RESET_SLIP_IDSEQ := lrBody2.SLIP_IDSEQ;
	End If;
	PKG_MAKE_SLIP.Insert_Body(lrBody2);
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
