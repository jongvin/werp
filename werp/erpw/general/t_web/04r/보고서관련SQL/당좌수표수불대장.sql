--:CHK_BILL_CLS : ��ǥ�������� C=>��ǥ B=>����
--���޾��� ���Ҵ��嵵 ������
Select
	:MAKE_DT_F MAKE_DT,
	Min(a.CHK_BILL_NO)||'-'||Max(a.CHK_BILL_NO)  CHK_BILL_NO,
	Count(*) IN_COUNT,
	Sum(Case When a.STAT_CLS = 1 Then
		0
	Else
		1
	End) OUT_COUNT,
	'�����̿�' SUMMARY1,
	'1' TAG
From	T_FIN_PAY_CHK_BILL a
Where	a.COMP_CODE = :MAKE_COMP_CODE
And		a.ACPT_DT < :MAKE_DT_F
And		a.CHK_BILL_CLS = 'C'
having	Count(*) > 0
Union All
Select
	a.ACPT_DT MAKE_DT,
	a.CHK_BILL_NO  CHK_BILL_NO,
	1 IN_COUNT,
	0 OUT_COUNT,
	'�԰�' SUMMARY1,
	'2' TAG
From	T_FIN_PAY_CHK_BILL a
Where	a.COMP_CODE = :MAKE_COMP_CODE
And		a.ACPT_DT >= :MAKE_DT_F
And		a.ACPT_DT <= :MAKE_DT_T
And		a.CHK_BILL_CLS = 'C'
Union All
Select
	a.PUBL_DT MAKE_DT,
	a.CHK_BILL_NO  CHK_BILL_NO,
	0 IN_COUNT,
	1 OUT_COUNT,
	b.SUMMARY1 SUMMARY1,
	'2' TAG
From	T_FIN_PAY_CHK_BILL a,
		T_ACC_SLIP_BODY2 b
Where	a.COMP_CODE = :MAKE_COMP_CODE
And		a.PUBL_DT >= :MAKE_DT_F
And		a.PUBL_DT <= :MAKE_DT_T
And		a.CHK_BILL_CLS = 'C'
And		a.STAT_CLS = '2'		--����
And		a.SLIP_ID = b.SLIP_ID (+)
And		a.SLIP_IDSEQ = b.SLIP_IDSEQ (+)
Union All
Select
	a.PUBL_DT MAKE_DT,
	a.CHK_BILL_NO  CHK_BILL_NO,
	0 IN_COUNT,
	1 OUT_COUNT,
	'��������' SUMMARY1,
	'2' TAG
From	T_FIN_PAY_CHK_BILL a
Where	a.COMP_CODE = :MAKE_COMP_CODE
And		a.PUBL_DT >= :MAKE_DT_F
And		a.PUBL_DT <= :MAKE_DT_T
And		a.CHK_BILL_CLS = 'C'
And		a.STAT_CLS = '0'		--��������
Union All
Select
	a.DUSE_DT MAKE_DT,
	a.CHK_BILL_NO  CHK_BILL_NO,
	0 IN_COUNT,
	1 OUT_COUNT,
	'���/�н�' SUMMARY1,
	'2' TAG
From	T_FIN_PAY_CHK_BILL a
Where	a.COMP_CODE = :MAKE_COMP_CODE
And		a.DUSE_DT >= :MAKE_DT_F
And		a.DUSE_DT <= :MAKE_DT_T
And		a.CHK_BILL_CLS = 'C'
Union All
Select
	a.RETURN_DT MAKE_DT,
	a.CHK_BILL_NO  CHK_BILL_NO,
	0 IN_COUNT,
	1 OUT_COUNT,
	'�����ȯ' SUMMARY1,
	'2' TAG
From	T_FIN_PAY_CHK_BILL a
Where	a.COMP_CODE = :MAKE_COMP_CODE
And		a.RETURN_DT >= :MAKE_DT_F
And		a.RETURN_DT <= :MAKE_DT_T
And		a.CHK_BILL_CLS = 'C'
And		a.STAT_CLS = '9'		--�����ȯ
