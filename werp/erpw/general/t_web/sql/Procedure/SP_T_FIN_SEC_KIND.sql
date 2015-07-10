Create Or Replace Procedure SP_T_FIN_SEC_KIND_I
(
	AR_SEC_KIND_CODE                           VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SEC_KIND_NAME                           VARCHAR2,
	AR_SEC_ACC_CODE                            VARCHAR2,
	AR_ITRP_ACC_CODE                           VARCHAR2,
	AR_ITRB_ACC_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SEC_KIND_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SEC_KIND ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-20)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_SEC_KIND
	(
		SEC_KIND_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SEC_KIND_NAME,
		SEC_ACC_CODE,
		ITRP_ACC_CODE,
		ITRB_ACC_CODE
	)
	Values
	(
		AR_SEC_KIND_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SEC_KIND_NAME,
		AR_SEC_ACC_CODE,
		AR_ITRP_ACC_CODE,
		AR_ITRB_ACC_CODE
	);
End;
/
Create Or Replace Procedure SP_T_FIN_SEC_KIND_U
(
	AR_SEC_KIND_CODE                           VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SEC_KIND_NAME                           VARCHAR2,
	AR_SEC_ACC_CODE                            VARCHAR2,
	AR_ITRP_ACC_CODE                           VARCHAR2,
	AR_ITRB_ACC_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SEC_KIND_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SEC_KIND ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-20)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIN_SEC_KIND
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SEC_KIND_NAME = AR_SEC_KIND_NAME,
		SEC_ACC_CODE = AR_SEC_ACC_CODE,
		ITRP_ACC_CODE = AR_ITRP_ACC_CODE,
		ITRB_ACC_CODE = AR_ITRB_ACC_CODE
	Where	SEC_KIND_CODE = AR_SEC_KIND_CODE;
End;
/
Create Or Replace Procedure SP_T_FIN_SEC_KIND_D
(
	AR_SEC_KIND_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SEC_KIND_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SEC_KIND ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-20)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIN_SEC_KIND
	Where	SEC_KIND_CODE = AR_SEC_KIND_CODE;
End;
/
