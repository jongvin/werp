CREATE OR REPLACE Procedure SP_T_FIX_REM_INCREDU_SLIP
(
	AR_FIX_ASSET_SEQ				Number,
	AR_INCREDU_SEQ					Number
)
Is
	ln_SLIP_ID   	Number;
Begin
	Begin
		select slip_id
		into ln_SLIP_ID
		from t_fix_incredu
		where fix_asset_seq = AR_FIX_ASSET_SEQ
		and	  incredu_seq = AR_INCREDU_SEQ;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'삭제하려는 전표의 정보를 고정자산 증감목록에서 찾을 수 없습니다.');
	End;

	Update	T_FIX_INCREDU
	Set		SLIP_ID = Null,
			SLIP_IDSEQ = Null
	Where	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ
	And		INCREDU_SEQ = AR_INCREDU_SEQ;

	PKG_T_Check_Slip.DeleteMaster(ln_SLIP_ID);
End;
/
