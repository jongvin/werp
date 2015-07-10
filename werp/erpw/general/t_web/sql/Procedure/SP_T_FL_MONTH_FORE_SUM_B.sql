Create Or Replace Procedure SP_T_FL_MONTH_FORE_SUM_B
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_DEPT_CODE				Varchar2,
	Ar_QUARTER_YEAR				Number
)
Is
Begin
	PKG_FL_DEPT_FORE_B.ProcessAutoRecal(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_QUARTER_YEAR,'0');
	SP_T_FL_MONTH_FORE_SUMUP_B(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_QUARTER_YEAR);
End;
/
