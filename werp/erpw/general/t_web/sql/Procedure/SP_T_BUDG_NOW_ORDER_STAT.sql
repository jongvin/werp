Create Or Replace Procedure SP_T_BUDG_NOW_ORDER_STAT_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_GRADE_CODE                              VARCHAR2,
	AR_EMP_NAME                                VARCHAR2,
	AR_ORDER_DT                                VARCHAR2,
	AR_BF_ORDER_DEPT_CODE                      VARCHAR2,
	AR_BF_ORDER_GRADE_CODE                     VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_NOW_ORDER_STAT_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_NOW_ORDER_STAT ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_NOW_ORDER_STAT
	(
		COMP_CODE,
		CLSE_ACC_ID,
		ALL_CHG_SEQ,
		DEPT_CODE,
		EMP_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		GRADE_CODE,
		EMP_NAME,
		ORDER_DT,
		BF_ORDER_DEPT_CODE,
		BF_ORDER_GRADE_CODE
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_ALL_CHG_SEQ,
		AR_DEPT_CODE,
		AR_EMP_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_GRADE_CODE,
		AR_EMP_NAME,
		 AR_ORDER_DT,
		AR_BF_ORDER_DEPT_CODE,
		AR_BF_ORDER_GRADE_CODE
	);
End;
/
Create Or Replace Procedure SP_T_BUDG_NOW_ORDER_STAT_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_GRADE_CODE                              VARCHAR2,
	AR_EMP_NAME                                VARCHAR2,
	AR_ORDER_DT                                VARCHAR2,
	AR_BF_ORDER_DEPT_CODE                      VARCHAR2,
	AR_BF_ORDER_GRADE_CODE                     VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_NOW_ORDER_STAT_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_NOW_ORDER_STAT ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_BUDG_NOW_ORDER_STAT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		GRADE_CODE = AR_GRADE_CODE,
		EMP_NAME = AR_EMP_NAME,
		ORDER_DT = F_T_StringToDate(AR_ORDER_DT),
		BF_ORDER_DEPT_CODE = AR_BF_ORDER_DEPT_CODE,
		BF_ORDER_GRADE_CODE = AR_BF_ORDER_GRADE_CODE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ
	And	DEPT_CODE = AR_DEPT_CODE
	And	EMP_NO = AR_EMP_NO;
End;
/
Create Or Replace Procedure SP_T_BUDG_NOW_ORDER_STAT_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_NOW_ORDER_STAT_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_NOW_ORDER_STAT ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-05)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_BUDG_NOW_ORDER_STAT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ
	And	DEPT_CODE = AR_DEPT_CODE
	And	EMP_NO = AR_EMP_NO;
End;
/
