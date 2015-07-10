Create Or Replace Procedure SP_T_FIN_REMOVE_NP_SLIP
(
	Ar_Work_No					Number,
	Ar_CrtUserNo				Varchar2
)
Is
	lrHead						T_ACC_SLIP_HEAD%RowType;
	lrRec						T_FIN_SEC_NP_ITR_WORK%RowType;
	lbFound						Boolean;
	lnCnt						Number;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_SEC_NP_ITR_WORK
		Where	WORK_NO = Ar_Work_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'유가증권 미수이자 작업을 찾을 수 없습니다.');
	End;
	If lrRec.SLIP_ID Is Null Then
		Raise_Application_Error(-20009,'발행된 전표가 없습니다.');
	End If;
	Begin
		Select
			*
		Into
			lrHead
		From	T_ACC_SLIP_HEAD
		Where	SLIP_ID = lrRec.SLIP_ID;
	Exception When No_Data_Found Then
		Update	T_FIN_SEC_ITR_AMT a
		Set		a.SLIP_ID = Null,
				a.SLIP_IDSEQ = Null
		Where	Exists
		(
			Select
				Null
			From	T_FIN_NP_ITR_TAR_SEC b
			Where	b.WORK_NO = Ar_Work_No
			And		a.SECU_NO = b.SECU_NO
			And		a.ITR_CALC_NO = b.ITR_CALC_NO
		);
		Update	T_FIN_SEC_NP_ITR_WORK
		Set		SLIP_ID = Null,
				SLIP_IDSEQ = Null
		Where	WORK_NO = Ar_Work_No;
		Return;
	End;
	Update	T_FIN_SEC_ITR_AMT a
	Set		a.SLIP_ID = Null,
			a.SLIP_IDSEQ = Null
	Where	Exists
	(
		Select
			Null
		From	T_FIN_NP_ITR_TAR_SEC b
		Where	b.WORK_NO = Ar_Work_No
		And		a.SECU_NO = b.SECU_NO
		And		a.ITR_CALC_NO = b.ITR_CALC_NO
	);
	Update	T_FIN_SEC_NP_ITR_WORK
	Set		SLIP_ID = Null,
			SLIP_IDSEQ = Null
	Where	WORK_NO = Ar_Work_No;
	PKG_T_Check_Slip.DeleteMaster(lrRec.SLIP_ID);
End;
/
