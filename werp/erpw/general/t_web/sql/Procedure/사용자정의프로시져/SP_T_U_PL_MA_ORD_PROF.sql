Create Or Replace Procedure SP_T_U_PL_MA_ORD_PROF
/*경상이익 계산용 사용자 정의 함수*/
Is
Begin
	SP_T_U_PL_MA_PLUS_MINUS('공헌이익','간접부문간접지급비용');
End;
/
