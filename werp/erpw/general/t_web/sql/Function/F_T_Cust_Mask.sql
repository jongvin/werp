Create Or Replace Function F_T_Cust_Mask
(
	Ar_CustCode			Varchar2
)
Return Varchar2
Is
	ls_CustCode			Varchar2(100);
Begin
	ls_CustCode := Trim(Replace(Ar_CustCode, '-', ''));
	If LengthB(ls_CustCode) <> Length(ls_CustCode) Then
		Return Ar_CustCode;
	End If;
	If LengthB(ls_CustCode) = 10 Then
		Return SubStrB(ls_CustCode,1,3) || '-' || SubStrB(ls_CustCode,4,2)|| '-' || SubStrB(ls_CustCode,6,5);
	ElsIf LengthB(ls_CustCode) = 13 Then
		Return SubStrB(ls_CustCode,1,6) || '-' || SubStrB(ls_CustCode,7,7);
	Else
		Return Ar_CustCode;
	End If;
End;
/
