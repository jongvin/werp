Create Or Replace Procedure SP_T_FIN_MAKE_NP_DATA
(
	Ar_Work_No					Number,
	Ar_CrtUserNo				Varchar2
)
Is
	lrRec						T_FIN_SEC_NP_ITR_WORK%Rowtype;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_SEC_NP_ITR_WORK
		Where	Work_No = Ar_Work_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'�������� �̼����� ��ǥ�����۾��� ã�� �� �����ϴ�.');
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'�̹� ��ǥ�� ����Ǿ� �ֽ��ϴ�.');
	End If;
	If lrRec.CALC_DT_FROM Is Null Or lrRec.CALC_DT_TO Is Null Then
		Raise_Application_Error(-20009,'���۾��� �ϱ����� ���� ���ڰ�� �Ⱓ�� �Է��Ͽ� ������ �� �۾��� �Ͻñ� �ٶ��ϴ�.');
	End If;
	If lrRec.TARGET_COMP_CODE Is Null Then
		Raise_Application_Error(-20009,'���۾��� �ϱ����� ���� �۾���� ������� �Է��Ͽ� ������ �� �۾��� �Ͻñ� �ٶ��ϴ�.');
	End If;
	SP_T_FIN_ONLY_MAKE_NP_DATA(Ar_Work_No,Ar_CrtUserNo);
	SP_T_FIN_REAL_MAKE_NP_DATA(Ar_Work_No,Ar_CrtUserNo);
End;
/
