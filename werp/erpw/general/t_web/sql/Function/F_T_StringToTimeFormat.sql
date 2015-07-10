Create Or Replace Function F_T_StringToTimeFormat
(
	Ar_TIME			Varchar2
)
Return Varchar2
Is
Begin
	If Ar_TIME Is Null Or Lengthb(Ar_TIME) < 6 Then
		Return Ar_TIME;
	Else
		Return SUBSTR(Ar_TIME,1,2)||':'||SUBSTR(Ar_TIME,3,2)||':'||SUBSTR(Ar_TIME,5,2);
	End If;
Exception When Others Then
	Return Null;
End;
/
