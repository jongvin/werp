Create Or Replace Package PKG_T_Debug
Is
	Procedure ClearMessages
	(
		Ar_MSG_GRP				T_Msg.MSG_GRP%Type
	);
	Procedure PrintMessages
	(
		Ar_MSG_GRP				T_Msg.MSG_GRP%Type,
		Ar_MSG					T_Msg.MSG%Type
	);
	Procedure PrintMessages
	(
		Ar_MSG_GRP				T_Msg.MSG_GRP%Type,
		Ar_MSG					Number
	);
	Procedure PrintMessages
	(
		Ar_MSG_GRP				T_Msg.MSG_GRP%Type,
		Ar_MSG					Date
	);
End;
/

Create Or Replace Package Body PKG_T_Debug
Is
	Procedure ClearMessages
	(
		Ar_MSG_GRP				T_Msg.MSG_GRP%Type
	)
	Is
		Pragma autonomous_transaction;
	Begin
		Delete	T_Msg
		Where	MSG_GRP = Ar_MSG_GRP;
		Commit;
	Exception When Others Then
		Null;
	End;
	Procedure PrintMessages
	(
		Ar_MSG_GRP				T_Msg.MSG_GRP%Type,
		Ar_MSG					T_Msg.MSG%Type
	)
	Is
		Pragma autonomous_transaction;
	Begin
		Insert Into T_Msg
		(
			Msg_Grp,
			Make_dt,
			Msg,
			Msg_Seq
		)
		Values
		(
			Ar_MSG_GRP,
			Sysdate,
			Ar_MSG,
			SQ_T_MSG_SEQ.NextVal
		);
		Commit;
	Exception When Others Then
		Null;
	End;
	Procedure PrintMessages
	(
		Ar_MSG_GRP				T_Msg.MSG_GRP%Type,
		Ar_MSG					Number
	)
	Is
	Begin
		PrintMessages(Ar_MSG_GRP,To_Char(Ar_MSG));
	End;
	Procedure PrintMessages
	(
		Ar_MSG_GRP				T_Msg.MSG_GRP%Type,
		Ar_MSG					Date
	)
	Is
	Begin
		PrintMessages(Ar_MSG_GRP,To_Char(Ar_MSG,'YYYY-MM-DD HH24:MI:SS'));
	End;
End;
/
