Create Or Replace Procedure SP_T_DEPT_LEVEL_I
(
	AR_DEPT_KIND_TAG                           VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DEPT_KIND_NAME                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_LEVEL_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_LEVEL ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_DEPT_LEVEL
	(
		DEPT_KIND_TAG,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DEPT_KIND_NAME
	)
	Values
	(
		AR_DEPT_KIND_TAG,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DEPT_KIND_NAME
	);
End;
/
Create Or Replace Procedure SP_T_DEPT_LEVEL_U
(
	AR_DEPT_KIND_TAG                           VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_DEPT_KIND_NAME                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_LEVEL_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_LEVEL ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_DEPT_LEVEL
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DEPT_KIND_NAME = AR_DEPT_KIND_NAME
	Where	DEPT_KIND_TAG = AR_DEPT_KIND_TAG;
End;
/
Create Or Replace Procedure SP_T_DEPT_LEVEL_D
(
	AR_DEPT_KIND_TAG                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_LEVEL_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_LEVEL ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_DEPT_LEVEL
	Where	DEPT_KIND_TAG = AR_DEPT_KIND_TAG;
End;
/
