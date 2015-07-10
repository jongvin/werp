Create Or Replace Procedure SP_T_FL_SUM_HISTORY_I
(
	AR_WORK_DT                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_START_DT_TIME                           VARCHAR2,
	AR_END_DT_TIME                             VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_NAME                                    VARCHAR2,
	AR_ERRM                                    VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_SUM_HISTORY_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_SUM_HISTORY ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-05-01)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_SUM_HISTORY
	(
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		F_T_StringToDate(AR_WORK_DT),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_FL_SUM_HISTORY_U
(
	AR_WORK_DT                                 VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_START_DT_TIME                           VARCHAR2,
	AR_END_DT_TIME                             VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_NAME                                    VARCHAR2,
	AR_ERRM                                    VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_SUM_HISTORY_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_SUM_HISTORY ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-05-01)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Null;
End;
/
Create Or Replace Procedure SP_T_FL_SUM_HISTORY_D
(
	AR_WORK_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_SUM_HISTORY_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_SUM_HISTORY ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-05-01)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Raise_Application_Error(-20009,'�۾����� ��ü�� ������ �Ұ����մϴ�.');
End;
/
