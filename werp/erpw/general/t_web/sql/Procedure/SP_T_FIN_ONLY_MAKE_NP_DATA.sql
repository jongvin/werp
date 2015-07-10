Create Or Replace Procedure SP_T_FIN_ONLY_MAKE_NP_DATA
(
	Ar_Work_No					Number,
	Ar_CrtUserNo				Varchar2
)
Is
Begin
	Insert Into T_FIN_NP_ITR_TAR_SEC
	(
		WORK_NO,
		SECU_NO,
		CRTUSERNO,
		CRTDATE
	)
	Select
		a.WORK_NO,
		b.SECU_NO,
		Ar_CrtUserNo,
		SysDate
	From	T_FIN_SEC_NP_ITR_WORK a,
			T_FIN_SECURTY b
	Where	a.WORK_NO = Ar_Work_No
	And		b.COMP_CODE Like a.TARGET_COMP_CODE
	And		b.SALE_DT Is Null
	And		b.RETURN_DT Is Null
	And		Not Exists
	(
		Select
			Null
		From	T_FIN_NP_ITR_TAR_SEC c
		Where	c.WORK_NO = a.WORK_NO
		And		c.SECU_NO = b.SECU_NO
	);
End;
/
