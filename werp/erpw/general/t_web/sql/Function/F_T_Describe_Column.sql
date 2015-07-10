Create Or Replace Function F_T_Describe_Column
(
	Ar_SQL			Varchar2,
	Ar_TAG			Varchar2
)
Return Varchar2
Is
	lsErrm			Varchar2(4000);
	lsRet			Varchar2(4000);
	liCount			Number;
	ltColumns		dbms_sql.desc_tab2;
	liCursor		Integer;
	Function	convdatatype
	(
		ai_type		Number
	)
	Return Varchar2
	Is
	Begin
		If ai_type = 1 Then
			Return 'VARCHAR2';
		ElsIf ai_type = 2 Then
			Return 'NUMBER';
		ElsIf ai_type = 8 Then
			Return 'LONG';
		ElsIf ai_type = 9 Then
			Return 'VARCHAR2';
		ElsIf ai_type = 12 Then
			Return 'DATE';
		ElsIf ai_type = 23 Then
			Return 'RAW';
		ElsIf ai_type = 24 Then
			Return 'LONG RAW';
		ElsIf ai_type = 69 Then
			Return 'ROWID';
		ElsIf ai_type = 96 Then
			Return 'VARCHAR2';
		ElsIf ai_type = 23 Then
			Return 'RAW';
		Else
			Return 'UNDEFINED';
		End If;
	End;
Begin
	lsRet :='';
	liCursor := Dbms_Sql.Open_Cursor;
	Dbms_Sql.Parse(liCursor,Ar_SQL,Dbms_Sql.Native);
	Dbms_Sql.describe_columns2(liCursor,liCount,ltColumns);
	For liI In 1..liCount Loop
		If Ar_TAG = 'C' Then
			If liI = 1 Then
				lsRet := ltColumns(liI).col_name;
			Else
				lsRet := lsRet ||','||ltColumns(liI).col_name;
			End If;
		ElsIf Ar_TAG = 'CT' Then
			If liI = 1 Then
				lsRet := ltColumns(liI).col_name||'|'||convdatatype(ltColumns(liI).col_type);
			Else
				lsRet := lsRet ||','||ltColumns(liI).col_name||'|'||convdatatype(ltColumns(liI).col_type);
			End If;
		ElsIf Ar_TAG = 'CTL' Then
			If liI = 1 Then
				lsRet := ltColumns(liI).col_name||'|'||convdatatype(ltColumns(liI).col_type)||'|'||To_Char(ltColumns(liI).col_max_len);
			Else
				lsRet := lsRet ||','||ltColumns(liI).col_name||'|'||convdatatype(ltColumns(liI).col_type)||'|'||To_Char(ltColumns(liI).col_max_len);
			End If;
		Else
			Null;
		End If;
	End Loop;
	Dbms_Sql.Close_Cursor(liCursor);
	Return 'S'||lsRet;
Exception When Others Then
	lsErrm := SqlErrm;
	If Dbms_Sql.Is_Open(liCursor) Then
		Dbms_Sql.Close_Cursor(liCursor);
	End If;
	Return 'F'||lsErrm;
End;
/
