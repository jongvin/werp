Create Or Replace Procedure SP_T_MAKE_FBS_C_DATA_SE
--거래처지급분
(
	Ar_Comp_Code			Varchar2,
	Ar_Date_From			Varchar2,
	Ar_Date_To				Varchar2
)
Is
	PAY_KIND		Constant		T_FB_CASH_PAY_DATA.PAY_KIND_GUBUN%Type := 'SE';
	ln_Cnt							Number;
	lrTar							T_FB_CASH_PAY_DATA%RowType;
	lb_Exists						Boolean;
	ln_Pay_Seq						Number;
Begin
	--먼저 기존의 자료를 금액 0으로 만든다.
	Update	T_FB_CASH_PAY_DATA a
	Set		a.PAY_AMT = 0
	Where	a.COMP_CODE = Ar_Comp_Code
	And		a.PAY_KIND_GUBUN = PAY_KIND
	And		a.PAY_YMD Between Replace(Ar_Date_From,'-','') And Replace(Ar_Date_To,'-','');
	Insert Into T_FB_REL_SLIP_TMP
	(
		PAY_KIND_GUBUN,
		COMP_CODE,
		DEPT_CODE,
		PAY_AMT,
		PAY_DUE_YMD,
		DESCRIPTION,
		IN_BANK_CODE,
		IN_ACCOUNT_NO,
		ACCT_HOLDER_NAME,
		CUST_SEQ,
		VENDOR_NAME,
		OUT_BANK_CODE,
		OUT_ACCOUNT_NO,
		PAY_YMD,
		SLIP_ID,
		SLIP_IDSEQ
	)
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
		a.SLIP_ID ,
		a.SLIP_IDSEQ
	From	T_FIN_PAY_EXEC_LIST a,
			T_ACC_SLIP_BODY b,
			T_FIN_PAY_SUM_ACC_LIST c,
			T_FIN_PAY_SUM_ACC_GROUP d,
			T_ACCNO_CODE e,
			T_BANK_CODE f,
			T_ACC_SLIP_BODY g
	Where	a.TARGET_SLIP_ID = b.SLIP_ID
	And		a.TARGET_SLIP_IDSEQ = b.SLIP_IDSEQ
	And		b.ACC_CODE = c.ACC_CODE
	And		c.ACC_KIND_CODE = d.ACC_KIND_CODE
	And		a.OUT_ACC_NO = e.ACCNO
	And		e.BANK_CODE = f.BANK_CODE
	And		d.PAY_TAR_TAG = '1'			--'1' 거래처 '2' 사원 '3' 사원법인카드
	And		a.EXEC_KIND_TAG = '1'		--'1' 예금 '2' 구매카드 '3' 실물어음 '4' 순현금
	And		a.COMP_CODE = Ar_Comp_Code
	And		a.WORK_DT Between F_T_STRINGTODATE(Ar_Date_From) And F_T_STRINGTODATE(Ar_Date_To)
	And		a.SLIP_ID = g.SLIP_ID
	And		a.SLIP_IDSEQ = g.SLIP_IDSEQ
	And		g.KEEP_DT Is Not Null
	And		a.IN_ACC_NO Is Not Null
	And		a.IN_BANK_MAIN_CODE Is Not Null
	And		f.BANK_MAIN_CODE Is Not Null
	And		e.ACCOUNT_NO Is Not Null;


	For lrA In
	(
		Select
			PAY_KIND_GUBUN,
			COMP_CODE,
			Max(DEPT_CODE) DEPT_CODE,
			Sum(PAY_AMT) PAY_AMT,
			PAY_DUE_YMD,
			Max(DESCRIPTION) DESCRIPTION,
			IN_BANK_CODE,
			IN_ACCOUNT_NO,
			ACCT_HOLDER_NAME,
			CUST_SEQ,
			VENDOR_NAME,
			OUT_BANK_CODE,
			OUT_ACCOUNT_NO,
			PAY_YMD
		From	T_FB_REL_SLIP_TMP
		Group By
			PAY_KIND_GUBUN,
			COMP_CODE,
			PAY_DUE_YMD,
			IN_BANK_CODE,
			IN_ACCOUNT_NO,
			ACCT_HOLDER_NAME,
			CUST_SEQ,
			VENDOR_NAME,
			OUT_BANK_CODE,
			OUT_ACCOUNT_NO,
			PAY_YMD
	)
	Loop
		--먼저 기존에 있는 자료인지 검증한다.
		Begin
			Select
				*
			Into
				lrTar
			From	T_FB_CASH_PAY_DATA
			Where	PAY_KIND_GUBUN = lrA.PAY_KIND_GUBUN
			And		COMP_CODE = lrA.COMP_CODE
			And		CUST_SEQ = lrA.CUST_SEQ
			And		IN_BANK_CODE = lrA.IN_BANK_CODE
			And		IN_ACCOUNT_NO = lrA.IN_ACCOUNT_NO
			And		OUT_BANK_CODE = lrA.OUT_BANK_CODE
			And		OUT_ACCOUNT_NO = lrA.OUT_ACCOUNT_NO
			And		PAY_YMD = lrA.PAY_YMD
			And		RowNum < 2;
			lb_Exists := True;
		Exception When No_Data_Found Then
			lb_Exists := False;
		End;
		If lb_Exists Then		--이미 자료가 있으면 Update
			Update	T_FB_CASH_PAY_DATA
			Set		PAY_KIND_GUBUN = lrA.PAY_KIND_GUBUN,
					COMP_CODE = lrA.COMP_CODE,
					DEPT_CODE = lrA.DEPT_CODE,
					DESCRIPTION = lrA.DESCRIPTION,
					IN_BANK_CODE = lrA.IN_BANK_CODE,
					IN_ACCOUNT_NO = lrA.IN_ACCOUNT_NO,
					ACCT_HOLDER_NAME = lrA.ACCT_HOLDER_NAME,
					CUST_SEQ = lrA.CUST_SEQ,
					VENDOR_NAME = lrA.VENDOR_NAME,
					OUT_BANK_CODE = lrA.OUT_BANK_CODE,
					OUT_ACCOUNT_NO = lrA.OUT_ACCOUNT_NO,
					PAY_YMD = lrA.PAY_YMD
			Where	PAY_SEQ = lrTar.PAY_SEQ;
			Delete	T_FB_REL_SLIP
			Where	PAY_SEQ = lrTar.PAY_SEQ;

			Insert Into T_FB_REL_SLIP
			(
				SLIP_ID,
				SLIP_IDSEQ,
				PAY_SEQ
			)
			Select
				SLIP_ID,
				SLIP_IDSEQ,
				lrTar.PAY_SEQ
			From	T_FB_REL_SLIP_TMP
			Where	PAY_KIND_GUBUN = lrA.PAY_KIND_GUBUN
			And		COMP_CODE = lrA.COMP_CODE
			And		CUST_SEQ = lrA.CUST_SEQ
			And		IN_BANK_CODE = lrA.IN_BANK_CODE
			And		IN_ACCOUNT_NO = lrA.IN_ACCOUNT_NO
			And		OUT_BANK_CODE = lrA.OUT_BANK_CODE
			And		OUT_ACCOUNT_NO = lrA.OUT_ACCOUNT_NO
			And		PAY_YMD = lrA.PAY_YMD;
		Else
			Select
				T_FB_CASH_PAY_DATA_SEQ.NextVal
			Into
				ln_Pay_Seq
			From	Dual;
			Insert Into T_FB_CASH_PAY_DATA
			(
				PAY_SEQ,
				PAY_KIND_GUBUN,
				COMP_CODE,
				DEPT_CODE,
				PAY_AMT,
				PAY_DUE_YMD,
				DESCRIPTION,
				IN_BANK_CODE,
				IN_ACCOUNT_NO,
				ACCT_HOLDER_NAME,
				CUST_SEQ,
				VENDOR_NAME,
				OUT_BANK_CODE,
				OUT_ACCOUNT_NO,
				PAY_YMD,
				PAY_STATUS,
				MAIL_SEND_YN,
				EDI_CREATE_REQ_YN
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
				lrA.IN_BANK_CODE,
				lrA.IN_ACCOUNT_NO,
				lrA.ACCT_HOLDER_NAME,
				lrA.CUST_SEQ,
				lrA.VENDOR_NAME,
				lrA.OUT_BANK_CODE,
				lrA.OUT_ACCOUNT_NO,
				lrA.PAY_YMD,
				'0',
				'N',
				'N'
			);
			Insert Into T_FB_REL_SLIP
			(
				SLIP_ID,
				SLIP_IDSEQ,
				PAY_SEQ
			)
			Select
				SLIP_ID,
				SLIP_IDSEQ,
				ln_Pay_Seq
			From	T_FB_REL_SLIP_TMP
			Where	PAY_KIND_GUBUN = lrA.PAY_KIND_GUBUN
			And		COMP_CODE = lrA.COMP_CODE
			And		CUST_SEQ = lrA.CUST_SEQ
			And		IN_BANK_CODE = lrA.IN_BANK_CODE
			And		IN_ACCOUNT_NO = lrA.IN_ACCOUNT_NO
			And		OUT_BANK_CODE = lrA.OUT_BANK_CODE
			And		OUT_ACCOUNT_NO = lrA.OUT_ACCOUNT_NO
			And		PAY_YMD = lrA.PAY_YMD;
		End If;
	End Loop;
End;
/
