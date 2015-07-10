--당좌수표 발행대장
Select
	d.CUST_NAME,										--거래처명
	a.REMARKS,											--적요
	b.BANK_NAME,										--지급은행
	F_T_DATETOSTRING(a.PUBL_DT) DT,						--발행일
	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT,				       --만기일
	a.CHK_BILL_NO,										--어음번호
	a.PUBL_AMT											--발행금액
From	T_FIN_PAY_CHK_BILL a,
		T_BANK_CODE b,
		T_FIN_BILL_KIND c,
		T_CUST_CODE d
Where	a.BANK_CODE = b.BANK_CODE
And		a.BILL_KIND = c.BILL_KIND (+)
And		a.CHK_BILL_CLS = 'C'
And		a.COMP_CODE = :COMP_CODE
And		a.PUBL_DT Between :DT_F And :DT_T
And		a.STAT_CLS = '0'		--견질발행
And		a.CUST_SEQ = d.CUST_SEQ (+)
