Create Or Replace Function F_T_Get_Dec_No
Return Number
Is
	lnSeq			Number;
Begin
	Select	sq_t_dec_no.NextVal
	Into lnSeq
	From Dual;
	Return lnSeq;
End;
/
