Select
	aa.MAKE_DT,
	aa.MAKE_SLIPNO,
	td.DEPT_SHORT_NAME,					--�μ���
	a.MNG_ITEM_CHAR1 CARD_NO,			--ī���ȣ
	a.MAKE_SLIPLINE,					--�¼�
	a.DB_AMT AMT,						--�ݾ�
	F_T_Get_Cust_BankName(a.SLIP_ID,a.SLIP_IDSEQ,a.CUST_SEQ,'1') BANK_NAME,
	a.ACCNO ACCNO						--���¹�ȣ
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
