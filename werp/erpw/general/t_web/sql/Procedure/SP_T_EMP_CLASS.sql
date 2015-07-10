Create Or Replace Procedure SP_T_EMP_CLASS_I
(
	AR_EMP_CLASS_CODE                          VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_EMP_CLASS_NAME                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMP_CLASS_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMP_CLASS ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-04)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_EMP_CLASS
	(
		EMP_CLASS_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		EMP_CLASS_NAME
	)
	Values
	(
		AR_EMP_CLASS_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_EMP_CLASS_NAME
	);
End;
/
Create Or Replace Procedure SP_T_EMP_CLASS_U
(
	AR_EMP_CLASS_CODE                          VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_EMP_CLASS_NAME                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMP_CLASS_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMP_CLASS ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-04)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_EMP_CLASS
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		EMP_CLASS_NAME = AR_EMP_CLASS_NAME
	Where	EMP_CLASS_CODE = AR_EMP_CLASS_CODE;
End;
/
Create Or Replace Procedure SP_T_EMP_CLASS_D
(
	AR_EMP_CLASS_CODE                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMP_CLASS_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMP_CLASS ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-04)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_EMP_CLASS
	Where	EMP_CLASS_CODE = AR_EMP_CLASS_CODE;
End;
/
