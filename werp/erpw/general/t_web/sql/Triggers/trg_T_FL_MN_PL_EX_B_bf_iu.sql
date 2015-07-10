Create Or Replace Trigger trg_T_FL_MN_PL_EX_B_bf_iu
Before Insert Or Update On T_FL_MONTH_PLAN_EXEC_B
For Each Row
Begin
	--1~3��(1�б�)�� ��ȹ �ݾװ� �����ݾ��� ���� �����մϴ�.
	If SubStrb(:New.WORK_YM,-2) In ('01','02','03') Then
		:New.SUM_FORECAST_AMT := :New.SUM_PLAN_AMT;
		:New.MOD_FORECAST_AMT := :New.MOD_PLAN_AMT;
		:New.B_MOD_FORECAST_AMT := :New.B_MOD_PLAN_AMT;
		:New.FORECAST_AMT := :New.PLAN_AMT;
	End If;
End;
/
