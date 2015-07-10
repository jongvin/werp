Create Or Replace Procedure SP_T_FL_COMP_FLOW_MA_B_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_PLAN_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_COMP_FLOW_MA_B_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_COMP_FLOW_MA_B ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_COMP_FLOW_MA_B
	(
		COMP_CODE,
		CLSE_ACC_ID,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		PLAN_CONFIRM_TAG,
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
		AR_PLAN_CONFIRM_TAG,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FL_COMP_FLOW_MA_B_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_PLAN_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_COMP_FLOW_MA_B_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_COMP_FLOW_MA_B ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FL_COMP_FLOW_MA_B
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		PLAN_CONFIRM_TAG = AR_PLAN_CONFIRM_TAG,
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID;
End;
/
Create Or Replace Procedure SP_T_FL_COMP_FLOW_MA_B_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_COMP_FLOW_MA_B_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_COMP_FLOW_MA_B ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-13)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_COMP_FLOW_MA_B
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID;
End;
/
