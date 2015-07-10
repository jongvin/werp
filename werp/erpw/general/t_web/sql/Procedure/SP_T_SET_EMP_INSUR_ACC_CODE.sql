Create Or Replace Procedure SP_T_SET_EMP_INSUR_ACC_CODE_I
(
	AR_ACC_CODE                                VARCHAR2,
	AR_S_AMT_TAG                               VARCHAR2,
	AR_T_DFLT_TAG                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_EMP_INSUR_ACC_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_EMP_INSUR_ACC_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_SET_EMP_INSUR_ACC_CODE
	(
		ACC_CODE,
		S_AMT_TAG,
		T_DFLT_TAG
	)
	Values
	(
		AR_ACC_CODE,
		AR_S_AMT_TAG,
		AR_T_DFLT_TAG
	);
End;
/
Create Or Replace Procedure SP_T_SET_EMP_INSUR_ACC_CODE_U
(
	AR_ACC_CODE                                VARCHAR2,
	AR_S_AMT_TAG                               VARCHAR2,
	AR_T_DFLT_TAG                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_EMP_INSUR_ACC_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_EMP_INSUR_ACC_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update	T_SET_EMP_INSUR_ACC_CODE
	Set		S_AMT_TAG = AR_S_AMT_TAG,
			T_DFLT_TAG = AR_T_DFLT_TAG
	Where	ACC_CODE = AR_ACC_CODE;
End;
/
Create Or Replace Procedure SP_T_SET_EMP_INSUR_ACC_CODE_D
(
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_EMP_INSUR_ACC_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_EMP_INSUR_ACC_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_SET_EMP_INSUR_ACC_CODE
	Where	ACC_CODE = AR_ACC_CODE;
End;
/
