Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_DEPT_I
(
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_SUM_TAR_DEPT_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_SUM_TAR_DEPT ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_PL_MA_SUM_TAR_DEPT
	(
		SUM_TAR_CODE,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_SUM_TAR_CODE,
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_DEPT_U
(
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_SUM_TAR_DEPT_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_SUM_TAR_DEPT ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_PL_MA_SUM_TAR_DEPT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	SUM_TAR_CODE = AR_SUM_TAR_CODE
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_DEPT_D
(
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_SUM_TAR_DEPT_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_SUM_TAR_DEPT ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_PL_MA_SUM_TAR_DEPT
	Where	SUM_TAR_CODE = AR_SUM_TAR_CODE
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/