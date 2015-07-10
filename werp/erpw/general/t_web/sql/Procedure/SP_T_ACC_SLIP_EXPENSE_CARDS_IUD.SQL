Create Or Replace Procedure SP_T_ACC_SLIP_EXPENSE_CARDS_I
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_CARD_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CARDNO                                  VARCHAR2,
	AR_USE_DT                                  VARCHAR2,
	AR_HAVE_PERS                               VARCHAR2,
	AR_CUST_CODE                               VARCHAR2,
	AR_CUST_NAME                               VARCHAR2,
	AR_TRADE_AMT                               NUMBER,
	AR_REQ_TG                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_SLIP_EXPENSE_CARDS_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_SLIP_EXPENSE_CARDS ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-12-22)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_ACC_SLIP_EXPENSE_CARDS
	(
		SLIP_ID,
		SLIP_IDSEQ,
		CARD_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CARDNO,
		USE_DT,
		HAVE_PERS,
		CUST_CODE,
		CUST_NAME,
		TRADE_AMT,
		REQ_TG
	)
	Values
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_CARD_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CARDNO,
		F_T_StringToDate(AR_USE_DT),
		AR_HAVE_PERS,
		AR_CUST_CODE,
		AR_CUST_NAME,
		AR_TRADE_AMT,
		AR_REQ_TG
	);
End;
/
Create Or Replace Procedure SP_T_ACC_SLIP_EXPENSE_CARDS_U
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_CARD_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CARDNO                                  VARCHAR2,
	AR_USE_DT                                  VARCHAR2,
	AR_HAVE_PERS                               VARCHAR2,
	AR_CUST_CODE                               VARCHAR2,
	AR_CUST_NAME                               VARCHAR2,
	AR_TRADE_AMT                               NUMBER,
	AR_REQ_TG                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_SLIP_EXPENSE_CARDS_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_SLIP_EXPENSE_CARDS ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-12-22)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_ACC_SLIP_EXPENSE_CARDS
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CARDNO = AR_CARDNO,
		USE_DT = F_T_StringToDate(AR_USE_DT),
		HAVE_PERS = AR_HAVE_PERS,
		CUST_CODE = AR_CUST_CODE,
		CUST_NAME = AR_CUST_NAME,
		TRADE_AMT = AR_TRADE_AMT,
		REQ_TG = AR_REQ_TG
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ
	And	CARD_SEQ = AR_CARD_SEQ;
End;
/
Create Or Replace Procedure SP_T_ACC_SLIP_EXPENSE_CARDS_D
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_CARD_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_SLIP_EXPENSE_CARDS_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_SLIP_EXPENSE_CARDS ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-12-22)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_ACC_SLIP_EXPENSE_CARDS
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ
	And	CARD_SEQ = AR_CARD_SEQ;
End;
/