Create Or Replace Function F_T_RELATIVE_MONTHS
(
	Ar_StartDt		Date,
	Ar_EndDt		Date
)
Return Number
Is
Begin
	Return To_Number(To_Char(Ar_EndDt,'YYYY')) * 12 + To_Number(To_Char(Ar_EndDt,'MM')) - To_Number(To_Char(Ar_StartDt,'YYYY')) * 12   - To_Number(To_Char(Ar_StartDt,'MM')) + 1;
End;
/
