Select
	F_T_DATETOSTRING(a.DUSE_DT) DUSE_DT,				--�����
	b.BANK_NAME||'('||a.CHK_BILL_NO||')' CHK_BILL_NO,	--������ȣ
	a.REMARKS,											--����
	c.BILL_NAME||'���' DUSE_NAME,						--��ⱸ��
	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT,				--������
	F_T_DATETOSTRING(a.COLL_DT) COLL_DT					--ȸ����
From	T_FIN_PAY_CHK_BILL a,
		T_BANK_CODE b,
		T_FIN_BILL_KIND c
Where	a.BANK_CODE = b.BANK_CODE
And		a.BILL_KIND = c.BILL_KIND (+)
And		a.CHK_BILL_CLS = :CHK_BILL_CLS		--��ǥ�������� C=> ��ǥ B=> ����
And		a.COMP_CODE = :COMP_CODE
And		a.DUSE_DT Between :DUSE_DT_F And :DUSE_DT_T
