Create Or Replace Procedure SP_T_FL_MONTH_COM_PLAN_SUM
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2
)
Is
Begin
	PKG_FL_COM_PLAN.ProcessAutoRecal(Ar_COMP_CODE,Ar_CLSE_ACC_ID,'0');
	SP_T_FL_MONTH_COM_PLAN_SUMUP(Ar_COMP_CODE,Ar_CLSE_ACC_ID);
	PKG_FL_COM_PLAN.ProcessAutoRecal(Ar_COMP_CODE,Ar_CLSE_ACC_ID,'0');
End;
/
