Create Or Replace Function F_T_StringToYMDFormat
(
	Ar_DATE			Varchar2
)
Return Varchar2
Is
Begin
	If Ar_DATE Is Null Or Lengthb(Ar_DATE) < 8 Then
		Return Ar_Date;
	Else
		Return SUBSTR(Ar_DATE,1,4)||'-'||SUBSTR(Ar_DATE,5,2)||'-'||SUBSTR(Ar_DATE,7,2);
	End If;
Exception When Others Then
	Return Null;
End;
/
