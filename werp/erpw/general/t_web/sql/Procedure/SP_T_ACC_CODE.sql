Create Or Replace Procedure SP_T_ACC_CODE_I
(
	AR_ACC_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_SHRT_NAME                           VARCHAR2,
	AR_ACC_NAME                                VARCHAR2,
	AR_SHRT_CODE                               VARCHAR2,
	AR_COMPUTER_ACC                            VARCHAR2,
	AR_ACC_GRP                                 VARCHAR2,
	AR_ACC_LVL                                 VARCHAR2,
	AR_ACC_REMAIN_POSITION                     VARCHAR2,
	AR_FUND_INPUT_CLS                          VARCHAR2,
	AR_ACC_REMAIN_MNG                          VARCHAR2,
	AR_SUMMARY_CLS                             VARCHAR2,
	AR_CUST_CODE_MNG                           VARCHAR2,
	AR_CUST_CODE_MNG_TG                        VARCHAR2,
	AR_CUST_NAME_MNG                           VARCHAR2,
	AR_CUST_NAME_MNG_TG                        VARCHAR2,
	AR_BUDG_MNG                                VARCHAR2,
	AR_BUDG_EXEC_CLS                           VARCHAR2,
	AR_BANK_MNG                                VARCHAR2,
	AR_BANK_MNG_TG                             VARCHAR2,
	AR_ACCNO_MNG                               VARCHAR2,
	AR_ACCNO_MNG_TG                            VARCHAR2,
	AR_CHK_NO_MNG                              VARCHAR2,
	AR_CHK_NO_MNG_TG                           VARCHAR2,
	AR_BILL_NO_MNG                             VARCHAR2,
	AR_BILL_NO_MNG_TG                          VARCHAR2,
	AR_REC_BILL_NO_MNG                         VARCHAR2,
	AR_REC_BILL_NO_MNG_TG                      VARCHAR2,
	AR_CP_NO_MNG                               VARCHAR2,
	AR_CP_NO_MNG_TG                            VARCHAR2,
	AR_SECU_MNG                                VARCHAR2,
	AR_SECU_MNG_TG                             VARCHAR2,
	AR_LOAN_NO_MNG                             VARCHAR2,
	AR_LOAN_NO_MNG_TG                          VARCHAR2,
	AR_FIXED_MNG                               VARCHAR2,
	AR_FIXED_MNG_TG                            VARCHAR2,
	AR_DEPOSIT_PAY_MNG                         VARCHAR2,
	AR_DEPOSIT_PAY_MNG_TG                      VARCHAR2,
	AR_PAY_CON_MNG                             VARCHAR2,
	AR_PAY_CON_MNG_TG                          VARCHAR2,
	AR_BILL_EXPR_MNG                           VARCHAR2,
	AR_BILL_EXPR_MNG_TG                        VARCHAR2,
	AR_ANTICIPATION_DT_MNG                     VARCHAR2,
	AR_ANTICIPATION_DT_MNG_TG                  VARCHAR2,
	AR_EMP_NO_MNG                              VARCHAR2,
	AR_EMP_NO_MNG_TG                           VARCHAR2,
	AR_MNG_NAME_CHAR1                          VARCHAR2,
	AR_MNG_TG_CHAR1                            VARCHAR2,
	AR_MNG_NAME_CHAR2                          VARCHAR2,
	AR_MNG_TG_CHAR2                            VARCHAR2,
	AR_MNG_NAME_CHAR3                          VARCHAR2,
	AR_MNG_TG_CHAR3                            VARCHAR2,
	AR_MNG_NAME_CHAR4                          VARCHAR2,
	AR_MNG_TG_CHAR4                            VARCHAR2,
	AR_MNG_NAME_NUM1                           VARCHAR2,
	AR_MNG_TG_NUM1                             VARCHAR2,
	AR_MNG_NAME_NUM2                           VARCHAR2,
	AR_MNG_TG_NUM2                             VARCHAR2,
	AR_MNG_NAME_NUM3                           VARCHAR2,
	AR_MNG_TG_NUM3                             VARCHAR2,
	AR_MNG_NAME_NUM4                           VARCHAR2,
	AR_MNG_TG_NUM4                             VARCHAR2,
	AR_MNG_NAME_DT1                            VARCHAR2,
	AR_MNG_TG_DT1                              VARCHAR2,
	AR_MNG_NAME_DT2                            VARCHAR2,
	AR_MNG_TG_DT2                              VARCHAR2,
	AR_MNG_NAME_DT3                            VARCHAR2,
	AR_MNG_TG_DT3                              VARCHAR2,
	AR_MNG_NAME_DT4                            VARCHAR2,
	AR_MNG_TG_DT4                              VARCHAR2,
	AR_PRINT_SHEET_TAG                         VARCHAR2,
	AR_CARD_SEQ_MNG                            VARCHAR2,
	AR_CARD_SEQ_MNG_TG                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_ACC_CODE
	(
		ACC_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_SHRT_NAME,
		ACC_NAME,
		SHRT_CODE,
		COMPUTER_ACC,
		ACC_GRP,
		ACC_LVL,
		ACC_REMAIN_POSITION,
		FUND_INPUT_CLS,
		ACC_REMAIN_MNG,
		SUMMARY_CLS,
		CUST_CODE_MNG,
		CUST_CODE_MNG_TG,
		CUST_NAME_MNG,
		CUST_NAME_MNG_TG,
		BUDG_MNG,
		BUDG_EXEC_CLS,
		BANK_MNG,
		BANK_MNG_TG,
		ACCNO_MNG,
		ACCNO_MNG_TG,
		CHK_NO_MNG,
		CHK_NO_MNG_TG,
		BILL_NO_MNG,
		BILL_NO_MNG_TG,
		REC_BILL_NO_MNG,
		REC_BILL_NO_MNG_TG,
		CP_NO_MNG,
		CP_NO_MNG_TG,
		SECU_MNG,
		SECU_MNG_TG,
		LOAN_NO_MNG,
		LOAN_NO_MNG_TG,
		FIXED_MNG,
		FIXED_MNG_TG,
		DEPOSIT_PAY_MNG,
		DEPOSIT_PAY_MNG_TG,
		PAY_CON_MNG,
		PAY_CON_MNG_TG,
		BILL_EXPR_MNG,
		BILL_EXPR_MNG_TG,
		ANTICIPATION_DT_MNG,
		ANTICIPATION_DT_MNG_TG,
		EMP_NO_MNG,
		EMP_NO_MNG_TG,
		MNG_NAME_CHAR1,
		MNG_TG_CHAR1,
		MNG_NAME_CHAR2,
		MNG_TG_CHAR2,
		MNG_NAME_CHAR3,
		MNG_TG_CHAR3,
		MNG_NAME_CHAR4,
		MNG_TG_CHAR4,
		MNG_NAME_NUM1,
		MNG_TG_NUM1,
		MNG_NAME_NUM2,
		MNG_TG_NUM2,
		MNG_NAME_NUM3,
		MNG_TG_NUM3,
		MNG_NAME_NUM4,
		MNG_TG_NUM4,
		MNG_NAME_DT1,
		MNG_TG_DT1,
		MNG_NAME_DT2,
		MNG_TG_DT2,
		MNG_NAME_DT3,
		MNG_TG_DT3,
		MNG_NAME_DT4,
		MNG_TG_DT4,
		PRINT_SHEET_TAG,
		CARD_SEQ_MNG,
		CARD_SEQ_MNG_TG
	)
	Values
	(
		AR_ACC_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_SHRT_NAME,
		AR_ACC_NAME,
		AR_SHRT_CODE,
		AR_COMPUTER_ACC,
		AR_ACC_GRP,
		AR_ACC_LVL,
		AR_ACC_REMAIN_POSITION,
		AR_FUND_INPUT_CLS,
		AR_ACC_REMAIN_MNG,
		AR_SUMMARY_CLS,
		AR_CUST_CODE_MNG,
		AR_CUST_CODE_MNG_TG,
		AR_CUST_NAME_MNG,
		AR_CUST_NAME_MNG_TG,
		AR_BUDG_MNG,
		AR_BUDG_EXEC_CLS,
		AR_BANK_MNG,
		AR_BANK_MNG_TG,
		AR_ACCNO_MNG,
		AR_ACCNO_MNG_TG,
		AR_CHK_NO_MNG,
		AR_CHK_NO_MNG_TG,
		AR_BILL_NO_MNG,
		AR_BILL_NO_MNG_TG,
		AR_REC_BILL_NO_MNG,
		AR_REC_BILL_NO_MNG_TG,
		AR_CP_NO_MNG,
		AR_CP_NO_MNG_TG,
		AR_SECU_MNG,
		AR_SECU_MNG_TG,
		AR_LOAN_NO_MNG,
		AR_LOAN_NO_MNG_TG,
		AR_FIXED_MNG,
		AR_FIXED_MNG_TG,
		AR_DEPOSIT_PAY_MNG,
		AR_DEPOSIT_PAY_MNG_TG,
		AR_PAY_CON_MNG,
		AR_PAY_CON_MNG_TG,
		AR_BILL_EXPR_MNG,
		AR_BILL_EXPR_MNG_TG,
		AR_ANTICIPATION_DT_MNG,
		AR_ANTICIPATION_DT_MNG_TG,
		AR_EMP_NO_MNG,
		AR_EMP_NO_MNG_TG,
		AR_MNG_NAME_CHAR1,
		AR_MNG_TG_CHAR1,
		AR_MNG_NAME_CHAR2,
		AR_MNG_TG_CHAR2,
		AR_MNG_NAME_CHAR3,
		AR_MNG_TG_CHAR3,
		AR_MNG_NAME_CHAR4,
		AR_MNG_TG_CHAR4,
		AR_MNG_NAME_NUM1,
		AR_MNG_TG_NUM1,
		AR_MNG_NAME_NUM2,
		AR_MNG_TG_NUM2,
		AR_MNG_NAME_NUM3,
		AR_MNG_TG_NUM3,
		AR_MNG_NAME_NUM4,
		AR_MNG_TG_NUM4,
		AR_MNG_NAME_DT1,
		AR_MNG_TG_DT1,
		AR_MNG_NAME_DT2,
		AR_MNG_TG_DT2,
		AR_MNG_NAME_DT3,
		AR_MNG_TG_DT3,
		AR_MNG_NAME_DT4,
		AR_MNG_TG_DT4,
		AR_PRINT_SHEET_TAG,
		AR_CARD_SEQ_MNG,
		AR_CARD_SEQ_MNG_TG
	);
End;
/
Create Or Replace Procedure SP_T_ACC_CODE_U
(
	AR_ACC_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_SHRT_NAME                           VARCHAR2,
	AR_ACC_NAME                                VARCHAR2,
	AR_SHRT_CODE                               VARCHAR2,
	AR_COMPUTER_ACC                            VARCHAR2,
	AR_ACC_GRP                                 VARCHAR2,
	AR_ACC_LVL                                 VARCHAR2,
	AR_ACC_REMAIN_POSITION                     VARCHAR2,
	AR_FUND_INPUT_CLS                          VARCHAR2,
	AR_ACC_REMAIN_MNG                          VARCHAR2,
	AR_SUMMARY_CLS                             VARCHAR2,
	AR_CUST_CODE_MNG                           VARCHAR2,
	AR_CUST_CODE_MNG_TG                        VARCHAR2,
	AR_CUST_NAME_MNG                           VARCHAR2,
	AR_CUST_NAME_MNG_TG                        VARCHAR2,
	AR_BUDG_MNG                                VARCHAR2,
	AR_BUDG_EXEC_CLS                           VARCHAR2,
	AR_BANK_MNG                                VARCHAR2,
	AR_BANK_MNG_TG                             VARCHAR2,
	AR_ACCNO_MNG                               VARCHAR2,
	AR_ACCNO_MNG_TG                            VARCHAR2,
	AR_CHK_NO_MNG                              VARCHAR2,
	AR_CHK_NO_MNG_TG                           VARCHAR2,
	AR_BILL_NO_MNG                             VARCHAR2,
	AR_BILL_NO_MNG_TG                          VARCHAR2,
	AR_REC_BILL_NO_MNG                         VARCHAR2,
	AR_REC_BILL_NO_MNG_TG                      VARCHAR2,
	AR_CP_NO_MNG                               VARCHAR2,
	AR_CP_NO_MNG_TG                            VARCHAR2,
	AR_SECU_MNG                                VARCHAR2,
	AR_SECU_MNG_TG                             VARCHAR2,
	AR_LOAN_NO_MNG                             VARCHAR2,
	AR_LOAN_NO_MNG_TG                          VARCHAR2,
	AR_FIXED_MNG                               VARCHAR2,
	AR_FIXED_MNG_TG                            VARCHAR2,
	AR_DEPOSIT_PAY_MNG                         VARCHAR2,
	AR_DEPOSIT_PAY_MNG_TG                      VARCHAR2,
	AR_PAY_CON_MNG                             VARCHAR2,
	AR_PAY_CON_MNG_TG                          VARCHAR2,
	AR_BILL_EXPR_MNG                           VARCHAR2,
	AR_BILL_EXPR_MNG_TG                        VARCHAR2,
	AR_ANTICIPATION_DT_MNG                     VARCHAR2,
	AR_ANTICIPATION_DT_MNG_TG                  VARCHAR2,
	AR_EMP_NO_MNG                              VARCHAR2,
	AR_EMP_NO_MNG_TG                           VARCHAR2,
	AR_MNG_NAME_CHAR1                          VARCHAR2,
	AR_MNG_TG_CHAR1                            VARCHAR2,
	AR_MNG_NAME_CHAR2                          VARCHAR2,
	AR_MNG_TG_CHAR2                            VARCHAR2,
	AR_MNG_NAME_CHAR3                          VARCHAR2,
	AR_MNG_TG_CHAR3                            VARCHAR2,
	AR_MNG_NAME_CHAR4                          VARCHAR2,
	AR_MNG_TG_CHAR4                            VARCHAR2,
	AR_MNG_NAME_NUM1                           VARCHAR2,
	AR_MNG_TG_NUM1                             VARCHAR2,
	AR_MNG_NAME_NUM2                           VARCHAR2,
	AR_MNG_TG_NUM2                             VARCHAR2,
	AR_MNG_NAME_NUM3                           VARCHAR2,
	AR_MNG_TG_NUM3                             VARCHAR2,
	AR_MNG_NAME_NUM4                           VARCHAR2,
	AR_MNG_TG_NUM4                             VARCHAR2,
	AR_MNG_NAME_DT1                            VARCHAR2,
	AR_MNG_TG_DT1                              VARCHAR2,
	AR_MNG_NAME_DT2                            VARCHAR2,
	AR_MNG_TG_DT2                              VARCHAR2,
	AR_MNG_NAME_DT3                            VARCHAR2,
	AR_MNG_TG_DT3                              VARCHAR2,
	AR_MNG_NAME_DT4                            VARCHAR2,
	AR_MNG_TG_DT4                              VARCHAR2,
	AR_PRINT_SHEET_TAG                         VARCHAR2,
	AR_CARD_SEQ_MNG                            VARCHAR2,
	AR_CARD_SEQ_MNG_TG                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_CODE ���̺� Update
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_ACC_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_SHRT_NAME = AR_ACC_SHRT_NAME,
		ACC_NAME = AR_ACC_NAME,
		SHRT_CODE = AR_SHRT_CODE,
		COMPUTER_ACC = AR_COMPUTER_ACC,
		ACC_GRP = AR_ACC_GRP,
		ACC_LVL = AR_ACC_LVL,
		ACC_REMAIN_POSITION = AR_ACC_REMAIN_POSITION,
		FUND_INPUT_CLS = AR_FUND_INPUT_CLS,
		ACC_REMAIN_MNG = AR_ACC_REMAIN_MNG,
		SUMMARY_CLS = AR_SUMMARY_CLS,
		CUST_CODE_MNG = AR_CUST_CODE_MNG,
		CUST_CODE_MNG_TG = AR_CUST_CODE_MNG_TG,
		CUST_NAME_MNG = AR_CUST_NAME_MNG,
		CUST_NAME_MNG_TG = AR_CUST_NAME_MNG_TG,
		BUDG_MNG = AR_BUDG_MNG,
		BUDG_EXEC_CLS = AR_BUDG_EXEC_CLS,
		BANK_MNG = AR_BANK_MNG,
		BANK_MNG_TG = AR_BANK_MNG_TG,
		ACCNO_MNG = AR_ACCNO_MNG,
		ACCNO_MNG_TG = AR_ACCNO_MNG_TG,
		CHK_NO_MNG = AR_CHK_NO_MNG,
		CHK_NO_MNG_TG = AR_CHK_NO_MNG_TG,
		BILL_NO_MNG = AR_BILL_NO_MNG,
		BILL_NO_MNG_TG = AR_BILL_NO_MNG_TG,
		REC_BILL_NO_MNG = AR_REC_BILL_NO_MNG,
		REC_BILL_NO_MNG_TG = AR_REC_BILL_NO_MNG_TG,
		CP_NO_MNG = AR_CP_NO_MNG,
		CP_NO_MNG_TG = AR_CP_NO_MNG_TG,
		SECU_MNG = AR_SECU_MNG,
		SECU_MNG_TG = AR_SECU_MNG_TG,
		LOAN_NO_MNG = AR_LOAN_NO_MNG,
		LOAN_NO_MNG_TG = AR_LOAN_NO_MNG_TG,
		FIXED_MNG = AR_FIXED_MNG,
		FIXED_MNG_TG = AR_FIXED_MNG_TG,
		DEPOSIT_PAY_MNG = AR_DEPOSIT_PAY_MNG,
		DEPOSIT_PAY_MNG_TG = AR_DEPOSIT_PAY_MNG_TG,
		PAY_CON_MNG = AR_PAY_CON_MNG,
		PAY_CON_MNG_TG = AR_PAY_CON_MNG_TG,
		BILL_EXPR_MNG = AR_BILL_EXPR_MNG,
		BILL_EXPR_MNG_TG = AR_BILL_EXPR_MNG_TG,
		ANTICIPATION_DT_MNG = AR_ANTICIPATION_DT_MNG,
		ANTICIPATION_DT_MNG_TG = AR_ANTICIPATION_DT_MNG_TG,
		EMP_NO_MNG = AR_EMP_NO_MNG,
		EMP_NO_MNG_TG = AR_EMP_NO_MNG_TG,
		MNG_NAME_CHAR1 = AR_MNG_NAME_CHAR1,
		MNG_TG_CHAR1 = AR_MNG_TG_CHAR1,
		MNG_NAME_CHAR2 = AR_MNG_NAME_CHAR2,
		MNG_TG_CHAR2 = AR_MNG_TG_CHAR2,
		MNG_NAME_CHAR3 = AR_MNG_NAME_CHAR3,
		MNG_TG_CHAR3 = AR_MNG_TG_CHAR3,
		MNG_NAME_CHAR4 = AR_MNG_NAME_CHAR4,
		MNG_TG_CHAR4 = AR_MNG_TG_CHAR4,
		MNG_NAME_NUM1 = AR_MNG_NAME_NUM1,
		MNG_TG_NUM1 = AR_MNG_TG_NUM1,
		MNG_NAME_NUM2 = AR_MNG_NAME_NUM2,
		MNG_TG_NUM2 = AR_MNG_TG_NUM2,
		MNG_NAME_NUM3 = AR_MNG_NAME_NUM3,
		MNG_TG_NUM3 = AR_MNG_TG_NUM3,
		MNG_NAME_NUM4 = AR_MNG_NAME_NUM4,
		MNG_TG_NUM4 = AR_MNG_TG_NUM4,
		MNG_NAME_DT1 = AR_MNG_NAME_DT1,
		MNG_TG_DT1 = AR_MNG_TG_DT1,
		MNG_NAME_DT2 = AR_MNG_NAME_DT2,
		MNG_TG_DT2 = AR_MNG_TG_DT2,
		MNG_NAME_DT3 = AR_MNG_NAME_DT3,
		MNG_TG_DT3 = AR_MNG_TG_DT3,
		MNG_NAME_DT4 = AR_MNG_NAME_DT4,
		MNG_TG_DT4 = AR_MNG_TG_DT4,
		PRINT_SHEET_TAG = AR_PRINT_SHEET_TAG,
		CARD_SEQ_MNG = AR_CARD_SEQ_MNG,
		CARD_SEQ_MNG_TG = AR_CARD_SEQ_MNG_TG
	Where	ACC_CODE = AR_ACC_CODE;
	If AR_FUND_INPUT_CLS Is Null Or AR_FUND_INPUT_CLS = 'F' Then
		Delete	t_acc_code_CHILD a
		Where	child_acc_code=ar_acc_code;
		Delete	t_acc_code_CHILD2 a
		Where	child_acc_code=ar_acc_code;
	End If;
End;
/
Create Or Replace Procedure SP_T_ACC_CODE_D
(
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete	T_ACC_CODE_CHILD
	where	PARENT_ACC_CODE = Ar_Acc_Code;
	
	Delete	T_ACC_CODE_CHILD
	where	CHILD_ACC_CODE = Ar_Acc_Code;

	Delete	T_ACC_CODE_CHILD2
	where	PARENT_ACC_CODE = Ar_Acc_Code;
	
	Delete	T_ACC_CODE_CHILD2
	where	CHILD_ACC_CODE = Ar_Acc_Code;

	delete T_GRP_ACC_CODE
	where acc_code = ar_acc_code;

	delete T_WORK_ACC_CODE
	where acc_code = ar_acc_code;

	Delete T_ACC_CODE
	Where	ACC_CODE = AR_ACC_CODE;
End;
/