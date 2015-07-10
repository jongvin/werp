Create Or Replace Trigger trg_t_dept_code_org
Before Insert Or Update On t_dept_code_org
For Each Row
Begin
	If :New.ACC_CLOSE_DT Is Null Then
		:New.ACC_CLOST_DT_SYS := To_Date('99991231','YYYYMMDD');
	Else
		:New.ACC_CLOST_DT_SYS := :New.ACC_CLOSE_DT;
	End If;
End;
/
