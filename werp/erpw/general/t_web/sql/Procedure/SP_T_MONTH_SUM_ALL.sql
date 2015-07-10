Create Or Replace Procedure SP_T_MONTH_SUM_ALL
(
	Ar_WorkMonthFrom		Varchar2,
	Ar_WorkMonthTo			Varchar2,
	Ar_CRTUSERNO			Varchar2
)
Is
	ls_Work_Ym				Varchar2(6);
	li_Num					Number;
Begin
	If Ar_WorkMonthFrom > Ar_WorkMonthTo Then
		Raise_Application_Error(-20009,'시작월이 종료월보다 클 수는 없습니다.');
	End If;
	SP_T_Sum_Daily_From_To(Ar_WorkMonthFrom||'01',To_Char(Last_Day(To_Date(Ar_WorkMonthTo||'01','YYYYMMDD')),'YYYYMMDD'),Ar_CRTUSERNO);
	--PKG_TRACE_CASH.TraceCashSlip(To_Date(Ar_WorkMonthFrom||'01','YYYYMMDD'),Last_Day(To_Date(Ar_WorkMonthTo||'01','YYYYMMDD')));
	--SP_T_MONTH_SUM(Ar_WorkMonthFrom,Ar_WorkMonthTo,Ar_CRTUSERNO);--집계테이블 사용 안함
	For lrA In (Select SHEET_CODE from T_SHEET_CODE Where MONTH_SUM_TAG = 'T' ) Loop
		li_Num := 0;
		Loop
			ls_Work_Ym:= F_T_AddMonths(Ar_WorkMonthFrom,li_Num);
			Exit When ls_Work_Ym > Ar_WorkMonthTo;
			li_Num := li_Num + 1;
			SP_T_Make_SHEET_Month_SUM_BODY(lrA.SHEET_CODE,ls_Work_Ym);
		End Loop;
	End Loop;
End;
/
/*
Declare
	ls_Work_Ym				Varchar2(6);
	li_Num					Number;
Begin
	For lrA In (Select SHEET_CODE from T_SHEET_CODE Where MONTH_SUM_TAG = 'T' ) Loop
		li_Num := 0;
		Loop
			ls_Work_Ym:= F_T_AddMonths('199501',li_Num);
			Exit When ls_Work_Ym > '200604';
			li_Num := li_Num + 1;
			SP_T_Make_SHEET_Month_SUM_BODY(lrA.SHEET_CODE,ls_Work_Ym);
		End Loop;
	End Loop;
End;
/
*/
