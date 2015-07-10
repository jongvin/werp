Create Or Replace Function F_T_Get_Dept_Name
(
	Ar_Dept_Code			Varchar2
)
Return Varchar2
Is
	ls_DeptName				T_DEPT_CODE.DEPT_NAME%Type;
Begin
	Select
		DEPT_NAME
	Into
		ls_DeptName
	From	T_DEPT_CODE
	Where	DEPT_CODE = Ar_Dept_Code;
	Return ls_DeptName;
Exception When No_Data_Found Then
	Return Null;
End;
/
