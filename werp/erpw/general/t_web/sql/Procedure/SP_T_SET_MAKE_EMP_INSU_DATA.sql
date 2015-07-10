Create Or Replace Procedure SP_T_SET_MAKE_EMP_INSU_DATA
(
	AR_COMP_CODE						VARCHAR2,
	AR_WORK_NO							NUMBER,
	AR_CRTUSERNO						VARCHAR2
)
Is
	lrRec					T_SET_EMP_INSUR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_EMP_INSUR_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_WORK_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'대상이 되는 집계작업을 찾을 수 없습니다.');
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'대상이 되는 집계작업은 이미 전표가 발행되었습니다.전표를 삭제하신후 재 집계를 하셔야 합니다.');
	End If;
	Delete	T_SET_EMP_INSUR_TARGET_SLIP a
	Where	a.COMP_CODE = AR_COMP_CODE
	And		a.INSUR_WORK_NO = AR_WORK_NO
	And		Not Exists
	(
		Select
			null
		From	T_ACC_SLIP_BODY1 b
		Where	a.SLIP_ID = b.SLIP_ID
		And		a.SLIP_IDSEQ = b.SLIP_IDSEQ
	);
	Insert Into T_SET_EMP_INSUR_TARGET_SLIP
	(
		COMP_CODE,
		INSUR_WORK_NO,
		SLIP_ID,
		SLIP_IDSEQ
	)
	Select
		AR_COMP_CODE,
		AR_WORK_NO,
		a.SLIP_ID ,
		a.SLIP_IDSEQ
	From	T_ACC_SLIP_BODY1 a,
			T_SET_EMP_INSUR_ACC_CODE b,
			T_DEPT_CODE c
	Where	a.DEPT_CODE = c.DEPT_CODE
	And		a.ACC_CODE = b.ACC_CODE
	And		Nvl(a.DB_AMT,0) <> 0
	And		b.T_DFLT_TAG = 'T'
	And		c.DEPT_PROJ_TAG = 'P'
	And		a.MAKE_DT Between lrRec.TARGET_DT_F And lrRec.TARGET_DT_T
	And		a.KEEP_DT Is Not Null
	And		Not Exists
	(
		Select
			Null
		From	T_SET_EMP_INSUR_TARGET_SLIP aa
		Where	aa.SLIP_ID = a.SLIP_ID
		And		aa.SLIP_IDSEQ = a.SLIP_IDSEQ
		And		aa.COMP_CODE = AR_COMP_CODE
		And		aa.INSUR_WORK_NO = AR_WORK_NO
	);
End;
/
