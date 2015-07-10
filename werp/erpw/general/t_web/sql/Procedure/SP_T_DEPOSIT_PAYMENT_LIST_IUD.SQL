Create Or Replace Procedure SP_T_DEPOSIT_PAYMENT_LIST_I
(
	AR_ACCNO                                   VARCHAR2,
	AR_PAYMENT_SEQ                             NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_PAYMENT_SCH_DT                          VARCHAR2,
	AR_PAYMENT_SCH_AMT                         NUMBER,
	AR_ACC_CODE                                VARCHAR2,
	AR_PAYMENT_DT                              VARCHAR2,
	AR_PAYMENT_AMT                             NUMBER,
	AR_INTR_AMT                                NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPOSIT_PAYMENT_LIST_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPOSIT_PAYMENT_LIST ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-12-20)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_DEPOSIT_PAYMENT_LIST
	(
		ACCNO,
		PAYMENT_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		PAYMENT_SCH_DT,
		PAYMENT_SCH_AMT,
		ACC_CODE,
		PAYMENT_DT,
		PAYMENT_AMT,
		INTR_AMT,
		SLIP_ID,
		SLIP_IDSEQ
	)
	Values
	(
		AR_ACCNO,
		AR_PAYMENT_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_PAYMENT_SCH_DT),
		AR_PAYMENT_SCH_AMT,
		AR_ACC_CODE,
		F_T_StringToDate(AR_PAYMENT_DT),
		AR_PAYMENT_AMT,
		AR_INTR_AMT,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ
	);
End;
/
Create Or Replace Procedure SP_T_DEPOSIT_PAYMENT_LIST_U
(
	AR_ACCNO                                   VARCHAR2,
	AR_PAYMENT_SEQ                             NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_PAYMENT_SCH_DT                          VARCHAR2,
	AR_PAYMENT_SCH_AMT                         NUMBER,
	AR_ACC_CODE                                VARCHAR2,
	AR_PAYMENT_DT                              VARCHAR2,
	AR_PAYMENT_AMT                             NUMBER,
	AR_INTR_AMT                                NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPOSIT_PAYMENT_LIST_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPOSIT_PAYMENT_LIST ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-12-20)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_DEPOSIT_PAYMENT_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		PAYMENT_SCH_DT = F_T_StringToDate(AR_PAYMENT_SCH_DT),
		PAYMENT_SCH_AMT = AR_PAYMENT_SCH_AMT,
		ACC_CODE = AR_ACC_CODE,
		PAYMENT_DT = F_T_StringToDate(AR_PAYMENT_DT),
		PAYMENT_AMT = AR_PAYMENT_AMT,
		INTR_AMT = AR_INTR_AMT,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ
	Where	ACCNO = AR_ACCNO
	And	PAYMENT_SEQ = AR_PAYMENT_SEQ;
End;
/
Create Or Replace Procedure SP_T_DEPOSIT_PAYMENT_LIST_D
(
	AR_ACCNO                                   VARCHAR2,
	AR_PAYMENT_SEQ                             NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DEPOSIT_PAYMENT_LIST_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DEPOSIT_PAYMENT_LIST ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-12-20)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_DEPOSIT_PAYMENT_LIST
	Where	ACCNO = AR_ACCNO
	And	PAYMENT_SEQ = AR_PAYMENT_SEQ;
End;
/