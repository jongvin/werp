Create Or Replace Procedure SP_T_LOV_FILTER_RELS_I
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_REL_SEQ                          NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_M_FILTER_SEQ                            NUMBER,
	AR_D_FILTER_SEQ                            NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_FILTER_RELS_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_FILTER_RELS ���̺� Insert
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_LOV_FILTER_RELS
	(
		LOV_NO,
		FILTER_REL_SEQ,
		DIS_SEQ,
		M_FILTER_SEQ,
		D_FILTER_SEQ
	)
	Values
	(
		AR_LOV_NO,
		AR_FILTER_REL_SEQ,
		AR_DIS_SEQ,
		AR_M_FILTER_SEQ,
		AR_D_FILTER_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_LOV_FILTER_RELS_U
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_REL_SEQ                          NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_M_FILTER_SEQ                            NUMBER,
	AR_D_FILTER_SEQ                            NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_FILTER_RELS_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_FILTER_RELS ���̺� Update
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_LOV_FILTER_RELS
	Set
		DIS_SEQ = AR_DIS_SEQ,
		M_FILTER_SEQ = AR_M_FILTER_SEQ,
		D_FILTER_SEQ = AR_D_FILTER_SEQ
	Where	LOV_NO = AR_LOV_NO
	And	FILTER_REL_SEQ = AR_FILTER_REL_SEQ;
End;
/
Create Or Replace Procedure SP_T_LOV_FILTER_RELS_D
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_REL_SEQ                          NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_LOV_FILTER_RELS_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_LOV_FILTER_RELS ���̺� Delete
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-25)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_LOV_FILTER_RELS
	Where	LOV_NO = AR_LOV_NO
	And	FILTER_REL_SEQ = AR_FILTER_REL_SEQ;
End;
/
