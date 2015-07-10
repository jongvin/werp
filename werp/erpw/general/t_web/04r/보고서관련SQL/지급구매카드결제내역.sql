Select
	a.MAKE_DT,			--전표발행일
	b.MAKE_SLIPNO,		--전표번호
	d.CUST_CODE,		--사업자번호
	a.CUST_NAME,		--거래처
	c.BANK_NAME,		--지급은행
	a.ACCNO,			--계좌번호
	a.MAKE_SLIPLINE,	--좌수
	a.MNG_ITEM_DT1,		--발행일(세금계산서일자)
	a.PAY_CON_BILL_DT,	--만기일
	a.CR_AMT  AMT,			--입금금액
	a.SUMMARY1			--적요
From	T_ACC_SLIP_BODY a,
		T_ACC_SLIP_HEAD b,
		T_BANK_CODE c,
		T_CUST_CODE d
Where	a.MAKE_COMP_CODE = :MAKE_COMP_CODE
And		a.MAKE_DT = :MAKE_DT
And		a.ACC_CODE In
		(
			Select
				v.CODE_LIST_ID
			From	v_t_code_list v
			Where	v.CODE_GROUP_ID = 'PAY_CARD_ACC_CODE'
		)
And		a.SLIP_IDSEQ = a.RESET_SLIP_IDSEQ
And		a.SLIP_ID = a.RESET_SLIP_ID
And		a.SLIP_ID = b.SLIP_ID
And		a.BANK_CODE = c.BANK_CODE (+)
And		a.CUST_SEQ = d.CUST_SEQ (+)
And		a.KEEP_DT Is Not Null
Order By
	b.MAKE_SLIPNO,
	a.MAKE_SLIPLINE
