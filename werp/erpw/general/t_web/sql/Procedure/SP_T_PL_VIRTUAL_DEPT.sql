Create Or Replace Procedure SP_T_PL_VIRTUAL_DEPT_I
(
	AR_V_DEPT_CODE                             VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_NAME                               VARCHAR2,
	AR_DEPT_SHORT_NAME                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_VIRTUAL_DEPT_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_VIRTUAL_DEPT ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-12)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_PL_VIRTUAL_DEPT
	(
		V_DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		COMP_CODE,
		DEPT_NAME,
		DEPT_SHORT_NAME
	)
	Values
	(
		AR_V_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_COMP_CODE,
		AR_DEPT_NAME,
		AR_DEPT_SHORT_NAME
	);
End;
/
Create Or Replace Procedure SP_T_PL_VIRTUAL_DEPT_U
(
	AR_V_DEPT_CODE                             VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_NAME                               VARCHAR2,
	AR_DEPT_SHORT_NAME                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_VIRTUAL_DEPT_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_VIRTUAL_DEPT ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-12)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_PL_VIRTUAL_DEPT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		COMP_CODE = AR_COMP_CODE,
		DEPT_NAME = AR_DEPT_NAME,
		DEPT_SHORT_NAME = AR_DEPT_SHORT_NAME
	Where	V_DEPT_CODE = AR_V_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_PL_VIRTUAL_DEPT_D
(
	AR_V_DEPT_CODE                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_VIRTUAL_DEPT_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_VIRTUAL_DEPT ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-12)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lnCnt				Number;
Begin
	Select
		Count(*)
	Into
		lnCnt
	from	T_PL_VIRTUAL_REAL_DEPT
	Where	V_DEPT_CODE = AR_V_DEPT_CODE;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'�ش� ��Ȯ������(�Ǵ� ��������)�� �̹� ������� ���踦 �ΰ� �����Ƿ� ������ �Ұ����մϴ�.');
	End If;
	Delete T_PL_VIRTUAL_DEPT
	Where	V_DEPT_CODE = AR_V_DEPT_CODE;
End;
/
