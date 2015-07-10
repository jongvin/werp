Create Or Replace Procedure SP_T_FIN_LOAN_KIND_I
(
	AR_LOAN_KIND_CODE                          VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_LOAN_KIND_NAME                          VARCHAR2,
	AR_LOAN_ACC_CODE                           VARCHAR2,
	AR_ITR_ACC_CODE                            VARCHAR2,
	AR_PE_ITR_ACC_CODE                         VARCHAR2,
	AR_AE_ITR_ACC_CODE                         VARCHAR2,
	AR_LOAN_TAG                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_LOAN_KIND_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_LOAN_KIND ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-20)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_LOAN_KIND
	(
		LOAN_KIND_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		LOAN_KIND_NAME,
		LOAN_ACC_CODE,
		ITR_ACC_CODE,
		PE_ITR_ACC_CODE,
		AE_ITR_ACC_CODE,
		LOAN_TAG
	)
	Values
	(
		AR_LOAN_KIND_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_LOAN_KIND_NAME,
		AR_LOAN_ACC_CODE,
		AR_ITR_ACC_CODE,
		AR_PE_ITR_ACC_CODE,
		AR_AE_ITR_ACC_CODE,
		AR_LOAN_TAG
	);
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_KIND_U
(
	AR_LOAN_KIND_CODE                          VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_LOAN_KIND_NAME                          VARCHAR2,
	AR_LOAN_ACC_CODE                           VARCHAR2,
	AR_ITR_ACC_CODE                            VARCHAR2,
	AR_PE_ITR_ACC_CODE                         VARCHAR2,
	AR_AE_ITR_ACC_CODE                         VARCHAR2,
	AR_LOAN_TAG                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_LOAN_KIND_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_LOAN_KIND ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-20)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIN_LOAN_KIND
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		LOAN_KIND_NAME = AR_LOAN_KIND_NAME,
		LOAN_ACC_CODE = AR_LOAN_ACC_CODE,
		ITR_ACC_CODE = AR_ITR_ACC_CODE,
		PE_ITR_ACC_CODE = AR_PE_ITR_ACC_CODE,
		AE_ITR_ACC_CODE = AR_AE_ITR_ACC_CODE,
		LOAN_TAG = AR_LOAN_TAG
	Where	LOAN_KIND_CODE = AR_LOAN_KIND_CODE;
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_KIND_D
(
	AR_LOAN_KIND_CODE                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_LOAN_KIND_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_LOAN_KIND ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-20)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lnCnt			Number;
Begin
	Select
		Count(*)
	Into
		lnCnt
	From	T_FIN_BILL_KIND
	Where	REL_LOAN_KIND_CODE = AR_LOAN_KIND_CODE;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'�ش� ���������ڵ�� ������ �ִ� ���޾��� ������ �����Ƿ� ������ �Ұ��� �մϴ�.');
	End If;
	Delete T_FIN_LOAN_KIND
	Where	LOAN_KIND_CODE = AR_LOAN_KIND_CODE;
End;
/
