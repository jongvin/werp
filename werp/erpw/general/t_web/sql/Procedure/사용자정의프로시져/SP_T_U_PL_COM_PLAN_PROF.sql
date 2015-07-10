Create Or Replace Procedure SP_T_U_PL_COM_PLAN_PROF
--매출이익 가져오기
Is
Begin
	SP_T_U_PL_COM_PLAN_SUB('매출액','매출원가');
End;
/
