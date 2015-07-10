Create Or Replace Procedure SP_T_SET_MAKE_CONS_DEC_DATA
(
	AR_COMP_CODE						VARCHAR2,
	AR_WORK_NO							NUMBER,
	AR_CRTUSERNO						VARCHAR2
)
Is
	lrRec					T_SET_CONS_INSUR_DEC_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_CONS_INSUR_DEC_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_NO = AR_WORK_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'대상이 되는 집계작업을 찾을 수 없습니다.');
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'대상이 되는 집계작업은 이미 전표가 발행되었습니다.전표를 삭제하신후 재 집계를 하셔야 합니다.');
	End If;
	Merge Into T_SET_CONS_INSUR_DEC_AMT t
	Using
	(
		Select
			a.DEPT_CODE ,
			a.INSUR_NO ,
			AR_CRTUSERNO CRTUSERNO ,
			SysDate CRTDATE ,
			AR_CRTUSERNO MODUSERNO ,
			SysDate MODDATE ,
			AR_COMP_CODE COMP_CODE,
			AR_WORK_NO WORK_NO,
			Case When Nvl(a.INSUR_AMT,0) - Nvl(a.PRE_SUM_AMT,0) > Nvl(a.MONTH_DEC_AMT,0) Then
				Nvl(a.MONTH_DEC_AMT,0)
			Else
				Nvl(a.INSUR_AMT,0) - Nvl(a.PRE_SUM_AMT,0)
			End DEC_AMT
		From
			(
				Select
					a.DEPT_CODE ,
					a.INSUR_NO ,
					a.INSUR_AMT,
					a.MONTH_DEC_AMT ,
					(
						Select
							Nvl(Sum(cc.DEC_AMT),0)
						From	T_SET_CONS_INSUR_DEC_AMT cc,
								T_SET_CONS_INSUR_DEC_WORK dd
						Where	a.DEPT_CODE = cc.DEPT_CODE
						And		a.INSUR_NO = cc.INSUR_NO
						And		cc.COMP_CODE = dd.COMP_CODE
						And		cc.WORK_NO = dd.WORK_NO
						And		dd.WORK_DT < lrRec.WORK_DT
					) PRE_SUM_AMT
				From	T_SET_CONS_INSUR a,
						T_DEPT_CODE_ORG b,
						T_ACC_SLIP_HEAD c
				Where	a.INSUR_DT_F <= lrRec.WORK_DT
				And		a.INSUR_DT_T >= Trunc(lrRec.WORK_DT,'MM')
				And		b.COMP_CODE = AR_COMP_CODE
				And		a.DEPT_CODE = b.DEPT_CODE
				And		a.SLIP_ID = c.SLIP_ID
				And		c.KEEP_DT Is Not Null
				And		Nvl(a.INSUR_AMT,0) >
						(
							Select
								Nvl(Sum(cc.DEC_AMT),0)
							From	T_SET_CONS_INSUR_DEC_AMT cc,
									T_SET_CONS_INSUR_DEC_WORK dd
							Where	a.DEPT_CODE = cc.DEPT_CODE
							And		a.INSUR_NO = cc.INSUR_NO
							And		cc.COMP_CODE = dd.COMP_CODE
							And		cc.WORK_NO = dd.WORK_NO
							And		dd.WORK_DT < lrRec.WORK_DT
						)
			) a
		Where	a.PRE_SUM_AMT < a.INSUR_AMT
	) s
	On
	(
		s.COMP_CODE = t.COMP_CODE
	And	s.WORK_NO = t.WORK_NO
	And	s.DEPT_CODE = t.DEPT_CODE
	And	s.INSUR_NO = t.INSUR_NO
	)
	When Matched Then
	Update
	Set		t.MODDATE = s.MODDATE,
			t.MODUSERNO = s.MODUSERNO,
			t.DEC_AMT = s.DEC_AMT
	When Not Matched Then
	Insert
	(DEPT_CODE,INSUR_NO,DEC_NO,CRTUSERNO,CRTDATE,DEC_AMT,COMP_CODE,WORK_NO)
	Values
	(s.DEPT_CODE,s.INSUR_NO,F_T_Get_Dec_No,s.CRTUSERNO,s.CRTDATE,s.DEC_AMT,s.COMP_CODE,s.WORK_NO);
End;
/
