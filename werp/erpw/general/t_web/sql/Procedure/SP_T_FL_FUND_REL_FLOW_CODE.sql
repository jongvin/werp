Create Or Replace Procedure SP_T_FL_FUND_REL_FLOW_CODE_I
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_FLOW_CODE_B                             NUMBER,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_FUND_REL_FLOW_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_FUND_REL_FLOW_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_FUND_REL_FLOW_CODE
	(
		ITEM_CODE,
		FLOW_CODE_B,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_ITEM_CODE,
		AR_FLOW_CODE_B,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_FL_FUND_REL_FLOW_CODE_U
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_FLOW_CODE_B                             NUMBER,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_FUND_REL_FLOW_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_FUND_REL_FLOW_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FL_FUND_REL_FLOW_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	ITEM_CODE = AR_ITEM_CODE
	And	FLOW_CODE_B = AR_FLOW_CODE_B;
End;
/
Create Or Replace Procedure SP_T_FL_FUND_REL_FLOW_CODE_D
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_FLOW_CODE_B                             NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_FUND_REL_FLOW_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_FUND_REL_FLOW_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_FUND_REL_FLOW_CODE
	Where	ITEM_CODE = AR_ITEM_CODE
	And	FLOW_CODE_B = AR_FLOW_CODE_B;
End;
/
