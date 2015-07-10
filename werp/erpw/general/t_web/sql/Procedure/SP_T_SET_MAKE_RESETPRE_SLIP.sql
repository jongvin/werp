Create Or Replace Procedure SP_T_SET_MAKE_RESETPRE_SLIP
(
	AR_COMP_CODE					VARCHAR2,
	AR_DEPT_CODE					Varchar2,
	AR_WORK_NO						NUMBER,
	AR_CRTUSERNO					VARCHAR2
)
Is
	lrRec							T_SET_RESET_COST%RowType;
	lrInfo							T_SET_EMP_INSUR_INFO%RowType;
	ls_Work_Code					T_WORK_CODE.WORK_CODE%Type := 'SETPRECOST';
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;

	lrBody1							T_ACC_SLIP_BODY%RowType;
	lrBody2							T_ACC_SLIP_BODY%RowType;

	lrHead							T_ACC_SLIP_HEAD%RowType;
	lsChargePers					T_Acc_Slip_Head.CHARGE_PERS%Type;
	lnMakeSlipLine					Number;
	lnAmt							Number;
	lnSum							Number;
	lsCustName						T_ACC_SLIP_BODY.CUST_NAME%Type;
	lnCustSeq						T_CUST_CODE.CUST_SEQ%Type;
	
	lnCount							Number;
Begin
	
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_RESET_COST
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_NO = AR_WORK_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'대상이 되는 집계작업을 찾을 수 없습니다.');
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'대상이 되는 집계작업은 이미 전표가 발행되었습니다.전표를 삭제하신후 재 집계를 하셔야 합니다.');
	End If;
	If lrRec.REMARKS Is Null Then
		Raise_Application_Error(-20009,'적요를 입력하여 주십시오.');
	End If;
	Begin
		Select
			Count(*) 
		Into
			lnCount
		From	T_SET_RESET_COST_LIST a
		Where	a.COMP_CODE = AR_COMP_CODE
		And		a.WORK_NO = AR_WORK_NO
		And		Not Exists
		(
			Select
				Null
			From	Z_AUTHORITY_USER b,
					T_DEPT_CODE_ORG c
			Where	a.EMP_NO = b.EMPNO
			And		b.DEPT_CODE = c.DEPT_CODE
		);
		If lnCount > 0 Then
			Raise_Application_Error(-20009,'예정원가 목록중 '||To_Char(lnCount)||'건의 자료에 올바르지 않은 사원정보가 있습니다.');
		End If;
	Exception When No_Data_Found Then
		Null;
	End;
	lnCustSeq := PKG_MAKE_SLIP.GET_DFLT_CUST_SEQ;
	If lnCustSeq Is Null Then
		Raise_Application_Error(-20009,'임의 거래처가 설정되어 있지 않습니다.');
	End If;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);

	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(ls_Work_Code,AR_COMP_CODE);
	lrHead := PKG_MAKE_SLIP.New_Head(AR_COMP_CODE,AR_DEPT_CODE,Last_Day(lrRec.WORK_DT),'1','B',AR_CRTUSERNO,ls_Work_Code,lsChargePers,AR_CRTUSERNO);
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnSum := 0;
	--먼저 기존 정산되지 않은 사항을 찾아서 음수 전표를 발행한다.
	For lrA In ( 
					Select
						*
					From	T_ACC_SLIP_BODY a
					Where	a.SLIP_ID In
					(
						Select
							b.SLIP_ID
						From	T_SET_PREV_COST b,
								T_SET_RESET_COST c
						Where	b.R_SLIP_ID Is Null
						And		c.COMP_CODE = AR_COMP_CODE
						And		c.WORK_NO = AR_WORK_NO
						And		b.COST_MAIN_ACC_CODE = c.COST_MAIN_ACC_CODE
					)
					And		a.KEEP_DT Is Not Null
				)
	Loop
		--원가 전표
		lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);

		lnMakeSlipLine := lnMakeSlipLine + 1;
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrA.ACC_CODE,lsClassCode,Null);
		PKG_MAKE_SLIP.CopySlipBody(lrA,lrBody1);
		lrBody1.DB_AMT := - lrA.DB_AMT;
		lrBody1.CR_AMT := - lrA.CR_AMT;
		lrBody1.SUMMARY1 := SubStrb(lrRec.REMARKS,1,60);
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
		If lnMakeSlipLine = 1 Then
			Update T_SET_RESET_COST
			Set		SLIP_ID = lrBody1.SLIP_ID,
					SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
			Where	COMP_CODE = AR_COMP_CODE
			And		WORK_NO = AR_WORK_NO;
		End If;
		Update	T_SET_PREV_COST
		Set		R_SLIP_ID = lrBody1.SLIP_ID,
				R_SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
		Where	SLIP_ID = lrA.SLIP_ID
		And		R_SLIP_ID Is Null;
	End Loop;
	lnSum := 0;
	For lrA In ( 
					Select
						a.COMP_CODE,
						a.WORK_NO,
						a.DEPT_CODE,
						a.COST_DEPT_KND_TAG,
						a.COST_MAIN_ACC_CODE,
						a.AMT,
						x.ACC_CODE
					From
						(
							Select
								a.COMP_CODE,
								a.WORK_NO,
								d.DEPT_CODE,
								d.COST_DEPT_KND_TAG,
								b.COST_MAIN_ACC_CODE,
								Sum(a.AMT) AMT
							From	T_SET_RESET_COST_LIST a,
									T_SET_RESET_COST b,
									Z_AUTHORITY_USER c,
									T_DEPT_CODE_ORG d
							Where	a.COMP_CODE = b.COMP_CODE
							And		a.WORK_NO = b.WORK_NO
							And		a.EMP_NO = c.EMPNO
							And		c.DEPT_CODE = d.DEPT_CODE
							And		a.COMP_CODE = AR_COMP_CODE
							And		a.WORK_NO = AR_WORK_NO
							Group By
								a.COMP_CODE,
								a.WORK_NO,
								d.DEPT_CODE,
								d.COST_DEPT_KND_TAG,
								b.COST_MAIN_ACC_CODE
						) a,
						T_CODE_KIND_ACC_CODE x
					Where	a.COST_DEPT_KND_TAG = x.COST_DEPT_KND_TAG (+)
					And		a.COST_MAIN_ACC_CODE = x.MAIN_ACC_CODE (+)
					Order By
						a.DEPT_CODE
				)
	Loop
		--원가 전표
		If lrA.ACC_CODE Is Null Then
			RAISE_APPLICATION_ERROR(-20009,'해당 대표계정의 부서별 계정이 설정되어 있지 않습니다.'||lrA.COST_MAIN_ACC_CODE);
		End If;
		lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
		lnAmt := lrA.AMT;

		lnMakeSlipLine := lnMakeSlipLine + 1;
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrA.ACC_CODE,lsClassCode,Null);
		lrBody1.DB_AMT := lnAmt;
		lrBody1.TAX_COMP_CODE := PKG_MAKE_SLIP.Get_Comp_Code(lrA.DEPT_CODE);
		lrBody1.COMP_CODE := lrBody1.TAX_COMP_CODE;
		lrBody1.DEPT_CODE := lrA.DEPT_CODE;
		lrBody1.SUMMARY1 := SubStrb(lrRec.REMARKS,1,60);
		lrBody1.CUST_SEQ := lnCustSeq;
		lrBody1.CUST_NAME := lsCustName;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
		lnSum := Nvl(lnAmt,0) + Nvl(lnSum,0);
	End Loop;
	
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(AR_DEPT_CODE);
	--상대계정 라인
	lnMakeSlipLine := lnMakeSlipLine + 1;

	lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrRec.OTHER_ACC_CODE,lsClassCode,Null);

	lrBody2.CR_AMT := lnSum;
	lrBody2.TAX_COMP_CODE := AR_COMP_CODE;
	lrBody2.COMP_CODE := AR_COMP_CODE;
	lrBody2.DEPT_CODE := AR_DEPT_CODE;
	lrBody2.SUMMARY1 := SubStrb(lrRec.REMARKS,1,60);
	lrBody2.CUST_SEQ := lnCustSeq;
	lrBody2.CUST_NAME := lsCustName;
	lrBody2.RESET_SLIP_ID := lrBody2.SLIP_ID;
	lrBody2.RESET_SLIP_IDSEQ := lrBody2.SLIP_IDSEQ;
	PKG_MAKE_SLIP.Insert_Body(lrBody2);
	
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
