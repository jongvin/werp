Create Or Replace Function F_T_Conv_Kor_Number
(
	Ar_NumberAmt			Number
)
RETURN Varchar2 IS
	ln_NumLength			Number;
	ln_NumPosition			Number;
	ls_NumChar			Varchar2(40);
	ls_Position			Varchar2(1);
	ls_Exists			Varchar2(1);
	ls_NumberKor			Varchar2(100);
Begin
	If Ar_NumberAmt Is NULL  Then
		Return (NULL);
	ElsIf Ar_NumberAmt = 0  Then
		Return ('��');
	ElsIf Ar_NumberAmt < 0  Then
		ls_NumberKor := '-';
	End If;
	ls_NumChar := To_Char (Abs (Ar_NumberAmt));
	ln_NumLength := Lengthb (ls_NumChar);
	For i In 1..ln_NumLength Loop
		ls_Position := Substrb (ls_NumChar, i, 1);
		If ls_Position = '0'  Then
			ls_NumberKor := ls_NumberKor || '';
		Else
		If ls_Position = '1'  Then
			ls_NumberKor := ls_NumberKor || '��';
		ElsIf ls_Position = '2'  Then
			ls_NumberKor := ls_NumberKor || '��';
		ElsIf ls_Position = '3'  Then
			ls_NumberKor := ls_NumberKor || '��';
		ElsIf ls_Position = '4'  Then
			ls_NumberKor := ls_NumberKor || '��';
		ElsIf ls_Position = '5'  Then
			ls_NumberKor := ls_NumberKor || '��';
		ElsIf ls_Position = '6'  Then
			ls_NumberKor := ls_NumberKor || '��';
		ElsIf ls_Position = '7'  Then
			ls_NumberKor := ls_NumberKor || 'ĥ';
		ElsIf ls_Position = '8'  Then
			ls_NumberKor := ls_NumberKor || '��';
		ElsIf ls_Position = '9'  Then
			ls_NumberKor := ls_NumberKor || '��';
		End If;
			ls_Exists := '1';
		End If;
		ln_NumPosition := ln_NumLength + 1 - i;
		If ln_NumPosition = 1  Then
			ls_NumberKor := ls_NumberKor || '';
		ElsIf ln_NumPosition = 5  Then
			If ls_Exists = '1'  Then
				ls_NumberKor := ls_NumberKor || '��';
			End If;
		ElsIf ln_NumPosition = 9  Then
			If ls_Exists = '1'  Then
				ls_NumberKor := ls_NumberKor || '��';
			End If;
		ElsIf ln_NumPosition = 13  Then
			If ls_Exists = '1'  Then
				ls_NumberKor := ls_NumberKor || '��';
			End If;
		ElsIf ln_NumPosition = 17  Then
			If ls_Exists = '1'  Then
				ls_NumberKor := ls_NumberKor || '��';
			End If;
		Else
			If ls_Position <> 0  Then
				If Mod (ln_NumPosition, 4) = 0  Then
					ls_NumberKor := ls_NumberKor || 'õ';
				ElsIf Mod (ln_NumPosition, 4) = 1  Then
					ls_NumberKor := ls_NumberKor || '';
				ElsIf Mod (ln_NumPosition, 4) = 2  Then
					ls_NumberKor := ls_NumberKor || '��';
				ElsIf Mod (ln_NumPosition, 4) = 3  Then
					ls_NumberKor := ls_NumberKor || '��';
				End If;
			End If;
		End If;
		-- �ϰ����︸ �̶�� �ݾ��� ������ �ʵ���...
		If ln_NumPosition In (1, 5, 9, 13, 17)  Then
			ls_Exists := NULL;
		End If;
	End Loop;
	Return (Substr(ls_NumberKor,1,100));
End;
/
