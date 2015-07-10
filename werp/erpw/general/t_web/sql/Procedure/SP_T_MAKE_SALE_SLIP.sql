Create Or Replace Procedure SP_T_MAKE_SALE_SLIP
(
	Ar_Comp_Code					Varchar2,
	Ar_Work_No						Number,
	Ar_Dept_Code					Varchar2,
	Ar_CrtUserNo					Varchar2
)
Is
	ls_Work_Code					Varchar2(20):= 'SETSALE1';
	lrRec							T_SET_SALE_SLIP%RowType;
	lsNpRAccCode					T_ACC_CODE.ACC_CODE%Type;
	lsPpRAccCode					T_ACC_CODE.ACC_CODE%Type;
	lsSaleAccCode					T_ACC_CODE.ACC_CODE%Type;
	lrBody1							T_ACC_SLIP_BODY%RowType;
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;
	lrHead							T_ACC_SLIP_HEAD%RowType;
	lsChargePers					T_Acc_Slip_Head.CHARGE_PERS%Type;
	lnMakeSlipLine					Number;
	lsCustName						T_ACC_SLIP_BODY.CUST_NAME%Type;
	lnCustSeq						T_CUST_CODE.CUST_SEQ%Type;
	lnSlipId						Number;
	lnSlipIdSeq						Number;
	lrBody2							T_ACC_SLIP_BODY%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_SALE_SLIP
		Where	COMP_CODE = Ar_Comp_Code
		And		WORK_NO = Ar_Work_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'진행율 전표 생성 작업 정보를 찾을 수 없습니다.');
	End;

	Begin
		select
			a.CODE_LIST_ID
		Into
			lsNpRAccCode
		from	v_t_code_list a
		where	a.CODE_GROUP_ID = 'PPR_ACC_CODE'
		And		RowNum < 2;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'공통 코드에 진행율 선수금 계정이 설정되어 있지 않습니다.');
	End;
	Begin
		select
			a.CODE_LIST_ID
		Into
			lsPpRAccCode
		from	v_t_code_list a
		where	a.CODE_GROUP_ID = 'PPR_ACC_CODE'
		And		RowNum < 2;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'공통 코드에 진행율 미수금 계정이 설정되어 있지 않습니다.');
	End;
	


	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(ls_Work_Code,Ar_Comp_Code);

	lrHead := PKG_MAKE_SLIP.New_Head(Ar_Comp_Code,Ar_Dept_Code,Last_Day(lrRec.WORK_DT),'1','D',Ar_CrtUserNo,ls_Work_Code,lsChargePers,Ar_CrtUserNo);	--결산전표

	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnCustSeq := PKG_MAKE_SLIP.GET_DFLT_CUST_SEQ;
	If lnCustSeq Is Null Then
		Raise_Application_Error(-20009,'임의거래처가 설정되어 있지 않습니다.');
	End If;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);
	For lrA In (
					Select
						*
					From	T_SET_SALE_SLIP_LIST
					Where	COMP_CODE = Ar_Comp_Code
					And		WORK_NO = Ar_Work_No
					Order By
						DEPT_CODE
				)
	Loop
		--당월 매출액과 당월 매출액 기계상액의 차이가 양수이면 미수금 진행율이 음수이면 선수금 진행율이 발행된다.
		Begin
			Select
				b.SALE_ACC_CODE
			Into
				lsSaleAccCode
			From	T_DEPT_CODE_ORG a,
					T_SET_COST_CONV_CODE b
			Where	a.COST_CONV_CODE = b.COST_CONV_CODE
			And		a.DEPT_CODE = lrA.DEPT_CODE;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'해당현장의 매출액 계정 또는 원가대체계정구분이 설정되지 않았습니다.'||lrA.DEPT_CODE);
		End;
		If lsSaleAccCode Is Null Then
			Raise_Application_Error(-20009,'해당현장의 매출액 계정 또는 원가대체계정구분이 설정되지 않았습니다.'||lrA.DEPT_CODE);
		End If;
		If Nvl(lrA.NM_SALE_AMT,0) - Nvl(lrA.NM_SALE_P_AMT,0) > 0 Then
			--매출액 라인
			lnMakeSlipLine := lnMakeSlipLine + 1;
			lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
			lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsSaleAccCode,lsClassCode,Null);
			lrBody1.CR_AMT := Nvl(lrA.NM_SALE_AMT,0) - Nvl(lrA.NM_SALE_P_AMT,0);
			lrBody1.TAX_COMP_CODE := Ar_Comp_Code;
			lrBody1.COMP_CODE := Ar_Comp_Code;
			lrBody1.DEPT_CODE := lrA.DEPT_CODE;
			lrBody1.SUMMARY1 := '결산 진행율 매출 전표';
			lrBody1.CUST_SEQ := lnCustSeq;
			lrBody1.CUST_NAME := lsCustName;
			PKG_MAKE_SLIP.Insert_Body(lrBody1);
			lnSlipId := lrBody1.SLIP_ID;
			lnSlipIdSeq := lrBody1.SLIP_IDSEQ;
			--미수금 진행율 라인
			lnMakeSlipLine := lnMakeSlipLine + 1;
			lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
			lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsNpRAccCode,lsClassCode,Null);
			lrBody1.DB_AMT := Nvl(lrA.NM_SALE_AMT,0) - Nvl(lrA.NM_SALE_P_AMT,0);
			lrBody1.TAX_COMP_CODE := Ar_Comp_Code;
			lrBody1.COMP_CODE := Ar_Comp_Code;
			lrBody1.DEPT_CODE := lrA.DEPT_CODE;
			lrBody1.SUMMARY1 := '결산 진행율 미수금 전표';
			lrBody1.CUST_SEQ := lnCustSeq;
			lrBody1.CUST_NAME := lsCustName;
			PKG_MAKE_SLIP.Insert_Body(lrBody1);
		ElsIf Nvl(lrA.NM_SALE_AMT,0) - Nvl(lrA.NM_SALE_P_AMT,0) < 0 Then
			--매출액 라인
			lnMakeSlipLine := lnMakeSlipLine + 1;
			lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
			lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsSaleAccCode,lsClassCode,Null);
			lrBody1.CR_AMT := Nvl(lrA.NM_SALE_AMT,0) - Nvl(lrA.NM_SALE_P_AMT,0);
			lrBody1.TAX_COMP_CODE := Ar_Comp_Code;
			lrBody1.COMP_CODE := Ar_Comp_Code;
			lrBody1.DEPT_CODE := lrA.DEPT_CODE;
			lrBody1.SUMMARY1 := '결산 진행율 매출 전표';
			lrBody1.CUST_SEQ := lnCustSeq;
			lrBody1.CUST_NAME := lsCustName;
			PKG_MAKE_SLIP.Insert_Body(lrBody1);
			lnSlipId := lrBody1.SLIP_ID;
			lnSlipIdSeq := lrBody1.SLIP_IDSEQ;
			--선수금 진행율 라인
			lnMakeSlipLine := lnMakeSlipLine + 1;
			lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
			lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsPpRAccCode,lsClassCode,Null);
			lrBody1.CR_AMT := Nvl(lrA.NM_SALE_P_AMT,0) - Nvl(lrA.NM_SALE_AMT,0);
			lrBody1.TAX_COMP_CODE := Ar_Comp_Code;
			lrBody1.COMP_CODE := Ar_Comp_Code;
			lrBody1.DEPT_CODE := lrA.DEPT_CODE;
			lrBody1.SUMMARY1 := '결산 진행율 미수금 전표';
			lrBody1.CUST_SEQ := lnCustSeq;
			lrBody1.CUST_NAME := lsCustName;
			PKG_MAKE_SLIP.Insert_Body(lrBody1);
		Else
			Null;
		End If;
		--만약 공사 선수금 진행율 잔액이 있으면 없애준다.
		If Nvl(lrA.PP_R_REMAIN_AMT,0) <> 0 Then
			lnMakeSlipLine := lnMakeSlipLine + 1;
			lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
			lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsPpRAccCode,lsClassCode,Null);
			lrBody2.DB_AMT := Nvl(lrA.PP_R_REMAIN_AMT,0);
			lrBody2.TAX_COMP_CODE := Ar_Comp_Code;
			lrBody2.COMP_CODE := Ar_Comp_Code;
			lrBody2.DEPT_CODE := lrA.DEPT_CODE;
			lrBody2.SUMMARY1 := '선수금 진행율 반제';
			lrBody2.CUST_SEQ := lnCustSeq;
			lrBody2.CUST_NAME := lsCustName;
		
			PKG_MAKE_SLIP.Insert_Body(lrBody2);

			lnMakeSlipLine := lnMakeSlipLine + 1;
			lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
			lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsNpRAccCode,lsClassCode,Null);
			lrBody2.CR_AMT := Nvl(lrA.PP_R_REMAIN_AMT,0);
			lrBody2.TAX_COMP_CODE := Ar_Comp_Code;
			lrBody2.COMP_CODE := Ar_Comp_Code;
			lrBody2.DEPT_CODE := lrA.DEPT_CODE;
			lrBody2.SUMMARY1 := '선수금 진행율 반제';
			lrBody2.CUST_SEQ := lnCustSeq;
			lrBody2.CUST_NAME := lsCustName;
		
			PKG_MAKE_SLIP.Insert_Body(lrBody2);
		End If;
		--만약 공사 미수금 진행율 잔액이 있으면 없애준다.
		If Nvl(lrA.NP_R_REMAIN_AMT,0) <> 0 Then
			lnMakeSlipLine := lnMakeSlipLine + 1;
			lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
			lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsNpRAccCode,lsClassCode,Null);
			lrBody2.CR_AMT := Nvl(lrA.NP_R_REMAIN_AMT,0);
			lrBody2.TAX_COMP_CODE := Ar_Comp_Code;
			lrBody2.COMP_CODE := Ar_Comp_Code;
			lrBody2.DEPT_CODE := lrA.DEPT_CODE;
			lrBody2.SUMMARY1 := '미수금 진행율 반제';
			lrBody2.CUST_SEQ := lnCustSeq;
			lrBody2.CUST_NAME := lsCustName;
		
			PKG_MAKE_SLIP.Insert_Body(lrBody2);

			lnMakeSlipLine := lnMakeSlipLine + 1;
			lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
			lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsPpRAccCode,lsClassCode,Null);
			lrBody2.DB_AMT := Nvl(lrA.NP_R_REMAIN_AMT,0);
			lrBody2.TAX_COMP_CODE := Ar_Comp_Code;
			lrBody2.COMP_CODE := Ar_Comp_Code;
			lrBody2.DEPT_CODE := lrA.DEPT_CODE;
			lrBody2.SUMMARY1 := '미수금 진행율 반제';
			lrBody2.CUST_SEQ := lnCustSeq;
			lrBody2.CUST_NAME := lsCustName;
		
			PKG_MAKE_SLIP.Insert_Body(lrBody2);

		End If;
	End Loop;
	If lnSlipId Is Not Null Then
		Update	T_SET_SALE_SLIP
		Set		SLIP_ID = lnSlipId,
				SLIP_IDSEQ = lnSlipIdSeq
		Where	COMP_CODE = Ar_Comp_Code
		And		WORK_NO = Ar_Work_No;
	End If;
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
