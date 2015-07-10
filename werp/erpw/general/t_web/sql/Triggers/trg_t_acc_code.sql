Create Or Replace Trigger trg_t_acc_code
Before Insert Or Update On t_acc_code
For Each Row
Begin
	If :New.ACC_REMAIN_POSITION = 'T' Then	--���� �ܾװ������
		If :New.CUST_CODE_MNG = 'T' And :New.CUST_CODE_MNG_TG = 'T' Then
			Null;
		Else
			Raise_Application_Error(-20009,'�ܾװ��� ������ �ݵ�� �ŷ�ó�ڵ� ������ �ʼ��� �Ͽ��� �մϴ�.');
		End If;
		If :New.BILL_NO_MNG_TG = 'T' Then	--���޾����� �ʼ����
			Raise_Application_Error(-20009,'���޾����� �ʼ��� �����ϴ� ���� �ܾװ����� �������� �ʾƵ� �ܾ��� �����˴ϴ�.');
		End If;
		If :New.REC_BILL_NO_MNG_TG = 'T' Then	--���������� �ʼ����
			Raise_Application_Error(-20009,'���������� �ʼ��� �����ϴ� ���� �ܾװ����� �������� �ʾƵ� �ܾ��� �����˴ϴ�.');
		End If;
		If :New.CP_NO_MNG_TG = 'T' Then	--CP������ �ʼ����
			Raise_Application_Error(-20009,'CP������ �ʼ��� �����ϴ� ���� �ܾװ����� �������� �ʾƵ� �ܾ��� �����˴ϴ�.');
		End If;
		If :New.SECU_MNG_TG = 'T' Then	--���������� �ʼ����
			Raise_Application_Error(-20009,'���������� �ʼ��� �����ϴ� ���� �ܾװ����� �������� �ʾƵ� �ܾ��� �����˴ϴ�.');
		End If;
		If :New.LOAN_NO_MNG_TG = 'T' Then	--���Թ�ȣ�� �ʼ����
			Raise_Application_Error(-20009,'���Թ�ȣ�� �ʼ��� �����ϴ� ���� �ܾװ����� �������� �ʾƵ� �ܾ��� �����˴ϴ�.');
		End If;
	End If;
	If :New.BILL_NO_MNG_TG = 'T' Or :New.REC_BILL_NO_MNG_TG = 'T' Or :New.CP_NO_MNG_TG = 'T' Or :New.SECU_MNG_TG = 'T' Or :New.LOAN_NO_MNG_TG = 'T' Then
		If :New.CUST_CODE_MNG = 'T' And :New.CUST_CODE_MNG_TG = 'T' Then
			Null;
		Else
			Raise_Application_Error(-20009,'���޾���,��������,CP��ȣ,��������,���Թ�ȣ���� �ʼ��� �����ϴ� ������ �ݵ�� �ŷ�ó�ڵ� ������ �ʼ��� �Ͽ��� �մϴ�.');
		End If;
	End If;
End;
/
