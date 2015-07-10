Create Or Replace Procedure SP_T_FL_DEPT_FLOW_MA_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_PLAN_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DEPT_FLOW_MA_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DEPT_FLOW_MA ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_DEPT_FLOW_MA
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		PLAN_CONFIRM_TAG,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_PLAN_CONFIRM_TAG,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FL_DEPT_FLOW_MA_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_PLAN_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DEPT_FLOW_MA_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DEPT_FLOW_MA ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FL_DEPT_FLOW_MA
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		PLAN_CONFIRM_TAG = AR_PLAN_CONFIRM_TAG,
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_FL_DEPT_FLOW_MA_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DEPT_FLOW_MA_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DEPT_FLOW_MA ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lnCnt					Number;
	Function	GetDeptName
	Return Varchar2
	Is
		lsDeptName						T_DEPT_CODE_ORG.DEPT_NAME%Type;
	Begin
		Select
			DEPT_NAME
		Into
			lsDeptName
		From	T_DEPT_CODE_ORG
		Where	DEPT_CODE = AR_DEPT_CODE;
		Return lsDeptName;
	Exception When No_Data_Found Then
		Return '�� �� ���� ����';
	End;
Begin
	Select
		Count(*)
	Into
		lnCnt
	From	T_FL_MONTH_PLAN_EXEC
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	RowNum < 2;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'�ش�����('||GetDeptName||')�� �̹� ���庰 �ڱݼ����۾��� �̷���� ������ �Ұ����մϴ�. ���� �����Ͻ÷��� ���� ���庰�ڱݼ��� ������ �����Ͻʽÿ�.');
	End If;
	Select
		Count(*)
	Into
		lnCnt
	From	T_FL_MONTH_PLAN_EXEC_PROJ_B
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	RowNum < 2;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'�ش�����('||GetDeptName||')�� �̹� �����ڱݼ����� ���庰 �۾��� �̷���� ������ �Ұ����մϴ�. ���� �����Ͻ÷��� ���� �����ڱݼ����� ���庰 �۾� ������ �����Ͻʽÿ�.');
	End If;
	Delete T_FL_DEPT_FLOW_MA
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
