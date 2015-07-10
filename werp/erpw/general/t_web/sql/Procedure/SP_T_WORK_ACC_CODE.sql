Create Or Replace Procedure SP_T_WORK_ACC_CODE_I
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_POSITION                            VARCHAR2,
	AR_SUMMARY_CODE                            VARCHAR2,
	AR_SUMMARY1                                VARCHAR2,
	AR_SUMMARY2                                VARCHAR2,
	AR_VAT_CODE                                VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_USE_TAG                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_ACC_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_ACC_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_WORK_ACC_CODE
	(
		WORK_CODE,
		COST_DEPT_KND_TAG,
		ACC_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_POSITION,
		SUMMARY_CODE,
		SUMMARY1,
		SUMMARY2,
		VAT_CODE,
		SEQ,
		USE_TAG
	)
	Values
	(
		AR_WORK_CODE,
		AR_COST_DEPT_KND_TAG,
		AR_ACC_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_POSITION,
		AR_SUMMARY_CODE,
		AR_SUMMARY1,
		AR_SUMMARY2,
		AR_VAT_CODE,
		AR_SEQ,
		AR_USE_TAG
	);
End;
/
Create Or Replace Procedure SP_T_WORK_ACC_CODE_U
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_POSITION                            VARCHAR2,
	AR_SUMMARY_CODE                            VARCHAR2,
	AR_SUMMARY1                                VARCHAR2,
	AR_SUMMARY2                                VARCHAR2,
	AR_VAT_CODE                                VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_USE_TAG                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_ACC_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_ACC_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_WORK_ACC_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_POSITION = AR_ACC_POSITION,
		SUMMARY_CODE = AR_SUMMARY_CODE,
		SUMMARY1 = AR_SUMMARY1,
		SUMMARY2 = AR_SUMMARY2,
		VAT_CODE = AR_VAT_CODE,
		SEQ = AR_SEQ,
		USE_TAG = AR_USE_TAG
	Where	WORK_CODE = AR_WORK_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG
	And	ACC_CODE = AR_ACC_CODE;
End;
/
Create Or Replace Procedure SP_T_WORK_ACC_CODE_D
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_ACC_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_ACC_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_WORK_ACC_CODE
	Where	WORK_CODE = AR_WORK_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG
	And	ACC_CODE = AR_ACC_CODE;
End;
/
