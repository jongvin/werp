Create Or Replace Procedure SP_T_PL_MONTH_COM_PLAN_SUM
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2
)
Is
Begin
	SP_T_PL_MONTH_COM_PLAN_SUMUP(Ar_COMP_CODE,Ar_CLSE_ACC_ID,0);
	PKG_PL_COM_PLAN.ProcessAutoRecal(Ar_COMP_CODE,Ar_CLSE_ACC_ID,0,'0');
	SP_T_PL_MONTH_COM_PLAN_SUMUP(Ar_COMP_CODE,Ar_CLSE_ACC_ID,0);
End;
/