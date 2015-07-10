Create Or Replace Procedure SP_T_U_PL_MA_PLUS_MINUS
(
	Ar_Plsu_Item				Varchar2,
	Ar_Minus_Item				Varchar2
)
/*항목-항목 계산용*/
Is
	ln_ITEM_NO				T_PL_MA_DEPT_LIST.ITEM_NO%Type;
	ls_WORK_YM				T_PL_MA_DEPT_LIST.WORK_YM%Type;
	ls_CRTUSERNO			T_PL_MA_DEPT_LIST.CRTUSERNO%Type;
	ln_Plus_Item_No			Number;
	ln_Minus_Item_No		Number;
	
Begin
	ln_Plus_Item_No := PKG_PL_MA_DEPT_EXEC.Get_ITEM_NO_W_MNG_CODE(Ar_Plsu_Item);
	If ln_Plus_Item_No Is Null Then
		Raise_Application_Error(-20009,'관리손익 항목에 관리코드가 '||Ar_Plsu_Item||'인 항목이 설정되어 있지 않습니다.');
	End If;
	ln_Minus_Item_No := PKG_PL_MA_DEPT_EXEC.Get_ITEM_NO_W_MNG_CODE(Ar_Minus_Item);
	If ln_Minus_Item_No Is Null Then
		Raise_Application_Error(-20009,'관리손익 항목에 관리코드가 '||Ar_Minus_Item||'인 항목이 설정되어 있지 않습니다.');
	End If;
	ln_ITEM_NO := PKG_PL_MA_DEPT_EXEC.Get_ITEM_NO;
	ls_WORK_YM := PKG_PL_MA_DEPT_EXEC.Get_WORK_YM;
	ls_CRTUSERNO := PKG_PL_MA_DEPT_EXEC.Get_CRTUSERNO;
	Merge Into T_PL_MA_DEPT_LIST t
	Using
	(
		Select
			a.DEPT_CODE ,
			a.WORK_YM,
			ls_CRTUSERNO CRTUSERNO,
			SysDate CRTDATE,
			ln_ITEM_NO ITEM_NO,
			Sum(Case
			When a.ITEM_NO = ln_Plus_Item_No Then
				a.AMT
			Else
				- a.AMT
			End ) AMT
		From	T_PL_MA_DEPT_LIST a
		Where	a.WORK_YM = ls_WORK_YM
		And		a.ITEM_NO In (ln_Plus_Item_No,ln_Minus_Item_No)
		Group By
			a.DEPT_CODE ,
			a.WORK_YM
	) s
	On
	(
		s.DEPT_CODE = t.DEPT_CODE
	And	s.ITEM_NO = t.ITEM_NO
	And	s.WORK_YM = t.WORK_YM
	)
	When Matched Then
	Update
	Set		t.AMT = s.AMT,
			t.MODUSERNO = s.CRTUSERNO,
			t.MODDATE = s.CRTDATE
	When Not Matched Then
	Insert
	(
		DEPT_CODE,
		WORK_YM,
		ITEM_NO,
		CRTUSERNO,
		CRTDATE,
		AMT
	)
	Values
	(
		s.DEPT_CODE,
		s.WORK_YM,
		s.ITEM_NO,
		s.CRTUSERNO,
		s.CRTDATE,
		s.AMT
	);
End;
/
