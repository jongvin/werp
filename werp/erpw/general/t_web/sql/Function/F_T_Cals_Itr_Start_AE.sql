Create Or Replace Function F_T_Cals_Itr_Start_AE
(
	Ar_Date				Varchar2,
	Ar_Day				Number
)
Return Varchar2
Is
	lddt_Date			Date;
Begin
	lddt_Date := Trunc(F_T_STRINGTODATE(Ar_Date),'MM');
	If To_Char(lddt_Date,'YYYYMM') <> To_Char(lddt_Date+Nvl(Ar_Day,0) - 1 ,'YYYYMM') Then
		lddt_Date := Last_Day(lddt_Date);
	Else
		lddt_Date := lddt_Date+Nvl(Ar_Day,0) - 1;
	End If;
	lddt_Date := lddt_Date + 1;
	If To_Char(lddt_Date,'YYYYMM' ) = To_Char(F_T_STRINGTODATE(Ar_Date),'YYYYMM') Then
		Return F_T_DATETOSTRING(lddt_Date);
	End If;
	Return Null;
End;
/
