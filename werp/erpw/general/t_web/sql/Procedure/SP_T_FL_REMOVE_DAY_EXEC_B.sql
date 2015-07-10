Create Or Replace Procedure SP_T_FL_REMOVE_DAY_EXEC_B
(
	AR_COMP_CODE				VARCHAR2,
	AR_CLSE_ACC_ID				VARCHAR2,
	Ar_WORK_DT					Varchar2
)
Is
	lsClose				Varchar2(2);
	lddtWorkDt					Date;
Begin
	lddtWorkDt := F_T_STRINGTODATE(Ar_WORK_DT);
	--마감여부를 검증한다.
	lsClose := F_T_FL_Is_Close_Comp_E(AR_COMP_CODE,AR_CLSE_ACC_ID,To_Char(lddtWorkDt,'YYYYMM'));
	If lsClose = 'T' Then
		Raise_Application_Error(-20009,'이미 마감되어 삭제가 불가능합니다.');
	End If;
	Delete	T_FL_DAY_EXEC_B
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		WORK_DT = lddtWorkDt;
End;
/
