Create Or Replace Procedure SP_T_FIN_REAL_MAKE_NP_DATA
(
	Ar_Work_No					Number,
	Ar_CrtUserNo				Varchar2
)
Is
	Type T_T_FIN_NP_ITR_TAR_SEC Is Table Of T_FIN_NP_ITR_TAR_SEC%RowType
		Index By Binary_Integer;
	lt_T_FIN_NP_ITR_TAR_SEC				T_T_FIN_NP_ITR_TAR_SEC;
	liFirst								Number;
	liLast								Number;
	lrA									T_FIN_NP_ITR_TAR_SEC%RowType;
	lrInsert							T_FIN_SEC_ITR_AMT%RowType;
Begin
	Select *
	Bulk Collect Into lt_T_FIN_NP_ITR_TAR_SEC
	From	T_FIN_NP_ITR_TAR_SEC
	Where	WORK_NO = Ar_Work_No
	And		ITR_CALC_NO Is Null;
	If lt_T_FIN_NP_ITR_TAR_SEC.Count < 1 Then
		Return;
	End If;
	liFirst := lt_T_FIN_NP_ITR_TAR_SEC.First;
	liLast := lt_T_FIN_NP_ITR_TAR_SEC.Last;
	For liI In liFirst..liLast Loop
		lrA := lt_T_FIN_NP_ITR_TAR_SEC(liI);
		Select
			b.SECU_NO SECU_NO,
			SQ_T_ITR_CALC_NO.NextVal ITR_CALC_NO,
			Ar_CrtUserNo CRTUSERNO,
			SysDate CRTDATE,
			'1' KIND_TAG,
			a.CALC_DT_FROM CALC_DT_FROM,
			a.CALC_DT_TO CALC_DT_TO,
			a.CALC_DT_TO - a.CALC_DT_FROM CALC_DAYS,
			F_T_Calc_Itr_Amt(a.CALC_DT_FROM,a.CALC_DT_TO,c.PERSTOCK_AMT,c.INTR_RATE)   NP_ITR_AMT
		Into
			lrInsert.SECU_NO,
			lrInsert.ITR_CALC_NO,
			lrInsert.CRTUSERNO,
			lrInsert.CRTDATE,
			lrInsert.KIND_TAG,
			lrInsert.CALC_DT_FROM,
			lrInsert.CALC_DT_TO,
			lrInsert.CALC_DAYS,
			lrInsert.NP_ITR_AMT
		From	T_FIN_SEC_NP_ITR_WORK a,
				T_FIN_NP_ITR_TAR_SEC b,
				T_FIN_SECURTY c
		Where	b.WORK_NO = Ar_Work_No
		And		b.SECU_NO = lrA.SECU_NO
		And		b.WORK_NO = a.WORK_NO
		And		b.SECU_NO = c.SECU_NO;
		
		Insert Into T_FIN_SEC_ITR_AMT Values lrInsert;
		
		Update	T_FIN_NP_ITR_TAR_SEC
		Set		ITR_CALC_NO = lrInsert.ITR_CALC_NO
		Where	WORK_NO = lrA.WORK_NO
		And		SECU_NO = lrA.SECU_NO;
	End Loop;
End;
/
