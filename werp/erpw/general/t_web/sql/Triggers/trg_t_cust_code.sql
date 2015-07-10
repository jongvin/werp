Create Or Replace Trigger trg_t_cust_code
Before Insert Or Update Or Delete On t_cust_code
For Each Row
Begin
	If Inserting Or Updating Then
		If :New.CUST_CODE Is Null Then
			Raise_Application_Error(-20009,'사업자번호 또는 주민번호 또는 사번을 반드시 입력하십시오.');
		End If;
		If :New.TRADE_CLS = '1'	Then --사업자
			--사업자는 전체 필수
			If :New.ZIPCODE Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 우편번호를 반드시 입력하십시오.');
			End If;
			If :New.GROUP_COMP_CLS Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 계열사여부를 반드시 입력하십시오.');
			End If;
			If :New.BOSS_NAME Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 대표자명을 반드시 입력하십시오.');
			End If;
			If :New.BIZCOND Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 업태를 반드시 입력하십시오.');
			End If;
			If :New.BIZKND Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 업종을 반드시 입력하십시오.');
			End If;
			If :New.ADDR1 Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 주소를 반드시 입력하십시오.');
			End If;
			If :New.TELNO Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 전화번호를 반드시 입력하십시오.');
			End If;
		ElsIf :New.TRADE_CLS = '2'	Then --개인
			--개인은 업태,업종,전화번호는 선택사항
			If :New.ZIPCODE Is Null Then
				Raise_Application_Error(-20009,'우편번호를 반드시 입력하십시오.');
			End If;
			If :New.ADDR1 Is Null Then
				Raise_Application_Error(-20009,'주소를 반드시 입력하십시오.');
			End If;
		ElsIf :New.TRADE_CLS = '3'	Then --은행지점
			--은행은 전체 필수
			If :New.ZIPCODE Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 우편번호를 반드시 입력하십시오.');
			End If;
			If :New.GROUP_COMP_CLS Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 계열사여부를 반드시 입력하십시오.');
			End If;
			If :New.BOSS_NAME Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 대표자명을 반드시 입력하십시오.');
			End If;
			If :New.BIZCOND Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 업태를 반드시 입력하십시오.');
			End If;
			If :New.BIZKND Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 업종을 반드시 입력하십시오.');
			End If;
			If :New.ADDR1 Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 주소를 반드시 입력하십시오.');
			End If;
			If :New.TELNO Is Null Then
				Raise_Application_Error(-20009,'사업자의 경우는 전화번호를 반드시 입력하십시오.');
			End If;
		ElsIf :New.TRADE_CLS = '4'	Then --사원
			--사원은 제한 없음
			Null;
		ElsIf :New.TRADE_CLS = '5'	Then --부서
			--부서도 제한 없음
			Null;
		ElsIf :New.TRADE_CLS = '9'	Then --기타
			--기타도 제한 없음
			Null;
		End If;
		If Updating Then
			If :New.CUST_CODE <> :Old.CUST_CODE Then
				Begin
					Update	T_CUST_CODE_UNQ
					Set		CUST_CODE = :New.CUST_CODE
					Where	CUST_CODE = :Old.CUST_CODE;
				Exception When Dup_Val_On_Index Then
					Raise_Application_Error(-20009,'해당 사업자번호는 이미 존재합니다.');
				End;
			End If;
		Else
			Begin
				Insert Into T_CUST_CODE_UNQ
				(
					CUST_CODE
				)
				Values
				(
					:New.CUST_CODE
				);
			Exception When Dup_Val_On_Index Then
				Raise_Application_Error(-20009,'해당 사업자번호는 이미 존재합니다.');
			End;
		End If;
	Else
		Delete	T_CUST_CODE_UNQ
		Where	CUST_CODE = :Old.CUST_CODE;
	End If;
End;
/
