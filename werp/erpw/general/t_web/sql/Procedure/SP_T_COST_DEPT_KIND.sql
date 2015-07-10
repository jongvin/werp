Create Or Replace Procedure SP_T_COST_DEPT_KIND_I
(
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_COST_DEPT_KND_NAME                      VARCHAR2,
	AR_PRT_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_COST_DEPT_KIND_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_COST_DEPT_KIND ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_COST_DEPT_KIND
	(
		COST_DEPT_KND_TAG,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		COST_DEPT_KND_NAME,
		PRT_SEQ
	)
	Values
	(
		AR_COST_DEPT_KND_TAG,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_COST_DEPT_KND_NAME,
		AR_PRT_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_COST_DEPT_KIND_U
(
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_COST_DEPT_KND_NAME                      VARCHAR2,
	AR_PRT_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_COST_DEPT_KIND_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_COST_DEPT_KIND ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_COST_DEPT_KIND
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		COST_DEPT_KND_NAME = AR_COST_DEPT_KND_NAME,
		PRT_SEQ = AR_PRT_SEQ
	Where	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
End;
/
Create Or Replace Procedure SP_T_COST_DEPT_KIND_D
(
	AR_COST_DEPT_KND_TAG                       VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_COST_DEPT_KIND_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_COST_DEPT_KIND ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lnCnt				Number;
Begin
	Select
		Count(*)
	Into
		lnCnt
	From	T_DEPT_CODE_ORG
	Where	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'�ش� �μ����� ������ ���� �μ��ڵ忡�� ������̹Ƿ� ������ �Ұ����մϴ�.');
	End If;
	Select
		Count(*)
	Into
		lnCnt
	From	T_FIN_BILL_ACC_CODE
	Where	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'�ش� �μ����� ������ ���� ���޾��������屸�к��������� ������̹Ƿ� ������ �Ұ����մϴ�.');
	End If;
	Delete T_COST_DEPT_KIND
	Where	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
End;
/
