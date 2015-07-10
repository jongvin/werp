Create Or Replace Procedure SP_T_PL_REMOVE_EXECC
(
	AR_COMP_CODE				VARCHAR2,
	AR_CLSE_ACC_ID				VARCHAR2,
	Ar_WORK_YM					VARCHAR2
)
Is
	lsClose						Varchar2(2);
Begin
	Update	T_PL_COMP_PLAN_EXEC
	Set		EXEC_AMT = 0,
			SUM_EXEC_AMT = 0,
			MOD_EXEC_AMT = 0,
			B_MOD_EXEC_AMT = 0
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		WORK_YM = Ar_WORK_YM
	And		CHG_SEQ = 0;
End;
/
