Create Or Replace Function F_T_Cust_UMask
(
	Ar_CustCode			Varchar2
)
Return Varchar2
Is
	ls_CustCode			Varchar2(100);
Begin
	ls_CustCode := Trim(Replace(Ar_CustCode,'-',''));
	If LengthB(ls_CustCode) <> Length(ls_CustCode) Then
		Return Ar_CustCode;
	End If;
	If LengthB(ls_CustCode) = 10 Or LengthB(ls_CustCode) = 13 Then
		Return ls_CustCode;
	Else
		Return Ar_CustCode;
	End If;
End;
/
