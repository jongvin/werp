Create Or Replace Procedure SP_T_CARD_EXPENSE_DATA_USE
(
	AR_SEQNO                                   NUMBER,
	AR_USAGEGUBUN                              VARCHAR2,
	AR_MEMO                                    VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CARD_EXPENSE_DATA_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CARD_EXPENSE_DATA ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-22)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_CARD_EXPENSE_DATA
	Set
		USAGEGUBUN = AR_USAGEGUBUN,
		MEMO = AR_MEMO
	Where	SEQNO = AR_SEQNO;
End;
/
