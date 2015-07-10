Create Or Replace Procedure SP_T_U_PL_MA_CONS_AMT
/*���ֱݾ� ��������� ����� ���� �Լ�*/
Is
	ln_ITEM_NO				T_PL_MA_DEPT_LIST.ITEM_NO%Type;
	ls_WORK_YM				T_PL_MA_DEPT_LIST.WORK_YM%Type;
	ls_CRTUSERNO			T_PL_MA_DEPT_LIST.CRTUSERNO%Type;
	lddt_Base_Ym			Date;
Begin
	ln_ITEM_NO := PKG_PL_MA_DEPT_EXEC.Get_ITEM_NO;
	ls_WORK_YM := PKG_PL_MA_DEPT_EXEC.Get_WORK_YM;
	ls_CRTUSERNO := PKG_PL_MA_DEPT_EXEC.Get_CRTUSERNO;
	lddt_Base_Ym := To_Date(SubStrb(ls_WORK_YM,1,4) || '0101','YYYYMMDD');
	Merge Into T_PL_MA_DEPT_LIST t
	Using
	(
		Select
			a.DEPT_CODE,
			ls_WORK_YM WORK_YM,
			ls_CRTUSERNO CRTUSERNO,
			SysDate CRTDATE,
			F_T_GET_CONST_CNT_AMT(a.DEPT_CODE,Last_Day(To_Date(ls_WORK_YM||'01','YYYYMMDD'))) AMT,
			ln_ITEM_NO ITEM_NO
		From	T_DEPT_CODE a
		Where	a.ACC_CLOST_DT_SYS >= lddt_Base_Ym
		And		a.DEPT_PROJ_TAG = 'P'
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
