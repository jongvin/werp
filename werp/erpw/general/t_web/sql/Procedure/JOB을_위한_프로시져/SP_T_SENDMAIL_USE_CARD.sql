Create Or Replace Procedure SP_T_SENDMAIL_USE_CARD
Is
	HEAD_MSG			constant	Varchar2(4000) :=
	'���ϰ� �����Ͻ� ����ī�忡 ���Ͽ� �ϱ�� ���� ���(���Ա���)������ �뺸�Ǿ����ϴ�.'||FBS_UTIL_PKG.CRLF ||
	'���λ��а� ���λ����� �з��Ͻþ� [����ī���̿볻�����]���� �з� �����Ͽ� �ֽñ� �ٶ��ϴ�.'||FBS_UTIL_PKG.CRLF||FBS_UTIL_PKG.CRLF;
	SUCCESS_CODE		constant	Varchar2(2) := 'OK';
	Type T_REC Is Table Of T_CARD_EXPENSE_DATA%RowType
		Index By Binary_Integer;
	ltRec						T_REC;
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
	--ī�� �̿볻���� �����Ѵ�.
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
			'ī���ȣ : '||Ar_Rec.CardNumber ||FBS_UTIL_PKG.CRLF||
			'�� �� �� : '||GetEmpInfo(Ar_CardInfo.CardOwnerEmpNo)||FBS_UTIL_PKG.CRLF||
			'�� �� �� : '||GetEmpInfo(Ar_CardInfo.CardSubstituteEmpNo)||FBS_UTIL_PKG.CRLF||
			FBS_UTIL_PKG.CRLF||
			'������� : '||F_T_StringToYMDFormat(Ar_Rec.JobDate)||FBS_UTIL_PKG.CRLF||
			'�� �� ó : '||Ar_Rec.MerchantName||' ('||Ar_Rec.MerchantSocialNo||')'||FBS_UTIL_PKG.CRLF||
			'���ݾ� : ';
		If Ar_Rec.OVERSEAUSE = '1' Then		--��������
			lsContents := lsContents || To_Char(Ar_Rec.APPROVALSUMAMT,'FM999,999,999,999,999,999,990')||'��';
		Else								--��������
			lsContents := lsContents || To_Char(Ar_Rec.DomesticConversionAmt,'FM999,999,999,999,999,999,990')||'��'||FBS_UTIL_PKG.CRLF||
				'������ȭ : '||To_Char(Ar_Rec.LocalAmt,'FM999,999,999,999,999,999,990');
		End If;
		Return lsContents;
	Exception When Others Then
		UpdateErrm(Ar_Rec.SEQNO,SqlErrm);
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
		Ar_Rec			In Out NoCopy T_CARD_EXPENSE_DATA%RowType
	)
	Is
		lrCardInfo				T_CARD_MEMBER_HISTORY%RowType;
		lsMailContents			Varchar2(4000);
		lsMsg					Varchar2(300) := SUCCESS_CODE;
		lsMsg2					Varchar2(300) := SUCCESS_CODE;
	Begin
		--ī���� �� ������ �� �� �븮���� ã�� �´�.(���� ��������)
		If Not GetCurrentCardInfo(Ar_Rec.CardNumber,lrCardInfo) Then
			UpdateErrm(Ar_Rec.SEQNO,'�ش� ī���� ���� �̷��� �����ǰ� ���� �ʽ��ϴ�.');
			Return;
		End If;
		--ī�� �̿볻���� �����Ѵ�.
		lsMailContents := BuildMailContents(Ar_Rec,lrCardInfo);
		If lsMailContents Is Null Then
			Return;
		End If;
		--������ �� �븮�ڿ��� ī�� ��볻���� �߼��Ѵ�.
		If lrCardInfo.CardSubstituteEmpNo Is Null And lrCardInfo.CardOwnerEmpNo Is Null Then
			UpdateErrm(Ar_Rec.SEQNO,'������ ������ ī���� ������ �� �븮���� ��ϵǾ� ���� �ʽ��ϴ�.');
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
				UpdateErrm(Ar_Rec.SEQNO,SUCCESS_CODE);
			Else
				UpdateErrm(Ar_Rec.SEQNO,lsMsg||','||lsMsg2);
			End If;
		End If;
	Exception When Others Then
		UpdateErrm(Ar_Rec.SEQNO,SqlErrm);
	End;
Begin
	--������ �ʿ���� ������ ����
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
