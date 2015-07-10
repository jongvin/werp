--���¼�ǥ �������
Select
	d.CUST_NAME,										--�ŷ�ó��
	a.REMARKS,											--����
	b.BANK_NAME,										--��������
	F_T_DATETOSTRING(a.PUBL_DT) DT,						--������
	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT,				       --������
	a.CHK_BILL_NO,										--������ȣ
	a.PUBL_AMT											--����ݾ�
From	T_FIN_PAY_CHK_BILL a,
		T_BANK_CODE b,
		T_FIN_BILL_KIND c,
		T_CUST_CODE d
Where	a.BANK_CODE = b.BANK_CODE
And		a.BILL_KIND = c.BILL_KIND (+)
And		a.CHK_BILL_CLS = 'C'
And		a.COMP_CODE = :COMP_CODE
And		a.PUBL_DT Between :DT_F And :DT_T
And		a.STAT_CLS = '0'		--��������
And		a.CUST_SEQ = d.CUST_SEQ (+)
