Create Or Replace Procedure SP_T_REMOVE_ITR_SECU_SLIP
(
	Ar_Secu_No						Varchar2,
	Ar_CrtUserNo					Varchar2
)
Is
	lrRec							T_FIN_SECURTY%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_SECURTY
		Where	SECU_NO = Ar_Secu_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'삭제하려는 전표의 정보를 찾을 수 없습니다.');
	End;
	If lrRec.PRE_ITR_SLIP_ID Is Not Null Then
		Update	T_FIN_SECURTY
		Set		PRE_ITR_SLIP_ID = Null,
				PRE_ITR_SLIP_IDSEQ = Null
		Where	SECU_NO = Ar_Secu_No;
		PKG_T_Check_Slip.DeleteMaster(lrRec.PRE_ITR_SLIP_ID);
	End If;
End;
/
