Create Or Replace Procedure SP_T_FL_FLOW_ACC_CODE_B_I
(
	AR_FLOW_CODE_B                             NUMBER,
	AR_APPLY_SEQ                               NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_SIGN_TAG                                VARCHAR2,
	AR_SLIP_SUM_MTHD_TAG                       VARCHAR2,
	AR_REMARKS                                 VARCHAR2,
	AR_SUM_MTHD_TAG                            VARCHAR2,
	AR_SETOFF_ACC_CODE                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_FLOW_ACC_CODE_B_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_FLOW_ACC_CODE_B ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-04)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	If AR_SUM_MTHD_TAG Is Null Then
		Raise_Application_Error(-20009,'�������� �Է��Ͽ� �ֽʽÿ�.');
	End If;
	If AR_SUM_MTHD_TAG = '3' Then	--���� �����
		If AR_SETOFF_ACC_CODE Is Null Then
			Raise_Application_Error(-20009,'������� ����� ����Ͻ� ���� �ݵ�� �������� �Է��Ͽ� �ֽʽÿ�.');
		End If;
	End If;
	Insert Into T_FL_FLOW_ACC_CODE_B
	(
		FLOW_CODE_B,
		APPLY_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE,
		SIGN_TAG,
		SLIP_SUM_MTHD_TAG,
		REMARKS,
		SUM_MTHD_TAG,
		SETOFF_ACC_CODE
	)
	Values
	(
		AR_FLOW_CODE_B,
		AR_APPLY_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_CODE,
		AR_SIGN_TAG,
		AR_SLIP_SUM_MTHD_TAG,
		AR_REMARKS,
		AR_SUM_MTHD_TAG,
		AR_SETOFF_ACC_CODE
	);
End;
/
Create Or Replace Procedure SP_T_FL_FLOW_ACC_CODE_B_U
(
	AR_FLOW_CODE_B                             NUMBER,
	AR_APPLY_SEQ                               NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_SIGN_TAG                                VARCHAR2,
	AR_SLIP_SUM_MTHD_TAG                       VARCHAR2,
	AR_REMARKS                                 VARCHAR2,
	AR_SUM_MTHD_TAG                            VARCHAR2,
	AR_SETOFF_ACC_CODE                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_FLOW_ACC_CODE_B_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_FLOW_ACC_CODE_B ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-04)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	If AR_SUM_MTHD_TAG Is Null Then
		Raise_Application_Error(-20009,'�������� �Է��Ͽ� �ֽʽÿ�.');
	End If;
	If AR_SUM_MTHD_TAG = '3' Then	--���� �����
		If AR_SETOFF_ACC_CODE Is Null Then
			Raise_Application_Error(-20009,'������� ����� ����Ͻ� ���� �ݵ�� �������� �Է��Ͽ� �ֽʽÿ�.');
		End If;
	End If;
	Update T_FL_FLOW_ACC_CODE_B
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_CODE = AR_ACC_CODE,
		SIGN_TAG = AR_SIGN_TAG,
		SLIP_SUM_MTHD_TAG = AR_SLIP_SUM_MTHD_TAG,
		REMARKS = AR_REMARKS,
		SUM_MTHD_TAG = AR_SUM_MTHD_TAG,
		SETOFF_ACC_CODE = AR_SETOFF_ACC_CODE
	Where	FLOW_CODE_B = AR_FLOW_CODE_B
	And	APPLY_SEQ = AR_APPLY_SEQ;
End;
/
Create Or Replace Procedure SP_T_FL_FLOW_ACC_CODE_B_D
(
	AR_FLOW_CODE_B                             NUMBER,
	AR_APPLY_SEQ                               NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_FLOW_ACC_CODE_B_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_FLOW_ACC_CODE_B ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-04)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_FLOW_ACC_CODE_B
	Where	FLOW_CODE_B = AR_FLOW_CODE_B
	And	APPLY_SEQ = AR_APPLY_SEQ;
End;
/
