--�μ������������� �����Ұ��(�ϰ�����Ȯ���� �Ȼ��¸�) üũ 
CREATE OR REPLACE Procedure SP_T_BUDG_ALL_CHANGE_CHECK
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER
)
Is
	ln_BUDG_ALL_CHANGE_DEPT_ROW_CNT					NUMBER;
Begin
	
	Select	count(*)
	Into	ln_BUDG_ALL_CHANGE_DEPT_ROW_CNT
	From	T_BUDG_ALL_CHANGE_DEPT a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	If ln_BUDG_ALL_CHANGE_DEPT_ROW_CNT > 0 Then
		Raise_Application_Error(-20009,'�ϰ����꺯���� ����Ǿ� �ϰ����꺯����Ұ� �Ұ����մϴ�..');
	End If;
End;