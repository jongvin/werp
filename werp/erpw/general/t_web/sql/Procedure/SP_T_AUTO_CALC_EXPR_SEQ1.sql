Create Or Replace Procedure SP_T_AUTO_CALC_EXPR_SEQ1
(
	AR_SHEET_CODE				Varchar2,
	AR_CRTUSERNO				Number
)
/******************************************************************************
/*재무제표 산식 등록 시에 자체식인 경우의 연산 순서 자동 갱신 프로시져
/*작성자 : 김흥수
/*작성일 : 2004-12-01
/******************************************************************************/
Is
	lnCnt			Number;
	lsRet			Varchar2(100);
Begin
	--먼저 자체식은 일단 전부 1레벨로 바꾼다.
	Update	T_SHEET_EXPR_HEAD
	Set		EXPR_SEQ1 = '1',
			CRTUSERNO = AR_CRTUSERNO
	Where	EXPR_SEQ1 In ('2','3','4')
	And		SHEET_CODE = AR_SHEET_CODE;
	For liI In 0..3 Loop
		Update	T_SHEET_EXPR_HEAD a
		Set		a.EXPR_SEQ1 = To_Char(liI + 1,'FM0'),
				a.CRTUSERNO = AR_CRTUSERNO
		Where	a.SHEET_CODE = AR_SHEET_CODE
		And		a.EXPR_SEQ1 <> '0'
		And		Exists
		(
			Select
				Null
			From
				T_SHEET_EXPR_BODY b,
				T_SHEET_EXPR_HEAD c
			Where	c.EXPR_SEQ1 = To_Char(liI,'FM0')
			And		a.SHEET_CODE = b.SHEET_CODE
			And		a.ITEM_CODE = b.ITEM_CODE
			And		b.SHEET_CODE = c.SHEET_CODE
			And		b.ACC_CODE = c.ITEM_CODE
			And		b.SHEET_CODE = AR_SHEET_CODE
		);
		Exit When SQL%ROWCOUNT <= 0;
	End Loop;
	Select
		Count(*),
		Max(a.ITEM_CODE || '-' || a.ITEM_NAME)
	Into
		lnCnt,
		lsRet
	From	T_SHEET_EXPR_HEAD a
	Where	a.SHEET_CODE = AR_SHEET_CODE
	And		a.EXPR_SEQ1 <> '0'
	And		Exists
	(
		Select
			Null
		From
			T_SHEET_EXPR_BODY b,
			T_SHEET_EXPR_HEAD c
		Where	c.EXPR_SEQ1 = '4'
		And		a.SHEET_CODE = b.SHEET_CODE
		And		a.ITEM_CODE = b.ITEM_CODE
		And		b.SHEET_CODE = c.SHEET_CODE
		And		b.ACC_CODE = c.ITEM_CODE
		And		b.SHEET_CODE = AR_SHEET_CODE
	);
	If lnCnt > 0 Then
		Rollback;
		Raise_Application_Error	(-20009, '4레벨을 초과하는 자체식이 있습니다.'||chr(10)||lsRet);
	End If;
End;
/
