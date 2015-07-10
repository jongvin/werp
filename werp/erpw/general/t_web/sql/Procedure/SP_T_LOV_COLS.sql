Create Or Replace Procedure SP_T_LOV_COLS_I
(
	AR_LOV_NO                                  NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_NAME                                    VARCHAR2,
	AR_TITLE                                   VARCHAR2,
	AR_WIDTH                                   NUMBER,
	AR_ALIGN                                   VARCHAR2,
	AR_MASK                                    VARCHAR2,
	AR_VISIBLE                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_COLS_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_COLS ���̺� Insert
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_LOV_COLS
	(
		LOV_NO,
		COL_SEQ,
		DIS_SEQ,
		NAME,
		TITLE,
		WIDTH,
		ALIGN,
		MASK,
		VISIBLE
	)
	Values
	(
		AR_LOV_NO,
		SQ_T_LOV_COLS.nextval,
		AR_DIS_SEQ,
		AR_NAME,
		AR_TITLE,
		AR_WIDTH,
		AR_ALIGN,
		AR_MASK,
		AR_VISIBLE
	);
End;
/
Create Or Replace Procedure SP_T_LOV_COLS_U
(
	AR_LOV_NO                                  NUMBER,
	AR_COL_SEQ                                 NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_NAME                                    VARCHAR2,
	AR_TITLE                                   VARCHAR2,
	AR_WIDTH                                   NUMBER,
	AR_ALIGN                                   VARCHAR2,
	AR_MASK                                    VARCHAR2,
	AR_VISIBLE                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_COLS_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_COLS ���̺� Update
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update	T_LOV_COLS
	Set		TITLE = AR_TITLE,
			WIDTH = AR_WIDTH,
			ALIGN = AR_ALIGN,
			MASK = AR_MASK,
			VISIBLE = AR_VISIBLE
	Where	LOV_NO = AR_LOV_NO
	 And	COL_SEQ = AR_COL_SEQ;
End;
/
Create Or Replace Procedure SP_T_LOV_COLS_D
(
	AR_LOV_NO                                  NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_COLS_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_COLS ���̺� Delete
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete	T_LOV_COLS
	Where	LOV_NO = AR_LOV_NO;
End;
/
