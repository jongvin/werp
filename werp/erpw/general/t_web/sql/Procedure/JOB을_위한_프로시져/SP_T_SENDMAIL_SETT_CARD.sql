Create Or Replace Procedure SP_T_SENDMAIL_SETT_CARD
Is
	HEAD_MSG			constant	Long :=
'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> '||FBS_UTIL_PKG.CRLF ||
'<html> '||FBS_UTIL_PKG.CRLF ||
'	<table width="100%" border="0" cellpadding="0" cellspacing="0"> '||FBS_UTIL_PKG.CRLF ||
'		<tr> '||FBS_UTIL_PKG.CRLF ||
'			<td align=center> '||FBS_UTIL_PKG.CRLF ||
'				<table  border="0"> '||FBS_UTIL_PKG.CRLF ||
'					<tr> '||FBS_UTIL_PKG.CRLF ||
'						<td style="font-size:12px; text-decoration:none;"> '||FBS_UTIL_PKG.CRLF ||
'							귀하가 소지하신 법인카드에 대하여 하기와 같이 청구내역이 통보되었습니다.<br> '||FBS_UTIL_PKG.CRLF ||
'							회계시스템의 [법인카드정산관리] 화면으로 접속하시어 법인 사용분에 대하여 정산 입력을 하기기 바랍니다.<br> '||FBS_UTIL_PKG.CRLF ||
'							개인분의 경우, 별도로 개인분으로 마킹을 하신 후 별도 개인 처리하시기 바랍니다.<br> '||FBS_UTIL_PKG.CRLF ||
'							<br> '||FBS_UTIL_PKG.CRLF ||
'							<br> '||FBS_UTIL_PKG.CRLF ||
'						</td> '||FBS_UTIL_PKG.CRLF ||
'					</tr> '||FBS_UTIL_PKG.CRLF ||
'				</table> '||FBS_UTIL_PKG.CRLF ||
'			</td> '||FBS_UTIL_PKG.CRLF ||
'		</tr> '||FBS_UTIL_PKG.CRLF ||
'		<tr> '||FBS_UTIL_PKG.CRLF ||
'			<td align=center> '||FBS_UTIL_PKG.CRLF ||
'				<table  border="0"> '||FBS_UTIL_PKG.CRLF ||
'					<tr> '||FBS_UTIL_PKG.CRLF ||
'						<td> '||FBS_UTIL_PKG.CRLF ||
'							&nbsp; '||FBS_UTIL_PKG.CRLF ||
'						</td> '||FBS_UTIL_PKG.CRLF ||
'						<td style="font-size:12px; text-decoration:none;"> '||FBS_UTIL_PKG.CRLF ;
	SUCCESS_CODE		constant	Varchar2(2) := 'OK';
	Type T_REC Is Table Of T_CARD_EXPENSE_DATA%RowType
		Index By Binary_Integer;
	Type T_TAR_REC Is Table Of T_CARD_ACCOUNTING_DETAIL_T.CARDNUMBER%Type
		Index By Binary_Integer;
	ltRec						T_REC;
	ltRecTar					T_TAR_REC;
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
		Ar_CardNumber			Varchar2,
		Ar_Msg					Varchar2
	)
	Is
	Begin
		If Ar_Msg = SUCCESS_CODE Then
			Update	T_CARD_ACCOUNTING_MASTER
			Set		MAILSENDRESULTMSG = SubStrb(Ar_Msg,1,300),
					MailSendDateTime = SysDate
			Where	CARDNUMBER = Ar_CardNumber
			And		AdjustYearMonth = To_Char(Sysdate,'YYYYMM');
		Else
			Update	T_CARD_ACCOUNTING_MASTER
			Set		MAILSENDRESULTMSG = SubStrb(Ar_Msg,1,300)
			Where	CARDNUMBER = Ar_CardNumber
			And		AdjustYearMonth = To_Char(Sysdate,'YYYYMM');
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
	--은행명 가져오기
	Function	GetBankName
	(
		Ar_BankCode				Varchar2
	)
	Return Varchar2
	Is
		lsName				Varchar2(100);
	Begin
		Select
			BANK_MAIN_NAME
		Into
			lsName
		From	T_BANK_MAIN a
		Where	a.BANK_MAIN_CODE = Ar_BankCode;
		Return lsName;
	Exception When No_Data_Found Then
		Return Null;
	End;
	Function	GetStatusName
	(
		Ar_Usage			Varchar2
	)
	Return Varchar2
	Is
	Begin
		If Ar_Usage = 'P' Then
			Return '개인분 확인';
		ElsIf Ar_Usage = 'C' Then
			Return '법인분 확인';
		Else
			Return '미확인';
		End If;
	End;
	--카드 이용내역을 생성한다.
	Function	BuildMailContents
	(
		Ar_CardNumber					Varchar2,
		Ar_CardInfo		In Out NoCopy	T_CARD_MEMBER_HISTORY%RowType
	)
	Return Long
	Is
		lsContents				Long := '';
		liI						Number;
		lnTotAmt				Number;
	Begin
		lsContents := HEAD_MSG||FBS_UTIL_PKG.CRLF||
							'카드번호 : '||Ar_CardNumber ||'<br>'||FBS_UTIL_PKG.CRLF||
							'소 지 자 : '||GetEmpInfo(Ar_CardInfo.CardOwnerEmpNo)||'<br>'||FBS_UTIL_PKG.CRLF||
							'대 리 인 : '||GetEmpInfo(Ar_CardInfo.CardSubstituteEmpNo)||'<br>'||FBS_UTIL_PKG.CRLF||
							'결재은행/계좌 : '||GetBankName(Ar_CardInfo.BANK_MAIN_CODE)||' '||Ar_CardInfo.ACCNO||'<br>'||FBS_UTIL_PKG.CRLF||
							'							<br>'||FBS_UTIL_PKG.CRLF||
							'							<br>'||FBS_UTIL_PKG.CRLF||
							'							<table width="100%" border="1" cellpadding="2" cellspacing="0"  style="font-size:12px; text-decoration:none;">'||FBS_UTIL_PKG.CRLF||
							'								<tr  style="background:#DCF2EC;font-size:12px; text-decoration:none;font-weight:bold;">'||FBS_UTIL_PKG.CRLF||
							'									<td width="40" align=center >'||FBS_UTIL_PKG.CRLF||
							'										번호'||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td width="140" align=center>'||FBS_UTIL_PKG.CRLF||
							'										사용일시'||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td width="180" align=center>'||FBS_UTIL_PKG.CRLF||
							'										사용처'||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td width="80" align=center>'||FBS_UTIL_PKG.CRLF||
							'										사용금액'||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td width="100" align=center>'||FBS_UTIL_PKG.CRLF||
							'										기확인내역'||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'								</tr>'||FBS_UTIL_PKG.CRLF;
		liI := 0;
		lnTotAmt := 0;
		For lrA In ( Select * From T_CARD_ACCOUNTING_DETAIL Where CardNumber = Ar_CardNumber And AdjustYearMonth = To_Char(Sysdate,'YYYYMM') Order By AcctSubSeq)
		Loop
			liI := liI + 1;
			lsContents := lsContents ||
							'								<tr >'||FBS_UTIL_PKG.CRLF||
							'									<td align=center >'||FBS_UTIL_PKG.CRLF||
							To_Char(liI)||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td align=center>'||FBS_UTIL_PKG.CRLF||
							'										'||F_T_STRINGTOYMDFORMAT(lrA.ApprovalDate)||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td align=left>'||FBS_UTIL_PKG.CRLF||
							'									<td align=left>'||FBS_UTIL_PKG.CRLF||
							'										'||lrA.MerchantName||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td align=right>'||FBS_UTIL_PKG.CRLF||
							'										'||To_Char(Nvl(lrA.SupplyAmt,0) + Nvl(lrA.VatAmt,0),'FM999,999,999,999,999,999,999')||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td align=left>'||FBS_UTIL_PKG.CRLF||
							'										'||GetStatusName(lrA.UsageGubun) ||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'								</tr>'||FBS_UTIL_PKG.CRLF;
							lnTotAmt := lnTotAmt + Nvl(lrA.SupplyAmt,0) + Nvl(lrA.VatAmt,0);
				
		End Loop;
		lsContents := lsContents ||
							'								<tr style="background:#E6E6FA;font-size:12px; text-decoration:none;font-weight:bold;">'||FBS_UTIL_PKG.CRLF||
							'									<td align=center colspan=3>'||FBS_UTIL_PKG.CRLF||
							'										총&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;합'||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td align=right>'||FBS_UTIL_PKG.CRLF||
							'										'||To_Char(lnTotAmt,'FM999,999,999,999,999,999,999')||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td >'||FBS_UTIL_PKG.CRLF||
							'										&nbsp;'||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'								</tr>'||FBS_UTIL_PKG.CRLF||
							'							</table>'||FBS_UTIL_PKG.CRLF||
							'						</td>'||FBS_UTIL_PKG.CRLF||
							'						<td>'||FBS_UTIL_PKG.CRLF||
							'							&nbsp;'||FBS_UTIL_PKG.CRLF||
							'						</td>'||FBS_UTIL_PKG.CRLF||
							'					</tr>'||FBS_UTIL_PKG.CRLF||
							'				</table>'||FBS_UTIL_PKG.CRLF||
							'			</td>'||FBS_UTIL_PKG.CRLF||
							'		</tr>'||FBS_UTIL_PKG.CRLF||
							'	</table>'||FBS_UTIL_PKG.CRLF||
							'</html>'||FBS_UTIL_PKG.CRLF;
		Return lsContents;
	Exception When Others Then
		UpdateErrm(Ar_CardNumber,SqlErrm);
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
		Ar_CardNumber			Varchar2
	)
	Is
		lrCardInfo				T_CARD_MEMBER_HISTORY%RowType;
		lsMailContents			Long;
		lsMsg					Varchar2(300) := SUCCESS_CODE;
		lsMsg2					Varchar2(300) := SUCCESS_CODE;
	Begin
		--카드의 현 소유자 및 현 대리인을 찾아 온다.(현재 보유상태)
		If Not GetCurrentCardInfo(Ar_CardNumber,lrCardInfo) Then
			UpdateErrm(Ar_CardNumber,'해당 카드의 보유 이력이 관리되고 있지 않습니다.');
			Return;
		End If;
		--카드 이용내역을 생성한다.
		lsMailContents := BuildMailContents(Ar_CardNumber,lrCardInfo);
		If lsMailContents Is Null Then
			Return;
		End If;
		--소유자 및 대리자에게 카드 사용내역을 발송한다.
		If lrCardInfo.CardSubstituteEmpNo Is Null And lrCardInfo.CardOwnerEmpNo Is Null Then
			UpdateErrm(Ar_CardNumber,'메일을 수신할 카드의 소유자 및 대리인이 등록되어 있지 않습니다.');
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
				UpdateErrm(Ar_CardNumber,SUCCESS_CODE);
			Else
				UpdateErrm(Ar_CardNumber,lsMsg||','||lsMsg2);
			End If;
		End If;
	Exception When Others Then
		UpdateErrm(Ar_CardNumber,SqlErrm);
	End;
Begin
	--설명이 필요없는 간단한 로직
	Insert Into T_CARD_ACCOUNTING_DETAIL_T
	(
		CARDNUMBER,
		ADJUSTYEARMONTH,
		ACCTSUBSEQ,
		SEQNO,
		CRAMT,
		DRAMT,
		SupplyAmt,
		VATAMT,
		TaxGubun,
		USAGEGUBUN ,
		MerchantName,
		APPROVALDATE ,
		APPROVALTIME,
		APPROVALNUMBER,
		MCCNAME,
		ChargeDate
	)
	Select
		a.CARDNUMBER,
		SubStrb(a.CHARGEDATE,4) ADJUSTYEARMONTH,
		a.SEQNO,
		a.SEQNO,
		0 CRAMT,
		0 DRAMT,
		Nvl(a.CARDAMT,0) + Nvl(a.SERVICEAMT,0) SupplyAmt,
		a.CARDSUMOFFEE VATAMT,
		a.TAXLINEYN TaxGubun,
		Nvl(b.USAGEGUBUN,'1') USAGEGUBUN ,
		a.MerchantName,
		a.APPROVALDATE ,
		a.APPROVALTIME,
		a.APPROVALNUMBER,
		a.MCCNAME,
		a.ChargeDate
	From	T_CARD_EXPENSE_DATA a,
			T_CARD_EXPENSE_DATA b
	Where	a.GUBUNCODE = '05'
	And		a.CHARGEDATE Like To_Char(Sysdate,'YYYYMM') || '%'
	And		a.CARDNUMBER = b.CARDNUMBER (+)
	And		a.CARDDUEDATE = b.CARDDUEDATE (+)
	And		a.COLLECTIONNUMBER = b.COLLECTIONNUMBER (+)
	And		b.GUBUNCODE (+) = '03'
	And		Not Exists
	(
		Select
			Null
		From	T_CARD_ACCOUNTING_MASTER b
		Where	a.CARDNUMBER = b.CARDNUMBER
		And		a.CHARGEDATE Like b.ADJUSTYEARMONTH || '%'
	);
	Select
		Distinct
		cardnumber
	bulk Collect Into
		ltRecTar
	From	T_CARD_ACCOUNTING_DETAIL_T;

	Merge Into T_CARD_ACCOUNTING_MASTER t
	Using
	(
		Select
			a.CARDNUMBER,
			a.ADJUSTYEARMONTH,
			a.ChargeDate,
			a.AdjustStatus,
			a.PERSONSUM,
			a.COMPANYSUM,
			a.TOTALSUM,
			(
				Select
					x.COMP_CODE
				From	T_ACC_CREDCARD x
				Where	x.CARDNO = a.CARDNUMBER
			) COMP_CODE,
			(
				Select
					yy.DEPT_CODE
				From	T_ACC_CREDCARD x,
						T_CARD_MEMBER_HISTORY y,
						Z_AUTHORITY_USER yy
				Where	x.CARDNO = a.CARDNUMBER
				And		x.CARD_SEQ = y.CARD_SEQ
				And		y.USESTARTDATE =
				(
					Select
						Max(y.USESTARTDATE)
					From	T_CARD_MEMBER_HISTORY z
					Where	y.CARD_SEQ = z.CARD_SEQ
				)
				And		y.CARDOWNEREMPNO = yy.EMPNO
			) DEPT_CODE
		From
			(
				Select
					a.CARDNUMBER,
					a.ADJUSTYEARMONTH,
					Min(a.ChargeDate) ChargeDate,
					'0' AdjustStatus,
					Sum(Decode(a.USAGEGUBUN,'P',Nvl(a.SUPPLYAMT,0) + Nvl(a.VATAMT,0))) PERSONSUM,
					Sum(Decode(a.USAGEGUBUN,'C',Nvl(a.SUPPLYAMT,0) + Nvl(a.VATAMT,0))) COMPANYSUM,
					Sum(Nvl(a.SUPPLYAMT,0) + Nvl(a.VATAMT,0)) TOTALSUM
				From	T_CARD_ACCOUNTING_DETAIL_T a
				Group By
					a.CARDNUMBER,
					a.ADJUSTYEARMONTH
			) a
	) s
	On
	(
		s.CARDNUMBER = t.CARDNUMBER
	And	s.ADJUSTYEARMONTH = t.ADJUSTYEARMONTH
	)
	When Matched Then
	Update
	Set		ChargeDate = s.ChargeDate,
			PERSONSUM = s.PERSONSUM,
			COMPANYSUM = s.COMPANYSUM,
			TOTALSUM = s.TOTALSUM
	When Not Matched Then
	Insert
	(
		CARDNUMBER,
		ADJUSTYEARMONTH,
		CHARGEDATE,
		SLIP_ID,
		SLIP_IDSEQ,
		COMP_CODE,
		DEPT_CODE,
		ADJUSTSTATUS,
		ADJUSTFINISHDATETIME,
		ACCOUNTINGCONFIRMDATE,
		COMPANYSUM,
		PERSONSUM,
		TOTALSUM,
		MAILSENDDATETIME,
		MAILSENDRESULTMSG,
		ATTRIBUTE1,
		ATTRIBUTE2,
		ATTRIBUTE3
	)
	Values
	(
		s.CARDNUMBER,
		s.ADJUSTYEARMONTH,
		s.CHARGEDATE,
		Null,
		Null,
		s.COMP_CODE,
		s.DEPT_CODE,
		s.ADJUSTSTATUS,
		Null,
		Null,
		s.COMPANYSUM,
		s.PERSONSUM,
		s.TOTALSUM,
		Null,
		Null,
		Null,
		Null,
		Null
	);
	Insert Into T_CARD_ACCOUNTING_DETAIL
	(
		CARDNUMBER,
		ADJUSTYEARMONTH,
		ACCTSUBSEQ,
		SEQNO,
		ACC_CODE,
		CRAMT,
		DRAMT,
		SUPPLYAMT,
		VATAMT,
		TAXGUBUN,
		USAGEGUBUN,
		MERCHANTNAME,
		APPROVALDATE,
		APPROVALTIME,
		APPROVALNUMBER,
		MCCNAME,
		ATTRIBUTE1,
		ATTRIBUTE2,
		ATTRIBUTE3,
		VAT_ACC_CODE,
		SLIP_ID,
		SLIP_IDSEQ,
		MERCHANTCODE
	)
	Select
		CARDNUMBER,
		ADJUSTYEARMONTH,
		ACCTSUBSEQ,
		SEQNO,
		ACC_CODE,
		CRAMT,
		DRAMT,
		SUPPLYAMT,
		VATAMT,
		TAXGUBUN,
		USAGEGUBUN,
		MERCHANTNAME,
		APPROVALDATE,
		APPROVALTIME,
		APPROVALNUMBER,
		MCCNAME,
		ATTRIBUTE1,
		ATTRIBUTE2,
		ATTRIBUTE3,
		VAT_ACC_CODE,
		SLIP_ID,
		SLIP_IDSEQ,
		MERCHANTCODE
	From	T_CARD_ACCOUNTING_DETAIL_T;

	liCount := ltRecTar.Count;
	liFirst := ltRecTar.First;
	liLast := ltRecTar.Last;
	For liI In liFirst..liLast Loop
		ProcessElem(ltRecTar(liI));
	End Loop;
End;
/
