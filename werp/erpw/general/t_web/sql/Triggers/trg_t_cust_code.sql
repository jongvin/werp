Create Or Replace Trigger trg_t_cust_code
Before Insert Or Update Or Delete On t_cust_code
For Each Row
Begin
	If Inserting Or Updating Then
		If :New.CUST_CODE Is Null Then
			Raise_Application_Error(-20009,'����ڹ�ȣ �Ǵ� �ֹι�ȣ �Ǵ� ����� �ݵ�� �Է��Ͻʽÿ�.');
		End If;
		If :New.TRADE_CLS = '1'	Then --�����
			--����ڴ� ��ü �ʼ�
			If :New.ZIPCODE Is Null Then
				Raise_Application_Error(-20009,'������� ���� �����ȣ�� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.GROUP_COMP_CLS Is Null Then
				Raise_Application_Error(-20009,'������� ���� �迭�翩�θ� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.BOSS_NAME Is Null Then
				Raise_Application_Error(-20009,'������� ���� ��ǥ�ڸ��� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.BIZCOND Is Null Then
				Raise_Application_Error(-20009,'������� ���� ���¸� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.BIZKND Is Null Then
				Raise_Application_Error(-20009,'������� ���� ������ �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.ADDR1 Is Null Then
				Raise_Application_Error(-20009,'������� ���� �ּҸ� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.TELNO Is Null Then
				Raise_Application_Error(-20009,'������� ���� ��ȭ��ȣ�� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
		ElsIf :New.TRADE_CLS = '2'	Then --����
			--������ ����,����,��ȭ��ȣ�� ���û���
			If :New.ZIPCODE Is Null Then
				Raise_Application_Error(-20009,'�����ȣ�� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.ADDR1 Is Null Then
				Raise_Application_Error(-20009,'�ּҸ� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
		ElsIf :New.TRADE_CLS = '3'	Then --��������
			--������ ��ü �ʼ�
			If :New.ZIPCODE Is Null Then
				Raise_Application_Error(-20009,'������� ���� �����ȣ�� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.GROUP_COMP_CLS Is Null Then
				Raise_Application_Error(-20009,'������� ���� �迭�翩�θ� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.BOSS_NAME Is Null Then
				Raise_Application_Error(-20009,'������� ���� ��ǥ�ڸ��� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.BIZCOND Is Null Then
				Raise_Application_Error(-20009,'������� ���� ���¸� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.BIZKND Is Null Then
				Raise_Application_Error(-20009,'������� ���� ������ �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.ADDR1 Is Null Then
				Raise_Application_Error(-20009,'������� ���� �ּҸ� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
			If :New.TELNO Is Null Then
				Raise_Application_Error(-20009,'������� ���� ��ȭ��ȣ�� �ݵ�� �Է��Ͻʽÿ�.');
			End If;
		ElsIf :New.TRADE_CLS = '4'	Then --���
			--����� ���� ����
			Null;
		ElsIf :New.TRADE_CLS = '5'	Then --�μ�
			--�μ��� ���� ����
			Null;
		ElsIf :New.TRADE_CLS = '9'	Then --��Ÿ
			--��Ÿ�� ���� ����
			Null;
		End If;
		If Updating Then
			If :New.CUST_CODE <> :Old.CUST_CODE Then
				Begin
					Update	T_CUST_CODE_UNQ
					Set		CUST_CODE = :New.CUST_CODE
					Where	CUST_CODE = :Old.CUST_CODE;
				Exception When Dup_Val_On_Index Then
					Raise_Application_Error(-20009,'�ش� ����ڹ�ȣ�� �̹� �����մϴ�.');
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
				Raise_Application_Error(-20009,'�ش� ����ڹ�ȣ�� �̹� �����մϴ�.');
			End;
		End If;
	Else
		Delete	T_CUST_CODE_UNQ
		Where	CUST_CODE = :Old.CUST_CODE;
	End If;
End;
/
