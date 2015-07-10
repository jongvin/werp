Create Or Replace Procedure SP_T_FIN_SAL_ITEM_I
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SAL_ITEM_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SAL_ITEM ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_SAL_ITEM
	(
		ITEM_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITEM_NAME
	)
	Values
	(
		AR_ITEM_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITEM_NAME
	);
End;
/
Create Or Replace Procedure SP_T_FIN_SAL_ITEM_U
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SAL_ITEM_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SAL_ITEM ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIN_SAL_ITEM
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITEM_NAME = AR_ITEM_NAME
	Where	ITEM_CODE = AR_ITEM_CODE;
End;
/
Create Or Replace Procedure SP_T_FIN_SAL_ITEM_D
(
	AR_ITEM_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SAL_ITEM_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SAL_ITEM ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIN_SAL_ITEM
	Where	ITEM_CODE = AR_ITEM_CODE;
End;
/
