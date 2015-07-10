Create Or Replace Procedure SP_T_DEPT_CODE_ORG3_I
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DEPT_NAME                               VARCHAR2,
	AR_DEPT_SHORT_NAME                         VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_TAX_COMP_CODE                           VARCHAR2,
	AR_BUDG_CLS                                VARCHAR2,
	AR_GROUP_DEPT_CODE                         VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_INPUT_DT_F                              VARCHAR2,
	AR_INPUT_DT_T                              VARCHAR2,
	AR_ACC_GRP_CODE                            NUMBER,
	AR_LEGA_DEPT                               VARCHAR2,
	AR_SAUP_TAX_TAG                            VARCHAR2,
	AR_EMP_CLASS_CODE                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_CODE_ORG3_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_CODE_ORG ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_DEPT_CODE_ORG
	(
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DEPT_NAME,
		DEPT_SHORT_NAME,
		COMP_CODE,
		TAX_COMP_CODE,
		BUDG_CLS,
		GROUP_DEPT_CODE,
		COST_DEPT_KND_TAG,
		INPUT_DT_F,
		INPUT_DT_T,
		ACC_GRP_CODE,
		LEGA_DEPT,
		SAUP_TAX_TAG,
		EMP_CLASS_CODE
	)
	Values
	(
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DEPT_NAME,
		AR_DEPT_SHORT_NAME,
		AR_COMP_CODE,
		AR_TAX_COMP_CODE,
		AR_BUDG_CLS,
		AR_GROUP_DEPT_CODE,
		AR_COST_DEPT_KND_TAG,
		F_T_StringToDate(AR_INPUT_DT_F),
		F_T_StringToDate(AR_INPUT_DT_T),
		AR_ACC_GRP_CODE,
		AR_LEGA_DEPT,
		AR_SAUP_TAX_TAG,
		AR_EMP_CLASS_CODE
	);
End;
/
Create Or Replace Procedure SP_T_DEPT_CODE_ORG3_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_DEPT_NAME                               VARCHAR2,
	AR_DEPT_SHORT_NAME                         VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_TAX_COMP_CODE                           VARCHAR2,
	AR_BUDG_CLS                                VARCHAR2,
	AR_GROUP_DEPT_CODE                         VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_INPUT_DT_F                              VARCHAR2,
	AR_INPUT_DT_T                              VARCHAR2,
	AR_ACC_GRP_CODE                            NUMBER,
	AR_LEGA_DEPT                               VARCHAR2,
	AR_SAUP_TAX_TAG                            VARCHAR2,
	AR_EMP_CLASS_CODE                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_CODE_ORG3_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_CODE_ORG ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_DEPT_CODE_ORG
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DEPT_NAME = AR_DEPT_NAME,
		DEPT_SHORT_NAME = AR_DEPT_SHORT_NAME,
		COMP_CODE = AR_COMP_CODE,
		TAX_COMP_CODE = AR_TAX_COMP_CODE,
		BUDG_CLS = AR_BUDG_CLS,
		GROUP_DEPT_CODE = AR_GROUP_DEPT_CODE,
		COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG,
		INPUT_DT_F = F_T_StringToDate(AR_INPUT_DT_F),
		INPUT_DT_T = F_T_StringToDate(AR_INPUT_DT_T),
		ACC_GRP_CODE = AR_ACC_GRP_CODE,
		LEGA_DEPT = AR_LEGA_DEPT,
		SAUP_TAX_TAG = AR_SAUP_TAX_TAG,
		EMP_CLASS_CODE = AR_EMP_CLASS_CODE
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_DEPT_CODE_ORG3_D
(
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_CODE_ORG3_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_CODE_ORG ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_DEPT_CODE_ORG
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
