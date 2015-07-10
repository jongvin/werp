Create Or Replace Procedure SP_T_BUDG_MONTH_REQ_CONF_KIND
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                   NUMBER,
	AR_BUDG_CODE_NO                         NUMBER,
	AR_RESERVED_SEQ                         NUMBER,
	AR_BUDG_YM                                   VARCHAR2,
	AR_CONFIRM_KIND                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_MONTH_REQ_CONF_KIND
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : SP_T_BUDG_MONTH_REQ ���̺� Update
/* 4. ��  ��  ��  �� : �����  �ۼ�(2005-12-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE,AR_CHG_SEQ);
	Update T_BUDG_MONTH_REQ 
	Set
			CONFIRM_KIND = AR_CONFIRM_KIND
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID 	= AR_CLSE_ACC_ID
	And	DEPT_CODE 	= AR_DEPT_CODE
	And	CHG_SEQ 	= AR_CHG_SEQ
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	RESERVED_SEQ  = AR_RESERVED_SEQ
	And	BUDG_YM 	   = to_date( AR_BUDG_YM,'YYYY-MM');
End;
/

