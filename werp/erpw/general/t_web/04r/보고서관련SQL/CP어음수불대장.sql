--견질수표의 경우는 :CHK_BILL_CLS값이 C이다
Select
	'1' STAT_KIND ,										--구분 1=> 발행 2=>회수 3=>폐기
	F_T_DATETOSTRING(a.PUBL_DT) DT,						--발행일
	b.BANK_NAME||'('||a.CHK_BILL_NO||')' CHK_BILL_NO,	--어음번호
	a.REMARKS,											--적요
	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT,				--만기일
	a.PUBL_AMT											--발행금액
From	T_FIN_PAY_CHK_BILL a,
		T_BANK_CODE b,
		T_FIN_BILL_KIND c
Where	a.BANK_CODE = b.BANK_CODE
And		a.BILL_KIND = c.BILL_KIND (+)
And		a.CHK_BILL_CLS = :CHK_BILL_CLS		--수표어음구분 C=> 수표 B=> 어음
And		a.COMP_CODE = :COMP_CODE
And		a.PUBL_DT Between :DT_F And :DT_T
And		a.BILL_KIND In ( Select v.CODE_LIST_ID From V_T_CODE_LIST v Where v.CODE_GROUP_ID = 'CP_BILL_KIND')
Union All
Select
	'2' STAT_KIND ,										--구분 1=> 발행 2=>회수 3=>폐기
	F_T_DATETOSTRING(a.COLL_DT) DT,						--발행일
	b.BANK_NAME||'('||a.CHK_BILL_NO||')' CHK_BILL_NO,	--어음번호
	a.REMARKS,											--적요
	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT,				--만기일
	a.PUBL_AMT											--발행금액
From	T_FIN_PAY_CHK_BILL a,
		T_BANK_CODE b,
		T_FIN_BILL_KIND c
Where	a.BANK_CODE = b.BANK_CODE
And		a.BILL_KIND = c.BILL_KIND (+)
And		a.CHK_BILL_CLS = :CHK_BILL_CLS		--수표어음구분 C=> 수표 B=> 어음
And		a.COMP_CODE = :COMP_CODE
And		a.COLL_DT Between :DT_F And :DT_T
And		a.BILL_KIND In ( Select v.CODE_LIST_ID From V_T_CODE_LIST v Where v.CODE_GROUP_ID = 'CP_BILL_KIND')
Union All
Select
	'3' STAT_KIND ,										--구분 1=> 발행 2=>회수 3=>폐기
	F_T_DATETOSTRING(a.DUSE_DT) DT,						--발행일
	b.BANK_NAME||'('||a.CHK_BILL_NO||')' CHK_BILL_NO,	--어음번호
	a.REMARKS,											--적요
	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT,				--만기일
	a.PUBL_AMT											--발행금액
From	T_FIN_PAY_CHK_BILL a,
		T_BANK_CODE b,
		T_FIN_BILL_KIND c
Where	a.BANK_CODE = b.BANK_CODE
And		a.BILL_KIND = c.BILL_KIND (+)
And		a.CHK_BILL_CLS = :CHK_BILL_CLS		--수표어음구분 C=> 수표 B=> 어음
And		a.COMP_CODE = :COMP_CODE
And		a.DUSE_DT Between :DT_F And :DT_T
And		a.BILL_KIND In ( Select v.CODE_LIST_ID From V_T_CODE_LIST v Where v.CODE_GROUP_ID = 'CP_BILL_KIND')
