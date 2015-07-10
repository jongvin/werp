Create Or Replace Procedure SP_T_FL_FLOW_COMP_B_I
(
	AR_FLOW_CODE_B                             NUMBER,
	AR_COMP_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_FLOW_COMP_B_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_FLOW_COMP_B ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-03)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_FLOW_COMP_B
	(
		FLOW_CODE_B,
		COMP_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_FLOW_CODE_B,
		AR_COMP_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_FL_FLOW_COMP_B_U
(
	AR_FLOW_CODE_B                             NUMBER,
	AR_COMP_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_FLOW_COMP_B_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_FLOW_COMP_B ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-03)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FL_FLOW_COMP_B
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	FLOW_CODE_B = AR_FLOW_CODE_B
	And	COMP_CODE = AR_COMP_CODE;
End;
/
Create Or Replace Procedure SP_T_FL_FLOW_COMP_B_D
(
	AR_FLOW_CODE_B                             NUMBER,
	AR_COMP_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_FLOW_COMP_B_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_FLOW_COMP_B ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-03)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_FLOW_COMP_B
	Where	FLOW_CODE_B = AR_FLOW_CODE_B
	And	COMP_CODE = AR_COMP_CODE;
End;
/
