Create Or Replace Procedure SP_T_ACC_CREDCARD_I
(
	AR_CARD_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CARDNO                                  VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CARD_NAME                               VARCHAR2,
	AR_CARD_CLS                                VARCHAR2,
	AR_CARD_OWNER                              VARCHAR2,
	AR_BANK_CODE                               VARCHAR2,
	AR_ACCNO                                   VARCHAR2,
	AR_PAY_DATE                                NUMBER,
	AR_EXPR_MONTH                              VARCHAR2,
	AR_LIMIT_AMT                               NUMBER,
	AR_USE_TG                                  VARCHAR2,
	AR_UNUSED_DT                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_CREDCARD_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_CREDCARD ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_ACC_CREDCARD
	(
		CARD_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CARDNO,
		BANK_MAIN_CODE,
		COMP_CODE,
		CARD_NAME,
		CARD_CLS,
		CARD_OWNER,
		BANK_CODE,
		ACCNO,
		PAY_DATE,
		EXPR_MONTH,
		LIMIT_AMT,
		USE_TG,
		UNUSED_DT
	)
	Values
	(
		AR_CARD_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CARDNO,
		AR_BANK_MAIN_CODE,
		AR_COMP_CODE,
		AR_CARD_NAME,
		AR_CARD_CLS,
		AR_CARD_OWNER,
		AR_BANK_CODE,
		AR_ACCNO,
		AR_PAY_DATE,
		REPLACE(AR_EXPR_MONTH, '-', NULL),
		AR_LIMIT_AMT,
		AR_USE_TG,
		F_T_STRINGTODATE(AR_UNUSED_DT)
	);
End;
/
Create Or Replace Procedure SP_T_ACC_CREDCARD_U
(
	AR_CARD_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CARDNO                                  VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CARD_NAME                               VARCHAR2,
	AR_CARD_CLS                                VARCHAR2,
	AR_CARD_OWNER                              VARCHAR2,
	AR_BANK_CODE                               VARCHAR2,
	AR_ACCNO                                   VARCHAR2,
	AR_PAY_DATE                                NUMBER,
	AR_EXPR_MONTH                              VARCHAR2,
	AR_LIMIT_AMT                               NUMBER,
	AR_USE_TG                                  VARCHAR2,
	AR_UNUSED_DT                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_CREDCARD_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_CREDCARD ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_ACC_CREDCARD
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CARDNO = AR_CARDNO,
		BANK_MAIN_CODE = AR_BANK_MAIN_CODE,
		COMP_CODE = AR_COMP_CODE,
		CARD_NAME = AR_CARD_NAME,
		CARD_CLS = AR_CARD_CLS,
		CARD_OWNER = AR_CARD_OWNER,
		BANK_CODE = AR_BANK_CODE,
		ACCNO = AR_ACCNO,
		PAY_DATE = AR_PAY_DATE,
		EXPR_MONTH = REPLACE(AR_EXPR_MONTH, '-', NULL),
		LIMIT_AMT = AR_LIMIT_AMT,
		USE_TG = AR_USE_TG,
		UNUSED_DT = F_T_STRINGTODATE(AR_UNUSED_DT)
	Where	CARD_SEQ = AR_CARD_SEQ;
End;
/
Create Or Replace Procedure SP_T_ACC_CREDCARD_D
(
	AR_CARD_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_CREDCARD_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_CREDCARD ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_ACC_CREDCARD
	Where	CARD_SEQ = AR_CARD_SEQ;
End;
/
