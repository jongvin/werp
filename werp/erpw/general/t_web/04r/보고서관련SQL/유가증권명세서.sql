--���� ���ϸ� r_t_040013.rpt
--�Է����� ������ڵ�

Select
	a.SEC_KIND_CODE,			--�������Ǳ����ڵ�
	a.SEC_KIND_NAME,			--�������Ǳ��и�
	b.PUBL_DT,					--������
	b.EXPR_DT,					--������
	b.INTR_RATE,				--����
	b.PERSTOCK_AMT,				--�������Ǳݾ�
	b.REAL_SECU_NO,				--�������ǹ�ȣ
	b.CONSIGN_BANK,				--��Ź����ڵ�
	d.BANK_MAIN_NAME,			--��Ź�����
	e.MAKE_SLIPNO				--��ǥ��ȣ
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
