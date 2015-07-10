Create Or Replace Procedure SP_T_FL_DAY_FUND_IN_OUT_I
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_AMT                                     NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DAY_FUND_IN_OUT_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DAY_FUND_IN_OUT ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_DAY_FUND_IN_OUT
	(
		ITEM_CODE,
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		AMT,
		REMARKS
	)
	Values
	(
		AR_ITEM_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_AMT,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FL_DAY_FUND_IN_OUT_U
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_AMT                                     NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DAY_FUND_IN_OUT_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DAY_FUND_IN_OUT ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_DAY_FUND_IN_OUT
	(
		ITEM_CODE,
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		AMT,
		REMARKS
	)
	Values
	(
		AR_ITEM_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_MODUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_AMT,
		AR_REMARKS
	);
Exception When Dup_Val_On_Index Then
	Update T_FL_DAY_FUND_IN_OUT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		AMT = AR_AMT,
		REMARKS = AR_REMARKS
	Where	ITEM_CODE = AR_ITEM_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT);
End;
/
Create Or Replace Procedure SP_T_FL_DAY_FUND_IN_OUT_D
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_DAY_FUND_IN_OUT_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_DAY_FUND_IN_OUT ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_DAY_FUND_IN_OUT
	Where	ITEM_CODE = AR_ITEM_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT);
End;
/
