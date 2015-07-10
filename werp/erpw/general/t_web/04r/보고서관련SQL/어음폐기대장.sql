Select
	F_T_DATETOSTRING(a.DUSE_DT) DUSE_DT,				--폐기일
	b.BANK_NAME||'('||a.CHK_BILL_NO||')' CHK_BILL_NO,	--어음번호
	a.REMARKS,											--적요
	c.BILL_NAME||'폐기' DUSE_NAME,						--폐기구분
	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT,				--만기일
	F_T_DATETOSTRING(a.COLL_DT) COLL_DT					--회수일
From	T_FIN_PAY_CHK_BILL a,
		T_BANK_CODE b,
		T_FIN_BILL_KIND c
Where	a.BANK_CODE = b.BANK_CODE
And		a.BILL_KIND = c.BILL_KIND (+)
And		a.CHK_BILL_CLS = :CHK_BILL_CLS		--수표어음구분 C=> 수표 B=> 어음
And		a.COMP_CODE = :COMP_CODE
And		a.DUSE_DT Between :DUSE_DT_F And :DUSE_DT_T
