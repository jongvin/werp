Create Or Replace Procedure SP_T_SET_REMOVE_CONS_DEC_SLIP
(
	AR_COMP_CODE					VARCHAR2,
	AR_WORK_NO						NUMBER,
	AR_CRTUSERNO					VARCHAR2
)
Is
	lrRec							T_SET_CONS_INSUR_DEC_WORK%RowType;
	lnCount							Number;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_CONS_INSUR_DEC_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_NO = AR_WORK_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'삭제하려는 전표의 정보를 찾을 수 없습니다.');
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Update	T_SET_CONS_INSUR_DEC_AMT
		Set		SLIP_ID = Null,
				SLIP_IDSEQ = Null
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_NO = AR_WORK_NO;

		Update	T_SET_CONS_INSUR_DEC_WORK
		Set		SLIP_ID = Null,
				SLIP_IDSEQ = Null
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_NO = AR_WORK_NO;
		PKG_T_Check_Slip.DeleteMaster(lrRec.SLIP_ID);
	Else
		Raise_Application_Error(-20009,'삭제하려는 전표가 발행된 적이 없습니다.');
	End If;
End;
/
