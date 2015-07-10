Create Or Replace Procedure SP_T_FL_DEPT_EXE_FUNCTIONS_I
(
	AR_DEPT_EXE_FUNC_NO                        NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DEPT_EXE_FUNCTIONS_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DEPT_EXE_FUNCTIONS ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_DEPT_EXE_FUNCTIONS
	(
		DEPT_EXE_FUNC_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		FUNC_TITLE,
		FUNC_NAME,
		AUTO_RECALCC_TAG
	)
	Values
	(
		AR_DEPT_EXE_FUNC_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_FUNC_TITLE,
		AR_FUNC_NAME,
		AR_AUTO_RECALCC_TAG
	);
End;
/
Create Or Replace Procedure SP_T_FL_DEPT_EXE_FUNCTIONS_U
(
	AR_DEPT_EXE_FUNC_NO                        NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DEPT_EXE_FUNCTIONS_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DEPT_EXE_FUNCTIONS ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FL_DEPT_EXE_FUNCTIONS
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		FUNC_TITLE = AR_FUNC_TITLE,
		FUNC_NAME = AR_FUNC_NAME,
		AUTO_RECALCC_TAG = AR_AUTO_RECALCC_TAG
	Where	DEPT_EXE_FUNC_NO = AR_DEPT_EXE_FUNC_NO;
End;
/
Create Or Replace Procedure SP_T_FL_DEPT_EXE_FUNCTIONS_D
(
	AR_DEPT_EXE_FUNC_NO                        NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DEPT_EXE_FUNCTIONS_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DEPT_EXE_FUNCTIONS ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_DEPT_EXE_FUNCTIONS
	Where	DEPT_EXE_FUNC_NO = AR_DEPT_EXE_FUNC_NO;
End;
/