Create Or Replace Procedure SP_T_ACC_SUMMARY_I
(
	AR_ACC_CODE                                VARCHAR2,
	AR_SUMMARY_CODE                            VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SUMMARY_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_SUMMARY_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_SUMMARY ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_ACC_SUMMARY
	(
		ACC_CODE,
		SUMMARY_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SUMMARY_NAME
	)
	Values
	(
		AR_ACC_CODE,
		AR_SUMMARY_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SUMMARY_NAME
	);
End;
/
Create Or Replace Procedure SP_T_ACC_SUMMARY_U
(
	AR_ACC_CODE                                VARCHAR2,
	AR_SUMMARY_CODE                            VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SUMMARY_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_SUMMARY_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_SUMMARY ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_ACC_SUMMARY
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SUMMARY_NAME = AR_SUMMARY_NAME
	Where	ACC_CODE = AR_ACC_CODE
	And	SUMMARY_CODE = AR_SUMMARY_CODE;
End;
/
Create Or Replace Procedure SP_T_ACC_SUMMARY_D
(
	AR_ACC_CODE                                VARCHAR2,
	AR_SUMMARY_CODE                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_SUMMARY_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_SUMMARY ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_ACC_SUMMARY
	Where	ACC_CODE = AR_ACC_CODE
	And	SUMMARY_CODE = AR_SUMMARY_CODE;
End;
/
