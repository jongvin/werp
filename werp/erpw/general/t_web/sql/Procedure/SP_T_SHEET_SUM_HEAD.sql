Create Or Replace Procedure SP_T_SHEET_SUM_HEAD_I
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_PAST_ACC_ID                             VARCHAR2,
	AR_PAST_ACC_FDT                            VARCHAR2,
	AR_PAST_ACC_EDT                            VARCHAR2,
	AR_CURR_ACC_ID                             VARCHAR2,
	AR_CURR_ACC_FDT                            VARCHAR2,
	AR_CURR_ACC_EDT                            VARCHAR2,
	AR_AMTUNIT                                 NUMBER,
	AR_EDIT_DT                                 VARCHAR2,
	AR_EDIT_USERNO                             NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_SUM_HEAD_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_SUM_HEAD ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_SHEET_SUM_HEAD
	(
		SHEET_CODE,
		COMP_CODE,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		PAST_ACC_ID,
		PAST_ACC_FDT,
		PAST_ACC_EDT,
		CURR_ACC_ID,
		CURR_ACC_FDT,
		CURR_ACC_EDT,
		AMTUNIT,
		EDIT_DT,
		EDIT_USERNO
	)
	Values
	(
		AR_SHEET_CODE,
		AR_COMP_CODE,
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_PAST_ACC_ID,
		F_T_StringToDate(AR_PAST_ACC_FDT),
		F_T_StringToDate(AR_PAST_ACC_EDT),
		AR_CURR_ACC_ID,
		F_T_StringToDate(AR_CURR_ACC_FDT),
		F_T_StringToDate(AR_CURR_ACC_EDT),
		AR_AMTUNIT,
		F_T_StringToDate(AR_EDIT_DT),
		AR_EDIT_USERNO
	);
End;
/
Create Or Replace Procedure SP_T_SHEET_SUM_HEAD_U
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_PAST_ACC_ID                             VARCHAR2,
	AR_PAST_ACC_FDT                            VARCHAR2,
	AR_PAST_ACC_EDT                            VARCHAR2,
	AR_CURR_ACC_ID                             VARCHAR2,
	AR_CURR_ACC_FDT                            VARCHAR2,
	AR_CURR_ACC_EDT                            VARCHAR2,
	AR_AMTUNIT                                 NUMBER,
	AR_EDIT_DT                                 VARCHAR2,
	AR_EDIT_USERNO                             NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_SUM_HEAD_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_SUM_HEAD ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_SHEET_SUM_HEAD
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		PAST_ACC_ID = AR_PAST_ACC_ID,
		PAST_ACC_FDT = F_T_StringToDate(AR_PAST_ACC_FDT),
		PAST_ACC_EDT = F_T_StringToDate(AR_PAST_ACC_EDT),
		CURR_ACC_ID = AR_CURR_ACC_ID,
		CURR_ACC_FDT = F_T_StringToDate(AR_CURR_ACC_FDT),
		CURR_ACC_EDT = F_T_StringToDate(AR_CURR_ACC_EDT),
		AMTUNIT = AR_AMTUNIT,
		EDIT_DT = F_T_StringToDate(AR_EDIT_DT),
		EDIT_USERNO = AR_EDIT_USERNO
	Where	SHEET_CODE = AR_SHEET_CODE
	And	COMP_CODE = AR_COMP_CODE
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_SHEET_SUM_HEAD_D
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SHEET_SUM_HEAD_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SHEET_SUM_HEAD ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_SHEET_SUM_BODY
	Where	SHEET_CODE = AR_SHEET_CODE
	And	COMP_CODE = AR_COMP_CODE
	And	DEPT_CODE = AR_DEPT_CODE;

	Delete T_SHEET_SUM_HEAD
	Where	SHEET_CODE = AR_SHEET_CODE
	And	COMP_CODE = AR_COMP_CODE
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
