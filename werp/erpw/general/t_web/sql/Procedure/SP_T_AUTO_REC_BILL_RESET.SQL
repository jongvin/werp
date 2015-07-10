Create Or Replace Procedure SP_T_AUTO_REC_BILL_RESET_I
(
	AR_AUTO_REC_BILL_RESET_SEQ                   NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_RESET_AMT                               NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_REC_BILL_RESET_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_REC_BILL_RESET ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-31)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_AUTO_REC_BILL_RESET
	(
		AUTO_REC_BILL_RESET_SEQ,
		SLIP_ID,
		SLIP_IDSEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		RESET_AMT
	)
	Values
	(
		AR_AUTO_REC_BILL_RESET_SEQ,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_RESET_AMT
	);
End;
/
Create Or Replace Procedure SP_T_AUTO_REC_BILL_RESET_U
(
	AR_AUTO_REC_BILL_RESET_SEQ                   NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_RESET_AMT                               NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_REC_BILL_RESET_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_REC_BILL_RESET ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-31)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_AUTO_REC_BILL_RESET
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		RESET_AMT = AR_RESET_AMT
	Where	AUTO_REC_BILL_RESET_SEQ = AR_AUTO_REC_BILL_RESET_SEQ
	And	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
End;
/
Create Or Replace Procedure SP_T_AUTO_REC_BILL_RESET_D
(
	AR_AUTO_REC_BILL_RESET_SEQ                   NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_REC_BILL_RESET_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_REC_BILL_RESET ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-31)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_AUTO_REC_BILL_RESET
	Where	AUTO_REC_BILL_RESET_SEQ = AR_AUTO_REC_BILL_RESET_SEQ
	And	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
End;
/