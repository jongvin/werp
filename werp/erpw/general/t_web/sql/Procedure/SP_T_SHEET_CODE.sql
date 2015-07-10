Create Or Replace Procedure SP_T_SHEET_CODE_I
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SHEET_NAME                              VARCHAR2,
	AR_SHEET_PRINT_NAME                        VARCHAR2,
	AR_SHEET_ENG_NAME                          VARCHAR2,
	AR_SHEET_TYPE                              VARCHAR2,
	AR_AMTUNIT                                 NUMBER,
	AR_INDENTCNT                               NUMBER,
	AR_ROUND_CLS                               VARCHAR2,
	AR_COST_CODE                               VARCHAR2,
	AR_ZERO_CLS                                VARCHAR2,
	AR_MONTH_SUM_TAG                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_SHEET_CODE
	(
		SHEET_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SHEET_NAME,
		SHEET_PRINT_NAME,
		SHEET_ENG_NAME,
		SHEET_TYPE,
		AMTUNIT,
		INDENTCNT,
		ROUND_CLS,
		COST_CODE,
		ZERO_CLS,
		MONTH_SUM_TAG
	)
	Values
	(
		AR_SHEET_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SHEET_NAME,
		AR_SHEET_PRINT_NAME,
		AR_SHEET_ENG_NAME,
		AR_SHEET_TYPE,
		AR_AMTUNIT,
		AR_INDENTCNT,
		AR_ROUND_CLS,
		AR_COST_CODE,
		AR_ZERO_CLS,
		Nvl(AR_MONTH_SUM_TAG,'F')
	);
End;
/
Create Or Replace Procedure SP_T_SHEET_CODE_U
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SHEET_NAME                              VARCHAR2,
	AR_SHEET_PRINT_NAME                        VARCHAR2,
	AR_SHEET_ENG_NAME                          VARCHAR2,
	AR_SHEET_TYPE                              VARCHAR2,
	AR_AMTUNIT                                 NUMBER,
	AR_INDENTCNT                               NUMBER,
	AR_ROUND_CLS                               VARCHAR2,
	AR_COST_CODE                               VARCHAR2,
	AR_ZERO_CLS                                VARCHAR2,
	AR_MONTH_SUM_TAG                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_SHEET_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SHEET_NAME = AR_SHEET_NAME,
		SHEET_PRINT_NAME = AR_SHEET_PRINT_NAME,
		SHEET_ENG_NAME = AR_SHEET_ENG_NAME,
		SHEET_TYPE = AR_SHEET_TYPE,
		AMTUNIT = AR_AMTUNIT,
		INDENTCNT = AR_INDENTCNT,
		ROUND_CLS = AR_ROUND_CLS,
		COST_CODE = AR_COST_CODE,
		ZERO_CLS = AR_ZERO_CLS,
		MONTH_SUM_TAG = Nvl(AR_MONTH_SUM_TAG,'F')
	Where	SHEET_CODE = AR_SHEET_CODE;
End;
/
Create Or Replace Procedure SP_T_SHEET_CODE_D
(
	AR_SHEET_CODE                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_SHEET_CODE
	Where	SHEET_CODE = AR_SHEET_CODE;
End;
/
