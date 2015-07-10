Create Or Replace Procedure SP_T_WORK_CODE_I
(
	AR_WORK_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_WORK_NAME                               VARCHAR2,
	AR_SLIP_UPDATE_CLS                         VARCHAR2,
	AR_CHARGE_PERS                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_WORK_CODE
	(
		WORK_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_NAME,
		SLIP_UPDATE_CLS,
		CHARGE_PERS
	)
	Values
	(
		AR_WORK_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_WORK_NAME,
		AR_SLIP_UPDATE_CLS,
		AR_CHARGE_PERS
	);
End;
/
Create Or Replace Procedure SP_T_WORK_CODE_U
(
	AR_WORK_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_WORK_NAME                               VARCHAR2,
	AR_SLIP_UPDATE_CLS                         VARCHAR2,
	AR_CHARGE_PERS                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_WORK_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		WORK_NAME = AR_WORK_NAME,
		SLIP_UPDATE_CLS = AR_SLIP_UPDATE_CLS,
		CHARGE_PERS = AR_CHARGE_PERS
	Where	WORK_CODE = AR_WORK_CODE;
End;
/
Create Or Replace Procedure SP_T_WORK_CODE_D
(
	AR_WORK_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_WORK_CODE
	Where	WORK_CODE = AR_WORK_CODE;
End;
/
