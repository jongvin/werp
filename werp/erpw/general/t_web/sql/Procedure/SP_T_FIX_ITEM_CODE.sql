Create Or Replace Procedure SP_T_FIX_ITEM_CODE_I
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_ITEM_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_ITEM_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIX_ITEM_CODE
	(
		ASSET_CLS_CODE,
		ITEM_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITEM_NAME
	)
	Values
	(
		AR_ASSET_CLS_CODE,
		AR_ITEM_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITEM_NAME
	);
End;
/
Create Or Replace Procedure SP_T_FIX_ITEM_CODE_U
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_ITEM_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_ITEM_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIX_ITEM_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITEM_NAME = AR_ITEM_NAME
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	ITEM_CODE = AR_ITEM_CODE;
End;
/
Create Or Replace Procedure SP_T_FIX_ITEM_CODE_D
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_ITEM_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_ITEM_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIX_ITEM_CODE
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	ITEM_CODE = AR_ITEM_CODE;
End;
/
