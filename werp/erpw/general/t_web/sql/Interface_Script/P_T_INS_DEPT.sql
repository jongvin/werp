--현장코드 삽입시
Create Or Replace Procedure P_T_INS_DEPT
(
	Ar_Dept_Code			t_dept_code_org.DEPT_CODE%Type,
	Ar_Comp_Code			t_dept_code_org.COMP_CODE%Type,
	Ar_Dept_Name			t_dept_code_org.DEPT_NAME%Type,
	Ar_Dept_Short_Name		t_dept_code_org.DEPT_SHORT_NAME%Type
)
Is
Begin
	If Ar_Comp_Code Is Null Then
		Raise_Application_Error(-20009,'부서(현장)코드에 사업장코드를 반드시 입력하여 주십시오.');
	End If;
	Begin
		Insert Into	t_dept_code_org
		(
			DEPT_CODE,
			DEPT_NAME,
			DEPT_SHORT_NAME,
			COMP_CODE,
			TAX_COMP_CODE,
			BUDG_CLS
		)
		Values
		(
			Ar_Dept_Code,
			Ar_Dept_Name,
			Ar_Dept_Short_Name,
			Ar_Comp_Code,
			Ar_Comp_Code,
			'F'
		);
	Exception When Dup_Val_On_Index Then
		Update	t_dept_code_org
		Set		
			DEPT_NAME = Ar_Dept_Name,
			DEPT_SHORT_NAME = Ar_Dept_Short_Name,
			COMP_CODE = Ar_Comp_Code
		Where	DEPT_CODE = Ar_Dept_Code;
	End;
	Insert Into T_EMPNO_AUTH_DEPT
	(
		EMPNO,
		COMP_CODE,
		DEPT_CODE
	)
	Select
		a.EMPNO,
		b.COMP_CODE,
		Ar_Dept_Code DEPT_CODE
	From	T_EMPNO_AUTH a,
			T_EMPNO_AUTH_COMP b
	Where	a.EMPNO = b.EMPNO
	And		b.COMP_CODE = Ar_Comp_Code
	And		a.SLIP_TRANS_CLS = 'T'
	And		Not Exists
	(
		Select
			Null
		From	T_EMPNO_AUTH_DEPT c
		Where	b.EMPNO = c.EMPNO
		And		b.COMP_CODE = c.COMP_CODE
		And		c.DEPT_CODE = Ar_Dept_Code
	);
End;
/
--현장코드 변경시
Create Or Replace Procedure P_T_UPD_DEPT
(
	Ar_Dept_Code			t_dept_code_org.DEPT_CODE%Type,
	Ar_Comp_Code			t_dept_code_org.COMP_CODE%Type,
	Ar_Dept_Name			t_dept_code_org.DEPT_NAME%Type,
	Ar_Dept_Short_Name		t_dept_code_org.DEPT_SHORT_NAME%Type
)
Is
Begin
	If Ar_Comp_Code Is Null Then
		Raise_Application_Error(-20009,'부서(현장)코드에 사업장코드를 반드시 입력하여 주십시오.');
	End If;
	Insert Into	t_dept_code_org
	(
		DEPT_CODE,
		DEPT_NAME,
		DEPT_SHORT_NAME,
		COMP_CODE,
		TAX_COMP_CODE,
		BUDG_CLS
	)
	Values
	(
		Ar_Dept_Code,
		Ar_Dept_Name,
		Ar_Dept_Short_Name,
		Ar_Comp_Code,
		Ar_Comp_Code,
		'F'
	);
Exception When Dup_Val_On_Index Then
	Update	t_dept_code_org
	Set		
		DEPT_NAME = Ar_Dept_Name,
		DEPT_SHORT_NAME = Ar_Dept_Short_Name,
		COMP_CODE = Ar_Comp_Code
	Where	DEPT_CODE = Ar_Dept_Code;
End;
/
