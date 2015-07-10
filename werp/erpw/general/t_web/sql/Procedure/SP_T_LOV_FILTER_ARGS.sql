Create Or Replace Procedure SP_T_LOV_FILTER_ARGS_I
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_SEQ                              NUMBER,
	AR_FILTER_ARG_SEQ                          NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_TYPE                                    VARCHAR2,
	AR_FILTER_ARG_NAME                         VARCHAR2,
	AR_DEFAULT_VALUE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_FILTER_ARGS_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_FILTER_ARGS ���̺� Insert
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_LOV_FILTER_ARGS
	(
		LOV_NO,
		FILTER_SEQ,
		FILTER_ARG_SEQ,
		DIS_SEQ,
		TYPE,
		FILTER_ARG_NAME,
		DEFAULT_VALUE
	)
	Values
	(
		AR_LOV_NO,
		AR_FILTER_SEQ,
		AR_FILTER_ARG_SEQ,
		AR_DIS_SEQ,
		AR_TYPE,
		AR_FILTER_ARG_NAME,
		AR_DEFAULT_VALUE
	);
End;
/
Create Or Replace Procedure SP_T_LOV_FILTER_ARGS_U
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_SEQ                              NUMBER,
	AR_FILTER_ARG_SEQ                          NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_TYPE                                    VARCHAR2,
	AR_FILTER_ARG_NAME                         VARCHAR2,
	AR_DEFAULT_VALUE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_FILTER_ARGS_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_FILTER_ARGS ���̺� Update
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_LOV_FILTER_ARGS
	Set
		DIS_SEQ = AR_DIS_SEQ,
		TYPE = AR_TYPE,
		FILTER_ARG_NAME = AR_FILTER_ARG_NAME,
		DEFAULT_VALUE = AR_DEFAULT_VALUE
	Where	LOV_NO = AR_LOV_NO
	And	FILTER_SEQ = AR_FILTER_SEQ
	And	FILTER_ARG_SEQ = AR_FILTER_ARG_SEQ;
End;
/
Create Or Replace Procedure SP_T_LOV_FILTER_ARGS_D
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_SEQ                              NUMBER,
	AR_FILTER_ARG_SEQ                          NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_FILTER_ARGS_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_FILTER_ARGS ���̺� Delete
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_LOV_FILTER_ARGS
	Where	LOV_NO = AR_LOV_NO
	And	FILTER_SEQ = AR_FILTER_SEQ
	And	FILTER_ARG_SEQ = AR_FILTER_ARG_SEQ;
End;
/
