Create Or Replace Function F_T_NEW_CUST
(
	Ar_CUST_CODE				T_CUST_CODE.CUST_CODE%Type,				--����ڹ�ȣ(�ʼ�) ������ ������ ��
	Ar_CUST_NAME				T_CUST_CODE.CUST_NAME%Type,				--����ڸ�(�ʼ�)
	Ar_BOSS_NAME				T_CUST_CODE.BOSS_NAME%Type,				--��ǥ�ڸ�
	Ar_TRADE_CLS				T_CUST_CODE.TRADE_CLS%Type,				--����ڱ���	1: ����� 2: �ֹι�ȣ 3: �������� 4:��� 5:�μ� 9: ��Ÿ (�ʼ�)
	Ar_BIZCOND					T_CUST_CODE.BIZCOND%Type,				--����
	Ar_BIZKND					T_CUST_CODE.BIZKND%Type,				--����
	Ar_ZIPCODE					T_CUST_CODE.ZIPCODE%Type,				--�����ȣ ������ ������ ��
	Ar_ADDR1					T_CUST_CODE.ADDR1%Type,					--�ּ�1 (������)
	Ar_ADDR2					T_CUST_CODE.ADDR2%Type,					--�ּ�2 (����)
	Ar_TELNO					T_CUST_CODE.TELNO%Type,					--��ȭ��ȣ
	Ar_GROUP_COMP_CLS			T_CUST_CODE.GROUP_COMP_CLS%Type,		--ZZ:��迭�� AA:���� AB:�迭��	(�ʼ�)
	Ar_USE_CLS					T_CUST_CODE.USE_CLS%Type,				--��뿩�� T/F	Null�� �Ѿ���� �⺻���� T�� �ȴ�
	Ar_REPRESENT_CUST_SEQ		T_CUST_CODE.REPRESENT_CUST_SEQ%Type,	--��ǥ�ŷ�ó���� Null�� �Ѿ���� �ڱⰡ ��ǥ�ŷ�ó��.
	Ar_TR_MANAGER_NAME			T_CUST_CODE.TR_MANAGER_NAME%Type,		--����� ����
	Ar_TR_MANAGER_EMAIL			T_CUST_CODE.TR_MANAGER_EMAIL%Type,		--����� EMAIL
	Ar_CRTUSERNO				T_CUST_CODE.CRTUSERNO%Type				--�Է��� ��� (�ʼ�)
)
Return	Number															--���ϰ��� �ŷ�ó ����(Key��)... ���� ������ ���� Raise��Ų��.
Is
	lnCustSeq					Number;
	lnCnt						Number;
Begin
	If Ar_CUST_CODE Is Null then
		Raise_Application_Error(-20009,'����ڹ�ȣ�� �Է��Ͻʽÿ�.');
	End If;
	If Ar_CUST_NAME Is Null then
		Raise_Application_Error(-20009,'��ü���� �Է��Ͻʽÿ�.');
	End If;
	If Ar_TRADE_CLS Is Null then
		Raise_Application_Error(-20009,'����ڱ����� �Է��Ͻʽÿ�.');
	End If;
	If Ar_CRTUSERNO Is Null then
		Raise_Application_Error(-20009,'�Է��ڻ���� �Է��Ͻʽÿ�.');
	End If;
	If Ar_GROUP_COMP_CLS Is Null then
		Raise_Application_Error(-20009,'�迭�籸���� �Է��Ͻʽÿ�.');
	End If;
	If Instr(Ar_CUST_CODE,'-') > 0 then
		Raise_Application_Error(-20009,'����ڹ�ȣ���� -(������)�� �����ϰ� �Է��Ͻʽÿ�.');
	End If;
	If Instr(Ar_ZIPCODE,'-') > 0 then
		Raise_Application_Error(-20009,'�����ȣ���� -(������)�� �����ϰ� �Է��Ͻʽÿ�.');
	End If;
	If Ar_TRADE_CLS Not In ('1','2','3','4','5','9') Then
		Raise_Application_Error(-20009,'�ùٸ��� ���� ����ڱ����Դϴ�. 1: ����� 2: �ֹι�ȣ 3: �������� 4:��� 5:�μ� 9: ��Ÿ');
	End If;
	If Nvl(Ar_USE_CLS,'T') Not In ('T','F') Then
		Raise_Application_Error(-20009,'��뿩�ΰ� �ùٸ��� �ʽ��ϴ�.');
	End If;
	Select
		Sq_T_Cust_Seq.NextVal
	Into
		lnCustSeq
	From	Dual;
	Select
		Count(*)
	Into
		lnCnt
	From	T_CUST_CODE
	Where	CUST_CODE = Ar_CUST_CODE
	And		RowNum < 2;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'�̹� ��ϵ� �ŷ�ó�Դϴ�.');
	End If;
	--ȸ�� ���� ��û���׿� ���� ����.
	--������� ��� ȭ�鿡 �ʿ��� ��� ������ �ʼ��� �ش޶�!
	If Ar_TRADE_CLS = '1' Or LengthB(Ar_CUST_CODE) = 10 Then
		If Ar_CUST_NAME Is Null Then
			Raise_Application_Error(-20009,'�ŷ�ó���� �ʼ������Դϴ�.');
		End If;
		If Ar_BIZCOND Is Null Then
			Raise_Application_Error(-20009,'���´� �ʼ������Դϴ�.');
		End If;
		If Ar_BIZKND Is Null Then
			Raise_Application_Error(-20009,'������ �ʼ������Դϴ�.');
		End If;
		If Ar_ZIPCODE Is Null Then
			Raise_Application_Error(-20009,'�����ȣ�� �ʼ������Դϴ�.');
		End If;
		If Ar_ADDR1 Is Null Then
			Raise_Application_Error(-20009,'�ּҴ� �ʼ������Դϴ�.');
		End If;
		If Ar_TELNO Is Null Then
			Raise_Application_Error(-20009,'��ȭ��ȣ�� �ʼ������Դϴ�.');
		End If;
	End If;
	Insert Into T_CUST_CODE
	(
		CUST_SEQ,
		CUST_CODE,
		CUST_NAME,
		BOSS_NAME,
		TRADE_CLS,
		BIZCOND,
		BIZKND,
		ZIPCODE,
		ADDR1,
		ADDR2,
		TELNO,
		GROUP_COMP_CLS,
		USE_CLS,
		REPRESENT_CUST_SEQ,
		TR_MANAGER_NAME,
		TR_MANAGER_EMAIL,
		CRTUSERNO
	)
	Values
	(
		lnCustSeq,
		Ar_CUST_CODE,
		Ar_CUST_NAME,
		Ar_BOSS_NAME,
		Ar_TRADE_CLS,
		Ar_BIZCOND,
		Ar_BIZKND,
		Ar_ZIPCODE,
		Ar_ADDR1,
		Ar_ADDR2,
		Ar_TELNO,
		Ar_GROUP_COMP_CLS,
		Nvl(Ar_USE_CLS,'T'),
		Nvl(Ar_REPRESENT_CUST_SEQ,lnCustSeq),
		Ar_TR_MANAGER_NAME,
		Ar_TR_MANAGER_EMAIL,
		Ar_CRTUSERNO
	);
	Return lnCustSeq;
End;
/
