Create Or Replace Procedure SP_T_LOV_ARGS_I
(
	AR_LOV_NO                                  NUMBER,
	AR_ARG_SEQ                                 NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_NAME                                    VARCHAR2,
	AR_TYPE                                    VARCHAR2,
	AR_DEFAULT_VALUE                           VARCHAR2,
	AR_SESSION_TAG                             VARCHAR2,
	AR_SESSION_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_ARGS_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_ARGS ���̺� Insert
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_LOV_ARGS
	(
		LOV_NO,
		ARG_SEQ,
		DIS_SEQ,
		NAME,
		TYPE,
		DEFAULT_VALUE,
		SESSION_TAG,
		SESSION_NAME
	)
	Values
	(
		AR_LOV_NO,
		AR_ARG_SEQ,
		AR_DIS_SEQ,
		AR_NAME,
		AR_TYPE,
		AR_DEFAULT_VALUE,
		AR_SESSION_TAG,
		AR_SESSION_NAME
	);
End;
/
Create Or Replace Procedure SP_T_LOV_ARGS_U
(
	AR_LOV_NO                                  NUMBER,
	AR_ARG_SEQ                                 NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_NAME                                    VARCHAR2,
	AR_TYPE                                    VARCHAR2,
	AR_DEFAULT_VALUE                           VARCHAR2,
	AR_SESSION_TAG                             VARCHAR2,
	AR_SESSION_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_ARGS_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_ARGS ���̺� Update
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update	T_LOV_ARGS
	Set		DIS_SEQ = AR_DIS_SEQ,
			NAME = AR_NAME,
			TYPE = AR_TYPE,
			DEFAULT_VALUE = AR_DEFAULT_VALUE,
			SESSION_TAG = AR_SESSION_TAG,
			SESSION_NAME = AR_SESSION_NAME
	Where	LOV_NO = AR_LOV_NO
	 And	ARG_SEQ = AR_ARG_SEQ;
End;
/
Create Or Replace Procedure SP_T_LOV_ARGS_D
(
	AR_LOV_NO                                  NUMBER,
	AR_ARG_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_ARGS_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_ARGS ���̺� Delete
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete	T_LOV_ARGS
	Where	LOV_NO = AR_LOV_NO
	 And	ARG_SEQ = AR_ARG_SEQ;
End;
/
