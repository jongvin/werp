Create Or Replace Package PKG_T_SLIP_ERROR_INFO
Is
	G_Error_Slip_Id				T_ACC_SLIP_HEAD.SLIP_ID%Type := 0;
	G_Error_Slip_IdSeq			T_ACC_SLIP_BODY.SLIP_IDSEQ%Type := 0;
	G_Error_MAKE_SLIPLINE		T_ACC_SLIP_BODY.MAKE_SLIPLINE%Type := 0;
	G_Errm						Varchar2(4000) := '';
	Procedure	Set_Error
	(
		Ar_Slip_Id				T_ACC_SLIP_HEAD.SLIP_ID%Type,
		Ar_Slip_IdSeq			T_ACC_SLIP_BODY.SLIP_IDSEQ%Type,
		Ar_MAKE_SLIPLINE		T_ACC_SLIP_BODY.MAKE_SLIPLINE%Type,
		Ar_Errm					Varchar2
	);
	Function	Get_Error_MakeSlipLine
	Return T_ACC_SLIP_BODY.MAKE_SLIPLINE%Type;
	Function	Get_Error_SlipId
	Return T_ACC_SLIP_HEAD.SLIP_ID%Type;
	Function	Get_Error_SlipIdSeq
	Return T_ACC_SLIP_BODY.SLIP_IDSEQ%Type;
	Function	Get_Error_Message
	Return Varchar2;
End;
/
Create Or Replace Package Body PKG_T_SLIP_ERROR_INFO
Is
	Procedure	Set_Error
	(
		Ar_Slip_Id				T_ACC_SLIP_HEAD.SLIP_ID%Type,
		Ar_Slip_IdSeq			T_ACC_SLIP_BODY.SLIP_IDSEQ%Type,
		Ar_MAKE_SLIPLINE		T_ACC_SLIP_BODY.MAKE_SLIPLINE%Type,
		Ar_Errm					Varchar2
	)
	Is
	Begin
		G_Error_Slip_Id				:= Ar_Slip_Id;
		G_Error_Slip_IdSeq			:= Ar_Slip_IdSeq;
		G_Error_MAKE_SLIPLINE		:= Ar_MAKE_SLIPLINE;
		G_Errm						:= Ar_Errm;
	End;
	Function	Get_Error_MakeSlipLine
	Return T_ACC_SLIP_BODY.MAKE_SLIPLINE%Type
	Is
	Begin
		Return G_Error_MAKE_SLIPLINE;
	End;
	Function	Get_Error_SlipId
	Return T_ACC_SLIP_HEAD.SLIP_ID%Type
	Is
	Begin
		Return G_Error_Slip_Id;
	End;
	Function	Get_Error_SlipIdSeq
	Return T_ACC_SLIP_BODY.SLIP_IDSEQ%Type
	Is
	Begin
		Return G_Error_Slip_IdSeq;
	End;
	Function	Get_Error_Message
	Return Varchar2
	Is
	Begin
		Return G_Errm;
	End;
End;
/
