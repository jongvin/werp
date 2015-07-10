Create Or Replace Function F_T_Zip_Mask
(
	Ar_ZipCode			Varchar2
)
Return Varchar2
Is
Begin
	If LengthB(Ar_ZipCode) = 6 Then
		Return SubStrB(Ar_ZipCode,1,3) || '-' || SubStrB(Ar_ZipCode,4,3);
	Else
		Return Ar_ZipCode;
	End If;
End;
/
