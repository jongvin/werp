Create Or Replace Procedure SP_T_AUTO_FBS_CASH_TRANS_I
(
	AR_SEQ                                     NUMBER,
	AR_TRANSFER_SEQ                            NUMBER,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_FBS_CASH_TRANS_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_FBS_CASH_TRANS ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_AUTO_FBS_CASH_TRANS
	(
		SEQ,
		TRANSFER_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_SEQ,
		AR_TRANSFER_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_AUTO_FBS_CASH_TRANS_U
(
	AR_SEQ                                     NUMBER,
	AR_TRANSFER_SEQ                            NUMBER,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_FBS_CASH_TRANS_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_FBS_CASH_TRANS ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_AUTO_FBS_CASH_TRANS
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	SEQ = AR_SEQ
	And	TRANSFER_SEQ = AR_TRANSFER_SEQ;
End;
/
Create Or Replace Procedure SP_T_AUTO_FBS_CASH_TRANS_D
(
	AR_SEQ                                     NUMBER,
	AR_TRANSFER_SEQ                            NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_FBS_CASH_TRANS_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_FBS_CASH_TRANS ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_AUTO_FBS_CASH_TRANS
	Where	SEQ = AR_SEQ
	And	TRANSFER_SEQ = AR_TRANSFER_SEQ;
End;
/
