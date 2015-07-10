CREATE OR REPLACE PROCEDURE SP_T_ACC_VAT_DIV_CODE_I
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DIV_NAME                                VARCHAR2,
	AR_DIV_RATIO                               NUMBER,
	AR_REMARKS                                 VARCHAR2,
	AR_USE_TAG                                 VARCHAR2,
	AR_MAIN_TAG                                 VARCHAR2
)
IS
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_VAT_DIV_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_VAT_DIV_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
BEGIN
	INSERT INTO T_ACC_VAT_DIV_CODE
	(
		DIV_COMP_CODE,
		DIV_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DIV_NAME,
		DIV_RATIO,
		REMARKS,
		USE_TAG,
		MAIN_TAG
	)
	VALUES
	(
		AR_DIV_COMP_CODE,
		AR_DIV_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DIV_NAME,
		AR_DIV_RATIO,
		AR_REMARKS,
		AR_USE_TAG,
		AR_MAIN_TAG
	);
END;
/
CREATE OR REPLACE PROCEDURE SP_T_ACC_VAT_DIV_CODE_U
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_DIV_NAME                                VARCHAR2,
	AR_DIV_RATIO                               NUMBER,
	AR_REMARKS                                 VARCHAR2,
	AR_USE_TAG                                 VARCHAR2,
	AR_MAIN_TAG                                 VARCHAR2
)
IS
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_VAT_DIV_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_VAT_DIV_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
BEGIN
	UPDATE T_ACC_VAT_DIV_CODE
	SET
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DIV_NAME = AR_DIV_NAME,
		DIV_RATIO = AR_DIV_RATIO,
		REMARKS = AR_REMARKS,
		USE_TAG = AR_USE_TAG,
		MAIN_TAG = AR_MAIN_TAG
	WHERE	DIV_COMP_CODE = AR_DIV_COMP_CODE
	AND	DIV_CODE = AR_DIV_CODE;
END;
/
CREATE OR REPLACE PROCEDURE SP_T_ACC_VAT_DIV_CODE_D
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2
)
IS
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_VAT_DIV_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_VAT_DIV_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-15)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
BEGIN
	DELETE T_ACC_VAT_DIV_CODE
	WHERE	DIV_COMP_CODE = AR_DIV_COMP_CODE
	AND	DIV_CODE = AR_DIV_CODE;
END;
/
