Select
	b.MAKE_SLIPNO,
	a.MAKE_SLIPLINE,
	a.CUST_NAME,		--�ŷ�ó
	a.SUMMARY1,			--����
	c.BANK_NAME,		--��������
	a.MNG_ITEM_DT1,		--������(���ݰ�꼭����)
	a.PAY_CON_BILL_DT,	--������
	a.CR_AMT			--�Աݱݾ�
From	T_ACC_SLIP_BODY a,
		T_ACC_SLIP_HEAD b,
		T_BANK_CODE c
Where	a.MAKE_COMP_CODE = :MAKE_COMP_CODE
And		a.MAKE_DT = :MAKE_DT
And		a.ACC_CODE In
		(
			Select
				v.CODE_LIST_ID
			From	v_t_code_list v
			Where	v.CODE_GROUP_ID = 'PAY_CARD_ACC_CODE'
		)
And		Nvl(a.CR_AMT,0) <> 0
And		a.SLIP_ID = b.SLIP_ID
And		a.BANK_CODE = c.BANK_CODE (+)
And		a.KEEP_DT Is Not Null
Order By
	b.MAKE_SLIPNO,
	a.MAKE_SLIPLINE
