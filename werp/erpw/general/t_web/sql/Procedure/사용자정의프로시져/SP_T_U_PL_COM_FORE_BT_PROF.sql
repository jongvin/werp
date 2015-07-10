Create Or Replace Procedure SP_T_U_PL_COM_FORE_BT_PROF
--세전이익 가져오기
Is
Begin
	SP_T_U_PL_COM_FORE_ADD('경상이익','특별손익');
End;
/
