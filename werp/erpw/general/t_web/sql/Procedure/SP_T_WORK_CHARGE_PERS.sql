Create Or Replace Procedure SP_T_WORK_CHARGE_PERS_I
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CHARGE_PERS                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_CHARGE_PERS_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_CHARGE_PERS ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-01)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_WORK_CHARGE_PERS
	(
		WORK_CODE,
		COMP_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CHARGE_PERS
	)
	Values
	(
		AR_WORK_CODE,
		AR_COMP_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CHARGE_PERS
	);
End;
/
Create Or Replace Procedure SP_T_WORK_CHARGE_PERS_U
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CHARGE_PERS                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_CHARGE_PERS_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_CHARGE_PERS ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-01)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_WORK_CHARGE_PERS
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CHARGE_PERS = AR_CHARGE_PERS
	Where	WORK_CODE = AR_WORK_CODE
	And	COMP_CODE = AR_COMP_CODE;
End;
/
Create Or Replace Procedure SP_T_WORK_CHARGE_PERS_D
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_CHARGE_PERS_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_CHARGE_PERS ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-01)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_WORK_CHARGE_PERS
	Where	WORK_CODE = AR_WORK_CODE
	And	COMP_CODE = AR_COMP_CODE;
End;
/
