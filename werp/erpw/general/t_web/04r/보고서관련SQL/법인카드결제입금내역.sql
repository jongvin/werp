Select
	aa.MAKE_DT,
	aa.MAKE_SLIPNO,
	td.DEPT_SHORT_NAME,					--부서명
	a.EMP_NO,							--사번
	zu.NAME,							--성명
	a.MNG_ITEM_CHAR1 CARD_NO,			--카드번호
	a.MAKE_SLIPLINE,					--좌수
	a.DB_AMT AMT,						--금액
	F_T_Get_Pers_BankName(a.SLIP_ID,a.SLIP_IDSEQ,a.EMP_NO) BANK_NAME,	--은행명
	F_T_Get_Pers_AccNo(a.SLIP_ID,a.SLIP_IDSEQ,a.EMP_NO) ACCNO,			--계좌번호
	a.PAY_CON_BILL_DT					--만기일
From	T_ACC_SLIP_BODY a,
		T_ACC_SLIP_HEAD aa,
		Z_AUTHORITY_USER zu,
		T_DEPT_CODE td
Where	a.SLIP_ID = aa.SLIP_ID
And		Nvl(a.DB_AMT,0) <> 0
And		a.ACC_CODE In
(
	Select
		v.CODE_LIST_ID
	From	v_t_code_list v
	Where	v.CODE_GROUP_ID = 'CRED_CARD_ACC_CODE'
)
And		a.MAKE_COMP_CODE = :MAKE_COMP_CODE
And		a.MAKE_DT = :MAKE_DT
And		a.KEEP_DT Is Not Null
And		a.EMP_NO = zu.EMPNO (+)
And		zu.DEPT_CODE = td.DEPT_CODE (+)
Order By
	aa.MAKE_DT,
	aa.MAKE_SLIPNO,
	a.MAKE_SLIPLINE
