Create Or Replace Function F_T_NEW_CUST
(
	Ar_CUST_CODE				T_CUST_CODE.CUST_CODE%Type,				--사업자번호(필수) 하이픈 제거한 것
	Ar_CUST_NAME				T_CUST_CODE.CUST_NAME%Type,				--사업자명(필수)
	Ar_BOSS_NAME				T_CUST_CODE.BOSS_NAME%Type,				--대표자명
	Ar_TRADE_CLS				T_CUST_CODE.TRADE_CLS%Type,				--사업자구분	1: 사업자 2: 주민번호 3: 은행지점 4:사번 5:부서 9: 기타 (필수)
	Ar_BIZCOND					T_CUST_CODE.BIZCOND%Type,				--업태
	Ar_BIZKND					T_CUST_CODE.BIZKND%Type,				--업종
	Ar_ZIPCODE					T_CUST_CODE.ZIPCODE%Type,				--우편번호 하이픈 제거한 것
	Ar_ADDR1					T_CUST_CODE.ADDR1%Type,					--주소1 (동까지)
	Ar_ADDR2					T_CUST_CODE.ADDR2%Type,					--주소2 (번지)
	Ar_TELNO					T_CUST_CODE.TELNO%Type,					--전화번호
	Ar_GROUP_COMP_CLS			T_CUST_CODE.GROUP_COMP_CLS%Type,		--ZZ:비계열사 AA:제당 AB:계열사	(필수)
	Ar_USE_CLS					T_CUST_CODE.USE_CLS%Type,				--사용여부 T/F	Null이 넘어오면 기본값이 T가 된다
	Ar_REPRESENT_CUST_SEQ		T_CUST_CODE.REPRESENT_CUST_SEQ%Type,	--대표거래처순번 Null이 넘어오면 자기가 대표거래처다.
	Ar_TR_MANAGER_NAME			T_CUST_CODE.TR_MANAGER_NAME%Type,		--담당자 성명
	Ar_TR_MANAGER_EMAIL			T_CUST_CODE.TR_MANAGER_EMAIL%Type,		--담당자 EMAIL
	Ar_CRTUSERNO				T_CUST_CODE.CRTUSERNO%Type				--입력자 사번 (필수)
)
Return	Number															--리턴값은 거래처 순번(Key값)... 만약 에러가 나면 Raise시킨다.
Is
	lnCustSeq					Number;
	lnCnt						Number;
Begin
	If Ar_CUST_CODE Is Null then
		Raise_Application_Error(-20009,'사업자번호를 입력하십시오.');
	End If;
	If Ar_CUST_NAME Is Null then
		Raise_Application_Error(-20009,'업체명을 입력하십시오.');
	End If;
	If Ar_TRADE_CLS Is Null then
		Raise_Application_Error(-20009,'사업자구분을 입력하십시오.');
	End If;
	If Ar_CRTUSERNO Is Null then
		Raise_Application_Error(-20009,'입력자사번을 입력하십시오.');
	End If;
	If Ar_GROUP_COMP_CLS Is Null then
		Raise_Application_Error(-20009,'계열사구분을 입력하십시오.');
	End If;
	If Instr(Ar_CUST_CODE,'-') > 0 then
		Raise_Application_Error(-20009,'사업자번호에서 -(하이픈)을 제거하고 입력하십시오.');
	End If;
	If Instr(Ar_ZIPCODE,'-') > 0 then
		Raise_Application_Error(-20009,'우편번호에서 -(하이픈)을 제거하고 입력하십시오.');
	End If;
	If Ar_TRADE_CLS Not In ('1','2','3','4','5','9') Then
		Raise_Application_Error(-20009,'올바르지 않은 사업자구분입니다. 1: 사업자 2: 주민번호 3: 은행지점 4:사번 5:부서 9: 기타');
	End If;
	If Nvl(Ar_USE_CLS,'T') Not In ('T','F') Then
		Raise_Application_Error(-20009,'사용여부가 올바르지 않습니다.');
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
		Raise_Application_Error(-20009,'이미 등록된 거래처입니다.');
	End If;
	--회계 최종 요청사항에 의한 변경.
	--사업자의 경우 화면에 필요한 모든 사항을 필수로 해달라!
	If Ar_TRADE_CLS = '1' Or LengthB(Ar_CUST_CODE) = 10 Then
		If Ar_CUST_NAME Is Null Then
			Raise_Application_Error(-20009,'거래처명은 필수사항입니다.');
		End If;
		If Ar_BIZCOND Is Null Then
			Raise_Application_Error(-20009,'업태는 필수사항입니다.');
		End If;
		If Ar_BIZKND Is Null Then
			Raise_Application_Error(-20009,'업종은 필수사항입니다.');
		End If;
		If Ar_ZIPCODE Is Null Then
			Raise_Application_Error(-20009,'우편번호는 필수사항입니다.');
		End If;
		If Ar_ADDR1 Is Null Then
			Raise_Application_Error(-20009,'주소는 필수사항입니다.');
		End If;
		If Ar_TELNO Is Null Then
			Raise_Application_Error(-20009,'전화번호는 필수사항입니다.');
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
