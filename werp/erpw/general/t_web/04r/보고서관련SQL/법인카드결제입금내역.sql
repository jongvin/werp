Select
	aa.MAKE_DT,
	aa.MAKE_SLIPNO,
	td.DEPT_SHORT_NAME,					--�μ���
	a.EMP_NO,							--���
	zu.NAME,							--����
	a.MNG_ITEM_CHAR1 CARD_NO,			--ī���ȣ
	a.MAKE_SLIPLINE,					--�¼�
	a.DB_AMT AMT,						--�ݾ�
	F_T_Get_Pers_BankName(a.SLIP_ID,a.SLIP_IDSEQ,a.EMP_NO) BANK_NAME,	--�����
	F_T_Get_Pers_AccNo(a.SLIP_ID,a.SLIP_IDSEQ,a.EMP_NO) ACCNO,			--���¹�ȣ
	a.PAY_CON_BILL_DT					--������
From	T_ACC_SLIP_BODY a,
		T_ACC_SLIP_HEAD aa,
		Z_AUTHORITY_USER zu,
		T_DEPT_CODE td
Where	a.SLIP_ID = aa.SLIP_ID
And		Nvl(a.DB_AMT,0) <> 0
And		a.ACC_CODE In
(
	Select
		v.CODE_LIST_ID
	From	v_t_code_list v
	Where	v.CODE_GROUP_ID = 'CRED_CARD_ACC_CODE'
)
And		a.MAKE_COMP_CODE = :MAKE_COMP_CODE
And		a.MAKE_DT = :MAKE_DT
And		a.KEEP_DT Is Not Null
And		a.EMP_NO = zu.EMPNO (+)
And		zu.DEPT_CODE = td.DEPT_CODE (+)
Order By
	aa.MAKE_DT,
	aa.MAKE_SLIPNO,
	a.MAKE_SLIPLINE
