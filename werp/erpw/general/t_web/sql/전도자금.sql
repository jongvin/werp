/*
IN_TAG 가 '1' 이면 현장 입금 '2'면 본사입금
*/
Select
	Case When a.MAKE_DEPT_CODE = a.DEPT_CODE Then
		'1'
	Else
		'2'
	End IN_TAG,
	a.*
From	T_ACC_SLIP_BODY1 a
Where	a.ACC_CODE In
(
	Select
		b.CODE_LIST_ID
	From	V_T_CODE_LIST b
	Where	b.CODE_GROUP_ID = 'PROJ_PAY_ACC_CODE'
)
And		Nvl(a.DB_AMT,0) <> 0
And		a.KEEP_DT Is Not Null
And		a.TRANSFER_TAG = 'F'
And		a.DEPT_CODE = :DEPT_CODE
And		Not Exists
(
	Select
		Null
	From	F_RECEIVE_AMT b
	Where	a.SLIP_ID = b.INVOICE_NUM
	And		a.SLIP_IDSEQ = b.INVOICE_NUM1
)
