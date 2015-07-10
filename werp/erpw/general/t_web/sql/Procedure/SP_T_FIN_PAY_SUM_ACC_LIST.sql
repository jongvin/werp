Create Or Replace Procedure SP_T_FIN_PAY_SUM_ACC_LIST_I
(
	AR_ACC_KIND_CODE                           VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_SUM_ACC_LIST_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_SUM_ACC_LIST ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_PAY_SUM_ACC_LIST
	(
		ACC_KIND_CODE,
		ACC_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_ACC_KIND_CODE,
		AR_ACC_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SUM_ACC_LIST_U
(
	AR_ACC_KIND_CODE                           VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_SUM_ACC_LIST_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_SUM_ACC_LIST ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIN_PAY_SUM_ACC_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	ACC_KIND_CODE = AR_ACC_KIND_CODE
	And	ACC_CODE = AR_ACC_CODE;
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SUM_ACC_LIST_D
(
	AR_ACC_KIND_CODE                           VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_SUM_ACC_LIST_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_SUM_ACC_LIST ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIN_PAY_SUM_ACC_LIST
	Where	ACC_KIND_CODE = AR_ACC_KIND_CODE
	And	ACC_CODE = AR_ACC_CODE;
End;
/
