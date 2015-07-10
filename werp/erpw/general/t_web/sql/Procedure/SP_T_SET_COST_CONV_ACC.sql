Create Or Replace Procedure SP_T_SET_COST_CONV_ACC_I
(
	AR_COST_CONV_CODE                          VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_R_ACC_CODE                              VARCHAR2,
	AR_R_ACC_CODE2                             VARCHAR2,
	AR_R_ACC_CODE3                             VARCHAR2,
	AR_R_ACC_CODE4                             VARCHAR2,
	AR_R_ACC_CODE5                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_COST_CONV_ACC_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_COST_CONV_ACC ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_SET_COST_CONV_ACC
	(
		COST_CONV_CODE,
		ACC_CODE,
		R_ACC_CODE,
		R_ACC_CODE2,
		R_ACC_CODE3,
		R_ACC_CODE4,
		R_ACC_CODE5
	)
	Values
	(
		AR_COST_CONV_CODE,
		AR_ACC_CODE,
		AR_R_ACC_CODE,
		AR_R_ACC_CODE2,
		AR_R_ACC_CODE3,
		AR_R_ACC_CODE4,
		AR_R_ACC_CODE5
	);
End;
/
Create Or Replace Procedure SP_T_SET_COST_CONV_ACC_U
(
	AR_COST_CONV_CODE                          VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_R_ACC_CODE                              VARCHAR2,
	AR_R_ACC_CODE2                             VARCHAR2,
	AR_R_ACC_CODE3                             VARCHAR2,
	AR_R_ACC_CODE4                             VARCHAR2,
	AR_R_ACC_CODE5                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_COST_CONV_ACC_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_COST_CONV_ACC ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_SET_COST_CONV_ACC
	Set
		R_ACC_CODE = AR_R_ACC_CODE,
		R_ACC_CODE2 = AR_R_ACC_CODE2,
		R_ACC_CODE3 = AR_R_ACC_CODE3,
		R_ACC_CODE4 = AR_R_ACC_CODE4,
		R_ACC_CODE5 = AR_R_ACC_CODE5
	Where	COST_CONV_CODE = AR_COST_CONV_CODE
	And	ACC_CODE = AR_ACC_CODE;
End;
/
Create Or Replace Procedure SP_T_SET_COST_CONV_ACC_D
(
	AR_COST_CONV_CODE                          VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_COST_CONV_ACC_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_COST_CONV_ACC ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_SET_COST_CONV_ACC
	Where	COST_CONV_CODE = AR_COST_CONV_CODE
	And	ACC_CODE = AR_ACC_CODE;
End;
/
