Create Or Replace Procedure SP_T_FL_CASH_ACC_CODE_I
(
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_CASH_ACC_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_CASH_ACC_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-04)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_CASH_ACC_CODE
	(
		ACC_CODE
	)
	Values
	(
		AR_ACC_CODE
	);
End;
/
Create Or Replace Procedure SP_T_FL_CASH_ACC_CODE_U
(
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_CASH_ACC_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_CASH_ACC_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-04)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Null;
End;
/
Create Or Replace Procedure SP_T_FL_CASH_ACC_CODE_D
(
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_CASH_ACC_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_CASH_ACC_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-04)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_CASH_ACC_CODE
	Where	ACC_CODE = AR_ACC_CODE;
End;
/
