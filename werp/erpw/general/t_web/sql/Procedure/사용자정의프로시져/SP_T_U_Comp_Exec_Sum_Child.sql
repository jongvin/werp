Create Or Replace Procedure SP_T_U_Comp_Exec_Sum_Child
Is
Begin
	If PKG_FL_DAY_EXEC.Is_DayExec Then	--만약 일집계이면
		PKG_FL_DAY_EXEC.SumChild;
	Else
		PKG_FL_DAY_EXEC.SumChildMonth;
	End If;
End;
/
