Create Or Replace Function F_T_StringToDate
(
	Ar_DATE			Varchar2
)
Return Date
Is
Begin
	Return To_Date(Ar_DATE,'YYYY-MM-DD');
Exception When Others Then
	Return Null;
End;
/
