Create Or Replace Procedure SP_T_GRP_ACC_CODE_I
(
	AR_ACC_GRP_CODE                            NUMBER,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_GRP_ACC_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_GRP_ACC_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_GRP_ACC_CODE
	(
		ACC_GRP_CODE,
		ACC_CODE
	)
	Values
	(
		AR_ACC_GRP_CODE,
		AR_ACC_CODE
	);
End;
/
Create Or Replace Procedure SP_T_GRP_ACC_CODE_U
(
	AR_ACC_GRP_CODE                            NUMBER,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_GRP_ACC_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_GRP_ACC_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Null;
End;
/
Create Or Replace Procedure SP_T_GRP_ACC_CODE_D
(
	AR_ACC_GRP_CODE                            NUMBER,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_GRP_ACC_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_GRP_ACC_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_GRP_ACC_CODE
	Where	ACC_GRP_CODE = AR_ACC_GRP_CODE
	And	ACC_CODE = AR_ACC_CODE;
End;
/