Create Or Replace Procedure SP_T_FL_M_MARKET_STAT_CODE_I
(
	AR_M_MARKET_STAT_CODE                      VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_M_MARKET_STAT_NAME                      VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_M_MARKET_STAT_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_M_MARKET_STAT_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_M_MARKET_STAT_CODE
	(
		M_MARKET_STAT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		M_MARKET_STAT_NAME
	)
	Values
	(
		AR_M_MARKET_STAT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_M_MARKET_STAT_NAME
	);
End;
/
Create Or Replace Procedure SP_T_FL_M_MARKET_STAT_CODE_U
(
	AR_M_MARKET_STAT_CODE                      VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_M_MARKET_STAT_NAME                      VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_M_MARKET_STAT_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_M_MARKET_STAT_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FL_M_MARKET_STAT_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		M_MARKET_STAT_NAME = AR_M_MARKET_STAT_NAME
	Where	M_MARKET_STAT_CODE = AR_M_MARKET_STAT_CODE;
End;
/
Create Or Replace Procedure SP_T_FL_M_MARKET_STAT_CODE_D
(
	AR_M_MARKET_STAT_CODE                      VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_M_MARKET_STAT_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_M_MARKET_STAT_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_M_MARKET_STAT_CODE
	Where	M_MARKET_STAT_CODE = AR_M_MARKET_STAT_CODE;
End;
/
