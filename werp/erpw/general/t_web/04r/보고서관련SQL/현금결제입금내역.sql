Select
	aa.MAKE_DT,
	aa.MAKE_SLIPNO,
	b.CUST_NAME,
	b.BOSS_NAME,
	a.MAKE_SLIPLINE,
	a.DB_AMT AMT,
	F_T_Get_Cust_BankName(a.SLIP_ID,a.SLIP_IDSEQ,a.CUST_SEQ,'1') BANK_NAME,
	F_T_Get_Cust_AccNo(a.SLIP_ID,a.SLIP_IDSEQ,a.CUST_SEQ,'1') ACCNO
From	T_ACC_SLIP_BODY a,
		T_CUST_CODE b,
		T_ACC_SLIP_HEAD aa
Where	a.CUST_SEQ = b.CUST_SEQ (+)
And		a.SLIP_ID = aa.SLIP_ID
And		Nvl(a.DB_AMT,0) <> 0
And		a.ACC_CODE In
(
	Select
		v.CODE_LIST_ID
	From	v_t_code_list v
	Where	v.CODE_GROUP_ID = 'PAY_CUST_ACC_CODE'
)
And		a.MAKE_COMP_CODE = :MAKE_COMP_CODE
And		a.MAKE_DT = :MAKE_DT
And		a.KEEP_DT Is Not Null
And		Exists
(
	Select
		Null
	From	T_ACC_SLIP_REMAIN_KEEP sa,
			T_ACC_SLIP_BODY1 sb
	Where	a.SLIP_ID = sa.SLIP_ID
	And		a.SLIP_IDSEQ = sa.SLIP_IDSEQ
	And		sb.SLIP_ID = sa.SLIP_ID
	And		sb.SLIP_IDSEQ = sa.RESET_SLIP_IDSEQ
	And		sb.ACC_CODE In
	(
			Select
				v.CODE_LIST_ID
			From	v_t_code_list v
			Where	v.CODE_GROUP_ID = 'SAVING_ACC_CODE'
	)
)
