Create Or Replace Procedure SP_T_PL_COMP_PLN_FUNCTIONS_B_I
(
	AR_COMP_PLN_FUNC_NO_B                        NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_COMP_PLN_FUNCTIONS_B_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_COMP_PLN_FUNCTIONS_B ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-09)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_PL_COMP_PLN_FUNCTIONS_B
	(
		COMP_PLN_FUNC_NO_B,
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
		AR_COMP_PLN_FUNC_NO_B,
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
Create Or Replace Procedure SP_T_PL_COMP_PLN_FUNCTIONS_B_U
(
	AR_COMP_PLN_FUNC_NO_B                        NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_COMP_PLN_FUNCTIONS_B_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_COMP_PLN_FUNCTIONS_B ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-09)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_PL_COMP_PLN_FUNCTIONS_B
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		FUNC_TITLE = AR_FUNC_TITLE,
		FUNC_NAME = AR_FUNC_NAME,
		AUTO_RECALCC_TAG = AR_AUTO_RECALCC_TAG
	Where	COMP_PLN_FUNC_NO_B = AR_COMP_PLN_FUNC_NO_B;
End;
/
Create Or Replace Procedure SP_T_PL_COMP_PLN_FUNCTIONS_B_D
(
	AR_COMP_PLN_FUNC_NO_B                        NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_COMP_PLN_FUNCTIONS_B_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_COMP_PLN_FUNCTIONS_B ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-09)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_PL_COMP_PLN_FUNCTIONS_B
	Where	COMP_PLN_FUNC_NO_B = AR_COMP_PLN_FUNC_NO_B;
End;
/
