Select
	F_T_DATETOSTRING(a.DUSE_DT) DT,						--�����
	b.BANK_NAME||'('||a.CHK_BILL_NO||')' CHK_BILL_NO,	--������ȣ
	a.REMARKS,											--����
	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT,				--������
	a.PUBL_AMT											--����ݾ�
From	T_FIN_PAY_CHK_BILL a,
		T_BANK_CODE b,
		T_FIN_BILL_KIND c
Where	a.BANK_CODE = b.BANK_CODE
And		a.BILL_KIND = c.BILL_KIND (+)
And		a.CHK_BILL_CLS = 'C'
And		a.COMP_CODE = :COMP_CODE
And		a.DUSE_DT Between :DT_F And :DT_T
And		a.STAT_CLS = '0'		--��������
