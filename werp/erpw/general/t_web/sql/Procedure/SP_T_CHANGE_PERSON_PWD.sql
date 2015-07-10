Create Or Replace Procedure SP_T_CHANGE_PERSON_PWD
(
	Ar_Old_Pw			Varchar2,
	Ar_New_Pw			Varchar2,
	Ar_Emp_No			Varchar2
)
Is
	lsRet				Varchar2(4000);
Begin
	If Lengthb(Ar_New_Pw) < 4 Then
		Raise_Application_Error(-20009,'암호를 4자리 이상 입력하여 주십시오.');
	End If;
	lsRet := FBS_UTIL_PKG.do_pwd_job('CHG_MNG_PW',Ar_Emp_No,Ar_New_Pw,Ar_Old_Pw);
	If lsRet <> FBS_UTIL_PKG.SUCCESS_CODE Then
		Raise_Application_Error(-20009,'암호변경시 에러'||FBS_UTIL_PKG.CRLF||FBS_UTIL_PKG.format_msg(lsRet));
	End If;
End;
/
