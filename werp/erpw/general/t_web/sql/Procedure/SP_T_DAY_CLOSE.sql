Create Or Replace Procedure SP_T_DAY_CLOSE_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CLSE_MONTH                              VARCHAR2,
	AR_CLSE_DAY                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CLSE_CLS                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DAY_CLOSE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DAY_CLOSE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_DAY_CLOSE
	(
		COMP_CODE,
		CLSE_ACC_ID,
		CLSE_MONTH,
		CLSE_DAY,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CLSE_CLS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_CLSE_MONTH,
		F_T_StringToDate(AR_CLSE_DAY),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CLSE_CLS
	);
End;
/
Create Or Replace Procedure SP_T_DAY_CLOSE_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CLSE_MONTH                              VARCHAR2,
	AR_CLSE_DAY                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CLSE_CLS                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DAY_CLOSE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DAY_CLOSE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_DAY_CLOSE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CLSE_CLS = AR_CLSE_CLS
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	CLSE_MONTH = AR_CLSE_MONTH
	And	CLSE_DAY = F_T_StringToDate(AR_CLSE_DAY);
End;
/
Create Or Replace Procedure SP_T_DAY_CLOSE_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CLSE_MONTH                              VARCHAR2,
	AR_CLSE_DAY                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_DAY_CLOSE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_DAY_CLOSE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_DAY_CLOSE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	CLSE_MONTH = AR_CLSE_MONTH
	And	CLSE_DAY = F_T_StringToDate(AR_CLSE_DAY);
End;
/
