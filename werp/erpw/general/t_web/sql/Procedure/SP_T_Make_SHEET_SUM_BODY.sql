Create Or Replace Procedure SP_T_Make_SHEET_SUM_BODY
(
	Ar_Sheet_Code			T_SHEET_SUM_HEAD.SHEET_CODE%Type,
	Ar_COMP_CODE			T_SHEET_SUM_HEAD.COMP_CODE%Type,
	Ar_DEPT_CODE			T_SHEET_SUM_HEAD.DEPT_CODE%Type,
	Ar_CrtUserNo			T_SHEET_SUM_HEAD.CRTUSERNO%Type
)
Is
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 김흥수
/* 최초작성일 : 2004-12-03
/* 최종수정자 :
/* 최종수정일 :
/***************************************************/
-- 이 프로그램은 재무제표 생성 프로그램입니다.
	Type	t_ArrayByNumber Is Table Of T_SHEET_SEQ_TYPE_NAME.SEQ_TYPE_NAME%Type
		Index By Binary_Integer;
	Type	t_ArrayByVarcahr2 Is Table Of t_ArrayByNumber
		Index By Varchar2(1);
	Type	t_ArraySEQ_TYPE Is Table Of T_SHEET_SEQ_TYPE_NAME.SEQ_TYPE%Type
		Index By Binary_Integer;
	Type	t_ArraySEQ_SEQ Is Table Of T_SHEET_SEQ_TYPE_NAME.SEQ_SEQ%Type
		Index By Binary_Integer;
	Type	t_ArraySEQ_TYPE_NAME Is Table Of T_SHEET_SEQ_TYPE_NAME.SEQ_TYPE_NAME%Type
		Index By Binary_Integer;
	Type	t_ArrayITEM_CODE Is Table Of T_SHEET_SUM_BODY.ITEM_CODE%Type
		Index By Binary_Integer;
	Type	t_ArrayITEM_NAME Is Table Of T_SHEET_SUM_BODY.ITEM_NAME%Type
		Index By Binary_Integer;
	Type	t_ArrayITEM_ENG_NAME Is Table Of T_SHEET_SUM_BODY.ITEM_ENG_NAME%Type
		Index By Binary_Integer;
	Type	t_ArrayITEM_LVL Is Table Of T_SHEET_EXPR_HEAD.ITEM_LVL%Type
		Index By Binary_Integer;
	Type	t_ArrayOUT_CLS Is Table Of T_SHEET_SUM_BODY.OUT_CLS%Type
		Index By Binary_Integer;
	lrT_SHEET_SUM_HEAD		T_SHEET_SUM_HEAD%RowType;
	lrT_SHEET_CODE			T_SHEET_CODE%RowType;
	lsStartDt					Varchar2(8);
	lsEndDt						Varchar2(8);
	lsStartDtCarried			Varchar2(8);
	lsStartDtPre				Varchar2(8);
	lsEndDtPre					Varchar2(8);
	lsStartDtPreCarried			Varchar2(8);
	lsExprSeq1					Varchar2(1);
	lnAmtUnit					Number;
	r_ArraySEQ_TYPE				t_ArraySEQ_TYPE;
	r_ArraySEQ_SEQ				t_ArraySEQ_SEQ;
	r_ArraySEQ_TYPE_NAME		t_ArraySEQ_TYPE_NAME;
	r_ArraySeqType				t_ArrayByVarcahr2;
	r_BufITEM_CODE				t_ArrayITEM_CODE;
	r_BufITEM_NAME				t_ArrayITEM_NAME;
	r_BufITEM_ENG_NAME			t_ArrayITEM_ENG_NAME;
	r_BufITEM_LVL				t_ArrayITEM_LVL;
	r_BufSEQ_TYPE				t_ArraySEQ_TYPE;
	r_BufORG_SEQ_TYPE			t_ArraySEQ_TYPE;
	r_BufOUT_CLS				t_ArrayOUT_CLS;
	r_Level						t_ArrayITEM_LVL;
	lnLastLevel					Number;
	lsPrev						T_SHEET_SEQ_TYPE_NAME.SEQ_TYPE_NAME%Type;
	lsSeqType					T_SHEET_SEQ_TYPE_NAME.SEQ_TYPE%Type;
Begin
	Select
		*
	Into
		lrT_SHEET_CODE
	From	T_SHEET_CODE
	Where	Sheet_Code = Ar_Sheet_Code;
	Select
		*
	Into
		lrT_SHEET_SUM_HEAD
	From	T_SHEET_SUM_HEAD
	Where	Sheet_Code = Ar_Sheet_Code
	And		COMP_CODE = Ar_COMP_CODE
	And		DEPT_CODE = Ar_DEPT_CODE;
	lsStartDt := To_Char(lrT_SHEET_SUM_HEAD.CURR_ACC_FDT,'YYYYMMDD');
	lsEndDt := To_Char(lrT_SHEET_SUM_HEAD.CURR_ACC_EDT,'YYYYMMDD');
	lsStartDtCarried := To_Char(lrT_SHEET_SUM_HEAD.CURR_ACC_FDT,'YYYY')||'0100';
	lsStartDtPre := To_Char(lrT_SHEET_SUM_HEAD.PAST_ACC_FDT,'YYYYMMDD');
	lsEndDtPre := To_Char(lrT_SHEET_SUM_HEAD.PAST_ACC_EDT,'YYYYMMDD');
	lsStartDtPreCarried := To_Char(lrT_SHEET_SUM_HEAD.PAST_ACC_FDT,'YYYY')||'0100';
	--먼저 기존 자료 삭제합니다.
	Delete	T_SHEET_SUM_BODY
	Where	Sheet_Code = Ar_Sheet_Code
	And		COMP_CODE = Ar_COMP_CODE
	And		DEPT_CODE = Ar_DEPT_CODE;
	--재무제표자료를 일단 만들어 놓습니다.
	Insert Into T_SHEET_SUM_BODY
	(
		SHEET_CODE,
		COMP_CODE,
		DEPT_CODE,
		ITEM_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITEM_NAME,
		CURR_LEFT,
		CURR_RIGHT,
		PAST_LEFT,
		PAST_RIGHT,
		BOLD_CLS,
		OUT_CLS,
		UPLINE_CLS,
		DOWNLINE_CLS,
		ITEM_ENG_NAME
	)
	Select
		Ar_Sheet_Code,
		Ar_COMP_CODE,
		Ar_DEPT_CODE,
		ITEM_CODE,
		Ar_CrtUserNo,
		SysDate,
		Null,
		Null,
		ITEM_NAME,
		0,
		0,
		0,
		0,
		BOLD_CLS,
		OUT_CLS,
		UPLINE_CLS,
		DOWNLINE_CLS,
		ITEM_ENG_NAME
	From	T_SHEET_EXPR_HEAD
	Where	Sheet_Code = Ar_Sheet_Code;
	--먼저 전표에서 가져온단다.
	If Ar_COMP_CODE <> '%' And Ar_DEPT_CODE <> '%' Then	-- 특정 현장 집계
		Merge Into T_SHEET_SUM_BODY t
		Using
		(
			Select
				x1.SHEET_CODE ,
				Ar_COMP_CODE COMP_CODE,
				Ar_DEPT_CODE DEPT_CODE,
				x1.ITEM_CODE,
				Sum(
					Decode(x1.POSITION,'L',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_SUM,0),
							'C',Nvl(x1.CR_SUM,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_SUM,0) - Nvl(x1.CR_SUM,0),
								'C',Nvl(x1.CR_SUM,0) - Nvl(x1.DR_SUM,0),
								0)
						)
						,0)
				) Curr_Left,
				Sum(
					Decode(x1.POSITION,'R',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_SUM,0),
							'C',Nvl(x1.CR_SUM,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_SUM,0) - Nvl(x1.CR_SUM,0),
								'C',Nvl(x1.CR_SUM,0) - Nvl(x1.DR_SUM,0),
								0)
						)
						,0)
				) CURR_RIGHT,
				Sum(
					Decode(x1.POSITION,'L',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_PAST,0),
							'C',Nvl(x1.CR_PAST,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_PAST,0) - Nvl(x1.CR_PAST,0),
								'C',Nvl(x1.CR_PAST,0) - Nvl(x1.DR_PAST,0),
								0)
						)
						,0)
				) PAST_LEFT,
				Sum(
					Decode(x1.POSITION,'R',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_PAST,0),
							'C',Nvl(x1.CR_PAST,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_PAST,0) - Nvl(x1.CR_PAST,0),
								'C',Nvl(x1.CR_PAST,0) - Nvl(x1.DR_PAST,0),
								0)
						)
						,0)
				) PAST_RIGHT
			From
				(
					Select
						b.SHEET_CODE ,
						b.ITEM_CODE,
						b.SEQ,
						b.ACC_CODE ,
						b.POSITION ,
						b.CALC_CLS,
						b.REMAIN_CLS,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c.DR_SUM
							When 'P' Then
								c.DR_PAST
							When 'A' Then
								Nvl(c.DR_SUM,0) + Nvl(c.DR_PAST,0)
							Else
								0
						End DR_SUM,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c.CR_SUM
							When 'P' Then
								c.CR_PAST
							When 'A' Then
								Nvl(c.CR_SUM,0) + Nvl(c.CR_PAST,0)
							Else
								0
						End CR_SUM,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c2.DR_SUM
							When 'P' Then
								c2.DR_PAST
							When 'A' Then
								Nvl(c2.DR_SUM,0) + Nvl(c2.DR_PAST,0)
							Else
								0
						End DR_PAST,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c2.CR_SUM
							When 'P' Then
								c2.CR_PAST
							When 'A' Then
								Nvl(c2.CR_SUM,0) + Nvl(c2.CR_PAST,0)
							Else
								0
						End CR_PAST
					From	T_SHEET_EXPR_HEAD a,
							T_SHEET_EXPR_BODY b,
							(
								Select
									c.ACC_CODE ,
									Sum(Decode(c.CONF_YMD,lsStartDtCarried,DR_SUM,0)) DR_PAST,
									Sum(Decode(c.CONF_YMD,lsStartDtCarried,CR_SUM,0)) CR_PAST,
									Sum(
										case
											When c.CONF_YMD >= lsStartDt Then
												DR_SUM
											Else
												0
										End
									) DR_SUM,
									Sum(
										case
											When c.CONF_YMD >= lsStartDt Then
												CR_SUM
											Else
												0
										End
									) CR_SUM
								From	T_ACC_TRANS_DAILY_SUM c
								Where	c.CONF_YMD Between lsStartDtCarried And lsEndDt
								And		c.DEPT_CODE = Ar_DEPT_CODE
								Group By
									c.ACC_CODE
							) c,
							(
								Select
									c.ACC_CODE ,
									Sum(Decode(c.CONF_YMD,lsStartDtPreCarried,DR_SUM,0)) DR_PAST,
									Sum(Decode(c.CONF_YMD,lsStartDtPreCarried,CR_SUM,0)) CR_PAST,
									Sum(
										case
											When c.CONF_YMD >= lsStartDtPre Then
												DR_SUM
											Else
												0
										End
									) DR_SUM,
									Sum(
										case
											When c.CONF_YMD >= lsStartDtPre Then
												CR_SUM
											Else
												0
										End
									) CR_SUM
								From	T_ACC_TRANS_DAILY_SUM c
								Where	c.CONF_YMD Between lsStartDtPreCarried And lsEndDtPre
								And		c.DEPT_CODE = Ar_DEPT_CODE
								Group By
									c.ACC_CODE
							) c2
					Where	a.SHEET_CODE = b.SHEET_CODE
					And		a.ITEM_CODE = b.ITEM_CODE
					And		a.SHEET_CODE = Ar_Sheet_Code
					And		a.EXPR_SEQ1 = '0'
					And		b.ACC_CODE = c.ACC_CODE (+)
					And		b.ACC_CODE = c2.ACC_CODE (+)
				) x1,
				T_ACC_CODE x2
			Where	x1.ACC_CODE = x2.ACC_CODE
			Group By
				x1.SHEET_CODE ,
				x1.ITEM_CODE
		) f
		On (
				t.SHEET_CODE = f.SHEET_CODE
			And t.COMP_CODE = f.COMP_CODE
			And t.DEPT_CODE = f.DEPT_CODE
			And	t.ITEM_CODE = f.ITEM_CODE
			)
		When Matched Then
			Update
			Set	t.Curr_Left = f.Curr_Left,
				t.CURR_RIGHT = f.CURR_RIGHT,
				t.PAST_LEFT = f.PAST_LEFT,
				t.PAST_RIGHT = f.PAST_RIGHT
		When Not Matched Then
			Insert (SHEET_CODE,COMP_CODE,DEPT_CODE,ITEM_CODE)
			Values (f.SHEET_CODE,f.COMP_CODE,f.DEPT_CODE,f.ITEM_CODE);
	ElsIf Ar_COMP_CODE <> '%' And Ar_DEPT_CODE = '%' Then	-- 특정 사업장 전체 집계
		Merge Into T_SHEET_SUM_BODY t
		Using
		(
			Select
				x1.SHEET_CODE ,
				Ar_COMP_CODE COMP_CODE,
				Ar_DEPT_CODE DEPT_CODE,
				x1.ITEM_CODE,
				Sum(
					Decode(x1.POSITION,'L',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_SUM,0),
							'C',Nvl(x1.CR_SUM,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_SUM,0) - Nvl(x1.CR_SUM,0),
								'C',Nvl(x1.CR_SUM,0) - Nvl(x1.DR_SUM,0),
								0)
						)
						,0)
				) Curr_Left,
				Sum(
					Decode(x1.POSITION,'R',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_SUM,0),
							'C',Nvl(x1.CR_SUM,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_SUM,0) - Nvl(x1.CR_SUM,0),
								'C',Nvl(x1.CR_SUM,0) - Nvl(x1.DR_SUM,0),
								0)
						)
						,0)
				) CURR_RIGHT,
				Sum(
					Decode(x1.POSITION,'L',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_PAST,0),
							'C',Nvl(x1.CR_PAST,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_PAST,0) - Nvl(x1.CR_PAST,0),
								'C',Nvl(x1.CR_PAST,0) - Nvl(x1.DR_PAST,0),
								0)
						)
						,0)
				) PAST_LEFT,
				Sum(
					Decode(x1.POSITION,'R',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_PAST,0),
							'C',Nvl(x1.CR_PAST,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_PAST,0) - Nvl(x1.CR_PAST,0),
								'C',Nvl(x1.CR_PAST,0) - Nvl(x1.DR_PAST,0),
								0)
						)
						,0)
				) PAST_RIGHT
			From
				(
					Select
						b.SHEET_CODE ,
						b.ITEM_CODE,
						b.SEQ,
						b.ACC_CODE ,
						b.POSITION ,
						b.CALC_CLS,
						b.REMAIN_CLS,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c.DR_SUM
							When 'P' Then
								c.DR_PAST
							When 'A' Then
								Nvl(c.DR_SUM,0) + Nvl(c.DR_PAST,0)
							Else
								0
						End DR_SUM,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c.CR_SUM
							When 'P' Then
								c.CR_PAST
							When 'A' Then
								Nvl(c.CR_SUM,0) + Nvl(c.CR_PAST,0)
							Else
								0
						End CR_SUM,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c2.DR_SUM
							When 'P' Then
								c2.DR_PAST
							When 'A' Then
								Nvl(c2.DR_SUM,0) + Nvl(c2.DR_PAST,0)
							Else
								0
						End DR_PAST,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c2.CR_SUM
							When 'P' Then
								c2.CR_PAST
							When 'A' Then
								Nvl(c2.CR_SUM,0) + Nvl(c2.CR_PAST,0)
							Else
								0
						End CR_PAST
					From	T_SHEET_EXPR_HEAD a,
							T_SHEET_EXPR_BODY b,
							(
								Select
									c.ACC_CODE ,
									Sum(Decode(c.CONF_YMD,lsStartDtCarried,DR_SUM,0)) DR_PAST,
									Sum(Decode(c.CONF_YMD,lsStartDtCarried,CR_SUM,0)) CR_PAST,
									Sum(
										case
											When c.CONF_YMD >= lsStartDt Then
												DR_SUM
											Else
												0
										End
									) DR_SUM,
									Sum(
										case
											When c.CONF_YMD >= lsStartDt Then
												CR_SUM
											Else
												0
										End
									) CR_SUM
								From	T_ACC_TRANS_DAILY_SUM c
								Where	c.CONF_YMD Between lsStartDtCarried And lsEndDt
								and		c.COMP_CODE = Ar_COMP_CODE
								Group By
									c.ACC_CODE
							) c,
							(
								Select
									c.ACC_CODE ,
									Sum(Decode(c.CONF_YMD,lsStartDtPreCarried,DR_SUM,0)) DR_PAST,
									Sum(Decode(c.CONF_YMD,lsStartDtPreCarried,CR_SUM,0)) CR_PAST,
									Sum(
										case
											When c.CONF_YMD >= lsStartDtPre Then
												DR_SUM
											Else
												0
										End
									) DR_SUM,
									Sum(
										case
											When c.CONF_YMD >= lsStartDtPre Then
												CR_SUM
											Else
												0
										End
									) CR_SUM
								From	T_ACC_TRANS_DAILY_SUM c
								Where	c.CONF_YMD Between lsStartDtPreCarried And lsEndDtPre
								and		c.COMP_CODE = Ar_COMP_CODE
								Group By
									c.ACC_CODE
							) c2
					Where	a.SHEET_CODE = b.SHEET_CODE
					And		a.ITEM_CODE = b.ITEM_CODE
					And		a.SHEET_CODE = Ar_Sheet_Code
					And		a.EXPR_SEQ1 = '0'
					And		b.ACC_CODE = c.ACC_CODE (+)
					And		b.ACC_CODE = c2.ACC_CODE (+)
				) x1,
				T_ACC_CODE x2
			Where	x1.ACC_CODE = x2.ACC_CODE
			Group By
				x1.SHEET_CODE ,
				x1.ITEM_CODE
		) f
		On (
				t.SHEET_CODE = f.SHEET_CODE
			And t.COMP_CODE = f.COMP_CODE
			And t.DEPT_CODE = f.DEPT_CODE
			And	t.ITEM_CODE = f.ITEM_CODE
			)
		When Matched Then
			Update
			Set	t.Curr_Left = f.Curr_Left,
				t.CURR_RIGHT = f.CURR_RIGHT,
				t.PAST_LEFT = f.PAST_LEFT,
				t.PAST_RIGHT = f.PAST_RIGHT
		When Not Matched Then
			Insert (SHEET_CODE,COMP_CODE,DEPT_CODE,ITEM_CODE)
			Values (f.SHEET_CODE,f.COMP_CODE,f.DEPT_CODE,f.ITEM_CODE);
	ElsIf Ar_COMP_CODE = '%' Then	-- 특정 사업장 전체 집계	-- 전체 사업장 집계
		Merge Into T_SHEET_SUM_BODY t
		Using
		(
			Select
				x1.SHEET_CODE ,
				Ar_COMP_CODE COMP_CODE,
				Ar_DEPT_CODE DEPT_CODE,
				x1.ITEM_CODE,
				Sum(
					Decode(x1.POSITION,'L',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_SUM,0),
							'C',Nvl(x1.CR_SUM,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_SUM,0) - Nvl(x1.CR_SUM,0),
								'C',Nvl(x1.CR_SUM,0) - Nvl(x1.DR_SUM,0),
								0)
						)
						,0)
				) Curr_Left,
				Sum(
					Decode(x1.POSITION,'R',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_SUM,0),
							'C',Nvl(x1.CR_SUM,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_SUM,0) - Nvl(x1.CR_SUM,0),
								'C',Nvl(x1.CR_SUM,0) - Nvl(x1.DR_SUM,0),
								0)
						)
						,0)
				) CURR_RIGHT,
				Sum(
					Decode(x1.POSITION,'L',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_PAST,0),
							'C',Nvl(x1.CR_PAST,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_PAST,0) - Nvl(x1.CR_PAST,0),
								'C',Nvl(x1.CR_PAST,0) - Nvl(x1.DR_PAST,0),
								0)
						)
						,0)
				) PAST_LEFT,
				Sum(
					Decode(x1.POSITION,'R',
						Decode(x1.CALC_CLS,'M',-1,1) * Decode(x1.REMAIN_CLS,
							'D',Nvl(x1.DR_PAST,0),
							'C',Nvl(x1.CR_PAST,0),
							'R',
							Decode(x2.ACC_REMAIN_POSITION,
								'D',Nvl(x1.DR_PAST,0) - Nvl(x1.CR_PAST,0),
								'C',Nvl(x1.CR_PAST,0) - Nvl(x1.DR_PAST,0),
								0)
						)
						,0)
				) PAST_RIGHT
			From
				(
					Select
						b.SHEET_CODE ,
						b.ITEM_CODE,
						b.SEQ,
						b.ACC_CODE ,
						b.POSITION ,
						b.CALC_CLS,
						b.REMAIN_CLS,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c.DR_SUM
							When 'P' Then
								c.DR_PAST
							When 'A' Then
								Nvl(c.DR_SUM,0) + Nvl(c.DR_PAST,0)
							Else
								0
						End DR_SUM,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c.CR_SUM
							When 'P' Then
								c.CR_PAST
							When 'A' Then
								Nvl(c.CR_SUM,0) + Nvl(c.CR_PAST,0)
							Else
								0
						End CR_SUM,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c2.DR_SUM
							When 'P' Then
								c2.DR_PAST
							When 'A' Then
								Nvl(c2.DR_SUM,0) + Nvl(c2.DR_PAST,0)
							Else
								0
						End DR_PAST,
						Case a.CURR_PAST_CLS
							When 'C' Then
								c2.CR_SUM
							When 'P' Then
								c2.CR_PAST
							When 'A' Then
								Nvl(c2.CR_SUM,0) + Nvl(c2.CR_PAST,0)
							Else
								0
						End CR_PAST
					From	T_SHEET_EXPR_HEAD a,
							T_SHEET_EXPR_BODY b,
							(
								Select
									c.ACC_CODE ,
									Sum(Decode(c.CONF_YMD,lsStartDtCarried,DR_SUM,0)) DR_PAST,
									Sum(Decode(c.CONF_YMD,lsStartDtCarried,CR_SUM,0)) CR_PAST,
									Sum(
										case
											When c.CONF_YMD >= lsStartDt Then
												DR_SUM
											Else
												0
										End
									) DR_SUM,
									Sum(
										case
											When c.CONF_YMD >= lsStartDt Then
												CR_SUM
											Else
												0
										End
									) CR_SUM
								From	T_ACC_TRANS_DAILY_SUM c
								Where	c.CONF_YMD Between lsStartDtCarried And lsEndDt
								Group By
									c.ACC_CODE
							) c,
							(
								Select
									c.ACC_CODE ,
									Sum(Decode(c.CONF_YMD,lsStartDtPreCarried,DR_SUM,0)) DR_PAST,
									Sum(Decode(c.CONF_YMD,lsStartDtPreCarried,CR_SUM,0)) CR_PAST,
									Sum(
										case
											When c.CONF_YMD >= lsStartDtPre Then
												DR_SUM
											Else
												0
										End
									) DR_SUM,
									Sum(
										case
											When c.CONF_YMD >= lsStartDtPre Then
												CR_SUM
											Else
												0
										End
									) CR_SUM
								From	T_ACC_TRANS_DAILY_SUM c
								Where	c.CONF_YMD Between lsStartDtPreCarried And lsEndDtPre
								Group By
									c.ACC_CODE
							) c2
					Where	a.SHEET_CODE = b.SHEET_CODE
					And		a.ITEM_CODE = b.ITEM_CODE
					And		a.SHEET_CODE = Ar_Sheet_Code
					And		a.EXPR_SEQ1 = '0'
					And		b.ACC_CODE = c.ACC_CODE (+)
					And		b.ACC_CODE = c2.ACC_CODE (+)
				) x1,
				T_ACC_CODE x2
			Where	x1.ACC_CODE = x2.ACC_CODE
			Group By
				x1.SHEET_CODE ,
				x1.ITEM_CODE
		) f
		On (
				t.SHEET_CODE = f.SHEET_CODE
			And t.COMP_CODE = f.COMP_CODE
			And t.DEPT_CODE = f.DEPT_CODE
			And	t.ITEM_CODE = f.ITEM_CODE
			)
		When Matched Then
			Update
			Set	t.Curr_Left = f.Curr_Left,
				t.CURR_RIGHT = f.CURR_RIGHT,
				t.PAST_LEFT = f.PAST_LEFT,
				t.PAST_RIGHT = f.PAST_RIGHT
		When Not Matched Then
			Insert (SHEET_CODE,COMP_CODE,DEPT_CODE,ITEM_CODE)
			Values (f.SHEET_CODE,f.COMP_CODE,f.DEPT_CODE,f.ITEM_CODE);
	End If;
	For liI In 1..4 Loop
		lsExprSeq1 := To_Char(liI,'FM0');
		Merge Into T_SHEET_SUM_BODY t
		Using
		(
			Select
				b.SHEET_CODE ,
				c.COMP_CODE ,
				c.DEPT_CODE ,
				b.ITEM_CODE ,
				Sum(Decode(b.CALC_CLS,'M',-1,1) * Nvl(
					Decode(b.REMAIN_CLS||b.POSITION,
						'RL',c.CURR_LEFT,
						'RR',c.CURR_LEFT,
						'DL',c.CURR_LEFT,
						'CL',c.CURR_RIGHT,0),0))  CURR_LEFT,
				Sum(Decode(b.CALC_CLS,'M',-1,1) * Nvl(
					Decode(b.REMAIN_CLS||b.POSITION,
						'RL',c.CURR_RIGHT,
						'RR',c.CURR_RIGHT,
						'DR',c.CURR_LEFT,
						'CR',c.CURR_RIGHT,0),0))  CURR_RIGHT,
				Sum(Decode(b.CALC_CLS,'M',-1,1) * Nvl(
					Decode(b.REMAIN_CLS||b.POSITION,
						'RL',c.PAST_LEFT,
						'RR',c.PAST_LEFT,
						'DL',c.PAST_LEFT,
						'CL',c.PAST_RIGHT,0),0))  PAST_LEFT,
				Sum(Decode(b.CALC_CLS,'M',-1,1) * Nvl(
					Decode(b.REMAIN_CLS||b.POSITION,
						'RL',c.PAST_RIGHT,
						'RR',c.PAST_RIGHT,
						'DR',c.PAST_LEFT,
						'CR',c.PAST_RIGHT,0),0))  PAST_RIGHT
			From	T_SHEET_EXPR_HEAD a,
					T_SHEET_EXPR_BODY b,
					T_SHEET_SUM_BODY c
			Where	a.SHEET_CODE = Ar_Sheet_Code
			And		a.EXPR_SEQ1 = lsExprSeq1
			And		a.SHEET_CODE = b.SHEET_CODE
			And		a.ITEM_CODE = b.ITEM_CODE
			And		c.DEPT_CODE = Ar_DEPT_CODE
			And		c.COMP_CODE = Ar_COMP_CODE
			And		b.SHEET_CODE = c.SHEET_CODE
			And		b.ACC_CODE = c.ITEM_CODE
			Group By
				b.SHEET_CODE ,
				c.COMP_CODE ,
				c.DEPT_CODE ,
				b.ITEM_CODE
		) f
		On (
				t.SHEET_CODE = f.SHEET_CODE
			And t.COMP_CODE = f.COMP_CODE
			And t.DEPT_CODE = f.DEPT_CODE
			And	t.ITEM_CODE = f.ITEM_CODE
			)
		When Matched Then
			Update
			Set	t.Curr_Left = f.Curr_Left,
				t.CURR_RIGHT = f.CURR_RIGHT,
				t.PAST_LEFT = f.PAST_LEFT,
				t.PAST_RIGHT = f.PAST_RIGHT
		When Not Matched Then
			Insert (SHEET_CODE,COMP_CODE,DEPT_CODE,ITEM_CODE)
			Values (f.SHEET_CODE,f.COMP_CODE,f.DEPT_CODE,f.ITEM_CODE);
		Exit When SQL%RowCount < 1;
	End Loop;
	If lrT_SHEET_CODE.AMTUNIT Is Null Then
		lnAmtUnit:= 1;
	ElsIf lrT_SHEET_CODE.AMTUNIT = 0 Then
		lnAmtUnit:= 1;
	Else
		lnAmtUnit:= lrT_SHEET_CODE.AMTUNIT;
	End If;
	if lnAmtUnit <> 1 Then
		If lrT_SHEET_CODE.ROUND_CLS = '1' Then		--반올림
			Update	T_SHEET_SUM_BODY a
			Set		a.CURR_LEFT = Round(a.CURR_LEFT / lnAmtUnit),
					a.CURR_RIGHT = Round(a.CURR_RIGHT / lnAmtUnit),
					a.PAST_LEFT = Round(a.PAST_LEFT / lnAmtUnit),
					a.PAST_RIGHT = Round(a.PAST_RIGHT / lnAmtUnit)
			Where	a.SHEET_CODE = Ar_Sheet_Code
			And		a.COMP_CODE = Ar_COMP_CODE
			And		a.DEPT_CODE = Ar_DEPT_CODE;
		ElsIf lrT_SHEET_CODE.ROUND_CLS = '2' Then		--버림
			Update	T_SHEET_SUM_BODY a
			Set		a.CURR_LEFT = Floor(a.CURR_LEFT / lnAmtUnit),
					a.CURR_RIGHT = Floor(a.CURR_RIGHT / lnAmtUnit),
					a.PAST_LEFT = Floor(a.PAST_LEFT / lnAmtUnit),
					a.PAST_RIGHT = Floor(a.PAST_RIGHT / lnAmtUnit)
			Where	a.SHEET_CODE = Ar_Sheet_Code
			And		a.COMP_CODE = Ar_COMP_CODE
			And		a.DEPT_CODE = Ar_DEPT_CODE;
		ElsIf lrT_SHEET_CODE.ROUND_CLS = '3' Then		--올림
			Update	T_SHEET_SUM_BODY a
			Set		a.CURR_LEFT = Ceil(a.CURR_LEFT / lnAmtUnit),
					a.CURR_RIGHT = Ceil(a.CURR_RIGHT / lnAmtUnit),
					a.PAST_LEFT = Ceil(a.PAST_LEFT / lnAmtUnit),
					a.PAST_RIGHT = Ceil(a.PAST_RIGHT / lnAmtUnit)
			Where	a.SHEET_CODE = Ar_Sheet_Code
			And		a.COMP_CODE = Ar_COMP_CODE
			And		a.DEPT_CODE = Ar_DEPT_CODE;
		Else
			Update	T_SHEET_SUM_BODY a
			Set		a.CURR_LEFT = Round(a.CURR_LEFT / lnAmtUnit),
					a.CURR_RIGHT = Round(a.CURR_RIGHT / lnAmtUnit),
					a.PAST_LEFT = Round(a.PAST_LEFT / lnAmtUnit),
					a.PAST_RIGHT = Round(a.PAST_RIGHT / lnAmtUnit)
			Where	a.SHEET_CODE = Ar_Sheet_Code
			And		a.COMP_CODE = Ar_COMP_CODE
			And		a.DEPT_CODE = Ar_DEPT_CODE;
		End If;
	End If;
	If lrT_SHEET_CODE.ZERO_CLS = '2' Then		--당기기준
		Delete	T_SHEET_SUM_BODY a
		Where	a.SHEET_CODE = Ar_Sheet_Code
		And		a.COMP_CODE = Ar_COMP_CODE
		And		a.DEPT_CODE = Ar_DEPT_CODE
		And		Abs(a.CURR_LEFT) + Abs(a.CURR_RIGHT) = 0
		And		a.OUT_CLS <> 'S'
		And		(a.SHEET_CODE,a.ITEM_CODE) Not In
		(
			Select
				b.SHEET_CODE,b.ITEM_CODE
			From	T_SHEET_EXPR_HEAD b
			Where	b.SHEET_CODE = Ar_Sheet_Code
			And		b.EXPR_SEQ1 = '9'
		);
	ElsIf lrT_SHEET_CODE.ZERO_CLS = '3' Then		--당기및 전기 기준
		Delete	T_SHEET_SUM_BODY a
		Where	a.SHEET_CODE = Ar_Sheet_Code
		And		a.COMP_CODE = Ar_COMP_CODE
		And		a.DEPT_CODE = Ar_DEPT_CODE
		And		Abs(a.CURR_LEFT) + Abs(a.CURR_RIGHT) + Abs(a.PAST_LEFT) + Abs(a.PAST_RIGHT) = 0
		And		a.OUT_CLS <> 'S'
		And		(a.SHEET_CODE,a.ITEM_CODE) Not In
		(
			Select
				b.SHEET_CODE,b.ITEM_CODE
			From	T_SHEET_EXPR_HEAD b
			Where	b.SHEET_CODE = Ar_Sheet_Code
			And		b.EXPR_SEQ1 = '9'
		);
	End If;
	Begin
		Select
			b.SEQ_TYPE,
			b.SEQ_SEQ,
			b.SEQ_TYPE_NAME
		Bulk Collect Into
			r_ArraySEQ_TYPE,
			r_ArraySEQ_SEQ,
			r_ArraySEQ_TYPE_NAME
		From	T_SHEET_SEQ_TYPE_NAME b
		Order By
			b.SEQ_TYPE,
			b.SEQ_SEQ;
	Exception When No_Data_Found Then
		Null;
	End;
	For liI In 1..r_ArraySEQ_TYPE.Count Loop
		Declare
			r_ArrayByNumber				t_ArrayByNumber;
		Begin
			If r_ArraySeqType.Exists(r_ArraySEQ_TYPE(liI)) Then
				r_ArrayByNumber := r_ArraySeqType(r_ArraySEQ_TYPE(liI));
				r_ArrayByNumber(r_ArraySEQ_SEQ(liI)) := r_ArraySEQ_TYPE_NAME(liI);
			Else
				r_ArrayByNumber(r_ArraySEQ_SEQ(liI)) := r_ArraySEQ_TYPE_NAME(liI);
			End If;
			r_ArraySeqType(r_ArraySEQ_TYPE(liI)) := r_ArrayByNumber;
		End;
	End Loop;
	Begin
		Select
			a.ITEM_CODE ,
			a.ITEM_NAME ,
			a.ITEM_ENG_NAME,
			b.ITEM_LVL,
			b.SEQ_TYPE,
			c.SEQ_TYPE,
			b.OUT_CLS
		Bulk Collect Into
			r_BufITEM_CODE,
			r_BufITEM_NAME,
			r_BufITEM_ENG_NAME,
			r_BufITEM_LVL,
			r_BufSEQ_TYPE,
			r_BufORG_SEQ_TYPE,
			r_BufOUT_CLS
		From	T_SHEET_SUM_BODY a,
				T_SHEET_EXPR_HEAD b,
				T_SHEET_CODE_LVL c
		Where	a.SHEET_CODE = b.SHEET_CODE
		And		a.ITEM_CODE = b.ITEM_CODE
		And		b.SHEET_CODE = c.SHEET_CODE (+)
		And		b.ITEM_LVL = c.ITEM_LVL (+)
		And		a.SHEET_CODE = Ar_Sheet_Code
		And		a.COMP_CODE = Ar_COMP_CODE
		And		a.DEPT_CODE = Ar_DEPT_CODE
		Order By
			a.SHEET_CODE ,
			a.COMP_CODE ,
			a.DEPT_CODE ,
			a.ITEM_CODE;
	Exception When No_Data_Found Then
		Null;
	End;
	For liI In 1..7 Loop
		r_Level(liI) := -1;
	End Loop;
	lnLastLevel := -1;
	For liI In 1..r_BufITEM_CODE.Count Loop
		If r_BufITEM_LVL(liI) > 0 Then
			If r_BufITEM_LVL(liI) > lnLastLevel Then
				For liJ In r_BufITEM_LVL(liI)..r_Level.Count Loop
					r_Level(liJ) := 0;
				End Loop;
			End If;
			lnLastLevel := r_BufITEM_LVL(liI);
			If r_BufSEQ_TYPE(liI) = '0' Then	--만약 기본레벨 적용이면
				If r_BufORG_SEQ_TYPE(liI) = '9' Or r_BufOUT_CLS(liI) = 'F' Then
					r_Level(r_BufITEM_LVL(liI)) := r_Level(r_BufITEM_LVL(liI));
				Else
					r_Level(r_BufITEM_LVL(liI)) := r_Level(r_BufITEM_LVL(liI)) + 1;
				End If;
				Begin
					lsPrev := r_ArraySeqType(r_BufORG_SEQ_TYPE(liI))(r_Level(r_BufITEM_LVL(liI)));
				Exception When Others Then
					lsPrev := '';
				End;
			Else
				If r_BufSEQ_TYPE(liI) = '9' Or r_BufOUT_CLS(liI) = 'F' Then
					r_Level(r_BufITEM_LVL(liI)) := r_Level(r_BufITEM_LVL(liI));
				Else
					r_Level(r_BufITEM_LVL(liI)) := r_Level(r_BufITEM_LVL(liI)) + 1;
				End If;
				Begin
					lsPrev := r_ArraySeqType(r_BufSEQ_TYPE(liI))(r_Level(r_BufITEM_LVL(liI)));
				Exception When Others Then
					lsPrev := '';
				End;
			End If;
			r_BufITEM_NAME(liI) := SubStrb(RPad(' ',Nvl(lrT_SHEET_CODE.INDENTCNT,0) * r_BufITEM_LVL(liI),' ')||lsPrev||r_BufITEM_NAME(liI),1,60);
			r_BufITEM_ENG_NAME(liI) := SubStrb(RPad(' ',Nvl(lrT_SHEET_CODE.INDENTCNT,0) * r_BufITEM_LVL(liI),' ')||lsPrev||r_BufITEM_ENG_NAME(liI),1,60);
			Update	T_SHEET_SUM_BODY
			Set		ITEM_NAME = r_BufITEM_NAME(liI),
					ITEM_ENG_NAME = r_BufITEM_ENG_NAME(liI)
			Where	SHEET_CODE = Ar_Sheet_Code
			And		COMP_CODE = Ar_COMP_CODE
			And		DEPT_CODE = Ar_DEPT_CODE
			And		ITEM_CODE = r_BufITEM_CODE(liI);
		End If;
	End Loop;
End;
/
