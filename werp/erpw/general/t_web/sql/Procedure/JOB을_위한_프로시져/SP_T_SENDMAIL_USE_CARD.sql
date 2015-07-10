Create Or Replace Procedure SP_T_SENDMAIL_USE_CARD
Is
	HEAD_MSG			constant	Varchar2(4000) :=
	'귀하가 소지하신 법인카드에 대하여 하기와 같이 사용(매입기준)내역이 통보되었습니다.'||FBS_UTIL_PKG.CRLF ||
	'법인사용분과 개인사용분을 분류하시어 [법인카드이용내역등록]에서 분류 저장하여 주시기 바랍니다.'||FBS_UTIL_PKG.CRLF||FBS_UTIL_PKG.CRLF;
	SUCCESS_CODE		constant	Varchar2(2) := 'OK';
	Type T_REC Is Table Of T_CARD_EXPENSE_DATA%RowType
		Index By Binary_Integer;
	ltRec						T_REC;
	liFirst						Number;
	liLast						Number;
	liCount						Number;
	--사원의 이메일 주소 가져오기
	Function	GetEmpsMailAddress
	(
		Ar_EmpNo				Varchar2
	)
	Return Varchar2
	Is
	Begin
		Return Null;		--못찾으면
	End;
	--카드의 현 소유자 및 현 대리인을 찾아 온다.(현재 보유상태)
	Function	GetCurrentCardInfo
	(
		Ar_CardNo				Varchar2,
		Ar_CardInfo		In Out	T_CARD_MEMBER_HISTORY%RowType
	)
	Return Boolean
	Is
	Begin
		Select
			*
		Into
			Ar_CardInfo
		From	T_CARD_MEMBER_HISTORY a
		Where	Replace(a.CARDNUMBER,'-','') = Replace(Ar_CardNo,'-','')
		And		a.USESTARTDATE <= To_Char(SysDate - 1,'YYYYMMDD')
		And		a.USEENDDATE >= To_Char(SysDate - 1,'YYYYMMDD');
		Return True;
	Exception When No_Data_Found Then 
		Return False;
	End;
	Procedure	UpdateErrm
	(
		Ar_SeqNo				Number,
		Ar_Msg					Varchar2
	)
	Is
	Begin
		If Ar_Msg = SUCCESS_CODE Then
			Update	T_CARD_EXPENSE_DATA
			Set		MAILSENDRESULTMSG = SubStrb(Ar_Msg,1,300),
					MailSendDateTime = SysDate
			Where	SEQNO = Ar_SeqNo;
		Else
			Update	T_CARD_EXPENSE_DATA
			Set		MAILSENDRESULTMSG = SubStrb(Ar_Msg,1,300)
			Where	SEQNO = Ar_SeqNo;
		End If;
		Commit;
	Exception When Others Then
		Null;
	End;
	Function	GetEmpName
	(
		Ar_EmpNo				Varchar2
	)
	Return Varchar2
	Is
		lsName				Varchar2(100);
	Begin
		Select
			NAME
		Into
			lsName
		From	Z_AUTHORITY_USER a
		Where	a.EMPNO = Ar_EmpNo;
		Return lsName;
	Exception When No_Data_Found Then
		Return Null;
	End;
	--사원 정보 가져오기 (현재는 이름만...)
	Function	GetEmpInfo
	(
		Ar_EmpNo				Varchar2
	)
	Return Varchar2
	Is
		lsName				Varchar2(100);
	Begin
		Select
			NAME
		Into
			lsName
		From	Z_AUTHORITY_USER a
		Where	a.EMPNO = Ar_EmpNo;
		Return lsName;
	Exception When No_Data_Found Then
		Return Null;
	End;
	--카드 이용내역을 생성한다.
	Function	BuildMailContents
	(
		Ar_Rec			In Out NoCopy	T_CARD_EXPENSE_DATA%RowType,
		Ar_CardInfo		In Out NoCopy	T_CARD_MEMBER_HISTORY%RowType
	)
	Return Varchar2
	Is
		lsContents				Varchar2(4000);
	Begin
		lsContents := HEAD_MSG ||
			'카드번호 : '||Ar_Rec.CardNumber ||FBS_UTIL_PKG.CRLF||
			'소 지 자 : '||GetEmpInfo(Ar_CardInfo.CardOwnerEmpNo)||FBS_UTIL_PKG.CRLF||
			'대 리 인 : '||GetEmpInfo(Ar_CardInfo.CardSubstituteEmpNo)||FBS_UTIL_PKG.CRLF||
			FBS_UTIL_PKG.CRLF||
			'사용일자 : '||F_T_StringToYMDFormat(Ar_Rec.JobDate)||FBS_UTIL_PKG.CRLF||
			'사 용 처 : '||Ar_Rec.MerchantName||' ('||Ar_Rec.MerchantSocialNo||')'||FBS_UTIL_PKG.CRLF||
			'사용금액 : ';
		If Ar_Rec.OVERSEAUSE = '1' Then		--국내구입
			lsContents := lsContents || To_Char(Ar_Rec.APPROVALSUMAMT,'FM999,999,999,999,999,999,990')||'원';
		Else								--국제구입
			lsContents := lsContents || To_Char(Ar_Rec.DomesticConversionAmt,'FM999,999,999,999,999,999,990')||'원'||FBS_UTIL_PKG.CRLF||
				'현지통화 : '||To_Char(Ar_Rec.LocalAmt,'FM999,999,999,999,999,999,990');
		End If;
		Return lsContents;
	Exception When Others Then
		UpdateErrm(Ar_Rec.SEQNO,SqlErrm);
		Return Null;
	End;
	--사원에게 메일을 발송한다.
	Function	SendMailToEmp
	(
		Ar_EmpNo				Varchar2,
		Ar_Contents				Varchar2
	)
	Return Varchar2
	Is
		lsMailAddress				Varchar2(300);
		lsName						Varchar2(100);
	Begin
		lsMailAddress := GetEmpsMailAddress(Ar_EmpNo);
		If lsMailAddress Is Null Then
			Return '사번 : '||Ar_EmpNo||'의 메일주소를 찾을 수 없습니다.';
		End If;
		lsName := GetEmpName(Ar_EmpNo);
		If lsName Is Null Then
			Return '사번 : '||Ar_EmpNo||'의 정보를 찾을 수 없습니다.';
		End If;
		Return FBS_UTIL_PKG.mail_send(lsName||'<'||lsMailAddress||'>',null,'법인카드 사용내역',Ar_Contents,'N');
	Exception When Others Then
		Return SqlErrm;
	End;
	--카드 사용내역을 한건씩 처리
	Procedure	ProcessElem
	(
		Ar_Rec			In Out NoCopy T_CARD_EXPENSE_DATA%RowType
	)
	Is
		lrCardInfo				T_CARD_MEMBER_HISTORY%RowType;
		lsMailContents			Varchar2(4000);
		lsMsg					Varchar2(300) := SUCCESS_CODE;
		lsMsg2					Varchar2(300) := SUCCESS_CODE;
	Begin
		--카드의 현 소유자 및 현 대리인을 찾아 온다.(현재 보유상태)
		If Not GetCurrentCardInfo(Ar_Rec.CardNumber,lrCardInfo) Then
			UpdateErrm(Ar_Rec.SEQNO,'해당 카드의 보유 이력이 관리되고 있지 않습니다.');
			Return;
		End If;
		--카드 이용내역을 생성한다.
		lsMailContents := BuildMailContents(Ar_Rec,lrCardInfo);
		If lsMailContents Is Null Then
			Return;
		End If;
		--소유자 및 대리자에게 카드 사용내역을 발송한다.
		If lrCardInfo.CardSubstituteEmpNo Is Null And lrCardInfo.CardOwnerEmpNo Is Null Then
			UpdateErrm(Ar_Rec.SEQNO,'메일을 수신할 카드의 소유자 및 대리인이 등록되어 있지 않습니다.');
		Else
			--소유자한테 보내기
			If lrCardInfo.CardOwnerEmpNo Is Not Null Then
				lsMsg := SendMailToEmp(lrCardInfo.CardOwnerEmpNo,lsMailContents);
			End If;
			--대리자한테 보내기
			If lrCardInfo.CardSubstituteEmpNo Is Not Null Then
				lsMsg2 := SendMailToEmp(lrCardInfo.CardSubstituteEmpNo,lsMailContents);
			End If;
			--둘다 성공이면 성공이다.
			If lsMsg = SUCCESS_CODE And lsMsg2 = SUCCESS_CODE Then
				UpdateErrm(Ar_Rec.SEQNO,SUCCESS_CODE);
			Else
				UpdateErrm(Ar_Rec.SEQNO,lsMsg||','||lsMsg2);
			End If;
		End If;
	Exception When Others Then
		UpdateErrm(Ar_Rec.SEQNO,SqlErrm);
	End;
Begin
	--설명이 필요없는 간단한 로직
	Select
		*
	Bulk Collect Into
		ltRec
	From	T_CARD_EXPENSE_DATA a
	Where	a.SENDDATE = To_Char(Sysdate - 1,'YYYYMMDD')
	And		a.GUBUNCODE = '03'
	And		Nvl(a.MAILSENDRESULTMSG,'NO') <> 'OK';
	liCount := ltRec.Count;
	liFirst := ltRec.First;
	liLast := ltRec.Last;
	For liI In liFirst..liLast Loop
		ProcessElem(ltRec(liI));
	End Loop;
End;
/
