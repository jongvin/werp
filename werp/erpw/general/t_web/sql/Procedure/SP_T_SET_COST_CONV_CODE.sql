Create Or Replace Procedure SP_T_SET_COST_CONV_CODE_I
(
	AR_COST_CONV_CODE                          VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_COST_CONV_NAME                          VARCHAR2,
	AR_SALE_ACC_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_COST_CONV_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_COST_CONV_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_SET_COST_CONV_CODE
	(
		COST_CONV_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		COST_CONV_NAME,
		SALE_ACC_CODE
	)
	Values
	(
		AR_COST_CONV_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_COST_CONV_NAME,
		AR_SALE_ACC_CODE
	);
End;
/
Create Or Replace Procedure SP_T_SET_COST_CONV_CODE_U
(
	AR_COST_CONV_CODE                          VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_COST_CONV_NAME                          VARCHAR2,
	AR_SALE_ACC_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_COST_CONV_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_COST_CONV_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_SET_COST_CONV_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		COST_CONV_NAME = AR_COST_CONV_NAME,
		SALE_ACC_CODE = AR_SALE_ACC_CODE
	Where	COST_CONV_CODE = AR_COST_CONV_CODE;
End;
/
Create Or Replace Procedure SP_T_SET_COST_CONV_CODE_D
(
	AR_COST_CONV_CODE                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_COST_CONV_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_COST_CONV_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_SET_COST_CONV_CODE
	Where	COST_CONV_CODE = AR_COST_CONV_CODE;
End;
/
