CREATE OR REPLACE PROCEDURE Sp_T_Acc_Slip_Conf
(
	Ar_Slip_Id				NUMBER,
	Ar_KEEP_SLIPNO			VARCHAR2,
	Ar_Keep_Dt				VARCHAR2,
	Ar_Keep_Dt_Trans		VARCHAR2,
	Ar_Keep_Dept			VARCHAR2,
	Ar_KEEP_KEEPER			NUMBER,
	Ar_Confirm_YN			VARCHAR2		--T,F
)
IS
/***************************************************/
/* �� ���α׷��� �뺸�ý���(��) �� ����Դϴ�.
/* �����ۼ��� : �����
/* �����ۼ��� : 2004-12-15
/* ���������� :
/* ���������� :
/* ���� ����  : ������ ��ǥ Ȯ�� ���� ó���� Sp_T_Acc_Slip_Conf_Core �Լ��� �Ѱ���ϴ�.
/*              ������ ������ ��ǥ ó�� �����Դϴ�.
/*              ������ ��ǥ�� ��� ���� ��ǥ�� Ȯ���� ���� ��ǥ�� Ȯ������ �̾����� �ϱ� �����Դϴ�.
/***************************************************/
	lsKeepSlipNo					t_acc_slip_head.KEEP_SLIPNO%Type;
	lnCnt							Number;
Begin
	Select
		Count(*)
	Into
		lnCnt
	From	T_ACC_B_C_SLIP_INFO
	Where	SLIP_ID = Ar_Slip_Id
	And		BC_TAG In ('B','D');
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'������ ��ǥ�� ���� ��ǥ�� ���� ��ǥ������ Ȯ�� �Ǵ� Ȯ�� ��Ҹ� �Ͻ� �� �ֽ��ϴ�.');
	End If;
	--���� �� ��ǥ ��ü�� Ȯ���մϴ�.
	Sp_T_Acc_Slip_Conf_Core(Ar_Slip_Id,Ar_KEEP_SLIPNO,Ar_Keep_Dt,Ar_Keep_Dt_Trans,Ar_Keep_Dept,Ar_KEEP_KEEPER,Ar_Confirm_YN);
	--���� ���õ� ������ǥ�� �ִٸ� �׳��� Ȯ�� �Ǵ� ����մϴ�.
	For lrA In ( Select Distinct b.C_Slip_Id From T_ACC_B_C_SLIP_INFO b Where b.SLIP_ID = Ar_Slip_Id And b.BC_TAG = 'C' )
	Loop
		lsKeepSlipNo := F_T_Get_Keeep_Slip_No(lrA.C_Slip_Id,Ar_Keep_Dt,Ar_Keep_Dt_Trans,Ar_Keep_Dept,Ar_KEEP_KEEPER);
		Sp_T_Acc_Slip_Conf_Core(lrA.C_Slip_Id,lsKeepSlipNo,Ar_Keep_Dt,Ar_Keep_Dt_Trans,Ar_Keep_Dept,Ar_KEEP_KEEPER,Ar_Confirm_YN);
	End Loop;
END;
/