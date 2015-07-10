Create Or Replace Procedure SP_T_SET_MAKE_CONS_DEC_SLIP
(
	AR_COMP_CODE					VARCHAR2,
	AR_DEPT_CODE					Varchar2,
	AR_WORK_NO						NUMBER,
	AR_CRTUSERNO					VARCHAR2
)
Is
	lrRec							T_SET_CONS_INSUR_DEC_WORK%RowType;
	ls_Work_Code					T_WORK_CODE.WORK_CODE%Type := 'SETCONSRES';
	lsAccCode						T_ACC_CODE.ACC_CODE%Type;

	lrBody1							T_ACC_SLIP_BODY%RowType;
	lrBody2							T_ACC_SLIP_BODY%RowType;
	lrBodyOld						T_ACC_SLIP_BODY%RowType;		--선급비용 설정전표

	lrHead							T_ACC_SLIP_HEAD%RowType;
	lsChargePers					T_Acc_Slip_Head.CHARGE_PERS%Type;
	lnMakeSlipLine					Number;
Begin
	
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_CONS_INSUR_DEC_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_NO = AR_WORK_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'대상이 되는 집계작업을 찾을 수 없습니다.');
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'대상이 되는 집계작업은 이미 전표가 발행되었습니다.전표를 삭제하신후 재 집계를 하셔야 합니다.');
	End If;

	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(ls_Work_Code,AR_COMP_CODE);
	lrHead := PKG_MAKE_SLIP.New_Head(AR_COMP_CODE,AR_DEPT_CODE,lrRec.WORK_DT,'1','B',AR_CRTUSERNO,ls_Work_Code,lsChargePers,AR_CRTUSERNO);
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	For lrA In ( 
					Select
						a.DEPT_CODE ,
						a.INSUR_NO ,
						a.DEC_NO ,
						a.CRTUSERNO ,
						a.CRTDATE ,
						a.MODUSERNO ,
						a.MODDATE ,
						a.DEC_AMT ,
						a.COMP_CODE ,
						a.WORK_NO,
						b.SLIP_ID ,
						b.SLIP_IDSEQ
					From	T_SET_CONS_INSUR_DEC_AMT a,
							T_SET_CONS_INSUR b
					Where	a.COMP_CODE = Ar_Comp_Code
					And		a.WORK_NO = Ar_Work_No
					And		a.DEPT_CODE = b.DEPT_CODE
					And		a.INSUR_NO = b.INSUR_NO
					Order By
						a.DEPT_CODE
				)
	Loop
		--선급비용 설정 가져오기
		Select
			*
		Into
			lrBodyOld
		From	T_ACC_SLIP_BODY
		Where	SLIP_ID = lrA.SLIP_ID
		And		SLIP_IDSEQ = lrA.SLIP_IDSEQ;
		--선급비용 반제하기
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrBodyOld.ACC_CODE,lrBodyOld.CLASS_CODE,Null);
		lrBody1.RESET_SLIP_ID := lrBodyOld.SLIP_ID;
		lrBody1.RESET_SLIP_IDSEQ := lrBodyOld.SLIP_IDSEQ;
		lrBody1.CR_AMT := lrA.DEC_AMT;
		lrBody1.TAX_COMP_CODE := lrBodyOld.TAX_COMP_CODE;
		lrBody1.COMP_CODE := lrBodyOld.COMP_CODE;
		lrBody1.DEPT_CODE := lrBodyOld.DEPT_CODE;
		lrBody1.SUMMARY_CODE := lrBodyOld.SUMMARY_CODE;
		lrBody1.TAX_COMP_CODE := lrBodyOld.TAX_COMP_CODE;
		lrBody1.CLASS_CODE := lrBodyOld.CLASS_CODE;
		lrBody1.VAT_CODE := lrBodyOld.VAT_CODE;
		lrBody1.VAT_DT := lrBodyOld.VAT_DT;
		lrBody1.SUPAMT := lrBodyOld.SUPAMT;
		lrBody1.VATAMT := lrBodyOld.VATAMT;
		lrBody1.CUST_SEQ := lrBodyOld.CUST_SEQ;
		lrBody1.CUST_NAME := lrBodyOld.CUST_NAME;
		lrBody1.BANK_CODE := lrBodyOld.BANK_CODE;
		lrBody1.ACCNO := lrBodyOld.ACCNO;
		lrBody1.SUMMARY1 := lrBodyOld.SUMMARY1;
		lrBody1.SUMMARY2 := lrBodyOld.SUMMARY2;
		lrBody1.CHK_NO := lrBodyOld.CHK_NO;
		lrBody1.BILL_NO := lrBodyOld.BILL_NO;
		lrBody1.REC_BILL_NO := lrBodyOld.REC_BILL_NO;
		lrBody1.CP_NO := lrBodyOld.CP_NO;
		lrBody1.SECU_NO := lrBodyOld.SECU_NO;
		lrBody1.LOAN_NO := lrBodyOld.LOAN_NO;
		lrBody1.LOAN_REFUND_NO := lrBodyOld.LOAN_REFUND_NO;
		lrBody1.LOAN_REFUND_SEQ := lrBodyOld.LOAN_REFUND_SEQ;
		lrBody1.DEPOSIT_ACCNO := lrBodyOld.DEPOSIT_ACCNO;
		lrBody1.PAYMENT_SEQ := lrBodyOld.PAYMENT_SEQ;
		lrBody1.PAY_CON_CASH := lrBodyOld.PAY_CON_CASH;
		lrBody1.PAY_CON_BILL := lrBodyOld.PAY_CON_BILL;
		lrBody1.PAY_CON_BILL_DT := lrBodyOld.PAY_CON_BILL_DT;
		lrBody1.PAY_CON_BILL_DAYS := lrBodyOld.PAY_CON_BILL_DAYS;
		lrBody1.EMP_NO := lrBodyOld.EMP_NO;
		lrBody1.ANTICIPATION_DT := lrBodyOld.ANTICIPATION_DT;
		lrBody1.MNG_ITEM_CHAR1 := lrBodyOld.MNG_ITEM_CHAR1;
		lrBody1.MNG_ITEM_CHAR2 := lrBodyOld.MNG_ITEM_CHAR2;
		lrBody1.MNG_ITEM_CHAR3 := lrBodyOld.MNG_ITEM_CHAR3;
		lrBody1.MNG_ITEM_CHAR4 := lrBodyOld.MNG_ITEM_CHAR4;
		lrBody1.MNG_ITEM_NUM1 := lrBodyOld.MNG_ITEM_NUM1;
		lrBody1.MNG_ITEM_NUM2 := lrBodyOld.MNG_ITEM_NUM2;
		lrBody1.MNG_ITEM_NUM3 := lrBodyOld.MNG_ITEM_NUM3;
		lrBody1.MNG_ITEM_NUM4 := lrBodyOld.MNG_ITEM_NUM4;
		lrBody1.MNG_ITEM_DT1 := lrBodyOld.MNG_ITEM_DT1;
		lrBody1.MNG_ITEM_DT2 := lrBodyOld.MNG_ITEM_DT2;
		lrBody1.MNG_ITEM_DT3 := lrBodyOld.MNG_ITEM_DT3;
		lrBody1.MNG_ITEM_DT4 := lrBodyOld.MNG_ITEM_DT4;
		lrBody1.FIX_ASSET_SEQ := lrBodyOld.FIX_ASSET_SEQ;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
		If lnMakeSlipLine = 1 Then
			Update T_SET_CONS_INSUR_DEC_WORK
			Set		SLIP_ID = lrBody1.SLIP_ID,
					SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
			Where	COMP_CODE = AR_COMP_CODE
			And		WORK_NO = AR_WORK_NO;
		End If;

		--원가 라인
		lnMakeSlipLine := lnMakeSlipLine + 1;
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

		lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lsAccCode,lrBodyOld.CLASS_CODE,Null);

		lrBody2.DB_AMT := lrA.DEC_AMT;
		lrBody2.TAX_COMP_CODE := AR_COMP_CODE;
		lrBody2.COMP_CODE := AR_COMP_CODE;
		lrBody2.DEPT_CODE := AR_DEPT_CODE;
		lrBody2.SUMMARY1 := '공사보험료 공제';
		lrBody2.CUST_SEQ := lrBodyOld.CUST_SEQ;
		lrBody2.CUST_NAME := lrBodyOld.CUST_NAME;
		PKG_MAKE_SLIP.Insert_Body(lrBody2);
		Update T_SET_CONS_INSUR_DEC_AMT
		Set		SLIP_ID = lrBody1.SLIP_ID,
				SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
		Where	DEPT_CODE = lrA.DEPT_CODE
		And		INSUR_NO = lrA.INSUR_NO
		And		DEC_NO = lrA.DEC_NO;
	End Loop;
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
