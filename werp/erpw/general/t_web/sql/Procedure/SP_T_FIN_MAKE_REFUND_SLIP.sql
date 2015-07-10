Create Or Replace Procedure SP_T_FIN_MAKE_REFUND_SLIP
(
	Ar_Work_Slip_Id					Number,
	Ar_Work_Slip_IdSeq				Number,
	Ar_Work_Code					Varchar2,
	Ar_Make_Comp_Code				Varchar2,
	Ar_Dept_Code					Varchar2,
	Ar_Loan_No						Varchar2,
	Ar_Loan_Refund_Seq				Number,
	Ar_CrtUserNo					Varchar2
)
Is
	lrRec							T_FIN_LOAN_REFUND_LIST%RowType;
	lrLoan							T_FIN_LOAN_SHEET%RowType;
	lrLoanKind						T_FIN_LOAN_KIND%RowType;
	lrOther							T_WORK_ACC_SLIP_BODY%RowType;
	lnAmt							Number;
	lrBody1							T_ACC_SLIP_BODY%RowType;
	lrBody2							T_ACC_SLIP_BODY%RowType;
	lrBodyPE						T_ACC_SLIP_BODY%RowType;		--선급이자
	lrBodyAE						T_ACC_SLIP_BODY%RowType;		--미지급이자
	lrBodyIT						T_ACC_SLIP_BODY%RowType;		--당월분 이자
	lsClassCode						T_CLASS_CODE.CLASS_CODE%Type;
	lsBankName						T_BANK_MAIN.BANK_MAIN_NAME%Type;

	lrHead							T_ACC_SLIP_HEAD%RowType;
	lsChargePers					T_Acc_Slip_Head.CHARGE_PERS%Type;
	lnMakeSlipLine					Number;
	lsCustName						T_ACC_SLIP_BODY.CUST_NAME%Type;
	lnCustSeq						T_CUST_CODE.CUST_SEQ%Type;
	lnRefundAmt						Number;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_LOAN_REFUND_LIST
		Where	LOAN_NO = Ar_Loan_No
		And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'차입 정보를 찾을 수 없습니다.');
	End;
	If lrRec.ITR_TAG Is Null Then
		Raise_Application_Error(-20009,'차입전표를 발행하려면 이자구분을 선택하셔야 합니다.');
	End If;
	If lrRec.REFUND_SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'이미 상환전표가 발행되어 있습니다.전표를 삭제하셔야 재 발행 하실 수 있습니다.');
	End If;
	Begin
		Select
			*
		Into
			lrLoan
		From	T_FIN_LOAN_SHEET
		Where	LOAN_NO = Ar_Loan_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'차입 정보를 찾을 수 없습니다.');
	End;
	If lrLoan.LOAN_KIND_CODE Is Null Then
		Raise_Application_Error(-20009,'차입종류를 입력하셔야 합니다.');
	End If;
	Begin
		Select
			*
		Into
			lrLoanKind
		From	T_FIN_LOAN_KIND
		Where	LOAN_KIND_CODE = lrLoan.LOAN_KIND_CODE;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'차입 종류코드를 찾을 수 없습니다.');
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
	Begin
		Select
			BANK_MAIN_NAME
		Into
			lsBankName
		From	t_bank_main a,
				t_bank_code b
		Where	b.BANK_MAIN_CODE = a.BANK_MAIN_CODE
		And		b.BANK_CODE = lrLoan.BANK_CODE;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'차입금의 은행정보를 찾을 수 없습니다.');
	End;

	lsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS(Ar_Work_Code,Ar_Make_Comp_Code);
	--지불계정이 현금이면 현금전표 아니면 대채전표
	If PKG_MAKE_SLIP.IsCashAccCode(lrOther.ACC_CODE) Then
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.TRANS_DT,'2','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	Else
		lrHead := PKG_MAKE_SLIP.New_Head(Ar_Make_Comp_Code,Ar_Dept_Code,lrRec.TRANS_DT,'1','B',Ar_CrtUserNo,Ar_Work_Code,lsChargePers,Ar_CrtUserNo);
	End If;
	PKG_MAKE_SLIP.Insert_Head(lrHead);
	lnMakeSlipLine := 0;
	lnCustSeq := lrOther.CUST_SEQ;
	lsCustName := PKG_MAKE_SLIP.Get_Cust_Name(lnCustSeq);
	lsClassCode := PKG_MAKE_SLIP.Get_Class_Code(Ar_Dept_Code);

	--먼저 원금을 상환한다.
	--원금전표를 가져온다.
	lnRefundAmt := Nvl(lrRec.REFUND_AMT,0);
	If lnRefundAmt <= 0 Then
		Raise_Application_Error(-20009,'상환금액이 0보다 작거나 같을 수는 없습니다.');
	End If;
	For lrA In (
		Select
			a.SLIP_ID ,
			a.SLIP_IDSEQ ,
			a.MAKE_SLIPLINE ,
			a.ACC_CODE ,
			a.DB_AMT ,
			a.CR_AMT ,
			a.SUMMARY_CODE ,
			a.TAX_COMP_CODE ,
			a.COMP_CODE ,
			a.DEPT_CODE ,
			a.CLASS_CODE ,
			a.VAT_CODE ,
			a.VAT_DT ,
			a.SUPAMT ,
			a.VATAMT ,
			a.CUST_SEQ ,
			a.CUST_NAME ,
			a.BANK_CODE ,
			a.ACCNO ,
			a.RESET_SLIP_ID ,
			a.RESET_SLIP_IDSEQ ,
			a.MAKE_COMP_CODE ,
			a.MAKE_DEPT_CODE ,
			a.MAKE_DT ,
			a.KEEP_DT ,
			a.ORG_SLIP_ID ,
			a.ORG_SLIP_IDSEQ ,
			a.SLIP_KIND_TAG ,
			a.TRANSFER_TAG ,
			a.IGNORE_SET_RESET_TAG ,
			a.CRTUSERNO ,
			a.CRTDATE ,
			a.MODUSERNO ,
			a.MODDATE ,
			a.SUMMARY1 ,
			a.SUMMARY2 ,
			a.CHK_NO ,
			a.BILL_NO ,
			a.REC_BILL_NO ,
			a.CP_NO ,
			a.SECU_NO ,
			a.LOAN_NO ,
			a.LOAN_REFUND_NO ,
			a.LOAN_REFUND_SEQ ,
			a.DEPOSIT_ACCNO ,
			a.PAYMENT_SEQ ,
			a.PAY_CON_CASH ,
			a.PAY_CON_BILL ,
			a.PAY_CON_BILL_DT ,
			a.PAY_CON_BILL_DAYS ,
			a.EMP_NO ,
			a.ANTICIPATION_DT ,
			a.MNG_ITEM_CHAR1 ,
			a.MNG_ITEM_CHAR2 ,
			a.MNG_ITEM_CHAR3 ,
			a.MNG_ITEM_CHAR4 ,
			a.MNG_ITEM_NUM1 ,
			a.MNG_ITEM_NUM2 ,
			a.MNG_ITEM_NUM3 ,
			a.MNG_ITEM_NUM4 ,
			a.MNG_ITEM_DT1 ,
			a.MNG_ITEM_DT2 ,
			a.MNG_ITEM_DT3 ,
			a.MNG_ITEM_DT4 ,
			a.FIX_ASSET_SEQ,
			Nvl(a.CR_AMT,0) - 
			Nvl((
				Select
					Nvl(Sum(cc.DB_AMT),0) + Nvl(Sum(- cc.CR_AMT),0)
				From	T_ACC_SLIP_BODY1 cc
				Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
				And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
				And		cc.KEEP_DT Is Not Null
				And
				(
						cc.SLIP_ID <> cc.RESET_SLIP_ID
					Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
				)
			),0) REMAIN_AMT
		From	T_ACC_SLIP_BODY a
		Where	a.ACC_CODE = lrLoanKind.LOAN_ACC_CODE
		And		a.KEEP_DT Is Not Null
		And		a.LOAN_REFUND_NO = lrRec.LOAN_NO
		And		a.SLIP_ID = a.RESET_SLIP_ID
		And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
		And		Nvl(a.CR_AMT,0) - 
							Nvl((
								Select
									Nvl(Sum(cc.DB_AMT),0) + Nvl(Sum(- cc.CR_AMT),0)
								From	T_ACC_SLIP_BODY1 cc
								Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
								And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
								And		cc.KEEP_DT Is Not Null
								And
								(
										cc.SLIP_ID <> cc.RESET_SLIP_ID
									Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
								)
							),0) > 0)
	Loop
		If lnRefundAmt >= Nvl(lrA.REMAIN_AMT,0) then	--만약 이번잔액 이 더 작다면
			lnAmt := Nvl(lrA.REMAIN_AMT,0);
			lnRefundAmt := lnRefundAmt - lnAmt;
		Else
			lnAmt := lnRefundAmt;
			lnRefundAmt := 0;
		End If;
		--차입금 상환 라인
		lnMakeSlipLine := lnMakeSlipLine + 1;
		lrBody1 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.LOAN_ACC_CODE,lsClassCode,Null);
		lrBody1.DB_AMT := lnAmt;
		lrBody1.TAX_COMP_CODE := Ar_Make_Comp_Code;
		lrBody1.COMP_CODE := Ar_Make_Comp_Code;
		lrBody1.DEPT_CODE := Ar_Dept_Code;
		lrBody1.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
		lrBody1.CUST_SEQ := lnCustSeq;
		lrBody1.CUST_NAME := lsCustName;
		lrBody1.RESET_SLIP_ID := lrA.SLIP_ID;				--설정인 경우는 자기 전표 번호입니다.
		lrBody1.RESET_SLIP_IDSEQ := lrA.SLIP_IDSEQ;			--설정인 경우는 자기 전표 번호입니다.
		lrBody1.LOAN_REFUND_NO := Ar_Loan_No;
		lrBody1.LOAN_NO := Ar_Loan_No;
		lrBody1.BANK_CODE := lrLoan.BANK_CODE;
		lrBody1.ACCNO := lrOther.ACCNO;
		PKG_MAKE_SLIP.Insert_Body(lrBody1);
	End Loop;
	If lnRefundAmt > 0 Then
		Raise_Application_Error(-20009,'상환금액이 원금 잔액을 초과합니다.'||to_char(lnRefundAmt));
	End If;
	--전표 발행 번호를 엎어친다.

	Update	T_FIN_LOAN_REFUND_LIST
	Set		REFUND_SLIP_ID = lrBody1.SLIP_ID,
			REFUND_SLIP_IDSEQ = lrBody1.SLIP_IDSEQ
	Where	LOAN_NO = Ar_Loan_No
	And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;

	If lrRec.ITR_TAG = '5' Then		--선취이자 원금 상환
		--만약 상환시 이자가 있다면 이는 이자의 조정이다...즉 조기 상환시 이자 차감을 말한다.
		--이자 차감 금액은 선급비용에서 음수 반제되어야 한다
		--모든 선급비용 금액은 완전 반제 되어야 한다.
		--영업외 비용 지급이자의 금액은 이자 총액과 같아야 한다.

		Declare
			lnPrevPESETSum				Number;
			lnPrevPERESETSum			Number;
			lnPrevEXDBSum				Number;
			lnTotItrAmt					Number;
			lnPERemain					Number;
			lnPEResetTarget				Number;
			lnCrAmt						Number;
			lnDbAmt						Number;
		Begin
			--기존 선급비용 차변 합계구하기
			Begin
				Select
					Nvl(Sum(DB_AMT),0),
					Nvl(Sum(CR_AMT),0)
				Into
					lnPrevPESETSum,
					lnPrevPERESETSum
				From	T_ACC_SLIP_BODY
				Where	LOAN_REFUND_NO = lrRec.LOAN_NO
				And		KEEP_DT Is Not Null
				And		ACC_CODE = lrLoanKind.PE_ITR_ACC_CODE;
			Exception When No_Data_Found Then	--실제 집계함수에서는 이 에러가 발생되지는 않습니다.
				lnPrevPESETSum := 0;
				lnPrevPERESETSum := 0;
			End;
			--기존 영업외비용 지급이자 구하기
			Begin
				Select
					Nvl(Sum(DB_AMT),0)
				Into
					lnPrevEXDBSum
				From	T_ACC_SLIP_BODY
				Where	LOAN_REFUND_NO = lrRec.LOAN_NO
				And		KEEP_DT Is Not Null
				And		ACC_CODE = lrLoanKind.ITR_ACC_CODE;
			Exception When No_Data_Found Then	--실제 집계함수에서는 이 에러가 발생되지는 않습니다.
				lnPrevEXDBSum := 0;
			End;
			--해당 차입의 이자 총액을 구한다.
			Begin
				Select
					Nvl(Sum(a.INTR_AMT),0)
				Into
					lnTotItrAmt
				From	T_FIN_LOAN_REFUND_LIST a
				Where	LOAN_NO = lrRec.LOAN_NO
				And		REFUND_INTR_DT <= lrRec.REFUND_INTR_DT;
			Exception When No_Data_Found Then	--실제 집계함수에서는 이 에러가 발생되지는 않습니다.
				lnTotItrAmt := 0;
			End;
			--만약 이자가 있다면...
			--이는 이자 차감이며 선급비용 차감 항목이며 영업외 비용에서 빠져야 한다...
			If Nvl(lrRec.INTR_AMT,0) < 0 then
				lnPERemain := - Nvl(lrRec.INTR_AMT,0);
			Else
				lnPERemain := 0;
			End If;
			lnPEResetTarget := lnPrevPESETSum - lnPrevPERESETSum;
			If lnPEResetTarget > 0 Then		--만약 잔액이 남아 있다면
				For lrB In (
					Select
						a.SLIP_ID ,
						a.SLIP_IDSEQ ,
						a.MAKE_SLIPLINE ,
						a.ACC_CODE ,
						a.DB_AMT ,
						a.CR_AMT ,
						a.SUMMARY_CODE ,
						a.TAX_COMP_CODE ,
						a.COMP_CODE ,
						a.DEPT_CODE ,
						a.CLASS_CODE ,
						a.VAT_CODE ,
						a.VAT_DT ,
						a.SUPAMT ,
						a.VATAMT ,
						a.CUST_SEQ ,
						a.CUST_NAME ,
						a.BANK_CODE ,
						a.ACCNO ,
						a.RESET_SLIP_ID ,
						a.RESET_SLIP_IDSEQ ,
						a.MAKE_COMP_CODE ,
						a.MAKE_DEPT_CODE ,
						a.MAKE_DT ,
						a.KEEP_DT ,
						a.ORG_SLIP_ID ,
						a.ORG_SLIP_IDSEQ ,
						a.SLIP_KIND_TAG ,
						a.TRANSFER_TAG ,
						a.IGNORE_SET_RESET_TAG ,
						a.CRTUSERNO ,
						a.CRTDATE ,
						a.MODUSERNO ,
						a.MODDATE ,
						a.SUMMARY1 ,
						a.SUMMARY2 ,
						a.CHK_NO ,
						a.BILL_NO ,
						a.REC_BILL_NO ,
						a.CP_NO ,
						a.SECU_NO ,
						a.LOAN_NO ,
						a.LOAN_REFUND_NO ,
						a.LOAN_REFUND_SEQ ,
						a.DEPOSIT_ACCNO ,
						a.PAYMENT_SEQ ,
						a.PAY_CON_CASH ,
						a.PAY_CON_BILL ,
						a.PAY_CON_BILL_DT ,
						a.PAY_CON_BILL_DAYS ,
						a.EMP_NO ,
						a.ANTICIPATION_DT ,
						a.MNG_ITEM_CHAR1 ,
						a.MNG_ITEM_CHAR2 ,
						a.MNG_ITEM_CHAR3 ,
						a.MNG_ITEM_CHAR4 ,
						a.MNG_ITEM_NUM1 ,
						a.MNG_ITEM_NUM2 ,
						a.MNG_ITEM_NUM3 ,
						a.MNG_ITEM_NUM4 ,
						a.MNG_ITEM_DT1 ,
						a.MNG_ITEM_DT2 ,
						a.MNG_ITEM_DT3 ,
						a.MNG_ITEM_DT4 ,
						a.FIX_ASSET_SEQ,
						Nvl(a.DB_AMT,0) - 
						Nvl((
							Select
								Nvl(Sum(cc.CR_AMT),0) + Nvl(Sum(- cc.DB_AMT),0)
							From	T_ACC_SLIP_BODY1 cc
							Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
							And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
							And		cc.KEEP_DT Is Not Null
							And
							(
									cc.SLIP_ID <> cc.RESET_SLIP_ID
								Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
							)
						),0) REMAIN_AMT
					From	T_ACC_SLIP_BODY a
					Where	a.ACC_CODE = lrLoanKind.PE_ITR_ACC_CODE
					And		a.KEEP_DT Is Not Null
					And		a.LOAN_REFUND_NO = lrRec.LOAN_NO
					And		a.SLIP_ID = a.RESET_SLIP_ID
					And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
					And		Nvl(a.DB_AMT,0) - 
										Nvl((
											Select
												Nvl(Sum(cc.CR_AMT),0) + Nvl(Sum(- cc.DB_AMT),0)
											From	T_ACC_SLIP_BODY1 cc
											Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
											And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
											And		cc.KEEP_DT Is Not Null
											And
											(
													cc.SLIP_ID <> cc.RESET_SLIP_ID
												Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
											)
										),0) > 0)
				Loop
					lnCrAmt := 0;
					lnDbAmt := 0;
					If lnPERemain > 0 Then		--음수 반제될 부분이 아직 남아 있다면
						If lnPERemain >= Nvl(lrB.REMAIN_AMT,0) then	--만약 이번잔액 이 더 작다면
							lnDbAmt := - Nvl(lrB.REMAIN_AMT,0);
							lnPERemain := lnPERemain + lnDbAmt;
							lnPEResetTarget := lnPEResetTarget + lnDbAmt;
						Else
							lnDbAmt := - lnPERemain;
							lnPERemain := 0;
							lnPEResetTarget := lnPEResetTarget + lnDbAmt;
						End If;
						--선급비용 반제라인
						lnMakeSlipLine := lnMakeSlipLine + 1;
						lrBodyPE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.PE_ITR_ACC_CODE,lsClassCode,Null);
						lrBodyPE.DB_AMT := lnDbAmt;
						lrBodyPE.CR_AMT := lnCrAmt;
						lrBodyPE.TAX_COMP_CODE := Ar_Make_Comp_Code;
						lrBodyPE.COMP_CODE := Ar_Make_Comp_Code;
						lrBodyPE.DEPT_CODE := Ar_Dept_Code;
						lrBodyPE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
						lrBodyPE.CUST_SEQ := lnCustSeq;
						lrBodyPE.CUST_NAME := lsCustName;
						lrBodyPE.RESET_SLIP_ID := lrB.SLIP_ID;				--설정인 경우는 자기 전표 번호입니다.
						lrBodyPE.RESET_SLIP_IDSEQ := lrB.SLIP_IDSEQ;			--설정인 경우는 자기 전표 번호입니다.
						lrBodyPE.LOAN_REFUND_NO := Ar_Loan_No;
						lrBodyPE.LOAN_NO := Ar_Loan_No;
						lrBodyPE.BANK_CODE := lrLoan.BANK_CODE;
						lrBodyPE.ACCNO := lrB.ACCNO;
						PKG_MAKE_SLIP.Insert_Body(lrBodyPE);
					End If;
					lnCrAmt := 0;
					lnDbAmt := 0;
					If lnPERemain = 0 Then
						If lnPEResetTarget >= Nvl(lrB.REMAIN_AMT,0) then	--만약 이번잔액 이 더 작다면
							lnCrAmt := Nvl(lrB.REMAIN_AMT,0);
							lnPEResetTarget := lnPEResetTarget - lnCrAmt;
						Else
							lnCrAmt := lnPEResetTarget;
							lnPEResetTarget := lnPEResetTarget - lnCrAmt;
						End If;
					End If;
					--선급비용 반제라인
					lnMakeSlipLine := lnMakeSlipLine + 1;
					lrBodyPE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.PE_ITR_ACC_CODE,lsClassCode,Null);
					lrBodyPE.DB_AMT := lnDbAmt;
					lrBodyPE.CR_AMT := lnCrAmt;
					lrBodyPE.TAX_COMP_CODE := Ar_Make_Comp_Code;
					lrBodyPE.COMP_CODE := Ar_Make_Comp_Code;
					lrBodyPE.DEPT_CODE := Ar_Dept_Code;
					lrBodyPE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
					lrBodyPE.CUST_SEQ := lnCustSeq;
					lrBodyPE.CUST_NAME := lsCustName;
					lrBodyPE.RESET_SLIP_ID := lrB.SLIP_ID;				--설정인 경우는 자기 전표 번호입니다.
					lrBodyPE.RESET_SLIP_IDSEQ := lrB.SLIP_IDSEQ;			--설정인 경우는 자기 전표 번호입니다.
					lrBodyPE.LOAN_REFUND_NO := Ar_Loan_No;
					lrBodyPE.LOAN_NO := Ar_Loan_No;
					lrBodyPE.BANK_CODE := lrLoan.BANK_CODE;
					lrBodyPE.ACCNO := lrB.ACCNO;
					PKG_MAKE_SLIP.Insert_Body(lrBodyPE);
				End Loop;
			End If;
			--영업외비용 지급 이자 설정
			lnCrAmt := 0;
			lnDbAmt := 0;
			If lnPrevEXDBSum < lnTotItrAmt Then	--이자 총액이 기존 영업외비용 지급이자보다 크다면...차변 설정을 해야지요!
				lnDbAmt := lnTotItrAmt - lnPrevEXDBSum;
			ElsIf lnPrevEXDBSum > lnTotItrAmt Then	--물론 이런 경우가 없어야 하지만 만약 실제 이자보다 더 많이 계상했다면... 빼야지요!
				lnCrAmt := lnTotItrAmt - lnPrevEXDBSum;
			End If;
			If lnDbAmt <> 0 Or lnCrAmt <> 0  Then	--PL-SQL도 C나 C++처럼 Or에대해 참이면 뒤에 것은 연산 안한다는 사실...
				lnMakeSlipLine := lnMakeSlipLine + 1;
				lrBodyIT := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.ITR_ACC_CODE,lsClassCode,Null);
				lrBodyIT.DB_AMT := lnDbAmt;
				lrBodyIT.CR_AMT := lnCrAmt;
				lrBodyIT.TAX_COMP_CODE := Ar_Make_Comp_Code;
				lrBodyIT.COMP_CODE := Ar_Make_Comp_Code;
				lrBodyIT.DEPT_CODE := Ar_Dept_Code;
				lrBodyIT.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
				lrBodyIT.CUST_SEQ := lnCustSeq;
				lrBodyIT.CUST_NAME := lsCustName;
				lrBodyIT.LOAN_REFUND_NO := Ar_Loan_No;
				lrBodyIT.LOAN_NO := Ar_Loan_No;
				lrBodyIT.BANK_CODE := lrLoan.BANK_CODE;
				lrBodyIT.ACCNO := lrOther.ACCNO;
				PKG_MAKE_SLIP.Insert_Body(lrBodyIT);
			End If;
		End;
	ElsIf lrRec.ITR_TAG = '6' Then	--후취이자 원금상환
		--후취이자의 처리는 이렇습니다...
		--먼저 실재 이자 지급이 있다면... 이는 반드시 영업외 비용 지급이자가 됩니다.
		--미지급 비용 지급이자의 대변 잔액 과 영업외비용 지급이자의 합이 이자 총액보다 크다면 과대 계상된 것입니다.
		--미지급 비용 지급이자의 잔액이 남아 있다면... 이는 반드시 완전히 반제되어야 합니다.
		--거의 선급비용의 처리와 차이가 없습니다.(차대만 바뀌는 정도입니다.)
		Declare
			lnPrevPESETSum				Number;
			lnPrevPERESETSum			Number;
			lnPrevEXDBSum				Number;
			lnTotItrAmt					Number;
			lnPERemain					Number;
			lnPEResetTarget				Number;
			lnCrAmt						Number;
			lnDbAmt						Number;
		Begin
			--기존 미지급비용 차변,대변 합계구하기
			Begin
				Select
					Nvl(Sum(DB_AMT),0),
					Nvl(Sum(CR_AMT),0)
				Into
					lnPrevPERESETSum,
					lnPrevPESETSum
				From	T_ACC_SLIP_BODY
				Where	LOAN_REFUND_NO = lrRec.LOAN_NO
				And		KEEP_DT Is Not Null
				And		ACC_CODE = lrLoanKind.AE_ITR_ACC_CODE;
			Exception When No_Data_Found Then	--실제 집계함수에서는 이 에러가 발생되지는 않습니다.
				lnPrevPESETSum := 0;
				lnPrevPERESETSum := 0;
			End;
			--기존 영업외비용 지급이자 구하기
			Begin
				Select
					Nvl(Sum(DB_AMT),0)
				Into
					lnPrevEXDBSum
				From	T_ACC_SLIP_BODY
				Where	LOAN_REFUND_NO = lrRec.LOAN_NO
				And		KEEP_DT Is Not Null
				And		ACC_CODE = lrLoanKind.ITR_ACC_CODE;
			Exception When No_Data_Found Then	--실제 집계함수에서는 이 에러가 발생되지는 않습니다.
				lnPrevEXDBSum := 0;
			End;
			--해당 차입의 이자 총액을 구한다.
			Begin
				Select
					Nvl(Sum(a.INTR_AMT),0)
				Into
					lnTotItrAmt
				From	T_FIN_LOAN_REFUND_LIST a
				Where	LOAN_NO = lrRec.LOAN_NO
				And		REFUND_INTR_DT <= lrRec.REFUND_INTR_DT;
			Exception When No_Data_Found Then	--실제 집계함수에서는 이 에러가 발생되지는 않습니다.
				lnTotItrAmt := 0;
			End;
			If lnTotItrAmt < lnPrevPESETSum - lnPrevPERESETSum + lnPrevEXDBSum Then	--만약 미지급비용이 과대 계상되어 있다면...
				lnPERemain := lnPrevPESETSum - lnPrevPERESETSum + lnPrevEXDBSum - lnTotItrAmt;
			Else
				lnPERemain := 0;
			End If;
			lnPEResetTarget := lnPrevPESETSum - lnPrevPERESETSum;
			If lnPEResetTarget > 0 Then		--만약 잔액이 남아 있다면
				For lrB In (
					Select
						a.SLIP_ID ,
						a.SLIP_IDSEQ ,
						a.MAKE_SLIPLINE ,
						a.ACC_CODE ,
						a.DB_AMT ,
						a.CR_AMT ,
						a.SUMMARY_CODE ,
						a.TAX_COMP_CODE ,
						a.COMP_CODE ,
						a.DEPT_CODE ,
						a.CLASS_CODE ,
						a.VAT_CODE ,
						a.VAT_DT ,
						a.SUPAMT ,
						a.VATAMT ,
						a.CUST_SEQ ,
						a.CUST_NAME ,
						a.BANK_CODE ,
						a.ACCNO ,
						a.RESET_SLIP_ID ,
						a.RESET_SLIP_IDSEQ ,
						a.MAKE_COMP_CODE ,
						a.MAKE_DEPT_CODE ,
						a.MAKE_DT ,
						a.KEEP_DT ,
						a.ORG_SLIP_ID ,
						a.ORG_SLIP_IDSEQ ,
						a.SLIP_KIND_TAG ,
						a.TRANSFER_TAG ,
						a.IGNORE_SET_RESET_TAG ,
						a.CRTUSERNO ,
						a.CRTDATE ,
						a.MODUSERNO ,
						a.MODDATE ,
						a.SUMMARY1 ,
						a.SUMMARY2 ,
						a.CHK_NO ,
						a.BILL_NO ,
						a.REC_BILL_NO ,
						a.CP_NO ,
						a.SECU_NO ,
						a.LOAN_NO ,
						a.LOAN_REFUND_NO ,
						a.LOAN_REFUND_SEQ ,
						a.DEPOSIT_ACCNO ,
						a.PAYMENT_SEQ ,
						a.PAY_CON_CASH ,
						a.PAY_CON_BILL ,
						a.PAY_CON_BILL_DT ,
						a.PAY_CON_BILL_DAYS ,
						a.EMP_NO ,
						a.ANTICIPATION_DT ,
						a.MNG_ITEM_CHAR1 ,
						a.MNG_ITEM_CHAR2 ,
						a.MNG_ITEM_CHAR3 ,
						a.MNG_ITEM_CHAR4 ,
						a.MNG_ITEM_NUM1 ,
						a.MNG_ITEM_NUM2 ,
						a.MNG_ITEM_NUM3 ,
						a.MNG_ITEM_NUM4 ,
						a.MNG_ITEM_DT1 ,
						a.MNG_ITEM_DT2 ,
						a.MNG_ITEM_DT3 ,
						a.MNG_ITEM_DT4 ,
						a.FIX_ASSET_SEQ,
						Nvl(a.CR_AMT,0) - 
						Nvl((
							Select
								Nvl(Sum(cc.DB_AMT),0) + Nvl(Sum(- cc.CR_AMT),0)
							From	T_ACC_SLIP_BODY1 cc
							Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
							And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
							And		cc.KEEP_DT Is Not Null
							And
							(
									cc.SLIP_ID <> cc.RESET_SLIP_ID
								Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
							)
						),0) REMAIN_AMT
					From	T_ACC_SLIP_BODY a
					Where	a.ACC_CODE = lrLoanKind.AE_ITR_ACC_CODE
					And		a.KEEP_DT Is Not Null
					And		a.LOAN_REFUND_NO = lrRec.LOAN_NO
					And		a.SLIP_ID = a.RESET_SLIP_ID
					And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
					And		Nvl(a.CR_AMT,0) - 
										Nvl((
											Select
												Nvl(Sum(cc.DB_AMT),0) + Nvl(Sum(- cc.CR_AMT),0)
											From	T_ACC_SLIP_BODY1 cc
											Where	cc.RESET_SLIP_ID = a.RESET_SLIP_ID
											And		cc.RESET_SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
											And		cc.KEEP_DT Is Not Null
											And
											(
													cc.SLIP_ID <> cc.RESET_SLIP_ID
												Or	cc.SLIP_IDSEQ <> cc.RESET_SLIP_IDSEQ
											)
										),0) > 0)
				Loop
					lnCrAmt := 0;
					lnDbAmt := 0;
					If lnPERemain > 0 Then		--음수 반제될 부분이 아직 남아 있다면
						If lnPERemain >= Nvl(lrB.REMAIN_AMT,0) then	--만약 이번잔액 이 더 작다면
							lnCrAmt := - Nvl(lrB.REMAIN_AMT,0);
							lnPERemain := lnPERemain + lnCrAmt;
							lnPEResetTarget := lnPEResetTarget + lnCrAmt;
						Else
							lnCrAmt := - lnPERemain;
							lnPERemain := 0;
							lnPEResetTarget := lnPEResetTarget + lnCrAmt;
						End If;
						lnMakeSlipLine := lnMakeSlipLine + 1;
						lrBodyAE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.AE_ITR_ACC_CODE,lsClassCode,Null);
						lrBodyAE.DB_AMT := lnDbAmt;
						lrBodyAE.CR_AMT := lnCrAmt;
						lrBodyAE.TAX_COMP_CODE := Ar_Make_Comp_Code;
						lrBodyAE.COMP_CODE := Ar_Make_Comp_Code;
						lrBodyAE.DEPT_CODE := Ar_Dept_Code;
						lrBodyAE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
						lrBodyAE.CUST_SEQ := lnCustSeq;
						lrBodyAE.CUST_NAME := lsCustName;
						lrBodyAE.RESET_SLIP_ID := lrB.SLIP_ID;				--설정인 경우는 자기 전표 번호입니다.
						lrBodyAE.RESET_SLIP_IDSEQ := lrB.SLIP_IDSEQ;			--설정인 경우는 자기 전표 번호입니다.
						lrBodyAE.LOAN_REFUND_NO := Ar_Loan_No;
						lrBodyAE.LOAN_NO := Ar_Loan_No;
						lrBodyAE.BANK_CODE := lrLoan.BANK_CODE;
						lrBodyAE.ACCNO := lrB.ACCNO;
						PKG_MAKE_SLIP.Insert_Body(lrBodyAE);
					End If;
					lnCrAmt := 0;
					lnDbAmt := 0;
					If lnPERemain = 0 Then
						If lnPEResetTarget >= Nvl(lrB.REMAIN_AMT,0) then	--만약 이번잔액 이 더 작다면
							lnDbAmt := Nvl(lrB.REMAIN_AMT,0);
							lnPEResetTarget := lnPEResetTarget - lnDbAmt;
						Else
							lnDbAmt := lnPEResetTarget;
							lnPEResetTarget := lnPEResetTarget - lnDbAmt;
						End If;
					End If;
					--미지급비용 반제라인
					lnMakeSlipLine := lnMakeSlipLine + 1;
					lrBodyAE := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.AE_ITR_ACC_CODE,lsClassCode,Null);
					lrBodyAE.DB_AMT := lnDbAmt;
					lrBodyAE.CR_AMT := lnCrAmt;
					lrBodyAE.TAX_COMP_CODE := Ar_Make_Comp_Code;
					lrBodyAE.COMP_CODE := Ar_Make_Comp_Code;
					lrBodyAE.DEPT_CODE := Ar_Dept_Code;
					lrBodyAE.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
					lrBodyAE.CUST_SEQ := lnCustSeq;
					lrBodyAE.CUST_NAME := lsCustName;
					lrBodyAE.RESET_SLIP_ID := lrB.SLIP_ID;				--설정인 경우는 자기 전표 번호입니다.
					lrBodyAE.RESET_SLIP_IDSEQ := lrB.SLIP_IDSEQ;			--설정인 경우는 자기 전표 번호입니다.
					lrBodyAE.LOAN_REFUND_NO := Ar_Loan_No;
					lrBodyAE.LOAN_NO := Ar_Loan_No;
					lrBodyAE.BANK_CODE := lrLoan.BANK_CODE;
					lrBodyAE.ACCNO := lrB.ACCNO;
					PKG_MAKE_SLIP.Insert_Body(lrBodyAE);
				End Loop;
			End If;
			--영업외비용 지급 이자 설정
			lnCrAmt := 0;
			lnDbAmt := 0;
			If lnPrevEXDBSum < lnTotItrAmt Then	--이자 총액이 기존 영업외비용 지급이자보다 크다면...차변 설정을 해야지요!
				lnDbAmt := lnTotItrAmt - lnPrevEXDBSum;
			ElsIf lnPrevEXDBSum > lnTotItrAmt Then	--물론 이런 경우가 없어야 하지만 만약 실제 이자보다 더 많이 계상했다면... 빼야지요!
				lnCrAmt := lnTotItrAmt - lnPrevEXDBSum;
			End If;
			If lnDbAmt <> 0 Or lnCrAmt <> 0  Then	--PL-SQL도 C나 C++처럼 Or에대해 참이면 뒤에 것은 연산 안한다는 사실...
				lnMakeSlipLine := lnMakeSlipLine + 1;
				lrBodyIT := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrLoanKind.ITR_ACC_CODE,lsClassCode,Null);
				lrBodyIT.DB_AMT := lnDbAmt;
				lrBodyIT.CR_AMT := lnCrAmt;
				lrBodyIT.TAX_COMP_CODE := Ar_Make_Comp_Code;
				lrBodyIT.COMP_CODE := Ar_Make_Comp_Code;
				lrBodyIT.DEPT_CODE := Ar_Dept_Code;
				lrBodyIT.SUMMARY1 := lsBankName||' '||lrLoanKind.LOAN_KIND_NAME||'('||To_Char(lrLoan.REAL_INTR_RATE,'fm999,999,990.000')||'%)';
				lrBodyIT.CUST_SEQ := lnCustSeq;
				lrBodyIT.CUST_NAME := lsCustName;
				lrBodyIT.LOAN_REFUND_NO := Ar_Loan_No;
				lrBodyIT.LOAN_NO := Ar_Loan_No;
				lrBodyIT.BANK_CODE := lrLoan.BANK_CODE;
				lrBodyIT.ACCNO := lrOther.ACCNO;
				PKG_MAKE_SLIP.Insert_Body(lrBodyIT);
			End If;
		End;
	Else
		Raise_Application_Error(-20009,'상환전표는 이자구분을 선취원금상환 또는 후취원금상환으로 선택하셔야 합니다.');
	End If;

	--상대계정 라인
	lnMakeSlipLine := lnMakeSlipLine + 1;
	lrBody2 := PKG_MAKE_SLIP.New_Body(lrHead,lnMakeSlipLine,lrOther.ACC_CODE,lrOther.CLASS_CODE,Null);
	PKG_MAKE_SLIP.CopySlipBodyFromTemp(lrOther,lrBody2);
	lrBody2.CR_AMT := Nvl(lrRec.REFUND_AMT,0) + Nvl(lrRec.INTR_AMT,0);
	lrBody2.TAX_COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.COMP_CODE := Ar_Make_Comp_Code;
	lrBody2.DEPT_CODE := Ar_Dept_Code;
	PKG_MAKE_SLIP.Insert_Body(lrBody2);
	PKG_MAKE_SLIP.Check_Slip(lrHead.SLIP_ID);
End;
/
