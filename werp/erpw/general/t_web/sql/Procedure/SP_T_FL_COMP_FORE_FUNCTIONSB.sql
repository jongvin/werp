Create Or Replace Procedure SP_T_FL_COMP_FORE_FUNCTIONSB_I
(
	AR_COMP_FOR_FUNC_NO_B                      NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_COMP_FORE_FUNCTIONSB_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_COMP_FORE_FUNCTIONS_B ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-12)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_COMP_FORE_FUNCTIONS_B
	(
		COMP_FOR_FUNC_NO_B,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		FUNC_TITLE,
		FUNC_NAME,
		AUTO_RECALCC_TAG
	)
	Values
	(
		AR_COMP_FOR_FUNC_NO_B,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_FUNC_TITLE,
		AR_FUNC_NAME,
		AR_AUTO_RECALCC_TAG
	);
End;
/
Create Or Replace Procedure SP_T_FL_COMP_FORE_FUNCTIONSB_U
(
	AR_COMP_FOR_FUNC_NO_B                      NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_COMP_FORE_FUNCTIONSB_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_COMP_FORE_FUNCTIONS_B ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-12)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FL_COMP_FORE_FUNCTIONS_B
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		FUNC_TITLE = AR_FUNC_TITLE,
		FUNC_NAME = AR_FUNC_NAME,
		AUTO_RECALCC_TAG = AR_AUTO_RECALCC_TAG
	Where	COMP_FOR_FUNC_NO_B = AR_COMP_FOR_FUNC_NO_B;
End;
/
Create Or Replace Procedure SP_T_FL_COMP_FORE_FUNCTIONSB_D
(
	AR_COMP_FOR_FUNC_NO_B                      NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_COMP_FORE_FUNCTIONSB_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_COMP_FORE_FUNCTIONS_B ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-12)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_COMP_FORE_FUNCTIONS_B
	Where	COMP_FOR_FUNC_NO_B = AR_COMP_FOR_FUNC_NO_B;
End;
/
