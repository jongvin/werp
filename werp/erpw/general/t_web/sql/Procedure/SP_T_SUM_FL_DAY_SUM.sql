Create Or Replace Procedure SP_T_SUM_FL_DAY_SUM
(
	Ar_Work_Dt					Varchar2,
	Ar_CrtUserNo				Varchar2
)
Is
	lddt_Work_Dt				Date;
	lddt_Start_Dt				Date := SysDate;
	ls_Errm						Varchar2(4000);
Begin
	lddt_Work_Dt := F_T_STRINGTODATE(Ar_Work_Dt);
	Begin
		PKG_TRACE_CASH.TraceCashSlip(lddt_Work_Dt,lddt_Work_Dt);
		For lrA In (Select * from t_company_org order by comp_code) Loop
			SP_T_FL_GET_DAY_EXEC(lrA.COMP_CODE,SubStrb(Ar_Work_Dt,1,4),Ar_Work_Dt,Ar_CrtUserNo);
		End Loop;
		SP_T_SUM_FL_DAY_SUM_LOG(Ar_Work_Dt,Ar_CrtUserNo,lddt_Start_Dt,'정상수행');
	Exception When Others Then
		ls_Errm := SqlErrm;
		SP_T_SUM_FL_DAY_SUM_LOG(Ar_Work_Dt,Ar_CrtUserNo,lddt_Start_Dt,ls_Errm);
		Raise;
	End;
End;
/
