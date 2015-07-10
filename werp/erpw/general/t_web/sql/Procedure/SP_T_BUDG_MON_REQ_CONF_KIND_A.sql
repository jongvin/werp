Create Or Replace Procedure SP_T_BUDG_MON_REQ_CONF_KIND_A
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                   NUMBER,
	AR_CONFIRM_KIND                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_MON_REQ_CONF_KIND_A
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : SP_T_BUDG_MONTH_REQ ���̺�  Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE,AR_CHG_SEQ);
	Update T_BUDG_MONTH_REQ 
	Set CONFIRM_KIND = AR_CONFIRM_KIND
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
End;
/

