Create Or Replace Function F_T_Calc_Pe_Itr_Amt
(
	Ar_Dt_F					Date,
	Ar_Dt_T					Date,
	Ar_NumData				Number,
	Ar_Itr_Ratio			Number
)
Return Number
Is
Begin
	If Ar_Itr_Ratio = 0 Then
		Return 0;
	End If;
	If Ar_Dt_F > Ar_Dt_T Then
		Return 0;
	End If;
	If Last_Day(Ar_Dt_F) + 1 > Ar_Dt_T Then
		Return 0;
	End If;
	Return Trunc(((Ar_Dt_T - (Last_Day(Ar_Dt_F) + 1) + 1) * Ar_NumData) * Ar_Itr_Ratio / 36500);
End;
/
