Create Or Replace Procedure SP_T_CHANGE_ACCOUNT_PWD
(
	Ar_AccNo			Varchar2,
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
	lsRet := FBS_UTIL_PKG.do_pwd_job('RET_ACCT_PW',Ar_Emp_No,Replace(Ar_AccNo,'-',''),Null);
	Pkg_t_Debug.PrintMessages('PW',lsRet);
	If lsRet Is Null And Ar_Old_Pw Is Null Then
		Null;
	ElsIf Ar_Old_Pw Is Null Then
		Raise_Application_Error(-20009,'기존 암호를 입력하여 주십시오.');
	ElsIf lsRet = SubStrb(Ar_Old_Pw,1,4) Then
		Null;
	Else
		Raise_Application_Error(-20009,'기존 암호를 잘 못 입력셨습니다.');
	End If;
	lsRet := FBS_UTIL_PKG.do_pwd_job('CHG_ACCT_PW',Ar_Emp_No,Replace(Ar_AccNo,'-',''),Ar_New_Pw);
	If lsRet <> FBS_UTIL_PKG.SUCCESS_CODE Then
		Raise_Application_Error(-20009,'암호변경시 에러'||FBS_UTIL_PKG.CRLF||lsRet);
	End If;
End;
/
