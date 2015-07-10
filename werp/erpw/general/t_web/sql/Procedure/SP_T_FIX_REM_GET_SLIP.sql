CREATE OR REPLACE Procedure SP_T_FIX_REM_GET_SLIP
(
	AR_FIX_ASSET_SEQ				Number
)
Is
	ln_SLIP_ID   	Number;
Begin
	Begin
		select slip_id
		into ln_SLIP_ID
		from t_fix_sheet
		where fix_asset_seq = AR_FIX_ASSET_SEQ;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'삭제하려는 전표의 정보를 고정자산 목록에서 찾을 수 없습니다.');
	End;

	Update	T_FIX_SHEET
	Set		SLIP_ID = Null,
			SLIP_IDSEQ = Null
	Where	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;

	PKG_T_Check_Slip.DeleteMaster(ln_SLIP_ID);
End;
/
