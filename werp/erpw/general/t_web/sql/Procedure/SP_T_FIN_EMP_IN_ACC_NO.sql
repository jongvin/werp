Create Or Replace Procedure SP_T_FIN_EMP_IN_ACC_NO_I
(
	AR_ERMP_NO                                 VARCHAR2,
	AR_IN_BANK_MAIN_CODE_1                     VARCHAR2,
	AR_IN_ACC_NO_1                             VARCHAR2,
	AR_IN_BANK_MAIN_CODE_2                     VARCHAR2,
	AR_IN_ACC_NO_2                             VARCHAR2,
	AR_IN_BANK_MAIN_CODE_3                     VARCHAR2,
	AR_IN_ACC_NO_3                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_EMP_IN_ACC_NO_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_EMP_IN_ACC_NO ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-30)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_EMP_IN_ACC_NO
	(
		ERMP_NO,
		IN_BANK_MAIN_CODE_1,
		IN_ACC_NO_1,
		IN_BANK_MAIN_CODE_2,
		IN_ACC_NO_2,
		IN_BANK_MAIN_CODE_3,
		IN_ACC_NO_3
	)
	Values
	(
		AR_ERMP_NO,
		AR_IN_BANK_MAIN_CODE_1,
		AR_IN_ACC_NO_1,
		AR_IN_BANK_MAIN_CODE_2,
		AR_IN_ACC_NO_2,
		AR_IN_BANK_MAIN_CODE_3,
		AR_IN_ACC_NO_3
	);
End;
/
Create Or Replace Procedure SP_T_FIN_EMP_IN_ACC_NO_U
(
	AR_ERMP_NO                                 VARCHAR2,
	AR_IN_BANK_MAIN_CODE_1                     VARCHAR2,
	AR_IN_ACC_NO_1                             VARCHAR2,
	AR_IN_BANK_MAIN_CODE_2                     VARCHAR2,
	AR_IN_ACC_NO_2                             VARCHAR2,
	AR_IN_BANK_MAIN_CODE_3                     VARCHAR2,
	AR_IN_ACC_NO_3                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_EMP_IN_ACC_NO_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_EMP_IN_ACC_NO ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-30)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_EMP_IN_ACC_NO
	(
		ERMP_NO,
		IN_BANK_MAIN_CODE_1,
		IN_ACC_NO_1,
		IN_BANK_MAIN_CODE_2,
		IN_ACC_NO_2,
		IN_BANK_MAIN_CODE_3,
		IN_ACC_NO_3
	)
	Values
	(
		AR_ERMP_NO,
		AR_IN_BANK_MAIN_CODE_1,
		AR_IN_ACC_NO_1,
		AR_IN_BANK_MAIN_CODE_2,
		AR_IN_ACC_NO_2,
		AR_IN_BANK_MAIN_CODE_3,
		AR_IN_ACC_NO_3
	);
Exception When Dup_val_On_index Then
	Update T_FIN_EMP_IN_ACC_NO
	Set
		IN_BANK_MAIN_CODE_1 = AR_IN_BANK_MAIN_CODE_1,
		IN_ACC_NO_1 = AR_IN_ACC_NO_1,
		IN_BANK_MAIN_CODE_2 = AR_IN_BANK_MAIN_CODE_2,
		IN_ACC_NO_2 = AR_IN_ACC_NO_2,
		IN_BANK_MAIN_CODE_3 = AR_IN_BANK_MAIN_CODE_3,
		IN_ACC_NO_3 = AR_IN_ACC_NO_3
	Where	ERMP_NO = AR_ERMP_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_EMP_IN_ACC_NO_D
(
	AR_ERMP_NO                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_EMP_IN_ACC_NO_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_EMP_IN_ACC_NO ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-30)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIN_EMP_IN_ACC_NO
	Where	ERMP_NO = AR_ERMP_NO;
End;
/
