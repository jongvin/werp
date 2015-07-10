--������ǥ�� ���� :CHK_BILL_CLS���� C�̴�
Select
	'1' STAT_KIND ,										--���� 1=> ���� 2=>ȸ�� 3=>���
	F_T_DATETOSTRING(a.PUBL_DT) DT,						--������
	b.BANK_NAME||'('||a.CHK_BILL_NO||')' CHK_BILL_NO,	--������ȣ
	a.REMARKS,											--����
	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT,				--������
	a.PUBL_AMT											--����ݾ�
From	T_FIN_PAY_CHK_BILL a,
		T_BANK_CODE b,
		T_FIN_BILL_KIND c
Where	a.BANK_CODE = b.BANK_CODE
And		a.BILL_KIND = c.BILL_KIND (+)
And		a.CHK_BILL_CLS = :CHK_BILL_CLS		--��ǥ�������� C=> ��ǥ B=> ����
And		a.COMP_CODE = :COMP_CODE
And		to_char(a.PUBL_DT,'YYYYMM') = :DT_M
And		a.STAT_CLS = '0'					--0=>��������
Union All
Select
	'2' STAT_KIND ,										--���� 1=> ���� 2=>ȸ�� 3=>���
	F_T_DATETOSTRING(a.COLL_DT) DT,						--������
	b.BANK_NAME||'('||a.CHK_BILL_NO||')' CHK_BILL_NO,	--������ȣ
	a.REMARKS,											--����
	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT,				--������
	a.PUBL_AMT											--����ݾ�
From	T_FIN_PAY_CHK_BILL a,
		T_BANK_CODE b,
		T_FIN_BILL_KIND c
Where	a.BANK_CODE = b.BANK_CODE
And		a.BILL_KIND = c.BILL_KIND (+)
And		a.CHK_BILL_CLS = :CHK_BILL_CLS		--��ǥ�������� C=> ��ǥ B=> ����
And		a.COMP_CODE = :COMP_CODE
And		to_char(a.COLL_DT,'YYYYMM')  = :DT_M
And		a.STAT_CLS = '0'					--0=>��������
Union All
Select
	'3' STAT_KIND ,										--���� 1=> ���� 2=>ȸ�� 3=>���
	F_T_DATETOSTRING(a.DUSE_DT) DT,						--������
	b.BANK_NAME||'('||a.CHK_BILL_NO||')' CHK_BILL_NO,	--������ȣ
	a.REMARKS,											--����
	F_T_DATETOSTRING(a.EXPR_DT) EXPR_DT,				--������
	a.PUBL_AMT											--����ݾ�
From	T_FIN_PAY_CHK_BILL a,
		T_BANK_CODE b,
		T_FIN_BILL_KIND c
Where	a.BANK_CODE = b.BANK_CODE
And		a.BILL_KIND = c.BILL_KIND (+)
And		a.CHK_BILL_CLS = :CHK_BILL_CLS		--��ǥ�������� C=> ��ǥ B=> ����
And		a.COMP_CODE = :COMP_CODE
And		to_char(a.DUSE_DT,'YYYYMM')  = :DT_M
And		a.STAT_CLS = '0'					--0=>��������
