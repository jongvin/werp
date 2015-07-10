Create Or Replace Function F_T_COMON_PROPERTY
(
	Ar_Group				Varchar2,
	Ar_Code					Varchar2
)
Return Varchar2
Is
	lsRet					v_t_code_list.CODE_LIST_NAME%Type;
Begin
	Select
		CODE_LIST_NAME
	Into
		lsRet
	From	v_t_code_list
	Where	CODE_GROUP_ID = Ar_Group
	And		CODE_LIST_ID = Ar_Code;
	Return lsRet;
Exception When No_Data_Found Then
	Return Null;
End;
/

