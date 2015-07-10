CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_REQUEST_FINISH
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_REQUEST_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_DEPT_REQUEST_FINISH.sql
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : �����û�Ϸ� �� ���
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-22)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
ls_REQUEST_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
li_ROW_CNT					       NUMBER;
Begin
	If AR_REQUEST_TAG = 'T' Then
		Select	COUNT(*)
		Into	li_ROW_CNT
		From	T_BUDG_MONTH_REQ a
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And		CHG_SEQ = AR_CHG_SEQ;
		If li_ROW_CNT = 0 Then
			Raise_Application_Error(-20009,'��û������ ������  ��û�Ϸᰡ �Ұ����մϴ�.');
		End If;
		
		Select	REQUEST_TAG
		Into	ls_REQUEST_TAG
		From	T_BUDG_DEPT_H a
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And		CHG_SEQ = AR_CHG_SEQ;
		If ls_REQUEST_TAG = 'T' Then
			Raise_Application_Error(-20009,'�̹� ��û�Ϸ�ƽ��ϴ�');
		End If;
	End If;
	
	If AR_REQUEST_TAG = 'F' Then
		Select	CONFIRM_TAG
		Into	ls_CONFIRM_TAG
		From	T_BUDG_DEPT_H a
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And		CHG_SEQ = AR_CHG_SEQ;
		If ls_CONFIRM_TAG = 'T' Then
			Raise_Application_Error(-20009,'�ش� ������ �̹� Ȯ���Ǿ� ��û�Ϸ���Ұ� �Ұ����մϴ�.');
		End If;
		
		Select	REQUEST_TAG
		Into	 ls_REQUEST_TAG
		From	T_BUDG_DEPT_H a
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And		CHG_SEQ = AR_CHG_SEQ;
		If ls_REQUEST_TAG = 'F' Then
			Raise_Application_Error(-20009,'��û�Ϸ��׸� �����մϴ�.');
		End If;
	End If;
	
	Update T_BUDG_DEPT_H
	Set
		REQUEST_TAG = AR_REQUEST_TAG
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
End;
