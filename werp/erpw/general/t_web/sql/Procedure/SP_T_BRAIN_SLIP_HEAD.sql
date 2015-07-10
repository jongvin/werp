Create Or Replace Procedure SP_T_BRAIN_SLIP_HEAD_I
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_BRAIN_SLIP_SEQ2                         NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BRAIN_SLIP_NAME2                        VARCHAR2,
	AR_USE_CLS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BRAIN_SLIP_HEAD_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BRAIN_SLIP_HEAD ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_BRAIN_SLIP_HEAD
	(
		BRAIN_SLIP_SEQ1,
		BRAIN_SLIP_SEQ2,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BRAIN_SLIP_NAME2,
		USE_CLS
	)
	Values
	(
		AR_BRAIN_SLIP_SEQ1,
		AR_BRAIN_SLIP_SEQ2,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BRAIN_SLIP_NAME2,
		AR_USE_CLS
	);
End;
/
Create Or Replace Procedure SP_T_BRAIN_SLIP_HEAD_U
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_BRAIN_SLIP_SEQ2                         NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_BRAIN_SLIP_NAME2                        VARCHAR2,
	AR_USE_CLS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BRAIN_SLIP_HEAD_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BRAIN_SLIP_HEAD ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_BRAIN_SLIP_HEAD
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BRAIN_SLIP_NAME2 = AR_BRAIN_SLIP_NAME2,
		USE_CLS = AR_USE_CLS
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1
	And	BRAIN_SLIP_SEQ2 = AR_BRAIN_SLIP_SEQ2;
End;
/
Create Or Replace Procedure SP_T_BRAIN_SLIP_HEAD_D
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_BRAIN_SLIP_SEQ2                         NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_BRAIN_SLIP_HEAD_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_BRAIN_SLIP_HEAD ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	--�ֿ������ ��û�� ���� �߰��� �����Դϴ�.
	--������ : �����
	--������ : 2006.05.24
	--��û���� : �극���� �ڵ带 ������ �� ������ ���� �ʵ��� �ش޶�(��������δ� ���� �׸��� �־ ���� �� �ְ� �ش޶�� �ǹ���)
	
	Delete	T_BRAIN_SLIP_BODY
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1
	And	BRAIN_SLIP_SEQ2 = AR_BRAIN_SLIP_SEQ2;
	--�������� �� 
	Delete T_BRAIN_SLIP_HEAD
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1
	And	BRAIN_SLIP_SEQ2 = AR_BRAIN_SLIP_SEQ2;
End;
/
