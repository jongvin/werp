Create Or Replace Function F_T_Get_NewSlip_Id
Return Number
Is
 ln_Ret    Number;
Begin
 Select
  SQ_T_SLIP_ID.NextVal
 Into
  ln_Ret
 From Dual;
 Return ln_Ret;
End;
/