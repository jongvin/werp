Select
	a.MAKE_DT,			--��ǥ������
	b.MAKE_SLIPNO,		--��ǥ��ȣ
	d.CUST_CODE,		--����ڹ�ȣ
	a.CUST_NAME,		--�ŷ�ó
	c.BANK_NAME,		--��������
	a.ACCNO,			--���¹�ȣ
	a.MAKE_SLIPLINE,	--�¼�
	a.MNG_ITEM_DT1,		--������(���ݰ�꼭����)
	a.PAY_CON_BILL_DT,	--������
	a.CR_AMT  AMT,			--�Աݱݾ�
	a.SUMMARY1			--����
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
