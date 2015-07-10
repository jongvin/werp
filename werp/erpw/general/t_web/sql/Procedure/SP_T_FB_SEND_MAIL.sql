Create Or Replace Procedure SP_T_FB_SEND_MAIL
(
	Ar_MAIL_SEQ						Number
)
Is
	lsMsg							Long;
	lsRet							Varchar2(4000);
Begin
	For lrA In (
		Select
			F_T_DATETOSTRING(To_Date(a.PAY_DUE_YMD,'YYYYMMDD')) PAY_DUE_YMD,
			a.TR_MANAGER_NAME ,
			a.TR_MANAGER_EMAIL,
			Sum(b.PAY_AMT) T_AMT,
			Sum(Decode(b.CASH_BILL_GUBUN,'C',b.PAY_AMT)) C_AMT,
			Sum(Decode(b.CASH_BILL_GUBUN,'B',b.PAY_AMT)) B_AMT,
			Sum(Decode(b.CASH_BILL_GUBUN,'P',b.PAY_AMT)) P_AMT,
			Sum(Decode(b.CASH_BILL_GUBUN,'N',b.PAY_AMT)) N_AMT
		From	T_FB_PAYDUE_MAIL_MASTER a,
				T_FB_PAYDUE_MAIL_DETAIL b
		Where	a.MAIL_SEQ = b.MAIL_SEQ
		And		a.MAIL_SEQ = Ar_MAIL_SEQ
		Group by
			a.TR_MANAGER_NAME ,
			a.TR_MANAGER_EMAIL,
			a.PAY_DUE_YMD
				) Loop
		lsMsg := lrA.TR_MANAGER_NAME ||'�� �ȳ��Ͻʴϱ�.'||FBS_UTIL_PKG.CRLF;
		lsMsg := lsMsg ||'�ݹ� '||lrA.PAY_DUE_YMD||'�� �ͻ翡 ���޵� �ݾ׿� ���Ͽ� �ȳ� ������ �帳�ϴ�.'||FBS_UTIL_PKG.CRLF;
		lsMsg := lsMsg ||'��    �� : '||to_Char(lrA.T_AMT,'fm999,999,999,999,999,999,999,990')||'��'||FBS_UTIL_PKG.CRLF;
		If Nvl(lrA.C_AMT,0) <> 0 Then
			lsMsg := lsMsg ||'��    �� : '||to_Char(lrA.C_AMT,'fm999,999,999,999,999,999,999,990')||'��'||FBS_UTIL_PKG.CRLF;
		End If;
		If Nvl(lrA.B_AMT,0) <> 0 Then
			lsMsg := lsMsg ||'���ھ��� : '||to_Char(lrA.B_AMT,'fm999,999,999,999,999,999,999,990')||'��'||FBS_UTIL_PKG.CRLF;
		End If;
		If Nvl(lrA.P_AMT,0) <> 0 Then
			lsMsg := lsMsg ||'�����ڱ� : '||to_Char(lrA.P_AMT,'fm999,999,999,999,999,999,999,990')||'��'||FBS_UTIL_PKG.CRLF;
		End If;
		If Nvl(lrA.N_AMT,0) <> 0 Then
			lsMsg := lsMsg ||'��    �� : '||to_Char(lrA.N_AMT,'fm999,999,999,999,999,999,999,990')||'��'||FBS_UTIL_PKG.CRLF;
		End If;
		lsMsg := lsMsg ||'�Դϴ�.'||FBS_UTIL_PKG.CRLF;
		lsMsg := lsMsg ||'�ͻ��� ������ ������ �����ñ� �ٶ��....'||FBS_UTIL_PKG.CRLF;
		lsRet := FBS_UTIL_PKG.mail_send(lrA.TR_MANAGER_NAME||'<'||lrA.TR_MANAGER_EMAIL||'>',null,'���޿����� �˷��帳�ϴ�.',lsMsg,'N');
		If lsRet = FBS_UTIL_PKG.SUCCESS_CODE Then
			SP_T_FB_Set_Mail_Error(Ar_MAIL_SEQ,'Y','����߽�');
		Else
			SP_T_FB_Set_Mail_Error(Ar_MAIL_SEQ,'F',lsRet);
		End If;
	End Loop;
End;
/
