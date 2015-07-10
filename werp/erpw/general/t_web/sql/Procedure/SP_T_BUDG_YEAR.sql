Create Or Replace Procedure SP_T_BUDG_YEAR_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_MAKE_DT_F                               VARCHAR2,
	AR_MAKE_DT_T                               VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_YEAR_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_YEAR ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_YEAR
	(
		COMP_CODE,
		CLSE_ACC_ID,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		MAKE_DT_F,
		MAKE_DT_T,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_MAKE_DT_F),
		F_T_StringToDate(AR_MAKE_DT_T),
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_BUDG_YEAR_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_MAKE_DT_F                               VARCHAR2,
	AR_MAKE_DT_T                               VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_YEAR_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_YEAR ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_YEAR
	(
		COMP_CODE,
		CLSE_ACC_ID,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		MAKE_DT_F,
		MAKE_DT_T,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_MODUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_MAKE_DT_F),
		F_T_StringToDate(AR_MAKE_DT_T),
		AR_REMARKS
	);
Exception When Dup_Val_On_Index Then	
	Update T_BUDG_YEAR
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		MAKE_DT_F = F_T_StringToDate(AR_MAKE_DT_F),
		MAKE_DT_T = F_T_StringToDate(AR_MAKE_DT_T),
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID;
End;
/
Create Or Replace Procedure SP_T_BUDG_YEAR_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BUDG_YEAR_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BUDG_YEAR ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_BUDG_YEAR
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID;
End;
/
