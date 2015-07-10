CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_CHG_CONFIRM_ALL
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_CONFIRM						Varchar2,
	Ar_CRTUSERNO					Varchar2
)
Is
	Type T_DEPT Is Table Of T_BUDG_DEPT_H.DEPT_CODE%Type
		Index By Binary_Integer;
	Type T_CHG_SEQ Is Table Of T_BUDG_DEPT_H.CHG_SEQ%Type
		Index By Binary_Integer;
	lt_T_DEPT						T_DEPT;
	lt_T_CHG_SEQ					T_CHG_SEQ	;
	liStart							Number;
	liEnd								Number;
	lsErrm							Varchar2(2000);
Begin
	If Ar_CONFIRM = 'T' Then
		
		Select
			a.DEPT_CODE,
			a.CHG_SEQ
			Bulk Collect Into
			lt_T_DEPT,
			lt_T_CHG_SEQ
		From	T_BUDG_DEPT_H a
		Where		a.COMP_CODE = AR_COMP_CODE
		And		a.CLSE_ACC_ID = AR_CLSE_ACC_ID
		And     a.CONFIRM_TAG = 'F'
		And		a.CHG_SEQ <> 0;
	Else
		
		Select
			a.DEPT_CODE,
			a.CHG_SEQ
			Bulk Collect Into
			lt_T_DEPT,
			lt_T_CHG_SEQ
		From	T_BUDG_DEPT_H a
		Where		a.COMP_CODE = AR_COMP_CODE
		And		a.CLSE_ACC_ID = AR_CLSE_ACC_ID
		And     a.CONFIRM_TAG = 'T'
		And		a.CHG_SEQ <> 0;
	End If;
	
	If lt_T_DEPT.Count < 1 Then
		Raise_Application_Error(-20009,'확정 또는 취소할 대상이 없습니다.');
	End If;
	
	liStart := lt_T_DEPT.First;
	liEnd := lt_T_DEPT.Last;
	For liI In liStart..liEnd Loop
		Begin
			SP_T_BUDG_DEPT_CONFIRM(Ar_COMP_CODE,Ar_CLSE_ACC_ID,lt_T_DEPT(liI),lt_T_CHG_SEQ(liI),Ar_CONFIRM,Ar_CRTUSERNO);
		Exception When Others Then
			lsErrm := SqlErrm;
			lsErrm := Replace(lsErrm,'ORA-20009:','');
			Raise_Application_Error(-20009,'부서/현장 :' ||lt_T_DEPT(liI)||'의 예산확정 에러'||chr(10)||lsErrm);
		End;
	End Loop;
End;