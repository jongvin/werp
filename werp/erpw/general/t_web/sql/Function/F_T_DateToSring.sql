Create Or Replace Function F_T_DateToString
(
	Ar_DATE			Date
)
Return Varchar2
Is
Begin
	Return To_Char(Ar_DATE,'YYYY-MM-DD');
Exception When Others Then
	Return Null;
End;
/
