Create Or Replace Procedure SP_T_SHEET_CODE_LVL_I
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_LVL                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SEQ_TYPE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_CODE_LVL_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_CODE_LVL ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_SHEET_CODE_LVL
	(
		SHEET_CODE,
		ITEM_LVL,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SEQ_TYPE
	)
	Values
	(
		AR_SHEET_CODE,
		AR_ITEM_LVL,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SEQ_TYPE
	);
End;
/
Create Or Replace Procedure SP_T_SHEET_CODE_LVL_U
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_LVL                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SEQ_TYPE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_CODE_LVL_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_CODE_LVL ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_SHEET_CODE_LVL
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SEQ_TYPE = AR_SEQ_TYPE
	Where	SHEET_CODE = AR_SHEET_CODE
	And	ITEM_LVL = AR_ITEM_LVL;
End;
/
Create Or Replace Procedure SP_T_SHEET_CODE_LVL_D
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_LVL                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_CODE_LVL_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_CODE_LVL ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_SHEET_CODE_LVL
	Where	SHEET_CODE = AR_SHEET_CODE
	And	ITEM_LVL = AR_ITEM_LVL;
End;
/
