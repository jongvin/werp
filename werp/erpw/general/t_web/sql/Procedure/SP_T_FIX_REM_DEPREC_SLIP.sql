CREATE OR REPLACE Procedure SP_T_FIX_REM_DEPREC_SLIP
(
	AR_WORK_SEQ				Number
)
Is
	ln_WORK_SEQ   	Number;
	ln_SLIP_ID   	Number;
	ln_CNT   		Number;
Begin
	Begin
		select  work_seq,
			   slip_id,
			   count(work_seq) cnt
		into ln_WORK_SEQ, ln_SLIP_ID, ln_CNT
		from T_FIX_FURNI_SUM
		where work_seq = AR_WORK_SEQ
		group by work_seq,
			     slip_id;

	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'삭제하려는 전표의 정보를 찾을 수 없습니다.');
	End;

	Update	T_FIX_FURNI_SUM
	Set		SLIP_ID = Null,
			SLIP_IDSEQ = Null
	Where	WORK_SEQ = AR_WORK_SEQ;


	PKG_T_Check_Slip.DeleteMaster(ln_SLIP_ID);
End;
/


