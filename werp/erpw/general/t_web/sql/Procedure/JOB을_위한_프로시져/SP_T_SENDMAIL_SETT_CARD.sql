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
'							���ϰ� �����Ͻ� ����ī�忡 ���Ͽ� �ϱ�� ���� û�������� �뺸�Ǿ����ϴ�.<br> '||FBS_UTIL_PKG.CRLF ||
'							ȸ��ý����� [����ī���������] ȭ������ �����Ͻþ� ���� ���п� ���Ͽ� ���� �Է��� �ϱ�� �ٶ��ϴ�.<br> '||FBS_UTIL_PKG.CRLF ||
'							���κ��� ���, ������ ���κ����� ��ŷ�� �Ͻ� �� ���� ���� ó���Ͻñ� �ٶ��ϴ�.<br> '||FBS_UTIL_PKG.CRLF ||
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
	--����� �̸��� �ּ� ��������
	Function	GetEmpsMailAddress
	(
		Ar_EmpNo				Varchar2
	)
	Return Varchar2
	Is
	Begin
		Return Null;		--��ã����
	End;
	--ī���� �� ������ �� �� �븮���� ã�� �´�.(���� ��������)
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
	--��� ���� �������� (����� �̸���...)
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
	--����� ��������
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
			Return '���κ� Ȯ��';
		ElsIf Ar_Usage = 'C' Then
			Return '���κ� Ȯ��';
		Else
			Return '��Ȯ��';
		End If;
	End;
	--ī�� �̿볻���� �����Ѵ�.
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
							'ī���ȣ : '||Ar_CardNumber ||'<br>'||FBS_UTIL_PKG.CRLF||
							'�� �� �� : '||GetEmpInfo(Ar_CardInfo.CardOwnerEmpNo)||'<br>'||FBS_UTIL_PKG.CRLF||
							'�� �� �� : '||GetEmpInfo(Ar_CardInfo.CardSubstituteEmpNo)||'<br>'||FBS_UTIL_PKG.CRLF||
							'��������/���� : '||GetBankName(Ar_CardInfo.BANK_MAIN_CODE)||' '||Ar_CardInfo.ACCNO||'<br>'||FBS_UTIL_PKG.CRLF||
							'							<br>'||FBS_UTIL_PKG.CRLF||
							'							<br>'||FBS_UTIL_PKG.CRLF||
							'							<table width="100%" border="1" cellpadding="2" cellspacing="0"  style="font-size:12px; text-decoration:none;">'||FBS_UTIL_PKG.CRLF||
							'								<tr  style="background:#DCF2EC;font-size:12px; text-decoration:none;font-weight:bold;">'||FBS_UTIL_PKG.CRLF||
							'									<td width="40" align=center >'||FBS_UTIL_PKG.CRLF||
							'										��ȣ'||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td width="140" align=center>'||FBS_UTIL_PKG.CRLF||
							'										����Ͻ�'||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td width="180" align=center>'||FBS_UTIL_PKG.CRLF||
							'										���ó'||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td width="80" align=center>'||FBS_UTIL_PKG.CRLF||
							'										���ݾ�'||FBS_UTIL_PKG.CRLF||
							'									</td>'||FBS_UTIL_PKG.CRLF||
							'									<td width="100" align=center>'||FBS_UTIL_PKG.CRLF||
							'										��Ȯ�γ���'||FBS_UTIL_PKG.CRLF||
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
							'										��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��'||FBS_UTIL_PKG.CRLF||
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
	--������� ������ �߼��Ѵ�.
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
			Return '��� : '||Ar_EmpNo||'�� �����ּҸ� ã�� �� �����ϴ�.';
		End If;
		lsName := GetEmpName(Ar_EmpNo);
		If lsName Is Null Then
			Return '��� : '||Ar_EmpNo||'�� ������ ã�� �� �����ϴ�.';
		End If;
		Return FBS_UTIL_PKG.mail_send(lsName||'<'||lsMailAddress||'>',null,'����ī�� ��볻��',Ar_Contents,'N');
	Exception When Others Then
		Return SqlErrm;
	End;
	--ī�� ��볻���� �ѰǾ� ó��
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
		--ī���� �� ������ �� �� �븮���� ã�� �´�.(���� ��������)
		If Not GetCurrentCardInfo(Ar_CardNumber,lrCardInfo) Then
			UpdateErrm(Ar_CardNumber,'�ش� ī���� ���� �̷��� �����ǰ� ���� �ʽ��ϴ�.');
			Return;
		End If;
		--ī�� �̿볻���� �����Ѵ�.
		lsMailContents := BuildMailContents(Ar_CardNumber,lrCardInfo);
		If lsMailContents Is Null Then
			Return;
		End If;
		--������ �� �븮�ڿ��� ī�� ��볻���� �߼��Ѵ�.
		If lrCardInfo.CardSubstituteEmpNo Is Null And lrCardInfo.CardOwnerEmpNo Is Null Then
			UpdateErrm(Ar_CardNumber,'������ ������ ī���� ������ �� �븮���� ��ϵǾ� ���� �ʽ��ϴ�.');
		Else
			--���������� ������
			If lrCardInfo.CardOwnerEmpNo Is Not Null Then
				lsMsg := SendMailToEmp(lrCardInfo.CardOwnerEmpNo,lsMailContents);
			End If;
			--�븮������ ������
			If lrCardInfo.CardSubstituteEmpNo Is Not Null Then
				lsMsg2 := SendMailToEmp(lrCardInfo.CardSubstituteEmpNo,lsMailContents);
			End If;
			--�Ѵ� �����̸� �����̴�.
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
	--������ �ʿ���� ������ ����
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
