Create Or Replace Trigger trg_T_CARD_EXPENSE_DATA
Before Insert on T_CARD_EXPENSE_DATA
For Each row
Begin
	Select T_CARD_EXPENSE_DATA_SEQ.NextVal Into :New.SeqNo From Dual;
End;
/
