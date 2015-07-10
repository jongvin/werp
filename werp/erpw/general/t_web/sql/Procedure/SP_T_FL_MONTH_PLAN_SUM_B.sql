Create Or Replace Procedure SP_T_FL_MONTH_PLAN_SUM_B
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_DEPT_CODE				Varchar2
)
Is
Begin
	PKG_FL_DEPT_PLAN_B.ProcessAutoRecal(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,'0');
	SP_T_FL_MONTH_PLAN_SUMUP_B(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE);
End;
/
