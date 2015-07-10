Create Or Replace Procedure SP_T_BUDG_DEPT_MAP_I
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CHK_DEPT_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_DEPT_MAP_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_DEPT_MAP ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_DEPT_MAP
	(
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CHK_DEPT_CODE
	)
	Values
	(
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CHK_DEPT_CODE
	);
Exception When Dup_Val_On_Index Then
	Update	T_BUDG_DEPT_MAP
	Set		MODUSERNO = AR_CRTUSERNO,
			MODDATE = SysDate,
			CHK_DEPT_CODE = AR_CHK_DEPT_CODE
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_BUDG_DEPT_MAP_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CHK_DEPT_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_DEPT_MAP_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_DEPT_MAP ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_DEPT_MAP
	(
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CHK_DEPT_CODE
	)
	Values
	(
		AR_DEPT_CODE,
		AR_MODUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CHK_DEPT_CODE
	);
Exception When Dup_Val_On_Index Then
	Update	T_BUDG_DEPT_MAP
	Set		MODUSERNO = AR_MODUSERNO,
			MODDATE = SysDate,
			CHK_DEPT_CODE = AR_CHK_DEPT_CODE
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_BUDG_DEPT_MAP_D
(
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_DEPT_MAP_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_DEPT_MAP ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_BUDG_DEPT_MAP
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
