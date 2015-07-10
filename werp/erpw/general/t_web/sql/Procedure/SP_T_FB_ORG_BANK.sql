Create Or Replace Procedure SP_T_FB_ORG_BANK_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_TRAN_CODE                               VARCHAR2,
	AR_ENTE_CODE                               VARCHAR2,
	AR_BILL_ENTE_CODE                          VARCHAR2,
	AR_BANK_EDI_LOGIN_ID                       VARCHAR2,
	AR_VENDOR_SUBJECT_NAME                     VARCHAR2,
	AR_CASH_SEND_SUBJECT_NAME                  VARCHAR2,
	AR_CASH_RECV_SUBJECT_NAME                  VARCHAR2,
	AR_BILL_SEND_SUBJECT_NAME                  VARCHAR2,
	AR_BILL_RECV_SUBJECT_NAME                  VARCHAR2,
	AR_CREATION_DATE                           VARCHAR2,
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_LAST_MODIFY_DATE                        VARCHAR2,
	AR_LAST_MODIFY_EMP_NO                      VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2,
	AR_ATTRIBUTE3                              VARCHAR2,
	AR_COMP_PASSWORD                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_ORG_BANK_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_ORG_BANK ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FB_ORG_BANK
	(
		COMP_CODE,
		BANK_MAIN_CODE,
		TRAN_CODE,
		ENTE_CODE,
		BILL_ENTE_CODE,
		BANK_EDI_LOGIN_ID,
		VENDOR_SUBJECT_NAME,
		CASH_SEND_SUBJECT_NAME,
		CASH_RECV_SUBJECT_NAME,
		BILL_SEND_SUBJECT_NAME,
		BILL_RECV_SUBJECT_NAME,
		CREATION_DATE,
		CREATION_EMP_NO,
		LAST_MODIFY_DATE,
		LAST_MODIFY_EMP_NO,
		ATTRIBUTE1,
		ATTRIBUTE2,
		ATTRIBUTE3,
		COMP_PASSWORD
	)
	Values
	(
		AR_COMP_CODE,
		AR_BANK_MAIN_CODE,
		AR_TRAN_CODE,
		AR_ENTE_CODE,
		AR_BILL_ENTE_CODE,
		AR_BANK_EDI_LOGIN_ID,
		AR_VENDOR_SUBJECT_NAME,
		AR_CASH_SEND_SUBJECT_NAME,
		AR_CASH_RECV_SUBJECT_NAME,
		AR_BILL_SEND_SUBJECT_NAME,
		AR_BILL_RECV_SUBJECT_NAME,
		SysDate,
		AR_CREATION_EMP_NO,
		Null,
		Null,
		AR_ATTRIBUTE1,
		AR_ATTRIBUTE2,
		AR_ATTRIBUTE3,
		AR_COMP_PASSWORD
	);
End;
/
Create Or Replace Procedure SP_T_FB_ORG_BANK_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_TRAN_CODE                               VARCHAR2,
	AR_ENTE_CODE                               VARCHAR2,
	AR_BILL_ENTE_CODE                          VARCHAR2,
	AR_BANK_EDI_LOGIN_ID                       VARCHAR2,
	AR_VENDOR_SUBJECT_NAME                     VARCHAR2,
	AR_CASH_SEND_SUBJECT_NAME                  VARCHAR2,
	AR_CASH_RECV_SUBJECT_NAME                  VARCHAR2,
	AR_BILL_SEND_SUBJECT_NAME                  VARCHAR2,
	AR_BILL_RECV_SUBJECT_NAME                  VARCHAR2,
	AR_CREATION_DATE                           VARCHAR2,
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_LAST_MODIFY_DATE                        VARCHAR2,
	AR_LAST_MODIFY_EMP_NO                      VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2,
	AR_ATTRIBUTE3                              VARCHAR2,
	AR_COMP_PASSWORD                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_ORG_BANK_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_ORG_BANK ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FB_ORG_BANK
	Set
		TRAN_CODE = AR_TRAN_CODE,
		ENTE_CODE = AR_ENTE_CODE,
		BILL_ENTE_CODE = AR_BILL_ENTE_CODE,
		BANK_EDI_LOGIN_ID = AR_BANK_EDI_LOGIN_ID,
		VENDOR_SUBJECT_NAME = AR_VENDOR_SUBJECT_NAME,
		CASH_SEND_SUBJECT_NAME = AR_CASH_SEND_SUBJECT_NAME,
		CASH_RECV_SUBJECT_NAME = AR_CASH_RECV_SUBJECT_NAME,
		BILL_SEND_SUBJECT_NAME = AR_BILL_SEND_SUBJECT_NAME,
		BILL_RECV_SUBJECT_NAME = AR_BILL_RECV_SUBJECT_NAME,
		LAST_MODIFY_DATE = SysDate,
		LAST_MODIFY_EMP_NO = AR_LAST_MODIFY_EMP_NO,
		ATTRIBUTE1 = AR_ATTRIBUTE1,
		ATTRIBUTE2 = AR_ATTRIBUTE2,
		ATTRIBUTE3 = AR_ATTRIBUTE3,
		COMP_PASSWORD = AR_COMP_PASSWORD
	Where	COMP_CODE = AR_COMP_CODE
	And	BANK_MAIN_CODE = AR_BANK_MAIN_CODE;
End;
/
Create Or Replace Procedure SP_T_FB_ORG_BANK_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_ORG_BANK_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_ORG_BANK ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FB_ORG_BANK
	Where	COMP_CODE = AR_COMP_CODE
	And	BANK_MAIN_CODE = AR_BANK_MAIN_CODE;
End;
/
