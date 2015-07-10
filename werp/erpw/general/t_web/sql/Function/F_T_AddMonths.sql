Create Or Replace Function F_T_AddMonths
(
	Ar_DATE			Varchar2,
	Ar_Months		Number
)
Return Varchar2
Is
	ln_Year			Number;
	ln_Months		Number;
Begin
	ln_Year := Trunc((To_Number(SubStrb(Ar_DATE,1,4)) * 12 + To_Number(SubStrb(Ar_DATE,5,2)) + Ar_Months) / 12);
	ln_Months := Mod((To_Number(SubStrb(Ar_DATE,1,4)) * 12 + To_Number(SubStrb(Ar_DATE,5,2)) + Ar_Months),12);
	If ln_Months = 0 Then
		ln_Year := ln_Year - 1;
		ln_Months := 12;
	End If;
	Return To_Char(ln_Year,'FM0000') || To_Char(ln_Months,'FM00');
Exception When Others Then
	Return Null;
End;
/
