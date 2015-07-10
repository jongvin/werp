Create Or Replace Procedure SP_T_SET_MAKE_IND_INS_SLIP
(
	AR_COMP_CODE					VARCHAR2,
	AR_DEPT_CODE					Varchar2,
	AR_INSUR_WORK_NO				NUMBER,
	AR_CRTUSERNO					VARCHAR2
)
Is
	lrRec							T_SET_IND_INSUR_WORK%RowType;
	lrInfo							T_SET_IND_INSUR_INFO%RowType;
	ls_Work_Code					T_WORK_CODE.WORK_CODE%Type := 'SETINDINS';
	lsAccCode						T_ACC_CODE.ACC_CODE%Type;
	lsAccCodeNPay					T_ACC_CODE.ACC_CODE%Type;
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
Begin
	
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_IND_INSUR_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_INSUR_WORK_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'대상이 되는 집계작업을 찾을 수 없습니다.');
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'대상이 되는 집계작업은 이미 전표가 발행되었습니다.전표를 삭제하신후 재 집계를 하셔야 합니다.');
	End If;
	Begin
		Select
			*
		Into
			lrInfo
		From	T_SET_IND_INSUR_INFO
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_YM = To_Char(lrRec.WORK_DT,'YYYY') ;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'해당 년도의 산재보험료율이 등록되어 있지 않습니다.');
	End;
	Begin
		Select
			a.CODE_LIST_ID
		Into
			lsAccCodeNPay
		From	V_T_CODE_LIST a
		Where	a.CODE_GROUP_ID = 'NPAY_IND_INSU'
		And		RowNum < 2;	
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'공통코드에 NPAY_IND_INSU에 의한 계정이 설정되어 있지 않습니다.');
	End;
	lnCustSeq := lrInfo.CUST_SEQ;
	If lnCustSeq Is Null Then
		Raise_Application_Error(-20009,'거래처가 설정되어 있지 않습니다.');
	End If;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);

	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(ls_Work_Code,AR_COMP_CODE);
	lrHead := PKG_MAKE_SLIP.New_Head(AR_COMP_CODE,AR_DEPT_CODE,lrRec.WORK_DT,'1','B',AR_CRTUSERNO,ls_Work_Code,lsChargePers,AR_CRTUSERNO);
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnSum := 0;
	For lrA In ( 
					Select
						b.DEPT_CODE,
						Sum(
						Case When c.S_AMT_TAG = 'T' Then
							b.DB_AMT
						Else
							0
						End) S_AMT,
						Sum(Case When c.S_AMT_TAG = 'T' Then
							0
						Else
							b.DB_AMT
						End) L_AMT
					From	T_SET_IND_INSUR_TARGET_SLIP a,
							T_ACC_SLIP_BODY1 b,
							T_SET_IND_INSUR_ACC_CODE c
					Where	a.COMP_CODE = AR_COMP_CODE
					And		a.INSUR_WORK_NO = AR_INSUR_WORK_NO
					And		a.SLIP_ID = b.SLIP_ID
					And		a.SLIP_IDSEQ = b.SLIP_IDSEQ
					And		b.ACC_CODE = c.ACC_CODE (+)
					Group By
						b.DEPT_CODE
				)
	Loop
		--원가 전표
		Begin
			Select
				b.ACC_CODE
			Into
				lsAccCode
			From	T_DEPT_CODE_ORG a,
					T_WORK_ACC_CODE b
			Where	a.COST_DEPT_KND_TAG = b.COST_DEPT_KND_TAG
			And		b.WORK_CODE = ls_Work_Code
			And		a.DEPT_CODE = lrA.DEPT_CODE
			And		RowNum < 2;
		Exception When No_Data_Found Then
			RAISE_APPLICATION_ERROR(-20009,'해당 자동전표의 계정정보를 가져올 수 없습니다.자동전표 코드 '||ls_Work_Code);
		End;
		lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(lrA.DEPT_CODE);
		lnAmt := Trunc((Nvl(lrA.S_AMT,0) * lrInfo.S_L_AMT_RATIO / 100 + lrA.L_AMT) * lrInfo.INSUR_RATIO / 100);

		lnMakeSlipLine := lnMakeSlipLine + 1;
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsAccCode,lsClassCode,Null);
		lrBody1.DB_AMT := lnAmt;
		lrBody1.TAX_COMP_CODE := PKG_MAKE_SLIP.Get_Comp_Code(lrA.DEPT_CODE);
		lrBody1.COMP_CODE := lrBody1.TAX_COMP_CODE;
		lrBody1.DEPT_CODE := lrA.DEPT_CODE;
		If To_Char(lrRec.TARGET_DT_F,'YYYYMM') = To_Char(lrRec.TARGET_DT_T,'YYYYMM') Then
			lrBody1.SUMMARY1 := SubStrb(To_Char(lrRec.TARGET_DT_F,'YYYY.MM') || lrInfo.PROJ_SUMMARY,1,60);
		Else
			lrBody1.SUMMARY1 := SubStrb(To_Char(lrRec.TARGET_DT_F,'YYYY.MM')||'-'||To_Char(lrRec.TARGET_DT_T,'YYYY.MM') || lrInfo.PROJ_SUMMARY,1,60);
		End If;
		lrBody1.CUST_SEQ := lnCustSeq;
		lrBody1.CUST_NAME := lsCustName;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
		If lnMakeSlipLine = 1 Then
			Update T_SET_IND_INSUR_WORK
			Set		SLIP_ID = lrBody1.SLIP_ID,
					SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
			Where	COMP_CODE = AR_COMP_CODE
			And		INSUR_WORK_NO = AR_INSUR_WORK_NO;
		End If;
		lnSum := Nvl(lnAmt,0) + Nvl(lnSum,0);
	End Loop;
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(AR_DEPT_CODE);
	--미지급비용 라인
	lnMakeSlipLine := lnMakeSlipLine + 1;

	lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsAccCodeNPay,lsClassCode,Null);

	lrBody2.CR_AMT := lnSum;
	lrBody2.TAX_COMP_CODE := AR_COMP_CODE;
	lrBody2.COMP_CODE := AR_COMP_CODE;
	lrBody2.DEPT_CODE := AR_DEPT_CODE;
	If To_Char(lrRec.TARGET_DT_F,'YYYYMM') = To_Char(lrRec.TARGET_DT_T,'YYYYMM') Then
		lrBody2.SUMMARY1 := SubStrb(To_Char(lrRec.TARGET_DT_F,'YYYY.MM') || lrInfo.PROJ_SUMMARY,1,60);
	Else
		lrBody2.SUMMARY1 := SubStrb(To_Char(lrRec.TARGET_DT_F,'YYYY.MM')||'-'||To_Char(lrRec.TARGET_DT_T,'YYYY.MM') || lrInfo.PROJ_SUMMARY,1,60);
	End If;
	lrBody2.CUST_SEQ := lnCustSeq;
	lrBody2.CUST_NAME := lsCustName;
	lrBody2.RESET_SLIP_ID := lrBody2.SLIP_ID;
	lrBody2.RESET_SLIP_IDSEQ := lrBody2.SLIP_IDSEQ;
	PKG_MAKE_SLIP.Insert_Body(lrBody2);
	--본사전표 발행
	Begin
		Select
			b.ACC_CODE
		Into
			lsAccCode
		From	T_DEPT_CODE_ORG a,
				T_WORK_ACC_CODE b
		Where	a.COST_DEPT_KND_TAG = b.COST_DEPT_KND_TAG
		And		b.WORK_CODE = ls_Work_Code
		And		a.DEPT_CODE = AR_DEPT_CODE
		And		RowNum < 2;
	Exception When No_Data_Found Then
		RAISE_APPLICATION_ERROR(-20009,'해당 자동전표의 계정정보를 가져올 수 없습니다.자동전표 코드 '||ls_Work_Code);
	End;
	lnAmt := Trunc(Nvl(lrInfo.HO_IND_DISASTER_AMT,0) / 12);

	lnMakeSlipLine := lnMakeSlipLine + 1;
	lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsAccCode,lsClassCode,Null);
	lrBody1.DB_AMT := lnAmt;
	lrBody1.TAX_COMP_CODE := AR_COMP_CODE;
	lrBody1.COMP_CODE := lrBody1.TAX_COMP_CODE;
	lrBody1.DEPT_CODE := AR_DEPT_CODE;
	If To_Char(lrRec.TARGET_DT_F,'YYYYMM') = To_Char(lrRec.TARGET_DT_T,'YYYYMM') Then
		lrBody1.SUMMARY1 := SubStrb(To_Char(lrRec.TARGET_DT_F,'YYYY.MM') || '산재보험료',1,60);
	Else
		lrBody1.SUMMARY1 := SubStrb(To_Char(lrRec.TARGET_DT_F,'YYYY.MM')||'-'||To_Char(lrRec.TARGET_DT_T,'YYYY.MM') || '산재보험료',1,60);
	End If;
	lrBody1.CUST_SEQ := lnCustSeq;
	lrBody1.CUST_NAME := lsCustName;
	PKG_MAKE_SLIP.Insert_Body(lrBody1);

	--미지급비용 라인
	lnMakeSlipLine := lnMakeSlipLine + 1;

	lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsAccCodeNPay,lsClassCode,Null);

	lrBody2.CR_AMT := lnAmt;
	lrBody2.TAX_COMP_CODE := lrBody1.COMP_CODE;
	lrBody2.COMP_CODE := lrBody1.COMP_CODE;
	lrBody2.DEPT_CODE := lrBody1.DEPT_CODE;
	lrBody2.SUMMARY1 := lrBody1.SUMMARY1;
	lrBody2.CUST_SEQ := lrBody1.CUST_SEQ;
	lrBody2.CUST_NAME := lrBody1.CUST_NAME;
	lrBody2.RESET_SLIP_ID := lrBody2.SLIP_ID;
	lrBody2.RESET_SLIP_IDSEQ := lrBody2.SLIP_IDSEQ;
	PKG_MAKE_SLIP.Insert_Body(lrBody2);
	
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
