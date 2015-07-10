Create Or Replace Procedure SP_T_PL_FLOW_ACC_CODE_I
(
	AR_BIZ_PLAN_ITEM_NO                        NUMBER,
	AR_APPLY_SEQ                               NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SLIP_SUM_MTHD_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_SETOFF_ACC_CODE                         VARCHAR2,
	AR_SIGN_TAG                                VARCHAR2,
	AR_SUM_MTHD_TAG                            VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_FLOW_ACC_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_FLOW_ACC_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_PL_FLOW_ACC_CODE
	(
		BIZ_PLAN_ITEM_NO,
		APPLY_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SUM_MTHD_TAG,
		ACC_CODE,
		SETOFF_ACC_CODE,
		SIGN_TAG,
		SLIP_SUM_MTHD_TAG,
		REMARKS
	)
	Values
	(
		AR_BIZ_PLAN_ITEM_NO,
		AR_APPLY_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SUM_MTHD_TAG,
		AR_ACC_CODE,
		AR_SETOFF_ACC_CODE,
		AR_SIGN_TAG,
		AR_SLIP_SUM_MTHD_TAG,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_PL_FLOW_ACC_CODE_U
(
	AR_BIZ_PLAN_ITEM_NO                        NUMBER,
	AR_APPLY_SEQ                               NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SLIP_SUM_MTHD_TAG                       VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_SETOFF_ACC_CODE                         VARCHAR2,
	AR_SIGN_TAG                                VARCHAR2,
	AR_SUM_MTHD_TAG                            VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_FLOW_ACC_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_FLOW_ACC_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_PL_FLOW_ACC_CODE
	Set
		MODUSERNO = AR_CRTUSERNO,
		MODDATE = SYSDATE,
		SUM_MTHD_TAG = AR_SUM_MTHD_TAG,
		ACC_CODE = AR_ACC_CODE,
		SETOFF_ACC_CODE = AR_SETOFF_ACC_CODE,
		SIGN_TAG = AR_SIGN_TAG,
		SLIP_SUM_MTHD_TAG = AR_SLIP_SUM_MTHD_TAG,
		REMARKS = AR_REMARKS
	Where	BIZ_PLAN_ITEM_NO = AR_BIZ_PLAN_ITEM_NO
	And	APPLY_SEQ = AR_APPLY_SEQ;
End;
/
Create Or Replace Procedure SP_T_PL_FLOW_ACC_CODE_D
(
	AR_BIZ_PLAN_ITEM_NO                        NUMBER,
	AR_APPLY_SEQ                               NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_FLOW_ACC_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_FLOW_ACC_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_PL_FLOW_ACC_CODE
	Where	BIZ_PLAN_ITEM_NO = AR_BIZ_PLAN_ITEM_NO
	And	APPLY_SEQ = AR_APPLY_SEQ;
End;
/
