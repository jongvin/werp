Create Or Replace Function F_T_Last_Word
(
	asString			Varchar2
)
Return Varchar2
Is
	liPos				Number;
	liPosOld			Number;
	lsString			Varchar2(4000) := Trim(asString);
Begin
	liPos := 0;
	Loop
		liPosOld := liPos+1;
		liPos := Instr(lsString,' ',liPosOld);
		If liPos = 0 Then
			Return SubStr(lsString,liPosOld);
		End If;
	End Loop;
End;
/
