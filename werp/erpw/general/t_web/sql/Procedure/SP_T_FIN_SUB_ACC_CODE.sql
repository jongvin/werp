Create Or Replace Procedure SP_T_FIN_SUB_ACC_CODE_I
(
	AR_SUBSCD                                  VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_ACC_CODE2                               VARCHAR2,
	AR_INCLUDE_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SUB_ACC_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SUB_ACC_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-03)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_SUB_ACC_CODE
	(
		SUBSCD,
		ACC_CODE,
		ACC_CODE2,
		INCLUDE_TAG
	)
	Values
	(
		AR_SUBSCD,
		AR_ACC_CODE,
		AR_ACC_CODE2,
		AR_INCLUDE_TAG
	);
End;
/
Create Or Replace Procedure SP_T_FIN_SUB_ACC_CODE_U
(
	AR_SUBSCD                                  VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_ACC_CODE2                               VARCHAR2,
	AR_INCLUDE_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SUB_ACC_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SUB_ACC_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-03)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_SUB_ACC_CODE
	(
		SUBSCD,
		ACC_CODE,
		ACC_CODE2,
		INCLUDE_TAG
	)
	Values
	(
		AR_SUBSCD,
		AR_ACC_CODE,
		AR_ACC_CODE2,
		AR_INCLUDE_TAG
	);
Exception When Dup_Val_on_Index Then
	Update T_FIN_SUB_ACC_CODE
	Set
		ACC_CODE = AR_ACC_CODE,
		ACC_CODE2 = AR_ACC_CODE2,
		INCLUDE_TAG = AR_INCLUDE_TAG
	Where	SUBSCD = AR_SUBSCD;
End;
/
Create Or Replace Procedure SP_T_FIN_SUB_ACC_CODE_D
(
	AR_SUBSCD                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SUB_ACC_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SUB_ACC_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-03)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIN_SUB_ACC_CODE
	Where	SUBSCD = AR_SUBSCD;
End;
/
