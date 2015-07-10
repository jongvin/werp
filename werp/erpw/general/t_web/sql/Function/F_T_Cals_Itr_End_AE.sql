Create Or Replace Function F_T_Cals_Itr_End_AE
(
	Ar_Date				Varchar2,
	Ar_DateExpr			Varchar2,
	Ar_Day				Number
)
Return Varchar2
Is
	lddt_Date			Date;
	lddt_DateExpr		Date;
Begin
	lddt_Date := Trunc(F_T_STRINGTODATE(Ar_Date),'MM');
	lddt_DateExpr := F_T_STRINGTODATE(Ar_DateExpr);
	If To_Char(lddt_Date,'YYYYMM') <> To_Char(lddt_Date+Nvl(Ar_Day,0) - 1 ,'YYYYMM') Then
		lddt_Date := Last_Day(lddt_Date);
	Else
		lddt_Date := lddt_Date+Nvl(Ar_Day,0) - 1;
	End If;
	lddt_Date := lddt_Date + 1;
	If To_Char(lddt_Date,'YYYYMM' ) = To_Char(F_T_STRINGTODATE(Ar_Date),'YYYYMM') Then
		lddt_Date := Last_Day(lddt_Date);
		If lddt_Date > lddt_DateExpr Then	--만기일 보다 크면 만기일 까지만
			lddt_Date := lddt_DateExpr;
		End If;
		Return F_T_DATETOSTRING(Last_Day(lddt_Date));
	End If;
	Return Null;
End;
/
