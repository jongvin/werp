Create Or Replace Procedure SP_T_COPY_EMP_AUTH
(
	Ar_EMPNO_SRC				Varchar2,
	Ar_EMPNO_DST				Varchar2,
	Ar_CRTUSERNO				Varchar2
)
Is
Begin
	Insert Into T_EMPNO_AUTH_COMP
	(
		EMPNO,
		COMP_CODE,
		CRTUSERNO,
		CRTDATE
	)
	Select
		Ar_EMPNO_DST EMPNO,
		a.COMP_CODE,
		Ar_CRTUSERNO,
		SysDate
	From	T_EMPNO_AUTH_COMP a
	Where	a.EMPNO = Ar_EMPNO_SRC
	And		Not Exists
	(
		Select
			Null
		From	T_EMPNO_AUTH_COMP b
		Where	a.COMP_CODE = b.COMP_CODE
		And		b.EMPNO = Ar_EMPNO_DST
	);

	Insert Into T_EMPNO_AUTH_DEPT
	(
		EMPNO,
		COMP_CODE,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE
	)
	Select
		Ar_EMPNO_DST EMPNO,
		a.COMP_CODE,
		a.DEPT_CODE,
		Ar_CRTUSERNO,
		SysDate
	From	T_EMPNO_AUTH_DEPT a
	Where	a.EMPNO = Ar_EMPNO_SRC
	And		Not Exists
	(
		Select
			Null
		From	T_EMPNO_AUTH_DEPT b
		Where	a.COMP_CODE = b.COMP_CODE
		And		a.DEPT_CODE = b.DEPT_CODE
		And		b.EMPNO = Ar_EMPNO_DST
	);
End;
/
