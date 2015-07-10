Create Or Replace Procedure SP_T_FIN_REMOVE_PAY_SLIP
(
	AR_COMP_CODE					Varchar2,
	AR_WORK_DT						Varchar2,
	AR_SLIP_ID						Number,
	AR_SLIP_IDSEQ					Number,
	AR_CRTUSERNO					Varchar2
)
Is
	lrRec							T_FIN_PAY_PUB_SLIP_LIST%RowType;
	lddtWorkDt						Date := f_t_stringtodate(AR_WORK_DT);
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_PAY_PUB_SLIP_LIST
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_DT = lddtWorkDt
		And		SLIP_ID = AR_SLIP_ID
		And		SLIP_IDSEQ = AR_SLIP_IDSEQ;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'삭제하려는 전표의 정보를 지불전표 목록에서 찾을 수 없습니다.');
	End;
	Update	T_FIN_PAY_EXEC_LIST
	Set		SLIP_PUB_SEQ = Null,
			SLIP_ID = Null,
			SLIP_IDSEQ = Null
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_DT = lddtWorkDt
	And		SLIP_PUB_SEQ = lrRec.SLIP_PUB_SEQ;

	Delete	T_FIN_PAY_PUB_SLIP_LIST
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_DT = lddtWorkDt
	And		SLIP_PUB_SEQ = lrRec.SLIP_PUB_SEQ;

	PKG_T_Check_Slip.DeleteMaster(AR_SLIP_ID);
End;
/
