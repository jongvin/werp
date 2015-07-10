Select
	aa.MAKE_DT,
	aa.MAKE_SLIPNO,
	td.DEPT_SHORT_NAME,					--부서명
	a.MNG_ITEM_CHAR1 CARD_NO,			--카드번호
	a.MAKE_SLIPLINE,					--좌수
	a.DB_AMT AMT,						--금액
	F_T_Get_Cust_BankName(a.SLIP_ID,a.SLIP_IDSEQ,a.CUST_SEQ,'1') BANK_NAME,
	a.ACCNO ACCNO						--계좌번호
From	T_ACC_SLIP_BODY a,
		T_ACC_SLIP_HEAD aa,
		T_DEPT_CODE td
Where	a.SLIP_ID = aa.SLIP_ID
And		Nvl(a.DB_AMT,0) <> 0
And		a.ACC_CODE In
(
	Select
		v.CODE_LIST_ID
	From	v_t_code_list v
	Where	v.CODE_GROUP_ID = 'PROJ_PAY_ACC_CODE'
)
And		a.MAKE_COMP_CODE = :MAKE_COMP_CODE
And		a.MAKE_DT = :MAKE_DT
And		a.KEEP_DT Is Not Null
And		a.DEPT_CODE = td.DEPT_CODE (+)
Order By
	aa.MAKE_DT,
	aa.MAKE_SLIPNO,
	a.MAKE_SLIPLINE
