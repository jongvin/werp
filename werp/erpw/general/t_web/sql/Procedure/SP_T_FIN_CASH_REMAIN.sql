Create Or Replace Procedure SP_T_FIN_CASH_REMAIN_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CASH_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_UNIT_COST                               NUMBER,
	AR_QTY                                     NUMBER,
	AR_AMT                                     NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_CASH_REMAIN_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_CASH_REMAIN ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-08)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_CASH_REMAIN
	(
		COMP_CODE,
		WORK_DT,
		CASH_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		UNIT_COST,
		QTY,
		AMT
	)
	Values
	(
		AR_COMP_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_CASH_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_UNIT_COST,
		AR_QTY,
		AR_AMT
	);
End;
/
Create Or Replace Procedure SP_T_FIN_CASH_REMAIN_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CASH_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_UNIT_COST                               NUMBER,
	AR_QTY                                     NUMBER,
	AR_AMT                                     NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_CASH_REMAIN_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_CASH_REMAIN ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-08)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_CASH_REMAIN
	(
		COMP_CODE,
		WORK_DT,
		CASH_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		UNIT_COST,
		QTY,
		AMT
	)
	Values
	(
		AR_COMP_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_CASH_CODE,
		AR_MODUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_UNIT_COST,
		AR_QTY,
		AR_AMT
	);
Exception When Dup_Val_On_Index Then
	Update T_FIN_CASH_REMAIN
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		UNIT_COST = AR_UNIT_COST,
		QTY = AR_QTY,
		AMT = AR_AMT
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT)
	And	CASH_CODE = AR_CASH_CODE;
End;
/
Create Or Replace Procedure SP_T_FIN_CASH_REMAIN_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CASH_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_CASH_REMAIN_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_CASH_REMAIN ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-08)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIN_CASH_REMAIN
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT)
	And	CASH_CODE = AR_CASH_CODE;
End;
/
