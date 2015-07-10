Create Or Replace Procedure SP_T_BRAIN_SLIP_I
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BRAIN_SLIP_NAME1                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BRAIN_SLIP_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BRAIN_SLIP ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_BRAIN_SLIP
	(
		BRAIN_SLIP_SEQ1,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BRAIN_SLIP_NAME1
	)
	Values
	(
		AR_BRAIN_SLIP_SEQ1,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BRAIN_SLIP_NAME1
	);
End;
/
Create Or Replace Procedure SP_T_BRAIN_SLIP_U
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_BRAIN_SLIP_NAME1                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BRAIN_SLIP_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BRAIN_SLIP ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_BRAIN_SLIP
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BRAIN_SLIP_NAME1 = AR_BRAIN_SLIP_NAME1
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1;
End;
/
Create Or Replace Procedure SP_T_BRAIN_SLIP_D
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BRAIN_SLIP_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BRAIN_SLIP ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_BRAIN_SLIP
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1;
End;
/
