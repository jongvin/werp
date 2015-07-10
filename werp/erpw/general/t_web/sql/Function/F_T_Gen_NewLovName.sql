Create Or Replace Function F_T_Gen_NewLovName
(
	Ar_LovNo				Number
)
Return Varchar2
Is
	lsLovName				T_LOV.NAME%Type;
	liLength				Number;
	liNumStartPos			Number;
	liNumLength				Number;
	lsCoreName				T_LOV.NAME%Type;
	liNumStart				Number := 0;
	liTargetLength			Number;
	liCoreLength			Number;
	lsTargetName			T_LOV.NAME%Type;
	lsTemp					Varchar2(2);
Begin
	Begin
		Select
			Name
		Into
			lsLovName
		From	T_LOV
		Where	LOV_NO = Ar_LovNo;
	Exception When No_Data_Found Then
		lsLovName := 'LOV';
	End;
	liLength := Length(lsLovName);
	For liI In 1..liLength Loop
		If InStr('0123456789' , SubStr(lsLovName, - liI,1)) > 0 Then
			Null;
		Else
			liNumStartPos := - liI + 1;
			liNumLength := liI - 1;
			Exit;
		End If;
	End Loop;
	liNumStart := To_Number(Nvl(SubStr(lsLovName,liNumStartPos,liNumLength),'0'));
	If liNumLength = 0 Then
		liTargetLength := 2;
	Else
		liTargetLength := liNumLength;
	End If;
	liCoreLength := liLength - liNumLength;
	lsCoreName := SubStr(lsLovName,1,liCoreLength);
	Loop
		liNumStart := liNumStart + 1;
		If liNumStart >= Power(10,liTargetLength) Then
			liTargetLength := liTargetLength + 1;
		End If;
		lsTargetName := lsCoreName || To_Char(liNumStart,RPad('FM',liTargetLength + 2,'0'));
		Begin
			Select
				'X'
			Into
				lsTemp
			From	T_LOV
			Where	NAME = lsTargetName;
		Exception When No_Data_Found Then
			Return lsTargetName;
		End;
	End Loop;
	Return Null;
End;
/
