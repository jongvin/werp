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
		Raise_Application_Error(-20009,'��ȣ�� 4�ڸ� �̻� �Է��Ͽ� �ֽʽÿ�.');
	End If;
	lsRet := FBS_UTIL_PKG.do_pwd_job('CHG_MNG_PW',Ar_Emp_No,Ar_New_Pw,Ar_Old_Pw);
	If lsRet <> FBS_UTIL_PKG.SUCCESS_CODE Then
		Raise_Application_Error(-20009,'��ȣ����� ����'||FBS_UTIL_PKG.CRLF||FBS_UTIL_PKG.format_msg(lsRet));
	End If;
End;
/
