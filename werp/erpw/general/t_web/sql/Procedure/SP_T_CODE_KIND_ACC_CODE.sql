Create Or Replace Procedure SP_T_CODE_KIND_ACC_CODE_I
(
	AR_MAIN_ACC_CODE                           VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CODE_KIND_ACC_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CODE_KIND_ACC_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_CODE_KIND_ACC_CODE
	(
		MAIN_ACC_CODE,
		COST_DEPT_KND_TAG,
		ACC_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_MAIN_ACC_CODE,
		AR_COST_DEPT_KND_TAG,
		AR_ACC_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_CODE_KIND_ACC_CODE_U
(
	AR_MAIN_ACC_CODE                           VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CODE_KIND_ACC_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CODE_KIND_ACC_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_CODE_KIND_ACC_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	MAIN_ACC_CODE = AR_MAIN_ACC_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG
	And	ACC_CODE = AR_ACC_CODE;
End;
/
Create Or Replace Procedure SP_T_CODE_KIND_ACC_CODE_D
(
	AR_MAIN_ACC_CODE                           VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CODE_KIND_ACC_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CODE_KIND_ACC_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_CODE_KIND_ACC_CODE
	Where	MAIN_ACC_CODE = AR_MAIN_ACC_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG
	And	ACC_CODE = AR_ACC_CODE;
End;
/
