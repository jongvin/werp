Create Or Replace Procedure SP_T_ACC_VAT_DIV_HIST_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_SEQ                                     NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_DIV_RATIO                               NUMBER,
	AR_CUR_DIV_RATIO                           NUMBER,
	AR_GONG_DIV_RATIO                          NUMBER,
	AR_PRE_DIV_RATIO                           NUMBER,
	AR_CUR_DIV_ACC_AMT                         NUMBER,
	AR_CUR_DIV_TAX_AMT                         NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_VAT_DIV_HIST_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_VAT_DIV_HIST ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-05-09)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_ACC_VAT_DIV_HIST
	(
		COMP_CODE,
		WORK_NO,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DIV_COMP_CODE,
		DIV_CODE,
		DIV_RATIO,
		CUR_DIV_RATIO,
		GONG_DIV_RATIO,
		PRE_DIV_RATIO,
		CUR_DIV_ACC_AMT,
		CUR_DIV_TAX_AMT
	)
	Values
	(
		AR_COMP_CODE,
		AR_WORK_NO,
		AR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DIV_COMP_CODE,
		AR_DIV_CODE,
		AR_DIV_RATIO,
		AR_CUR_DIV_RATIO,
		AR_GONG_DIV_RATIO,
		AR_PRE_DIV_RATIO,
		AR_CUR_DIV_ACC_AMT,
		AR_CUR_DIV_TAX_AMT
	);
End;
/
Create Or Replace Procedure SP_T_ACC_VAT_DIV_HIST_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_SEQ                                     NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_DIV_RATIO                               NUMBER,
	AR_CUR_DIV_RATIO                           NUMBER,
	AR_GONG_DIV_RATIO                          NUMBER,
	AR_PRE_DIV_RATIO                           NUMBER,
	AR_CUR_DIV_ACC_AMT                         NUMBER,
	AR_CUR_DIV_TAX_AMT                         NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_VAT_DIV_HIST_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_VAT_DIV_HIST ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-05-09)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_ACC_VAT_DIV_HIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DIV_COMP_CODE = AR_DIV_COMP_CODE,
		DIV_CODE = AR_DIV_CODE,
		DIV_RATIO = AR_DIV_RATIO,
		CUR_DIV_RATIO = AR_CUR_DIV_RATIO,
		GONG_DIV_RATIO = AR_GONG_DIV_RATIO,
		PRE_DIV_RATIO = AR_PRE_DIV_RATIO,
		CUR_DIV_ACC_AMT = AR_CUR_DIV_ACC_AMT,
		CUR_DIV_TAX_AMT = AR_CUR_DIV_TAX_AMT
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO
	And	SEQ = AR_SEQ;
End;
/
Create Or Replace Procedure SP_T_ACC_VAT_DIV_HIST_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_SEQ                                     NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_VAT_DIV_HIST_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_VAT_DIV_HIST ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-05-09)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_ACC_VAT_DIV_HIST
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO
	And	SEQ = AR_SEQ;
End;
/
