Create Or Replace Procedure SP_T_MONTH_SUM_CUST
(
	Ar_WorkMonthFrom		Varchar2,
	Ar_WorkMonthTo			Varchar2,
	Ar_CRTUSERNO			Varchar2
)
Is
	liMaxCnt			Number;
	lddtBegin			Date;
	lddtEnd				Date;
Begin
	lddtBegin := To_Date(Ar_WorkMonthFrom||'01','YYYYMMDD');
	lddtEnd := Last_Day(To_Date(Ar_WorkMonthTo||'01','YYYYMMDD'));
	Delete	T_CUST_SUM
	Where	CONF_YM Between Ar_WorkMonthFrom And Ar_WorkMonthTo;
	Insert Into T_CUST_SUM
	(
		CONF_YM,
		DEPT_CODE,
		CLASS_CODE,
		ACC_CODE,
		CUST_SEQ,
		CUST_NAME,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DR_SUM,
		CR_SUM
	)
	Select
		To_Char(b.MAKE_DT,'YYYYMM'),
		b.DEPT_CODE,
		b.CLASS_CODE,
		b.ACC_CODE,
		b.CUST_SEQ,
		b.CUST_NAME,
		Ar_CRTUSERNO,
		Sysdate,
		Null,
		Null,
		Nvl(Sum(b.DB_AMT),0) DB_AMT,
		Nvl(Sum(b.CR_AMT),0) CR_AMT
	From	T_ACC_SLIP_BODY1 b
	Where	b.MAKE_DT Between lddtBegin And lddtEnd
	And		b.CUST_SEQ Is Not Null
	And		b.CUST_NAME Is Not Null
	Group by
		To_Char(b.MAKE_DT,'YYYYMM'),
		b.DEPT_CODE,
		CLASS_CODE,
		b.ACC_CODE,
		b.CUST_SEQ,
		b.CUST_NAME;

	Insert Into T_CUST_SUM
	(
		CONF_YM,
		DEPT_CODE,
		CLASS_CODE,
		ACC_CODE,
		CUST_SEQ,
		CUST_NAME,
		CRTUSERNO,
		CRTDATE,
		DR_SUM,
		CR_SUM
	)
	Select
		a.CONF_YM ,
		a.DEPT_CODE ,
		a.CLASS_CODE,
		b.PARENT_ACC_CODE,
		a.CUST_SEQ,
		a.CUST_NAME,
		Ar_CRTUSERNO,
		Sysdate,
		Sum(a.DR_SUM) DR_SUM,
		Sum(a.CR_SUM )CR_SUM
	From	T_CUST_SUM a,
			T_ACC_CODE_CHILD b
	Where	a.CONF_YM Between Ar_WorkMonthFrom And Ar_WorkMonthTo
	And		a.ACC_CODE = b.CHILD_ACC_CODE
	Group by
		a.CONF_YM ,
		a.DEPT_CODE ,
		a.CLASS_CODE,
		b.PARENT_ACC_CODE,
		a.CUST_SEQ,
		a.CUST_NAME;
End;
/
