Create Or Replace Function F_T_YMDtoStringFormat
(
	Ar_DATE			Varchar2
)
Return Varchar2
Is
Begin
	Return Replace(Ar_DATE,'-','');
Exception When Others Then
	Return Null;
End;
/
