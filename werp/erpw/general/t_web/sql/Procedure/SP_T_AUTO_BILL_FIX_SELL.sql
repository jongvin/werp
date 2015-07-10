Create Or Replace Procedure SP_T_AUTO_BILL_FIX_SELL_I
(
	AR_AUTO_B_F_SELL_SEQ                       NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SELL_AMT                                NUMBER,
	AR_INCREDU_SEQ                             NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_BILL_FIX_SELL_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_BILL_FIX_SELL ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_AUTO_BILL_FIX_SELL
	(
		AUTO_B_F_SELL_SEQ,
		FIX_ASSET_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SELL_AMT,
		INCREDU_SEQ
	)
	Values
	(
		AR_AUTO_B_F_SELL_SEQ,
		AR_FIX_ASSET_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SELL_AMT,
		AR_INCREDU_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FIX_SELL_U
(
	AR_AUTO_B_F_SELL_SEQ                       NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_SELL_AMT                                NUMBER,
	AR_INCREDU_SEQ                             NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_BILL_FIX_SELL_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_BILL_FIX_SELL ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_AUTO_BILL_FIX_SELL
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SELL_AMT = AR_SELL_AMT,
		INCREDU_SEQ = AR_INCREDU_SEQ
	Where	AUTO_B_F_SELL_SEQ = AR_AUTO_B_F_SELL_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FIX_SELL_D
(
	AR_AUTO_B_F_SELL_SEQ                       NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_BILL_FIX_SELL_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_BILL_FIX_SELL ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_AUTO_BILL_FIX_SELL
	Where	AUTO_B_F_SELL_SEQ = AR_AUTO_B_F_SELL_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
