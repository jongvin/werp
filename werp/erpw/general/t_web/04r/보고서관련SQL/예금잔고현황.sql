--예금잔고현황
Select
	a.MAKE_COMP_CODE,			--사업장코드
	a.ACC_CODE,					--구분(계정코드)
	b.ACC_NAME,					--구분
	e.BANK_MAIN_CODE,			--은행
	e.BANK_MAIN_NAME,			--은행명
	Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) AMT,	--금액
	a.ACCNO,					--계좌
	c.ACCT_NAME
From	T_ACC_SLIP_BODY1 a,
		T_ACC_CODE b,
		T_ACCNO_CODE c,
		T_BANK_CODE d,
		T_BANK_MAIN e
Where	a.ACC_CODE In
		(
			Select	bc.CODE_LIST_ID	From	V_T_CODE_LIST bc	Where	bc.CODE_GROUP_ID = 'SAVING_ACC_CODE'
		)
And		a.TRANSFER_TAG = 'F'
And		a.ACC_CODE = b.ACC_CODE
And		a.ACCNO = c.ACCNO (+)
And		c.BANK_CODE = d.BANK_CODE (+)
And		d.BANK_MAIN_CODE = e.BANK_MAIN_CODE (+)
And		a.MAKE_COMP_CODE = :MAKE_COMP_CODE
And		a.MAKE_DT <= :MAKE_DT
And		a.KEEP_DT Is Not Null
Group By
	a.MAKE_COMP_CODE,
	a.ACC_CODE,
	b.ACC_NAME,
	a.ACCNO,
	c.ACCT_NAME,
	e.BANK_MAIN_CODE,
	e.BANK_MAIN_NAME
