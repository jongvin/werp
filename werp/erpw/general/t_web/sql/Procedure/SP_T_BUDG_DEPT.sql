Create Or Replace Procedure SP_T_BUDG_DEPT_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_LAST_CONFIRMED_SEQ                      NUMBER,
	AR_LAST_WORK_SEQ                           NUMBER,
	AR_FIRST_SEQ                               NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_DEPT_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_DEPT ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_DEPT
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		LAST_CONFIRMED_SEQ,
		LAST_WORK_SEQ,
		FIRST_SEQ
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_LAST_CONFIRMED_SEQ,
		AR_LAST_WORK_SEQ,
		AR_FIRST_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_BUDG_DEPT_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_LAST_CONFIRMED_SEQ                      NUMBER,
	AR_LAST_WORK_SEQ                           NUMBER,
	AR_FIRST_SEQ                               NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_DEPT_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_DEPT ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_BUDG_DEPT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		LAST_CONFIRMED_SEQ = AR_LAST_CONFIRMED_SEQ,
		LAST_WORK_SEQ = AR_LAST_WORK_SEQ,
		FIRST_SEQ = AR_FIRST_SEQ
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_BUDG_DEPT_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_DEPT_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_DEPT ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_BUDG_DEPT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
