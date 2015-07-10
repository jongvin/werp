Create Or Replace Procedure SP_T_MAKE_FBS_C_DATA_PH
--사원지급분(HR)
(
	Ar_Comp_Code			Varchar2,
	Ar_Date_From			Varchar2,
	Ar_Date_To				Varchar2
)
Is
	PAY_KIND		Constant		T_FB_CASH_PAY_DATA.PAY_KIND_GUBUN%Type := 'PH';
	ln_Cnt							Number;
	lrTar							T_FB_CASH_PAY_DATA%RowType;
	lb_Exists						Boolean;
	ln_Pay_Seq						Number;
Begin
	--급여의 경우는 잘못된 자료에 대한 검증이 전표 만으로는 불가능하므로 일단 해당 기간의 모든 자료를 잘못된 것으로 간주한다.
	Update	T_FB_CASH_PAY_DATA a
	Set		a.PAY_STATUS = '7'
	Where	a.COMP_CODE = Ar_Comp_Code
	And		a.PAY_KIND_GUBUN = PAY_KIND
	And		a.PAY_YMD Between Replace(Ar_Date_From,'-','') And Replace(Ar_Date_To,'-','');
	For lrA In
	(
		Select
			PAY_KIND PAY_KIND_GUBUN,
			a.COMP_CODE,
			Max(b.DEPT_CODE) DEPT_CODE,
			Sum(b.AMT) PAY_AMT,
			To_Char(a.WORK_DT,'YYYYMMDD') PAY_DUE_YMD,
			SubStrb(c.SUMMARY1 || ' '||c.SUMMARY2,1,100) DESCRIPTION,
			d.BANKCD IN_BANK_CODE,
			Replace(d.BANKNO,'-','') IN_ACCOUNT_NO,
			e.NAME ACCT_HOLDER_NAME,
			Null CUST_SEQ,
			e.NAME VENDOR_NAME,
			g.BANK_MAIN_CODE OUT_BANK_CODE,
			f.ACCOUNT_NO OUT_ACCOUNT_NO,
			To_Char(a.WORK_DT,'YYYYMMDD') PAY_YMD,
			'0' PAY_STATUS,
			'N' MAIL_SEND_YN,
			a.SLIP_ID ,
			a.SLIP_IDSEQ,
			'N' EDI_CREATE_REQ_YN,
			a.WORK_YM PAY_YM,
			a.PAYGBN HR_PAY_GUBUN ,
			Max(b.EMP_NO) EMP_NO
		From	T_FIN_PAY_SAL a,
				T_FIN_PAY_SAL_LIST b,
				T_ACC_SLIP_BODY c,
				GBAN001VV d,
				Z_AUTHORITY_USER e,
				T_ACCNO_CODE f,
				T_BANK_CODE g
		Where	a.COMP_CODE = b.COMP_CODE
		And		a.WORK_SEQ = b.WORK_SEQ
		And		a.COMP_CODE = Ar_Comp_Code
		And		a.WORK_DT Between F_T_STRINGTODATE(Ar_Date_From) And F_T_STRINGTODATE(Ar_Date_To)
		And		a.SLIP_ID = c.SLIP_ID
		And		a.SLIP_IDSEQ = c.SLIP_IDSEQ
		And		c.KEEP_DT Is Not Null
		And		b.EMP_NO = d.EMPNO
		And		b.EMP_NO = e.EMPNO
		And		d.PAYGBN = '1'
		And		d.BANKNO Is Not Null
		And		a.ACCNO = f.ACCNO
		And		f.BANK_CODE = g.BANK_CODE
		Group by
			a.COMP_CODE,
			To_Char(a.WORK_DT,'YYYYMMDD'),
			SubStrb(c.SUMMARY1 || ' '||c.SUMMARY2,1,100),
			d.BANKCD,
			Replace(d.BANKNO,'-',''),
			e.NAME,
			g.BANK_MAIN_CODE,
			f.ACCOUNT_NO,
			To_Char(a.WORK_DT,'YYYYMMDD'),
			a.SLIP_ID ,
			a.SLIP_IDSEQ,
			a.WORK_YM,
			a.PAYGBN
	)
	Loop
		--먼저 기존에 있는 자료인지 검증한다.
		--기존 자료의 검증은 T_FB_INTERFACE_HR 테이블을 통해서 한다.
		Begin
			Select
				*
			Into
				lrTar
			From	T_FB_CASH_PAY_DATA a
			Where	a.PAY_SEQ In
			(
				Select
					b.PAY_SEQ
				From	T_FB_INTERFACE_HR b
				Where	PAY_YM = lrA.PAY_YM
				And		EMP_NO = lrA.EMP_NO
				And		HR_PAY_GUBUN = lrA.HR_PAY_GUBUN
				And		RowNum < 2
			);
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
					PAY_YMD = lrA.PAY_YMD,
					SLIP_ID = lrA.SLIP_ID,
					SLIP_IDSEQ = lrA.SLIP_IDSEQ,
					PAY_STATUS = lrA.PAY_STATUS
			Where	PAY_SEQ = lrTar.PAY_SEQ;
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
				SLIP_ID,
				SLIP_IDSEQ,
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
				lrA.PAY_STATUS,
				lrA.MAIL_SEND_YN,
				lrA.SLIP_ID,
				lrA.SLIP_IDSEQ,
				lrA.EDI_CREATE_REQ_YN
			);
			Insert Into T_FB_INTERFACE_HR
			(
				SEQ,
				PAY_SEQ,
				COMP_CODE,
				PAY_YM,
				EMP_NO,
				HR_PAY_GUBUN
			)
			Values
			(
				ln_Pay_Seq,
				ln_Pay_Seq,
				lrA.COMP_CODE,
				lrA.PAY_YM,
				lrA.EMP_NO,
				lrA.HR_PAY_GUBUN
			);
		End If;
	End Loop;
End;
/
