Create Or Replace Procedure SP_T_DEPT_CODE_NP_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_NP_PRT_TAG                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_CODE_NP_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_CODE_ORG ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_DEPT_CODE_ORG
	Set
		MODUSERNO = AR_CRTUSERNO,
		MODDATE = SYSDATE,
		NP_PRT_TAG = AR_NP_PRT_TAG
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
