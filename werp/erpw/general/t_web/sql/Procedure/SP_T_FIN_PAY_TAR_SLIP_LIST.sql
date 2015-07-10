Create Or Replace Procedure SP_T_FIN_PAY_TAR_SLIP_LIST_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_TARGET_SLIP_ID                          NUMBER,
	AR_TARGET_SLIP_IDSEQ                       NUMBER,
	AR_CUST_SEQ                                NUMBER,
	AR_CUST_NAME                               VARCHAR2,
	AR_SET_AMT                                 NUMBER,
	AR_PRE_RESET_AMT                           NUMBER,
	AR_EXCEPT_AMT                              NUMBER,
	AR_C_RATIO                                 NUMBER,
	AR_B_RATIO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_TAR_SLIP_LIST_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_TARGET_SLIP_LIST ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_PAY_TARGET_SLIP_LIST
	(
		COMP_CODE,
		WORK_DT,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE,
		TARGET_SLIP_ID,
		TARGET_SLIP_IDSEQ,
		CUST_SEQ,
		CUST_NAME,
		SET_AMT,
		PRE_RESET_AMT,
		EXCEPT_AMT,
		C_RATIO,
		B_RATIO
	)
	Values
	(
		AR_COMP_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_CODE,
		AR_TARGET_SLIP_ID,
		AR_TARGET_SLIP_IDSEQ,
		AR_CUST_SEQ,
		AR_CUST_NAME,
		AR_SET_AMT,
		AR_PRE_RESET_AMT,
		AR_EXCEPT_AMT,
		AR_C_RATIO,
		AR_B_RATIO
	);
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_TAR_SLIP_LIST_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_TARGET_SLIP_ID                          NUMBER,
	AR_TARGET_SLIP_IDSEQ                       NUMBER,
	AR_CUST_SEQ                                NUMBER,
	AR_CUST_NAME                               VARCHAR2,
	AR_SET_AMT                                 NUMBER,
	AR_PRE_RESET_AMT                           NUMBER,
	AR_EXCEPT_AMT                              NUMBER,
	AR_C_RATIO                                 NUMBER,
	AR_B_RATIO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_TAR_SLIP_LIST_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_TARGET_SLIP_LIST ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIN_PAY_TARGET_SLIP_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_CODE = AR_ACC_CODE,
		TARGET_SLIP_ID = AR_TARGET_SLIP_ID,
		TARGET_SLIP_IDSEQ = AR_TARGET_SLIP_IDSEQ,
		CUST_SEQ = AR_CUST_SEQ,
		CUST_NAME = AR_CUST_NAME,
		SET_AMT = AR_SET_AMT,
		PRE_RESET_AMT = AR_PRE_RESET_AMT,
		EXCEPT_AMT = AR_EXCEPT_AMT,
		C_RATIO = AR_C_RATIO,
		B_RATIO = AR_B_RATIO
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT)
	And	SEQ = AR_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_TAR_SLIP_LIST_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_SEQ                                     NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_TAR_SLIP_LIST_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_TARGET_SLIP_LIST ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIN_PAY_TARGET_SLIP_LIST
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT)
	And	SEQ = AR_SEQ;
End;
/
