Create Or Replace Procedure SP_T_REMOVE_SAL_PAY
(
	AR_COMP_CODE					Varchar2,
	AR_WORK_DT						Varchar2,
	AR_WORK_SEQ						Number,
	AR_CRTUSERNO					Varchar2
)
Is
	lrRec							T_FIN_PAY_SAL%RowType;
	lddtWorkDt						Date := f_t_stringtodate(AR_WORK_DT);
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_PAY_SAL
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_SEQ = AR_WORK_SEQ;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'삭제하려는 전표의 정보를 전표작업 목록에서 찾을 수 없습니다.');
	End;
	Update	T_FIN_PAY_SAL
	Set		SLIP_ID = Null,
			SLIP_IDSEQ = Null
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_DT = lddtWorkDt
	And		WORK_SEQ = AR_WORK_SEQ;

	PKG_T_Check_Slip.DeleteMaster(lrRec.SLIP_ID);
End;
/
