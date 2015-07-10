Create Or Replace Procedure SP_T_U_PL_COM_PLAN_NOR_PROF
--영업이익 가져오기
Is
Begin
	SP_T_U_PL_COM_PLAN_SUB('매출이익','관리판매비');
End;
/
