Create Or Replace Procedure SP_T_FIN_BILL_KIND_I
(
	AR_BILL_KIND                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BILL_NAME                               VARCHAR2,
	AR_REL_LOAN_KIND_CODE                      VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_BILL_KIND_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_BILL_KIND ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_BILL_KIND
	(
		BILL_KIND,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BILL_NAME,
		REL_LOAN_KIND_CODE
	)
	Values
	(
		AR_BILL_KIND,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BILL_NAME,
		AR_REL_LOAN_KIND_CODE
	);
End;
/
Create Or Replace Procedure SP_T_FIN_BILL_KIND_U
(
	AR_BILL_KIND                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_BILL_NAME                               VARCHAR2,
	AR_REL_LOAN_KIND_CODE                      VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_BILL_KIND_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_BILL_KIND ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIN_BILL_KIND
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BILL_NAME = AR_BILL_NAME,
		REL_LOAN_KIND_CODE = AR_REL_LOAN_KIND_CODE
	Where	BILL_KIND = AR_BILL_KIND;
End;
/
Create Or Replace Procedure SP_T_FIN_BILL_KIND_D
(
	AR_BILL_KIND                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_BILL_KIND_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_BILL_KIND ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete	T_FIN_BILL_ACC_CODE
	Where	BILL_KIND = AR_BILL_KIND;
	Delete	T_FIN_BILL_KIND
	Where	BILL_KIND = AR_BILL_KIND;
End;
/
