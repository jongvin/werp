Create Or Replace Function F_T_Cals_Itr_End_PE
(
	Ar_Date				Varchar2,
	Ar_ExprDate			Varchar2
)
Return Varchar2
Is
	lddt_Date			Date;
	lddt_DateExpr		Date;
Begin
	lddt_Date := Last_Day(F_T_STRINGTODATE(Ar_Date));
	lddt_DateExpr := F_T_STRINGTODATE(Ar_ExprDate);
	If lddt_DateExpr > lddt_Date Then
		Return F_T_DATETOSTRING(lddt_Date);
	Else
		Return F_T_DATETOSTRING(lddt_DateExpr);
	End If;
End;
/
