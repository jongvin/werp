Create Or Replace Procedure SP_T_FL_DAY_EXEC_B_SUM
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_WORK_DT					Varchar2
)
Is
Begin
	SP_T_FL_DAY_EXEC_B_SUMUP(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_WORK_DT);
	PKG_FL_DAY_EXEC.ProcessAutoRecal(Ar_COMP_CODE,Ar_CLSE_ACC_ID,F_T_STRINGTODATE(Ar_WORK_DT),'0');
	SP_T_FL_DAY_EXEC_B_SUMUP(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_WORK_DT);
End;
/
