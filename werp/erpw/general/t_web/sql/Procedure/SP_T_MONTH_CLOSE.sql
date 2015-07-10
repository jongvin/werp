Create Or Replace Procedure SP_T_MONTH_CLOSE_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CLSE_MONTH                              VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CLSE_CLS                                VARCHAR2,
	AR_CLSE_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_MONTH_CLOSE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_MONTH_CLOSE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_MONTH_CLOSE
	(
		COMP_CODE,
		CLSE_ACC_ID,
		CLSE_MONTH,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CLSE_CLS,
		CLSE_DT
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		REPLACE(AR_CLSE_MONTH, '-', NULL),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CLSE_CLS,
		F_T_StringToDate(AR_CLSE_DT)
	);
End;
/
Create Or Replace Procedure SP_T_MONTH_CLOSE_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CLSE_MONTH                              VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CLSE_CLS                                VARCHAR2,
	AR_CLSE_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_MONTH_CLOSE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_MONTH_CLOSE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_MONTH_CLOSE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CLSE_CLS = AR_CLSE_CLS,
		CLSE_DT = F_T_StringToDate(AR_CLSE_DT)
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	CLSE_MONTH = AR_CLSE_MONTH;
End;
/
Create Or Replace Procedure SP_T_MONTH_CLOSE_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CLSE_MONTH                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_MONTH_CLOSE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_MONTH_CLOSE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_DAY_CLOSE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	CLSE_MONTH = AR_CLSE_MONTH;
	
	Delete T_MONTH_CLOSE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	CLSE_MONTH = AR_CLSE_MONTH;
End;
/
