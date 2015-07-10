Create Or Replace Procedure SP_T_SHEET_EXPR_BODY_I
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_POSITION                                VARCHAR2,
	AR_REMAIN_CLS                              VARCHAR2,
	AR_CALC_CLS                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_EXPR_BODY_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_EXPR_BODY ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_SHEET_EXPR_BODY
	(
		SHEET_CODE,
		ITEM_CODE,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE,
		POSITION,
		REMAIN_CLS,
		CALC_CLS
	)
	Values
	(
		AR_SHEET_CODE,
		AR_ITEM_CODE,
		AR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_CODE,
		AR_POSITION,
		AR_REMAIN_CLS,
		AR_CALC_CLS
	);
End;
/
Create Or Replace Procedure SP_T_SHEET_EXPR_BODY_U
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_POSITION                                VARCHAR2,
	AR_REMAIN_CLS                              VARCHAR2,
	AR_CALC_CLS                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_EXPR_BODY_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_EXPR_BODY ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_SHEET_EXPR_BODY
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_CODE = AR_ACC_CODE,
		POSITION = AR_POSITION,
		REMAIN_CLS = AR_REMAIN_CLS,
		CALC_CLS = AR_CALC_CLS
	Where	SHEET_CODE = AR_SHEET_CODE
	And	ITEM_CODE = AR_ITEM_CODE
	And	SEQ = AR_SEQ;
End;
/
Create Or Replace Procedure SP_T_SHEET_EXPR_BODY_D
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_SEQ                                     NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_EXPR_BODY_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_EXPR_BODY ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_SHEET_EXPR_BODY
	Where	SHEET_CODE = AR_SHEET_CODE
	And	ITEM_CODE = AR_ITEM_CODE
	And	SEQ = AR_SEQ;
End;
/
