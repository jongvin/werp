CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_CODE_I
(
	AR_DVD_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DVD_NAME                                VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_DVD_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_DVD_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
BEGIN
	INSERT INTO T_PL_MA_DVD_CODE
	(
		DVD_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DVD_NAME,
		FUNC_NAME
	)
	VALUES
	(
		AR_DVD_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DVD_NAME,
		AR_FUNC_NAME
	);
END;
/
CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_CODE_U
(
	AR_DVD_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_DVD_NAME                                VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_DVD_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_DVD_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
BEGIN
	UPDATE T_PL_MA_DVD_CODE
	SET
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DVD_NAME = AR_DVD_NAME,
		FUNC_NAME = AR_FUNC_NAME
	WHERE	DVD_CODE = AR_DVD_CODE;
END;
/
CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_CODE_D
(
	AR_DVD_CODE                                VARCHAR2
)
IS
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_DVD_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_DVD_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
BEGIN
	DELETE T_PL_MA_DVD_CODE
	WHERE	DVD_CODE = AR_DVD_CODE;
END;
/