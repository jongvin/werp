Create Or Replace Procedure SP_T_DEPT_CLASS_CODE_I
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CLASS_CODE                              VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DFLT_TAG                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_CLASS_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_CLASS_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-12-09)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_DEPT_CLASS_CODE
	(
		DEPT_CODE,
		CLASS_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DFLT_TAG
	)
	Values
	(
		AR_DEPT_CODE,
		AR_CLASS_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DFLT_TAG
	);
End;
/
Create Or Replace Procedure SP_T_DEPT_CLASS_CODE_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CLASS_CODE                              VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_DFLT_TAG                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_CLASS_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_CLASS_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-12-09)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_DEPT_CLASS_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DFLT_TAG = AR_DFLT_TAG
	Where	DEPT_CODE = AR_DEPT_CODE
	And	CLASS_CODE = AR_CLASS_CODE;
End;
/
Create Or Replace Procedure SP_T_DEPT_CLASS_CODE_D
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CLASS_CODE                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPT_CLASS_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPT_CLASS_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-12-09)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_DEPT_CLASS_CODE
	Where	DEPT_CODE = AR_DEPT_CODE
	And	CLASS_CODE = AR_CLASS_CODE;
End;
/
