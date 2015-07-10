Create Or Replace Procedure SP_T_PL_ITEM_I
(
	AR_BIZ_PLAN_ITEM_NO                        NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_P_NO                                    NUMBER,
	AR_BIZ_PLAN_ITEM_NAME                      VARCHAR2,
	AR_ITEM_LEVEL_SEQ                          NUMBER,
	AR_ITEM_TAG                                VARCHAR2,
	AR_LEVEL_TAG                               VARCHAR2,
	AR_DEPT_TAG                                VARCHAR2,
	AR_COMP_PLN_FUNC_NO                        NUMBER,
	AR_COMP_FOR_FUNC_NO                        NUMBER,
	AR_COMP_EXE_FUNC_NO                        NUMBER,
	AR_COMP_PLN_FUNC_NO_B                      NUMBER,
	AR_COMP_FOR_FUNC_NO_B                      NUMBER,
	AR_COMP_EXE_FUNC_NO_B                      NUMBER,
	AR_REMARKS                                 VARCHAR2,
	AR_MNG_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_ITEM_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_ITEM ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_PL_ITEM
	(
		BIZ_PLAN_ITEM_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		P_NO,
		BIZ_PLAN_ITEM_NAME,
		ITEM_LEVEL_SEQ,
		ITEM_TAG,
		LEVEL_TAG,
		DEPT_TAG,
		COMP_PLN_FUNC_NO,
		COMP_FOR_FUNC_NO,
		COMP_EXE_FUNC_NO,
		COMP_PLN_FUNC_NO_B,
		COMP_FOR_FUNC_NO_B,
		COMP_EXE_FUNC_NO_B,
		REMARKS,
		MNG_CODE
	)
	Values
	(
		AR_BIZ_PLAN_ITEM_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_P_NO,
		AR_BIZ_PLAN_ITEM_NAME,
		AR_ITEM_LEVEL_SEQ,
		AR_ITEM_TAG,
		AR_LEVEL_TAG,
		AR_DEPT_TAG,
		AR_COMP_PLN_FUNC_NO,
		AR_COMP_FOR_FUNC_NO,
		AR_COMP_EXE_FUNC_NO,
		AR_COMP_PLN_FUNC_NO_B,
		AR_COMP_FOR_FUNC_NO_B,
		AR_COMP_EXE_FUNC_NO_B,
		AR_REMARKS,
		AR_MNG_CODE
	);
End;
/
Create Or Replace Procedure SP_T_PL_ITEM_U
(
	AR_BIZ_PLAN_ITEM_NO                        NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_P_NO                                    NUMBER,
	AR_BIZ_PLAN_ITEM_NAME                      VARCHAR2,
	AR_ITEM_LEVEL_SEQ                          NUMBER,
	AR_ITEM_TAG                                VARCHAR2,
	AR_LEVEL_TAG                               VARCHAR2,
	AR_DEPT_TAG                                VARCHAR2,
	AR_COMP_PLN_FUNC_NO                        NUMBER,
	AR_COMP_FOR_FUNC_NO                        NUMBER,
	AR_COMP_EXE_FUNC_NO                        NUMBER,
	AR_COMP_PLN_FUNC_NO_B                      NUMBER,
	AR_COMP_FOR_FUNC_NO_B                      NUMBER,
	AR_COMP_EXE_FUNC_NO_B                      NUMBER,
	AR_REMARKS                                 VARCHAR2,
	AR_MNG_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_ITEM_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_ITEM ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_PL_ITEM
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		P_NO = AR_P_NO,
		BIZ_PLAN_ITEM_NAME = AR_BIZ_PLAN_ITEM_NAME,
		ITEM_LEVEL_SEQ = AR_ITEM_LEVEL_SEQ,
		ITEM_TAG = AR_ITEM_TAG,
		LEVEL_TAG = AR_LEVEL_TAG,
		DEPT_TAG = AR_DEPT_TAG,
		COMP_PLN_FUNC_NO = AR_COMP_PLN_FUNC_NO,
		COMP_FOR_FUNC_NO = AR_COMP_FOR_FUNC_NO,
		COMP_EXE_FUNC_NO = AR_COMP_EXE_FUNC_NO,
		COMP_PLN_FUNC_NO_B = AR_COMP_PLN_FUNC_NO_B,
		COMP_FOR_FUNC_NO_B = AR_COMP_FOR_FUNC_NO_B,
		COMP_EXE_FUNC_NO_B = AR_COMP_EXE_FUNC_NO_B,
		REMARKS = AR_REMARKS,
		MNG_CODE = AR_MNG_CODE
	Where	BIZ_PLAN_ITEM_NO = AR_BIZ_PLAN_ITEM_NO;
End;
/
Create Or Replace Procedure SP_T_PL_ITEM_D
(
	AR_BIZ_PLAN_ITEM_NO                        NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_ITEM_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_ITEM ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_PL_ITEM
	Where	BIZ_PLAN_ITEM_NO = AR_BIZ_PLAN_ITEM_NO;
End;
/
