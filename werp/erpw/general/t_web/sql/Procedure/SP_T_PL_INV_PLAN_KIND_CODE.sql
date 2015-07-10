Create Or Replace Procedure SP_T_PL_INV_PLAN_KIND_CODE_I
(
	AR_KIND_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_INV_TAG                                 VARCHAR2,
	AR_KIND_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_INV_PLAN_KIND_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_INV_PLAN_KIND_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-29)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_PL_INV_PLAN_KIND_CODE
	(
		KIND_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		INV_TAG,
		KIND_NAME
	)
	Values
	(
		AR_KIND_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_INV_TAG,
		AR_KIND_NAME
	);
End;
/
Create Or Replace Procedure SP_T_PL_INV_PLAN_KIND_CODE_U
(
	AR_KIND_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_INV_TAG                                 VARCHAR2,
	AR_KIND_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_INV_PLAN_KIND_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_INV_PLAN_KIND_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-29)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_PL_INV_PLAN_KIND_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		INV_TAG = AR_INV_TAG,
		KIND_NAME = AR_KIND_NAME
	Where	KIND_CODE = AR_KIND_CODE;
End;
/
Create Or Replace Procedure SP_T_PL_INV_PLAN_KIND_CODE_D
(
	AR_KIND_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_INV_PLAN_KIND_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_INV_PLAN_KIND_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-29)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_PL_INV_PLAN_KIND_CODE
	Where	KIND_CODE = AR_KIND_CODE;
End;
/
