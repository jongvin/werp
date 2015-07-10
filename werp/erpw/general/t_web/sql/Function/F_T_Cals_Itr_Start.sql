Create Or Replace Function F_T_Cals_Itr_Start
(
	Ar_Date				Varchar2,
	Ar_Day				Number,
	Ar_DatePrev			Varchar2 Default Null
)
Return Varchar2
Is
	lddt_Date			Date;
	lddt_PrevDate		Date;
Begin
	lddt_Date := Trunc(Add_Months(F_T_STRINGTODATE(Ar_Date),-1),'MM');
	lddt_PrevDate := F_T_STRINGTODATE(Ar_DatePrev);
	If To_Char(lddt_Date,'YYYYMM') <> To_Char(lddt_Date+Nvl(Ar_Day,0) - 1 ,'YYYYMM') Then
		lddt_Date := Last_Day(lddt_Date) + 1;
	Else
		lddt_Date := lddt_Date+Nvl(Ar_Day,0);
	End If;
	If lddt_PrevDate Is Not Null And lddt_Date <= lddt_PrevDate Then
		lddt_Date := lddt_PrevDate + 1;
	End If;
	Return F_T_DATETOSTRING(lddt_Date);
End;
/
