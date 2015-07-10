Create Or Replace Procedure SP_T_LOV_FILTERS_I
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_SEQ                              NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_FILTER_NAME                             VARCHAR2,
	AR_TYPE                                    VARCHAR2,
	AR_DATE_TYPE                               VARCHAR2,
	AR_DEFAULT_ARG_NAME                        VARCHAR2,
	AR_RETURN_ARG_NAME                         VARCHAR2,
	AR_LABEL_NAME                              VARCHAR2,
	AR_LABEL_WIDTH                             NUMBER,
	AR_WIDTH                                   NUMBER,
	AR_SQL                                     VARCHAR2,
	AR_TEXT_COL                                VARCHAR2,
	AR_VALUE_COL                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_FILTERS_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_FILTERS ���̺� Insert
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_LOV_FILTERS
	(
		LOV_NO,
		FILTER_SEQ,
		DIS_SEQ,
		FILTER_NAME,
		TYPE,
		DATE_TYPE,
		DEFAULT_ARG_NAME,
		RETURN_ARG_NAME,
		LABEL_NAME,
		LABEL_WIDTH,
		WIDTH,
		SQL,
		TEXT_COL,
		VALUE_COL
	)
	Values
	(
		AR_LOV_NO,
		AR_FILTER_SEQ,
		AR_DIS_SEQ,
		AR_FILTER_NAME,
		AR_TYPE,
		AR_DATE_TYPE,
		AR_DEFAULT_ARG_NAME,
		AR_RETURN_ARG_NAME,
		AR_LABEL_NAME,
		AR_LABEL_WIDTH,
		AR_WIDTH,
		AR_SQL,
		AR_TEXT_COL,
		AR_VALUE_COL
	);
End;
/
Create Or Replace Procedure SP_T_LOV_FILTERS_U
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_SEQ                              NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_FILTER_NAME                             VARCHAR2,
	AR_TYPE                                    VARCHAR2,
	AR_DATE_TYPE                               VARCHAR2,
	AR_DEFAULT_ARG_NAME                        VARCHAR2,
	AR_RETURN_ARG_NAME                         VARCHAR2,
	AR_LABEL_NAME                              VARCHAR2,
	AR_LABEL_WIDTH                             NUMBER,
	AR_WIDTH                                   NUMBER,
	AR_SQL                                     VARCHAR2,
	AR_TEXT_COL                                VARCHAR2,
	AR_VALUE_COL                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_FILTERS_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_FILTERS ���̺� Update
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_LOV_FILTERS
	Set
		DIS_SEQ = AR_DIS_SEQ,
		FILTER_NAME = AR_FILTER_NAME,
		TYPE = AR_TYPE,
		DATE_TYPE = AR_DATE_TYPE,
		DEFAULT_ARG_NAME = AR_DEFAULT_ARG_NAME,
		RETURN_ARG_NAME = AR_RETURN_ARG_NAME,
		LABEL_NAME = AR_LABEL_NAME,
		LABEL_WIDTH = AR_LABEL_WIDTH,
		WIDTH = AR_WIDTH,
		SQL = AR_SQL,
		TEXT_COL = AR_TEXT_COL,
		VALUE_COL = AR_VALUE_COL
	Where	LOV_NO = AR_LOV_NO
	And	FILTER_SEQ = AR_FILTER_SEQ;
End;
/
Create Or Replace Procedure SP_T_LOV_FILTERS_D
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_SEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_FILTERS_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_FILTERS ���̺� Delete
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lnCount			Number;
Begin
	Select	Count(*)
	Into	lnCount
	From	T_LOV_FILTER_RELS
	Where	LOV_NO = AR_LOV_NO
	And    (M_FILTER_SEQ = AR_FILTER_SEQ Or D_FILTER_SEQ = AR_FILTER_SEQ)
	And		RowNum < 2;
	
	If lnCount > 0 Then
		Raise_Application_Error	(-20009, '���Ͱ��谡 �����մϴ�.');
	End If;
	
	Delete T_LOV_FILTER_ARGS
	Where	LOV_NO = AR_LOV_NO
	And	FILTER_SEQ = AR_FILTER_SEQ;
	
	Delete T_LOV_FILTERS
	Where	LOV_NO = AR_LOV_NO
	And	FILTER_SEQ = AR_FILTER_SEQ;
End;
/
