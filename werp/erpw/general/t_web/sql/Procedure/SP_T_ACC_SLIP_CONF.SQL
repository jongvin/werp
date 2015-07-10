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
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 김흥수
/* 최초작성일 : 2004-12-15
/* 최종수정자 :
/* 최종수정일 :
/* 수정 내용  : 실제의 전표 확정 관련 처리는 Sp_T_Acc_Slip_Conf_Core 함수로 넘겼습니다.
/*              이유는 본지사 전표 처리 때문입니다.
/*              본지사 전표의 경우 본사 전표의 확정은 지사 전표의 확정으로 이어져야 하기 때문입니다.
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
		Raise_Application_Error(-20009,'본지사 전표의 지사 전표는 본사 전표에서만 확정 또는 확정 취소를 하실 수 있습니다.');
	End If;
	--먼저 이 전표 자체를 확정합니다.
	Sp_T_Acc_Slip_Conf_Core(Ar_Slip_Id,Ar_KEEP_SLIPNO,Ar_Keep_Dt,Ar_Keep_Dt_Trans,Ar_Keep_Dept,Ar_KEEP_KEEPER,Ar_Confirm_YN);
	--만약 관련된 지사전표가 있다면 그넘을 확정 또는 취소합니다.
	For lrA In ( Select Distinct b.C_Slip_Id From T_ACC_B_C_SLIP_INFO b Where b.SLIP_ID = Ar_Slip_Id And b.BC_TAG = 'C' )
	Loop
		lsKeepSlipNo := F_T_Get_Keeep_Slip_No(lrA.C_Slip_Id,Ar_Keep_Dt,Ar_Keep_Dt_Trans,Ar_Keep_Dept,Ar_KEEP_KEEPER);
		Sp_T_Acc_Slip_Conf_Core(lrA.C_Slip_Id,lsKeepSlipNo,Ar_Keep_Dt,Ar_Keep_Dt_Trans,Ar_Keep_Dept,Ar_KEEP_KEEPER,Ar_Confirm_YN);
	End Loop;
END;
/
