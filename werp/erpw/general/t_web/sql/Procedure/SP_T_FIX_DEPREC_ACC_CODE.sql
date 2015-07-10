Create Or Replace Procedure SP_T_FIX_DEPREC_ACC_CODE_I
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_DEPREC_ACC_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_DEPREC_ACC_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIX_DEPREC_ACC_CODE
	(
		ASSET_CLS_CODE,
		COST_DEPT_KND_TAG,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE
	)
	Values
	(
		AR_ASSET_CLS_CODE,
		AR_COST_DEPT_KND_TAG,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_CODE
	);
End;
/
Create Or Replace Procedure SP_T_FIX_DEPREC_ACC_CODE_U
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_DEPREC_ACC_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_DEPREC_ACC_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIX_DEPREC_ACC_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_CODE = AR_ACC_CODE
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
End;
/
Create Or Replace Procedure SP_T_FIX_DEPREC_ACC_CODE_D
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_DEPREC_ACC_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_DEPREC_ACC_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-17)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIX_DEPREC_ACC_CODE
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
End;
/
