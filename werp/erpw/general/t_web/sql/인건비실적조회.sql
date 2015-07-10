Select
	b.EMP_CLASS_CODE,
	f.EMP_CLASS_NAME,
	c.ITEM_CODE,
	e.ITEM_NAME,
	a.ACC_CODE,
	d.ACC_SHRT_NAME,
	Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) TOT_AMT,
	Nvl(Sum(Case When To_Char(a.MAKE_DT,'YYYYMM') = To_Char(:MAKE_DT,'YYYYMM') Then
		a.DB_AMT
	Else
		0
	End),0) - Nvl(Sum(Case When To_Char(a.MAKE_DT,'YYYYMM') = To_Char(:MAKE_DT,'YYYYMM') Then
		a.CR_AMT
	Else
		0
	End),0) NOW_AMT
From	T_ACC_SLIP_BODY1 a,
		T_DEPT_CODE_ORG b,
		T_FIN_SAL_ACC_CODE c,
		T_ACC_CODE d,
		T_FIN_SAL_ITEM e,
		T_EMP_CLASS f
Where	a.MAKE_DT Between Trunc(:MAKE_DT,'YYYY') And Last_Day(:MAKE_DT)
And		a.DEPT_CODE = b.DEPT_CODE
And		a.ACC_CODE = c.ACC_CODE
And		a.ACC_CODE = d.ACC_CODE
And		c.ITEM_CODE = e.ITEM_CODE
And		b.EMP_CLASS_CODE = f.EMP_CLASS_CODE
And		a.TRANSFER_TAG = 'F'
Group By
	b.EMP_CLASS_CODE,
	f.EMP_CLASS_NAME,
	c.ITEM_CODE,
	a.ACC_CODE,
	e.ITEM_NAME,
	d.ACC_SHRT_NAME
Order By
	b.EMP_CLASS_CODE,
	c.ITEM_CODE,
	a.ACC_CODE
