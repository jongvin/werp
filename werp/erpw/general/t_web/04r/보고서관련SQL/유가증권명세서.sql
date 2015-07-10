--보고서 파일명 r_t_040013.rpt
--입력인자 사업장코드

Select
	a.SEC_KIND_CODE,			--유가증권구분코드
	a.SEC_KIND_NAME,			--유가증권구분명
	b.PUBL_DT,					--발행일
	b.EXPR_DT,					--만기일
	b.INTR_RATE,				--이율
	b.PERSTOCK_AMT,				--유가증권금액
	b.REAL_SECU_NO,				--유가증권번호
	b.CONSIGN_BANK,				--위탁기관코드
	d.BANK_MAIN_NAME,			--위탁기관명
	e.MAKE_SLIPNO				--전표번호
From	T_FIN_SEC_KIND a,
		T_FIN_SECURTY b,
		T_BANK_CODE c,
		T_BANK_MAIN d,
		T_ACC_SLIP_HEAD e
Where	a.SEC_KIND_CODE = b.SEC_KIND_CODE
And		b.CONSIGN_BANK = c.BANK_CODE (+)
And		c.BANK_MAIN_CODE = d.BANK_MAIN_CODE (+)
And		b.SLIP_ID = e.SLIP_ID (+)
And		b.RETURN_DT Is Null
And		b.SALE_DT Is Null
And		b.COMP_CODE Like '%'|| :COMP_CODE ||'%'
Order By
	a.SEC_KIND_CODE,
	b.PUBL_DT,
	b.REAL_SECU_NO
