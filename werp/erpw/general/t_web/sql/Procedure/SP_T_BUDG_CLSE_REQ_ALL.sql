CREATE OR REPLACE Procedure SP_T_BUDG_CLSE_REQ_ALL
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_REQ_CLSE_DT					Varchar2,
	Ar_CRTUSERNO					NUMBER
)
Is
	Type T_DEPT Is Table Of T_BUDG_DEPT_H.DEPT_CODE%Type
		Index By Binary_Integer;
 
	lt_T_DEPT						T_DEPT;
	liStart							Number;
	liEnd							Number;
	lsErrm							Varchar2(2000);
Begin
	
	delete
	from t_budg_close a
	Where   a.comp_code = AR_COMP_CODE
	And		a.CLSE_ACC_ID = AR_CLSE_ACC_ID; 
		
	Select
		a.DEPT_CODE
	Bulk Collect Into
		lt_T_DEPT
	From	T_DEPT_CODE a,
			T_COMPANY b
	Where	a.COMP_CODE = b.COMP_CODE (+)
	And       BUDG_CLS  = 'T'
	And not Exists (select DEPT_CODE
				    from t_budg_close c
				    Where c.dept_code=a.dept_code
					And   c.comp_code = AR_COMP_CODE
					And		c.CLSE_ACC_ID = AR_CLSE_ACC_ID)
	Order By
		a.DEPT_CODE;
	
	If lt_T_DEPT.Count < 1 Then
		Raise_Application_Error(-20009,'마감신청이 완료됐습니다.');
	End If;
	liStart := lt_T_DEPT.First;
	liEnd := lt_T_DEPT.Last;
	For liI In liStart..liEnd Loop
		Begin		
			SP_T_BUDG_CLOSE_I(Ar_COMP_CODE,Ar_CLSE_ACC_ID,lt_T_DEPT(liI),Ar_CRTUSERNO,'T',Ar_REQ_CLSE_DT);
		Exception When Others Then
			lsErrm := SqlErrm;
			lsErrm := Replace(lsErrm,'ORA-20009:','');
			Raise_Application_Error(-20009,'부서/현장 :' ||lt_T_DEPT(liI)||'의 마감신청 에러'||chr(10)||lsErrm);
		End;
	End Loop;
End;