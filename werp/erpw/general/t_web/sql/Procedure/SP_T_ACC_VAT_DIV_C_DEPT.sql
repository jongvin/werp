Create Or Replace Procedure SP_T_ACC_VAT_DIV_C_DEPT_I
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_DIV_DEPT_CODE                           VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_VAT_DIV_C_DEPT_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_VAT_DIV_C_DEPT ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_ACC_VAT_DIV_C_DEPT
	(
		DIV_COMP_CODE,
		DIV_CODE,
		DIV_DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_DIV_COMP_CODE,
		AR_DIV_CODE,
		AR_DIV_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_ACC_VAT_DIV_C_DEPT_U
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_DIV_DEPT_CODE                           VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_VAT_DIV_C_DEPT_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_VAT_DIV_C_DEPT ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_ACC_VAT_DIV_C_DEPT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	DIV_COMP_CODE = AR_DIV_COMP_CODE
	And	DIV_CODE = AR_DIV_CODE
	And	DIV_DEPT_CODE = AR_DIV_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_ACC_VAT_DIV_C_DEPT_D
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_DIV_DEPT_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_VAT_DIV_C_DEPT_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_VAT_DIV_C_DEPT ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_ACC_VAT_DIV_C_DEPT
	Where	DIV_COMP_CODE = AR_DIV_COMP_CODE
	And	DIV_CODE = AR_DIV_CODE
	And	DIV_DEPT_CODE = AR_DIV_DEPT_CODE;
End;
/
