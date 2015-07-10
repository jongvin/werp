Create Or Replace Procedure SP_T_WORK_VAT_CODE_I
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_VAT_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_USE_TAG                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_VAT_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_VAT_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_WORK_VAT_CODE
	(
		WORK_CODE,
		COST_DEPT_KND_TAG,
		VAT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SEQ,
		USE_TAG
	)
	Values
	(
		AR_WORK_CODE,
		AR_COST_DEPT_KND_TAG,
		AR_VAT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SEQ,
		AR_USE_TAG
	);
End;
/
Create Or Replace Procedure SP_T_WORK_VAT_CODE_U
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_VAT_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_USE_TAG                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_VAT_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_VAT_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_WORK_VAT_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SEQ = AR_SEQ,
		USE_TAG = AR_USE_TAG
	Where	WORK_CODE = AR_WORK_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG
	And	VAT_CODE = AR_VAT_CODE;
End;
/
Create Or Replace Procedure SP_T_WORK_VAT_CODE_D
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_VAT_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_VAT_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_VAT_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_WORK_VAT_CODE
	Where	WORK_CODE = AR_WORK_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG
	And	VAT_CODE = AR_VAT_CODE;
End;
/