Create Or Replace Procedure SP_T_U_PL_MA_FIRST_PROF
/*1차공헌이익 계산용 사용자 정의 함수*/
Is
	
Begin
	SP_T_U_PL_MA_PLUS_MINUS('매출총이익','직접지급비용');
End;
/
