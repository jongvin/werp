Create Or Replace Procedure SP_T_MAKE_COST_CONV_SLIP
(
	Ar_Comp_Code					Varchar2,
	Ar_Work_No						Number,
	Ar_Dept_Code					Varchar2,
	Ar_CrtUserNo					Varchar2
)
Is
	ls_Work_Code					Varchar2(20):= 'SETCOST';
	lrRec							T_SET_COST_CONV_SLIP%RowType;
	lddtF							Date;
	lddtT							Date;
	lddtCloseDt						Date;
	lrT_DEPT_CODE_ORG				T_DEPT_CODE_ORG%ROWTYPE;
	lsAccCode						T_ACC_CODE.ACC_CODE%Type;
	lsAccCode1						T_ACC_CODE.ACC_CODE%Type;
	lsAccCode2						T_ACC_CODE.ACC_CODE%Type;
	lsAccCode3						T_ACC_CODE.ACC_CODE%Type;
	lsAccCode4						T_ACC_CODE.ACC_CODE%Type;
	lsAccCode5						T_ACC_CODE.ACC_CODE%Type;
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
			*
		Into
			lrRec
		From	T_SET_COST_CONV_SLIP
		Where	COMP_CODE = Ar_Comp_Code
		And		WORK_NO = Ar_Work_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'원가 대체 작업 정보를 찾을 수 없습니다.');
	End;

	BEGIN
		SELECT
			*
		INTO
			lrT_DEPT_CODE_ORG
		FROM	T_DEPT_CODE_ORG
		WHERE	DEPT_CODE=Ar_Dept_Code;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR(-20009,'존재하지 않는 부서코드입니다');
	END;
	
	lddtF := Trunc(lrRec.WORK_DT,'MM');
	lddtT := Last_Day(lrRec.WORK_DT);


	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(ls_Work_Code,Ar_Comp_Code);

	lrHead := PKG_MAKE_SLIP.New_Head(Ar_Comp_Code,Ar_Dept_Code,Last_Day(lrRec.WORK_DT),'1','D',Ar_CrtUserNo,ls_Work_Code,lsChargePers,Ar_CrtUserNo);

	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnCustSeq := PKG_MAKE_SLIP.GET_DFLT_CUST_SEQ;
	If lnCustSeq Is Null Then
		Raise_Application_Error(-20009,'임의거래처가 설정되어 있지 않습니다.');
	End If;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);
	For lrA In (
					Select
						a.COMP_CODE,
						a.DEPT_CODE,
						a.ACC_CODE,
						Sum(a.DB_AMT) DB_AMT
					From	T_ACC_SLIP_BODY1 a
					Where	a.COMP_CODE = Ar_Comp_Code
					And		a.MAKE_DT Between lddtF And lddtT
					And		a.TRANSFER_TAG = 'F'
					And		a.KEEP_DT Is Not Null
					And		a.ACC_CODE In
					(
						Select
						Distinct
							x.ACC_CODE
						From	T_SET_COST_CONV_ACC x
					)
					Group By
						a.COMP_CODE,
						a.DEPT_CODE,
						a.ACC_CODE
				)
	Loop
		--원가 라인
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrA.ACC_CODE,lsClassCode,Null);
		lrBody1.CR_AMT := lrA.DB_AMT;
		lrBody1.TAX_COMP_CODE := lrT_DEPT_CODE_ORG.COMP_CODE;
		lrBody1.COMP_CODE := lrT_DEPT_CODE_ORG.COMP_CODE;
		lrBody1.DEPT_CODE := lrA.DEPT_CODE;
		lrBody1.SUMMARY1 := SubStrb(lrRec.REMARKS,1,60);
		lrBody1.CUST_SEQ := lnCustSeq;
		lrBody1.CUST_NAME := lsCustName;
	
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
		If lnMakeSlipLine = 1 Then
			Update	T_SET_COST_CONV_SLIP
			Set		SLIP_ID = lrBody1.SLIP_ID,
					SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
			Where	COMP_CODE = Ar_Comp_Code
			And		WORK_NO = Ar_WORK_NO;
		End If;
		Begin
			Select
				a.R_ACC_CODE,
				a.R_ACC_CODE2,
				a.R_ACC_CODE3,
				a.R_ACC_CODE4,
				a.R_ACC_CODE5
			Into
				lsAccCode1,
				lsAccCode2,
				lsAccCode3,
				lsAccCode4,
				lsAccCode5
			From	T_SET_COST_CONV_ACC a,
					T_DEPT_CODE_ORG b
			Where	b.DEPT_CODE = lrA.DEPT_CODE
			And		b.COST_CONV_CODE = a.COST_CONV_CODE
			And		a.ACC_CODE = lrA.ACC_CODE;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'부서정보관리에 원가대체 구분이 등록되어 있지 않거나 해당계정의 원가대체 계정이 정의되어 있지 않습니다.(부서코드:'||lrA.DEPT_CODE||',계정코드:'||lrA.ACC_CODE);
		End;
		If lsAccCode2 Is Not Null Then		--자산대체 계정이면
			Select
				ACC_CLOST_DT_SYS
			Into
				lddtCloseDt
			From	T_DEPT_CODE_ORG
			Where	DEPT_CODE = lrA.DEPT_CODE;
			If Nvl(lddtCloseDt,To_Date('99991231','YYYYMMDD')) <= lddtT Then		--이미 마감된 현장이면
				lsAccCode := lsAccCode4;											--완성건물
			Else
				lsAccCode := lsAccCode2;											--미완성건물
			End If;
		Else
			lsAccCode := lsAccCode1;
		End If;

		lnMakeSlipLine := lnMakeSlipLine + 1;
		lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsAccCode,lsClassCode,Null);
		lrBody2.DB_AMT := lrA.DB_AMT;
		lrBody2.TAX_COMP_CODE := lrT_DEPT_CODE_ORG.COMP_CODE;
		lrBody2.COMP_CODE := lrT_DEPT_CODE_ORG.COMP_CODE;
		lrBody2.DEPT_CODE := lrA.DEPT_CODE;
		lrBody2.SUMMARY1 := SubStrb(lrRec.REMARKS,1,60);
		lrBody2.CUST_SEQ := lnCustSeq;
		lrBody2.CUST_NAME := lsCustName;
	
		PKG_MAKE_SLIP.Insert_Body(lrBody2);

	End Loop;
	If lnMakeSlipLine < 1 Then
		Raise_Application_Error(-20009,'전표를 발행할 대상 행이 없습니다.');
	End If;
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
