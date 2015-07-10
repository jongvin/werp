Create Or Replace Function F_T_GetOnlyPageName
(
	Ar_PageName				Varchar2
)
Return Varchar2
Is
	lsTmp					Varchar2(4000) := Ar_PageName;
	lsTmpLower				Varchar2(4000) := Lower(Ar_PageName);
	lnPosition				Number;
	Procedure	removePostFix
	(
		Ar_PostFix		Varchar2
	)
	Is
	Begin
		lnPosition := InStr(lsTmpLower,Ar_PostFix);
		If lnPosition > 0 Then
			lsTmpLower := SubStr(lsTmpLower,1,lnPosition - 1);
			lsTmp := SubStr(lsTmp,1,lnPosition - 1);
		End If;
	End;
Begin
	Loop
		lnPosition := InStr(lsTmpLower,'/');
		Exit When Nvl(lnPosition,0) = 0;
		lsTmpLower := SubStr(lsTmpLower,lnPosition + 1);
		lsTmp := SubStr(lsTmp,lnPosition + 1);
	End Loop;
	removePostFix('_c.jsp');
	removePostFix('_q.jsp');
	removePostFix('_tr.jsp');
	removePostFix('.jsp');
	Return lsTmp;
End;
/
