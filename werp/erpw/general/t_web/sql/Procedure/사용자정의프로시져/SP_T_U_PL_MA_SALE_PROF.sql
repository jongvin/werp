Create Or Replace Procedure SP_T_U_PL_MA_SALE_PROF
/*매출이익 계산용 사용자 정의 함수*/
Is
	
Begin
	SP_T_U_PL_MA_PLUS_MINUS('매출액','매출원가');
End;
/
