Create Or Replace Procedure SP_T_U_Comp_Exec_Sum_Slip
Is
Begin
	If PKG_FL_DAY_EXEC.Is_DayExec Then
		PKG_FL_DAY_EXEC.SumSlip;
	Else
		PKG_FL_DAY_EXEC.SumSlipMonth;
	End If;
End;
/
