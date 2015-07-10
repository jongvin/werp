Create Or Replace Procedure SP_T_FIN_CALC_NP_ITR
(
	Ar_Work_No					Number,
	Ar_CrtUserNo				Varchar2
)
Is
	lrRec						T_FIN_SEC_NP_ITR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_SEC_NP_ITR_WORK
		Where	WORK_NO = Ar_Work_No;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'유가증권 미수이자 작업을 찾을 수 없습니다.');
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'이미 전표가 발행되어 있습니다.');
	End If;
	Merge Into T_FIN_SEC_ITR_AMT t
	Using
	(
		Select
			b.SECU_NO SECU_NO,
			b.ITR_CALC_NO,
			Ar_CrtUserNo CRTUSERNO,
			SysDate CRTDATE,
			'1' KIND_TAG,
			a.CALC_DT_FROM CALC_DT_FROM,
			a.CALC_DT_TO CALC_DT_TO,
			a.CALC_DT_TO - a.CALC_DT_FROM CALC_DAYS,
			F_T_Calc_Itr_Amt(a.CALC_DT_FROM,a.CALC_DT_TO,c.PERSTOCK_AMT,c.INTR_RATE)   NP_ITR_AMT
		From	T_FIN_SEC_NP_ITR_WORK a,
				T_FIN_NP_ITR_TAR_SEC b,
				T_FIN_SECURTY c
		Where	b.WORK_NO = Ar_Work_No
		And		b.WORK_NO = a.WORK_NO
		And		b.SECU_NO = c.SECU_NO
	) s
	On
	(
		s.SECU_NO = t.SECU_NO
	And	s.ITR_CALC_NO = t.ITR_CALC_NO
	)
	When Matched Then
	Update
	Set		t.CALC_DT_FROM = s.CALC_DT_FROM,
			t.CALC_DT_TO = s.CALC_DT_TO,
			t.CALC_DAYS = s.CALC_DAYS,
			t.NP_ITR_AMT = s.NP_ITR_AMT,
			t.MODDATE = s.CRTDATE,
			t.MODUSERNO = s.CRTUSERNO
	When Not Matched Then
	Insert 
	(SECU_NO,ITR_CALC_NO,CALC_DT_TO)
	values
	(s.SECU_NO,s.ITR_CALC_NO,s.CALC_DT_TO);
End;
/
