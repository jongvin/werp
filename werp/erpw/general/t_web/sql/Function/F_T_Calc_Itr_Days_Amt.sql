Create Or Replace Function F_T_Calc_Itr_Days_Amt
(
	Ar_Days					Number,
	Ar_NumData				Number,
	Ar_Itr_Ratio			Number
)
Return Number
Is
Begin
	If Ar_Itr_Ratio = 0 Then
		Return 0;
	End If;
	Return Trunc(((Ar_Days) * Ar_NumData) * Ar_Itr_Ratio / 36500);
End;
/
