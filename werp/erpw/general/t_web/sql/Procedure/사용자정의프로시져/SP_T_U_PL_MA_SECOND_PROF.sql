Create Or Replace Procedure SP_T_U_PL_MA_SECOND_PROF
/*공헌이익 계산용 사용자 정의 함수*/
Is
Begin
	SP_T_U_PL_MA_PLUS_MINUS('1차공헌이익','직접부문간접지급비용');
End;
/
