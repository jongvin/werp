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
		lsMsg := lrA.TR_MANAGER_NAME ||'님 안녕하십니까.'||FBS_UTIL_PKG.CRLF;
		lsMsg := lsMsg ||'금번 '||lrA.PAY_DUE_YMD||'에 귀사에 지급될 금액에 대하여 안내 말씀을 드립니다.'||FBS_UTIL_PKG.CRLF;
		lsMsg := lsMsg ||'총    액 : '||to_Char(lrA.T_AMT,'fm999,999,999,999,999,999,999,990')||'원'||FBS_UTIL_PKG.CRLF;
		If Nvl(lrA.C_AMT,0) <> 0 Then
			lsMsg := lsMsg ||'현    금 : '||to_Char(lrA.C_AMT,'fm999,999,999,999,999,999,999,990')||'원'||FBS_UTIL_PKG.CRLF;
		End If;
		If Nvl(lrA.B_AMT,0) <> 0 Then
			lsMsg := lsMsg ||'전자어음 : '||to_Char(lrA.B_AMT,'fm999,999,999,999,999,999,999,990')||'원'||FBS_UTIL_PKG.CRLF;
		End If;
		If Nvl(lrA.P_AMT,0) <> 0 Then
			lsMsg := lsMsg ||'구매자금 : '||to_Char(lrA.P_AMT,'fm999,999,999,999,999,999,999,990')||'원'||FBS_UTIL_PKG.CRLF;
		End If;
		If Nvl(lrA.N_AMT,0) <> 0 Then
			lsMsg := lsMsg ||'어    음 : '||to_Char(lrA.N_AMT,'fm999,999,999,999,999,999,999,990')||'원'||FBS_UTIL_PKG.CRLF;
		End If;
		lsMsg := lsMsg ||'입니다.'||FBS_UTIL_PKG.CRLF;
		lsMsg := lsMsg ||'귀사의 무궁한 발전이 있으시길 바라며....'||FBS_UTIL_PKG.CRLF;
		lsRet := FBS_UTIL_PKG.mail_send(lrA.TR_MANAGER_NAME||'<'||lrA.TR_MANAGER_EMAIL||'>',null,'지급예정을 알려드립니다.',lsMsg,'N');
		If lsRet = FBS_UTIL_PKG.SUCCESS_CODE Then
			SP_T_FB_Set_Mail_Error(Ar_MAIL_SEQ,'Y','정상발신');
		Else
			SP_T_FB_Set_Mail_Error(Ar_MAIL_SEQ,'F',lsRet);
		End If;
	End Loop;
End;
/
