Create Or Replace Procedure SP_T_MAKE_FBS_B_DATA
(
	Ar_Comp_Code			Varchar2,
	Ar_Date_From			Varchar2,
	Ar_Date_To				Varchar2
)
Is
	PAY_KIND		Constant		T_FB_BILL_PAY_DATA.PAY_KIND_GUBUN%Type := 'SE';		--구매카드는 거래처 지급분 이외에는 없다.
	lsCheckNo						T_FB_BILL_PAY_DATA.CHECK_NO%Type;
	lrTar							T_FB_BILL_PAY_DATA%RowType;
	lb_Exists						Boolean;
	ln_Pay_Seq						Number;
Begin
	--먼저 기존의 자료에서 무효한 전표가 있으면 취소 시킨다.
	Update	T_FB_BILL_PAY_DATA a
	Set		a.PAY_STATUS = '7'
	Where	a.COMP_CODE = Ar_Comp_Code
	And		a.PAY_KIND_GUBUN = PAY_KIND
	And		a.PAY_YMD Between Replace(Ar_Date_From,'-','') And Replace(Ar_Date_To,'-','')
	And		Not Exists
	(
		Select
			Null
		From	T_ACC_SLIP_BODY1 b
		Where	a.SLIP_ID = b.SLIP_ID
		And		a.SLIP_IDSEQ = b.SLIP_IDSEQ
		And		b.KEEP_DT Is Not Null
	);
	For lrA In
	(
		Select
			PAY_KIND PAY_KIND_GUBUN,
			a.COMP_CODE,
			b.DEPT_CODE,
			a.EXEC_AMT PAY_AMT,
			To_Char(a.WORK_DT,'YYYYMMDD') PAY_DUE_YMD,
			SubStrb(b.SUMMARY1 || ' '||b.SUMMARY2,1,100) DESCRIPTION,
			a.IN_BANK_MAIN_CODE IN_BANK_CODE,
			Replace(a.IN_ACC_NO,'-','') IN_ACCOUNT_NO,
			a.ACCNO_OWNER ACCT_HOLDER_NAME,
			b.CUST_SEQ,
			b.CUST_NAME VENDOR_NAME,
			f.BANK_MAIN_CODE OUT_BANK_CODE,
			e.ACCOUNT_NO OUT_ACCOUNT_NO,
			To_Char(a.WORK_DT,'YYYYMMDD') PAY_YMD,
			'0' PAY_STATUS,
			'N' MAIL_SEND_YN,
			a.SLIP_ID ,
			a.SLIP_IDSEQ,
			'N' EDI_CREATE_REQ_YN,
			To_Char(a.EXPR_DT,'YYYYMMDD') FUTURE_PAY_DUE_YMD,
			h.CUST_CODE VAT_REGISTRATION_NUM
		From	T_FIN_PAY_EXEC_LIST a,
				T_ACC_SLIP_BODY b,
				T_FIN_PAY_SUM_ACC_LIST c,
				T_FIN_PAY_SUM_ACC_GROUP d,
				T_ACCNO_CODE e,
				T_BANK_CODE f,
				T_ACC_SLIP_BODY g,
				T_CUST_CODE h
		Where	a.TARGET_SLIP_ID = b.SLIP_ID
		And		a.TARGET_SLIP_IDSEQ = b.SLIP_IDSEQ
		And		b.ACC_CODE = c.ACC_CODE
		And		c.ACC_KIND_CODE = d.ACC_KIND_CODE
		And		a.OUT_ACC_NO = e.ACCNO
		And		e.BANK_CODE = f.BANK_CODE
		And		d.PAY_TAR_TAG = '1'			--'1' 거래처 '2' 사원 '3' 사원법인카드
		And		a.EXEC_KIND_TAG = '2'		--'1' 예금 '2' 구매카드 '3' 실물어음 '4' 순현금
		And		a.COMP_CODE = Ar_Comp_Code
		And		a.WORK_DT Between F_T_STRINGTODATE(Ar_Date_From) And F_T_STRINGTODATE(Ar_Date_To)
		And		a.SLIP_ID = g.SLIP_ID
		And		a.SLIP_IDSEQ = g.SLIP_IDSEQ
		And		g.KEEP_DT Is Not Null
		And		b.CUST_SEQ = h.CUST_SEQ
	)
	Loop
		--먼저 기존에 있는 자료인지 검증한다.
		Begin
			Select
				*
			Into
				lrTar
			From	T_FB_BILL_PAY_DATA
			Where	SLIP_ID = lrA.SLIP_ID
			And		SLIP_IDSEQ = lrA.SLIP_IDSEQ
			And		RowNum < 2;
			lb_Exists := True;
		Exception When No_Data_Found Then
			lb_Exists := False;
		End;
		If lb_Exists Then		--이미 자료가 있으면 Update
			Update	T_FB_BILL_PAY_DATA
			Set		PAY_KIND_GUBUN = lrA.PAY_KIND_GUBUN,
					COMP_CODE = lrA.COMP_CODE,
					DEPT_CODE = lrA.DEPT_CODE,
					DESCRIPTION = lrA.DESCRIPTION,
					CUST_SEQ = lrA.CUST_SEQ,
					VENDOR_NAME = lrA.VENDOR_NAME,
					OUT_BANK_CODE = lrA.OUT_BANK_CODE,
					OUT_ACCOUNT_NO = lrA.OUT_ACCOUNT_NO,
					PAY_YMD = lrA.PAY_YMD,
					FUTURE_PAY_DUE_YMD = lrA.FUTURE_PAY_DUE_YMD,
					VAT_REGISTRATION_NUM = lrA.VAT_REGISTRATION_NUM
			Where	PAY_SEQ = lrTar.PAY_SEQ;
		Else
			Select
				T_FB_BILL_PAY_DATA_SEQ.NextVal
			Into
				ln_Pay_Seq
			From	Dual;
			lsCheckNo := F_T_Get_New_Check_No(lrA.PAY_YMD);
			Insert Into T_FB_BILL_PAY_DATA
			(
				PAY_SEQ,
				PAY_KIND_GUBUN,
				COMP_CODE,
				DEPT_CODE,
				PAY_AMT,
				PAY_DUE_YMD,
				DESCRIPTION,
				CUST_SEQ,
				VENDOR_NAME,
				OUT_BANK_CODE,
				OUT_ACCOUNT_NO,
				PAY_YMD,
				PAY_STATUS,
				MAIL_SEND_YN,
				SLIP_ID,
				SLIP_IDSEQ,
				EDI_CREATE_REQ_YN,
				VAT_REGISTRATION_NUM,
				FUTURE_PAY_DUE_YMD,
				CHECK_NO
			)
			Values
			(
				ln_Pay_Seq,
				lrA.PAY_KIND_GUBUN,
				lrA.COMP_CODE,
				lrA.DEPT_CODE,
				lrA.PAY_AMT,
				lrA.PAY_DUE_YMD,
				lrA.DESCRIPTION,
				lrA.CUST_SEQ,
				lrA.VENDOR_NAME,
				lrA.OUT_BANK_CODE,
				lrA.OUT_ACCOUNT_NO,
				lrA.PAY_YMD,
				lrA.PAY_STATUS,
				lrA.MAIL_SEND_YN,
				lrA.SLIP_ID,
				lrA.SLIP_IDSEQ,
				lrA.EDI_CREATE_REQ_YN,
				lrA.VAT_REGISTRATION_NUM,
				lrA.FUTURE_PAY_DUE_YMD,
				lsCheckNo
			);
		End If;
	End Loop;
End;
/
