Create Or Replace Procedure SP_T_FIX_DEPREC_RAT_I
(
	AR_SRVLIFE                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DEPREC_RAT5                             NUMBER,
	AR_DEPREC_RAT10                            NUMBER,
	AR_DEPREC_AMT                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_DEPREC_RAT_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_DEPREC_RAT ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIX_DEPREC_RAT
	(
		SRVLIFE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DEPREC_RAT5,
		DEPREC_RAT10,
		DEPREC_AMT
	)
	Values
	(
		AR_SRVLIFE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DEPREC_RAT5,
		AR_DEPREC_RAT10,
		AR_DEPREC_AMT
	);
End;
/
Create Or Replace Procedure SP_T_FIX_DEPREC_RAT_U
(
	AR_SRVLIFE                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_DEPREC_RAT5                             NUMBER,
	AR_DEPREC_RAT10                            NUMBER,
	AR_DEPREC_AMT                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_DEPREC_RAT_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_DEPREC_RAT ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIX_DEPREC_RAT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DEPREC_RAT5 = AR_DEPREC_RAT5,
		DEPREC_RAT10 = AR_DEPREC_RAT10,
		DEPREC_AMT = AR_DEPREC_AMT
	Where	SRVLIFE = AR_SRVLIFE;
End;
/
Create Or Replace Procedure SP_T_FIX_DEPREC_RAT_D
(
	AR_SRVLIFE                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIX_DEPREC_RAT_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIX_DEPREC_RAT ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIX_DEPREC_RAT
	Where	SRVLIFE = AR_SRVLIFE;
End;
/
