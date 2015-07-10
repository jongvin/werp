Create Or Replace Procedure SP_T_BUDG_DEPT_CONFIRM_ALL
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_CHG_SEQ						Number,
	Ar_CONFIRM						Varchar2,
	Ar_CRTUSERNO					Varchar2
)
Is
	Type T_DEPT Is Table Of T_BUDG_DEPT_H.DEPT_CODE%Type
		Index By Binary_Integer;
	Type T_DEPT_NAME Is Table Of T_DEPT_CODE.DEPT_NAME%Type
		Index By Binary_Integer;
	lt_T_DEPT						T_DEPT;
	lt_T_DEPT_NAME					T_DEPT_NAME;
	ls_Tag							Varchar2(1);
	liStart							Number;
	liEnd							Number;
	lsErrm							Varchar2(2000);
Begin
	If Ar_CONFIRM = 'T' Then
		ls_Tag := 'F';
	Else
		ls_Tag := 'T';
	End If;
	Select
		a.DEPT_CODE,
		b.DEPT_NAME
	Bulk Collect Into
		lt_T_DEPT,
		lt_T_DEPT_NAME
	From	T_BUDG_DEPT_H a,
			T_DEPT_CODE b
	Where	a.CONFIRM_TAG = ls_Tag
	And		a.COMP_CODE = AR_COMP_CODE
	And		a.CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		a.CHG_SEQ = AR_CHG_SEQ
	And		a.DEPT_CODE = b.DEPT_CODE (+);
	If lt_T_DEPT.Count < 1 Then
		Raise_Application_Error(-20009,'확정 또는 취소할 대상이 없습니다.');
	End If;
	liStart := lt_T_DEPT.First;
	liEnd := lt_T_DEPT.Last;
	For liI In liStart..liEnd Loop
		Begin
			SP_T_BUDG_DEPT_CONFIRM(Ar_COMP_CODE,Ar_CLSE_ACC_ID,lt_T_DEPT(liI),Ar_CHG_SEQ,Ar_CONFIRM,Ar_CRTUSERNO);
		Exception When Others Then
			lsErrm := SqlErrm;
			lsErrm := Replace(lsErrm,'ORA-20009:','');
			Raise_Application_Error(-20009,'부서/현장 :' ||lt_T_DEPT_NAME(liI)||'의 예산확정 에러'||chr(10)||lsErrm);
		End;
	End Loop;
End;
/
--exec SP_T_BUDG_DEPT_CONFIRM_ALL('A0','2004',0,'T',0);