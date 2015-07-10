Create Or Replace Function F_T_Calc_Itr_Amt
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
	If Ar_Dt_F <= Ar_Dt_T Then
		Return Trunc(((Ar_Dt_T - Ar_Dt_F + 1) * Ar_NumData) * Ar_Itr_Ratio / 36500);
	Else
		Return - Trunc(((Ar_Dt_F - Ar_Dt_T + 1) * Ar_NumData) * Ar_Itr_Ratio / 36500);
	End If;
End;
/
