CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_ITEM_PARENT_ALL
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_CHG_SEQ						Number,
	Ar_CRTUSERNO					Varchar2
)
Is
	Type T_DEPT Is Table Of T_BUDG_DEPT_H.DEPT_CODE%Type
		Index By Binary_Integer;
	Type T_DEPT_NAME Is Table Of T_DEPT_CODE.DEPT_NAME%Type
		Index By Binary_Integer;
	lt_T_DEPT						T_DEPT;
	lt_T_DEPT_NAME					T_DEPT_NAME;
	liStart							Number;
	liEnd							Number;
	lsErrm							Varchar2(2000);
Begin
	
	Select
		a.DEPT_CODE,
		b.DEPT_NAME
	Bulk Collect Into
		lt_T_DEPT,
		lt_T_DEPT_NAME
	From	T_BUDG_DEPT_MAP a,
			T_DEPT_CODE_ORG b
	Where	a.DEPT_CODE = b.DEPT_CODE
	And		b.COMP_CODE = AR_COMP_CODE
	And     b.BUDG_CLS = 'T'
	And		b.DEPT_CODE not in (select c.DEPT_CODE
							    from   T_BUDG_DEPT_H c
							    Where  c.COMP_CODE = AR_COMP_CODE
							    And	   c.CLSE_ACC_ID = AR_CLSE_ACC_ID
							    And	   c.CHG_SEQ = AR_CHG_SEQ );
	If lt_T_DEPT.Count < 1 Then
		Raise_Application_Error(-20009,'이미 모든부서가 등록되었습니다.');
	End If;
	liStart := lt_T_DEPT.First;
	liEnd := lt_T_DEPT.Last;
	For liI In liStart..liEnd Loop
		Begin
			If AR_CHG_SEQ = 0 Then 
			   SP_T_BUDG_CHECK_REQ_CLSE_DT(AR_COMP_CODE,AR_CLSE_ACC_ID,lt_T_DEPT(liI));
			End If;
			SP_T_BUDG_DEPT_ITEM_PARENT(Ar_COMP_CODE,Ar_CLSE_ACC_ID,lt_T_DEPT(liI),Ar_CHG_SEQ, Ar_CRTUSERNO);
		Exception When Others Then
			lsErrm := SqlErrm;
			lsErrm := Replace(lsErrm,'ORA-20009:','');
			Raise_Application_Error(-20009,'부서/현장 :' ||lt_T_DEPT_NAME(liI)||'의 예산부서 등록  에러'||chr(10)||lsErrm);
		End;
	End Loop;
End;
/
