Create Or Replace Procedure SP_T_REMOVE_SALE_SLIP
(
	AR_COMP_CODE					Varchar2,
	AR_WORK_NO						Number,
	AR_CRTUSERNO					Varchar2
)
Is
	lrRec							T_SET_SALE_SLIP%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_SALE_SLIP
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_NO = AR_WORK_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'삭제하려는 전표의 정보를 전표작업 목록에서 찾을 수 없습니다.');
	End;
	Update	T_SET_SALE_SLIP
	Set		SLIP_ID = Null,
			SLIP_IDSEQ = Null
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_NO = AR_WORK_NO;

	PKG_T_Check_Slip.DeleteMaster(lrRec.SLIP_ID);
End;
/
