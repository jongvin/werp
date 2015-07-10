Create Or Replace Procedure SP_T_MAKE_PAY_TARGET
(
	AR_COMP_CODE				VARCHAR2,
	AR_WORK_DT					VARCHAR2,
	AR_CRTUSERNO				VARCHAR2
)
Is
	lddtWorkDt					Date := F_T_StringToDate(AR_WORK_DT);
Begin
	--먼저 해당 일의 작업 내용을 삭제 합니다.
	Delete	T_FIN_PAY_TARGET_SLIP_LIST
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_DT = lddtWorkDt;
	--그 다음 데이타를 삽입합니다.
	Insert Into T_FIN_PAY_TARGET_SLIP_LIST
	(
		COMP_CODE,
		WORK_DT,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		ACC_CODE,
		TARGET_SLIP_ID,
		TARGET_SLIP_IDSEQ,
		CUST_SEQ,
		CUST_NAME,
		SET_AMT,
		PRE_RESET_AMT,
		EXCEPT_AMT,
		C_RATIO,
		B_RATIO
	)
	Select
		AR_COMP_CODE COMP_CODE,
		lddtWorkDt WORK_DT,
		Row_Number() Over (Order By a.SLIP_ID ,	a.SLIP_IDSEQ) SEQ,
		AR_CRTUSERNO CRTUSERNO,
		SysDate CRTDATE,
		a.ACC_CODE ACC_CODE,
		a.SLIP_ID TARGET_SLIP_ID,
		a.SLIP_IDSEQ TARGET_SLIP_IDSEQ,
		a.CUST_SEQ CUST_SEQ,
		a.CUST_NAME CUST_NAME,
		Nvl(a.DB_AMT,0) + Nvl(a.CR_AMT,0) SET_AMT,
		Nvl(Sum(Abs(b.DB_AMT)),0) + Nvl(Sum(Abs(b.CR_AMT)),0) PRE_RESET_AMT,
		0 EXCEPT_AMT,
		a.PAY_CON_CASH C_RATIO,
		a.PAY_CON_BILL B_RATIO
	From	T_ACC_SLIP_BODY a,
			T_ACC_SLIP_BODY1 b
	Where	a.SLIP_ID = b.RESET_SLIP_ID (+)
	And		a.SLIP_IDSEQ = b.RESET_SLIP_IDSEQ (+)
	And		a.MAKE_COMP_CODE = AR_COMP_CODE
	And		a.ANTICIPATION_DT <= lddtWorkDt
	And		a.MAKE_DT <= lddtWorkDt
	And		b.MAKE_DT(+) < lddtWorkDt
	And		a.SLIP_ID = a.RESET_SLIP_ID
	And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
	And		b.SLIP_IDSEQ (+) <> b.RESET_SLIP_IDSEQ (+)
	And		a.IGNORE_SET_RESET_TAG = 'F'
	And		a.TRANSFER_TAG = 'F'
	And		b.TRANSFER_TAG (+) = 'F'
	And		a.KEEP_DT Is Not Null
	And		b.KEEP_DT (+) Is Not Null
	And		a.ACC_CODE In
			(
				Select
					x.ACC_CODE
				From	T_FIN_PAY_SUM_ACC_LIST x
			)
	having	Nvl(a.DB_AMT,0) + Nvl(a.CR_AMT,0) - Nvl(Sum(Abs(b.DB_AMT)),0) - Nvl(Sum(Abs(b.CR_AMT)),0) <> 0
	Group By
		a.ACC_CODE,
		a.SLIP_ID ,
		a.SLIP_IDSEQ,
		a.CUST_SEQ ,
		a.CUST_NAME,
		a.ANTICIPATION_DT,
		a.PAY_CON_CASH ,
		a.PAY_CON_BILL ,
		a.DB_AMT,
		a.CR_AMT;
End;
/
