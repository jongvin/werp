--�ϴ��� �����ڵ��ϰ� ���ణ ��������� �ڵ�(FBS_CODE)�� �ܽ��̶��
Create Or Replace Procedure SP_T_BANK_MAIN_I
(
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BANK_MAIN_NAME                          VARCHAR2,
	AR_BANK_CLS                                VARCHAR2,
	AR_BANK_MAIN_SHORT_NAME                    VARCHAR2,
	AR_FBS_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BANK_MAIN_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BANK_MAIN ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-17)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_BANK_MAIN
	(
		BANK_MAIN_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BANK_MAIN_NAME,
		BANK_CLS,
		BANK_MAIN_SHORT_NAME,
		FBS_CODE
	)
	Values
	(
		AR_BANK_MAIN_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BANK_MAIN_NAME,
		AR_BANK_CLS,
		AR_BANK_MAIN_SHORT_NAME,
		AR_BANK_MAIN_CODE		--�̺κ�
	);
End;
/
Create Or Replace Procedure SP_T_BANK_MAIN_U
(
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_BANK_MAIN_NAME                          VARCHAR2,
	AR_BANK_CLS                                VARCHAR2,
	AR_BANK_MAIN_SHORT_NAME                    VARCHAR2,
	AR_FBS_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BANK_MAIN_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BANK_MAIN ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-17)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_BANK_MAIN
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BANK_MAIN_NAME = AR_BANK_MAIN_NAME,
		BANK_CLS = AR_BANK_CLS,
		BANK_MAIN_SHORT_NAME = AR_BANK_MAIN_SHORT_NAME,
		FBS_CODE = AR_BANK_MAIN_CODE
	Where	BANK_MAIN_CODE = AR_BANK_MAIN_CODE;
End;
/
Create Or Replace Procedure SP_T_BANK_MAIN_D
(
	AR_BANK_MAIN_CODE                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BANK_MAIN_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BANK_MAIN ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2005-11-17)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_BANK_MAIN
	Where	BANK_MAIN_CODE = AR_BANK_MAIN_CODE;
End;
/
