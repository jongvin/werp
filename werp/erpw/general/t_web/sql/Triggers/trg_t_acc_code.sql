Create Or Replace Trigger trg_t_acc_code
Before Insert Or Update On t_acc_code
For Each Row
Begin
	If :New.ACC_REMAIN_POSITION = 'T' Then	--만약 잔액관리라면
		If :New.CUST_CODE_MNG = 'T' And :New.CUST_CODE_MNG_TG = 'T' Then
			Null;
		Else
			Raise_Application_Error(-20009,'잔액관리 계정은 반드시 거래처코드 관리를 필수로 하여야 합니다.');
		End If;
		If :New.BILL_NO_MNG_TG = 'T' Then	--지급어음이 필수라면
			Raise_Application_Error(-20009,'지급어음을 필수로 관리하는 경우는 잔액관리로 지정하지 않아도 잔액이 관리됩니다.');
		End If;
		If :New.REC_BILL_NO_MNG_TG = 'T' Then	--받을어음이 필수라면
			Raise_Application_Error(-20009,'받을어음을 필수로 관리하는 경우는 잔액관리로 지정하지 않아도 잔액이 관리됩니다.');
		End If;
		If :New.CP_NO_MNG_TG = 'T' Then	--CP매입이 필수라면
			Raise_Application_Error(-20009,'CP매입을 필수로 관리하는 경우는 잔액관리로 지정하지 않아도 잔액이 관리됩니다.');
		End If;
		If :New.SECU_MNG_TG = 'T' Then	--유가증권이 필수라면
			Raise_Application_Error(-20009,'유가증권을 필수로 관리하는 경우는 잔액관리로 지정하지 않아도 잔액이 관리됩니다.');
		End If;
		If :New.LOAN_NO_MNG_TG = 'T' Then	--차입번호가 필수라면
			Raise_Application_Error(-20009,'차입번호를 필수로 관리하는 경우는 잔액관리로 지정하지 않아도 잔액이 관리됩니다.');
		End If;
	End If;
	If :New.BILL_NO_MNG_TG = 'T' Or :New.REC_BILL_NO_MNG_TG = 'T' Or :New.CP_NO_MNG_TG = 'T' Or :New.SECU_MNG_TG = 'T' Or :New.LOAN_NO_MNG_TG = 'T' Then
		If :New.CUST_CODE_MNG = 'T' And :New.CUST_CODE_MNG_TG = 'T' Then
			Null;
		Else
			Raise_Application_Error(-20009,'지급어음,받을어음,CP번호,유가증권,차입번호등을 필수로 관리하는 계정은 반드시 거래처코드 관리를 필수로 하여야 합니다.');
		End If;
	End If;
End;
/
