Create Or Replace Procedure SP_T_FIN_LOAN_CONT_I
(
	AR_LOAN_CONT_NO                            NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_LIMIT_AMT                               NUMBER,
	AR_BANK_CODE                               VARCHAR2,
	AR_LOAN_CONT_NAME                          VARCHAR2,
	AR_LOAN_CONT_EXPR_DT                       VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_FL_LOAN_KIND_CODE                               VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_LOAN_CONT_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_LOAN_CONT ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_LOAN_CONT
	(
		LOAN_CONT_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		LIMIT_AMT,
		BANK_CODE,
		LOAN_CONT_NAME,
		LOAN_CONT_EXPR_DT,
		COMP_CODE,
		FL_LOAN_KIND_CODE,
		REMARK
	)
	Values
	(
		AR_LOAN_CONT_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_LIMIT_AMT,
		AR_BANK_CODE,
		AR_LOAN_CONT_NAME,
		F_T_StringToDate(AR_LOAN_CONT_EXPR_DT),
		AR_COMP_CODE,
		AR_FL_LOAN_KIND_CODE,
		AR_REMARK
	);
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_CONT_U
(
	AR_LOAN_CONT_NO                            NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_LIMIT_AMT                               NUMBER,
	AR_BANK_CODE                               VARCHAR2,
	AR_LOAN_CONT_NAME                          VARCHAR2,
	AR_LOAN_CONT_EXPR_DT                       VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_FL_LOAN_KIND_CODE                               VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_LOAN_CONT_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_LOAN_CONT ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIN_LOAN_CONT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		LIMIT_AMT = AR_LIMIT_AMT,
		BANK_CODE = AR_BANK_CODE,
		LOAN_CONT_NAME = AR_LOAN_CONT_NAME,
		LOAN_CONT_EXPR_DT = F_T_StringToDate(AR_LOAN_CONT_EXPR_DT),
		COMP_CODE = AR_COMP_CODE,
		FL_LOAN_KIND_CODE= AR_FL_LOAN_KIND_CODE,
		REMARK = AR_REMARK
	Where	LOAN_CONT_NO = AR_LOAN_CONT_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_CONT_D
(
	AR_LOAN_CONT_NO                            NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_LOAN_CONT_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_LOAN_CONT ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIN_LOAN_CONT
	Where	LOAN_CONT_NO = AR_LOAN_CONT_NO;
End;
/
