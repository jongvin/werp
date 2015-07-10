--�������
Select
	a.MAKE_COMP_CODE,
	a.ACC_CODE,
	c.ACC_NAME,
	a.ACCNO,
	b.ACCT_NAME,
	c.ACC_NAME ||' '|| b.ACCT_NAME ACC_AND_ACCT_NAME,		--���и�
	a.MAKE_DT,												--����
	a.TAG,													--'1'�̸� �����̿� '2' �̸� ���� �߻�
	a.SUMMARY1,												--����
	a.DB_AMT,												--���Աݾ�
	a.CR_AMT,												--����ݾ�
	Sum(Nvl(a.DB_AMT,0) - Nvl(a.CR_AMT,0)) Over (Partition by a.MAKE_COMP_CODE,	a.ACC_CODE,	a.ACCNO Order By a.MAKE_DT,a.TAG) REMAIN_AMT
From
	(
		Select
			:MAKE_DT MAKE_DT,
			c.MAKE_COMP_CODE,
			c.ACC_CODE,
			c.ACCNO,
			Sum(c.DB_AMT) DB_AMT,
			Sum(c.CR_AMT) CR_AMT,
			'�����̿�' SUMMARY1,
			'1' TAG 
		From	T_ACC_SLIP_BODY c
		Where	c.MAKE_COMP_CODE =   :MAKE_COMP_CODE
		And		c.ACC_CODE In
				(
					Select	bc.CODE_LIST_ID	From	V_T_CODE_LIST bc	Where	bc.CODE_GROUP_ID = 'SAVING_ACC_CODE'
				)
		And		c.MAKE_DT <   :MAKE_DT
		And		c.TRANSFER_TAG = 'F'
		Group By
			c.MAKE_COMP_CODE,
			c.ACC_CODE,
			c.ACCNO
		Union All
		Select
			c.MAKE_DT,
			c.MAKE_COMP_CODE,
			c.ACC_CODE,
			c.ACCNO,
			c.DB_AMT,
			c.CR_AMT,
			c.SUMMARY1,
			'2' TAG 
		From	T_ACC_SLIP_BODY c
		Where	c.MAKE_COMP_CODE =   :MAKE_COMP_CODE
		And		c.ACC_CODE In
				(
					Select	bc.CODE_LIST_ID	From	V_T_CODE_LIST bc	Where	bc.CODE_GROUP_ID = 'SAVING_ACC_CODE'
				)
		And		c.MAKE_DT =   :MAKE_DT
		And		c.TRANSFER_TAG = 'F'
	) a,
	T_ACCNO_CODE b,
	T_ACC_CODE c
Where	a.ACCNO = b.ACCNO (+)
And		a.ACC_CODE = c.ACC_CODE
Order By
	a.MAKE_COMP_CODE,
	a.ACC_CODE,
	a.ACCNO,
	a.MAKE_DT,
	a.TAG
