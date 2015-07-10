Create Or Replace Procedure SP_T_BUDG_DEPT_CONFIRM_N
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_DEPT_CODE					Varchar2,
	Ar_CHG_SEQ						Number,
	Ar_CRTUSERNO					Varchar2
)
Is
	ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
	ln_Count						Number;
Begin
	--���� �ڱ⺸�� �� ���� ������ Ȯ���� �Ű� ������ Ȯ�� ���� �Ұ�.
	Select
		Count(*)
	Into
		ln_Count
	From	T_BUDG_DEPT_H
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ > AR_CHG_SEQ
	And		CONFIRM_TAG = 'T';
	If ln_Count > 0 Then
		Raise_Application_Error(-20009,'���� Ȯ�� ����Ϸ��� ���� ���� �� ���߿� ���Ǿ� Ȯ���� ���� ���������� �����Ƿ� Ȯ�� ������ �ȵ˴ϴ�.');
	End If;
	
	Update	T_BUDG_DEPT_H
	Set		CONFIRM_TAG = 'F',
			MODUSERNO = Ar_CRTUSERNO,
			MODDATE = Sysdate
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ;
	
	SP_T_BUDG_LAST_CONFIRM(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_CRTUSERNO);
End;
/
