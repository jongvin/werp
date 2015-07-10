Create Or Replace Procedure SP_T_FL_REMOVE_EXECC
(
	AR_COMP_CODE				VARCHAR2,
	AR_CLSE_ACC_ID				VARCHAR2,
	Ar_WORK_YM					VARCHAR2
)
Is
	lsClose						Varchar2(2);
Begin
	--마감여부를 검증한다.
	lsClose := F_T_FL_Is_Close_Comp_E(AR_COMP_CODE,AR_CLSE_ACC_ID,Ar_WORK_YM);
	If lsClose = 'T' Then
		Raise_Application_Error(-20009,'이미 마감되어 삭제가 불가능합니다.');
	End If;
	Update	T_FL_MONTH_PLAN_EXEC_B
	Set		EXEC_AMT = 0,
			SUM_EXEC_AMT = 0,
			MOD_EXEC_AMT = 0,
			B_MOD_EXEC_AMT = 0
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		WORK_YM = Ar_WORK_YM;
End;
/
