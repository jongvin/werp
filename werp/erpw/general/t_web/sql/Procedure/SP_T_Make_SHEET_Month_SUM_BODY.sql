Create Or Replace Procedure SP_T_Make_SHEET_Month_SUM_BODY
(
	Ar_Sheet_Code			T_SHEET_MONTH_SUM_BODY.SHEET_CODE%Type,
	Ar_Work_Ym				T_SHEET_MONTH_SUM_BODY.WORK_YM%Type
)
Is
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 김흥수
/* 최초작성일 : 2004-12-03
/* 최종수정자 :
/* 최종수정일 :
/***************************************************/
-- 이 프로그램은 월별 재무제표 생성 프로그램입니다.
	lrT_SHEET_CODE			T_SHEET_CODE%RowType;
	lsStartDt					Varchar2(8);
	lsEndDt						Varchar2(8);
	lsStartDtCarried			Varchar2(8);
	lsStartDtPre				Varchar2(8);
	lsEndDtPre					Varchar2(8);
	lsStartDtPreCarried			Varchar2(8);
	lsExprSeq1					Varchar2(1);
	lnAmtUnit					Number;
Begin
	Select
		*
	Into
		lrT_SHEET_CODE
	From	T_SHEET_CODE
	Where	Sheet_Code = Ar_Sheet_Code;

	If lrT_SHEET_CODE.SHEET_TYPE In ('1','3') Then	--대차대조표 합계잔액 시산표	==> 시점 재무제표
		lsStartDt := SubStrb(Ar_Work_Ym,1,4) ||'0101';
		lsEndDt := To_Char(Last_Day(To_Date(Ar_Work_Ym||'01','YYYYMMDD')),'YYYYMMDD');
		lsStartDtCarried := SubStrb(Ar_Work_Ym,1,4) ||'0100';
		lsStartDtPre := To_Char(To_Number(SubStrb(Ar_Work_Ym,1,4)) - 1,'FM0000') || '0101';
		lsEndDtPre := To_Char(To_Date(lsStartDt,'YYYYMMDD') - 1,'YYYYMMDD');
		lsStartDtPreCarried := SubStrb(lsStartDtPre,1,4) ||'0100';
	Else											--손익계산서,공사원가명세서등	==> 기간 재무제표
		lsStartDt := Ar_Work_Ym||'01';				--당월 1일
		lsEndDt := To_Char(Last_Day(To_Date(Ar_Work_Ym||'01','YYYYMMDD')),'YYYYMMDD');
		lsStartDtCarried := SubStrb(Ar_Work_Ym,1,4) ||'0100';
		lsStartDtPre := To_Char(To_Number(SubStrb(Ar_Work_Ym,1,4)) - 1,'FM0000') || '0101';
		lsEndDtPre := To_Char(To_Date(lsStartDt,'YYYYMMDD') - 1,'YYYYMMDD');
		lsStartDtPreCarried := SubStrb(lsStartDtPre,1,4) ||'0100';
	End If;
	
	PKG_T_Debug.PrintMessages('SP_T_Make_SHEET_Month_SUM_BODY','lsStartDt');
	PKG_T_Debug.PrintMessages('SP_T_Make_SHEET_Month_SUM_BODY',lsStartDt);

	PKG_T_Debug.PrintMessages('SP_T_Make_SHEET_Month_SUM_BODY','lsEndDt');
	PKG_T_Debug.PrintMessages('SP_T_Make_SHEET_Month_SUM_BODY',lsEndDt);

	PKG_T_Debug.PrintMessages('SP_T_Make_SHEET_Month_SUM_BODY','lsStartDtCarried');
	PKG_T_Debug.PrintMessages('SP_T_Make_SHEET_Month_SUM_BODY',lsStartDtCarried);

	PKG_T_Debug.PrintMessages('SP_T_Make_SHEET_Month_SUM_BODY','lsStartDtPre');
	PKG_T_Debug.PrintMessages('SP_T_Make_SHEET_Month_SUM_BODY',lsStartDtPre);

	PKG_T_Debug.PrintMessages('SP_T_Make_SHEET_Month_SUM_BODY','lsStartDtPreCarried');
	PKG_T_Debug.PrintMessages('SP_T_Make_SHEET_Month_SUM_BODY',lsStartDtPreCarried);

	--먼저 기존 자료 삭제합니다.
	Delete	T_SHEET_MONTH_SUM_BODY
	Where	Sheet_Code = Ar_Sheet_Code
	And		WORK_YM = Ar_WORK_YM;
/*
	--재무제표자료를 일단 만들어 놓습니다.
	Insert Into T_SHEET_MONTH_SUM_BODY
	(
		SHEET_CODE,
		COMP_CODE,
		DEPT_CODE,
		ITEM_CODE,
		WORK_YM,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITEM_NAME,
		CURR_LEFT,
		CURR_RIGHT,
		BOLD_CLS,
		OUT_CLS,
		UPLINE_CLS,
		DOWNLINE_CLS,
		ITEM_ENG_NAME
	)
	Select
		x.SHEET_CODE,
		a.COMP_CODE,
		a.DEPT_CODE,
		x.ITEM_CODE,
		Ar_WORK_YM,
		SysDate,
		Null,
		Null,
		x.ITEM_NAME,
		0,
		0,
		x.BOLD_CLS,
		x.OUT_CLS,
		x.UPLINE_CLS,
		x.DOWNLINE_CLS,
		x.ITEM_ENG_NAME
	From
		(
			Select
				x.SHEET_CODE ,
				x.ITEM_CODE ,
				x.ITEM_NAME ,
				x.BOLD_CLS ,
				x.OUT_CLS ,
				x.UPLINE_CLS ,
				x.DOWNLINE_CLS ,
				x.ITEM_ENG_NAME ,
				RowNum Rn
			From	T_SHEET_EXPR_HEAD x
			Where	x.SHEET_CODE = Ar_Sheet_Code
		) x,
		(
			Select
				Distinct
				a.dept_code,
				b.COMP_CODE
			from	T_ACC_TRANS_DAILY_SUM a,
					T_DEPT_CODE_ORG b
			Where	a.CONF_YMD between lsStartDt and lsEndDt
			And		a.DEPT_CODE = b.DEPT_CODE
		) a;
		*/
	--먼저 전표에서 가져온단다.
	Merge Into T_SHEET_MONTH_SUM_BODY t
	Using
	(
		Select
			Ar_WORK_YM WORK_YM,
			x1.SHEET_CODE,
			x1.COMP_CODE,
			x1.DEPT_CODE,
			x1.ITEM_CODE,
			x1.ITEM_NAME,
			x1.ITEM_ENG_NAME,
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
			) CURR_RIGHT
		From
			(
				Select
					b.SHEET_CODE ,
					c.COMP_CODE,
					c.DEPT_CODE,
					b.ITEM_CODE,
					b.SEQ,
					b.ACC_CODE ,
					b.POSITION ,
					b.CALC_CLS,
					b.REMAIN_CLS,
					a.ITEM_NAME,
					a.ITEM_ENG_NAME,
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
					End CR_SUM
				From	T_SHEET_EXPR_HEAD a,
						T_SHEET_EXPR_BODY b,
						(
							Select
								c.DEPT_CODE,
								c.ACC_CODE ,
								c.COMP_CODE,
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
								) CR_SUM,
								0 DR_PAST2,
								0 CR_PAST2,
								0 DR_SUM2,
								0 CR_SUM2
							From	T_ACC_TRANS_DAILY_SUM c
							Where	c.CONF_YMD Between lsStartDtCarried And lsEndDt
							Group By
								c.DEPT_CODE,
								c.COMP_CODE,
								c.ACC_CODE
						) c
				Where	a.SHEET_CODE = b.SHEET_CODE
				And		a.ITEM_CODE = b.ITEM_CODE
				And		a.SHEET_CODE = Ar_Sheet_Code
				And		a.EXPR_SEQ1 = '0'
				And		b.ACC_CODE = c.ACC_CODE
			) x1,
			T_ACC_CODE x2
		Where	x1.ACC_CODE = x2.ACC_CODE
		Group By
			x1.SHEET_CODE ,
			x1.COMP_CODE,
			x1.DEPT_CODE,
			x1.ITEM_NAME,
			x1.ITEM_ENG_NAME,
			x1.ITEM_CODE
	) f
	On (
			t.SHEET_CODE = f.SHEET_CODE
		And t.WORK_YM = f.WORK_YM
		And t.COMP_CODE = f.COMP_CODE
		And t.DEPT_CODE = f.DEPT_CODE
		And	t.ITEM_CODE = f.ITEM_CODE
		)
	When Matched Then
		Update
		Set	t.CURR_LEFT = f.CURR_LEFT,
			t.CURR_RIGHT = f.CURR_RIGHT
	When Not Matched Then
		Insert (SHEET_CODE,WORK_YM,COMP_CODE,DEPT_CODE,ITEM_CODE,ITEM_NAME,CURR_LEFT,CURR_RIGHT,ITEM_ENG_NAME)
		Values (f.SHEET_CODE,f.WORK_YM,f.COMP_CODE,f.DEPT_CODE,f.ITEM_CODE,f.ITEM_NAME,f.CURR_LEFT,f.CURR_RIGHT,f.ITEM_ENG_NAME);
	For liI In 1..4 Loop
		lsExprSeq1 := To_Char(liI,'FM0');
		Merge Into T_SHEET_MONTH_SUM_BODY t
		Using
		(
			Select
				b.SHEET_CODE,
				c.WORK_YM,
				c.COMP_CODE,
				c.DEPT_CODE,
				b.ITEM_CODE,
				a.ITEM_NAME,
				a.ITEM_ENG_NAME,
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
						'CR',c.CURR_RIGHT,0),0))  CURR_RIGHT
			From	T_SHEET_EXPR_HEAD a,
					T_SHEET_EXPR_BODY b,
					T_SHEET_MONTH_SUM_BODY c
			Where	a.SHEET_CODE = Ar_Sheet_Code
			And		a.EXPR_SEQ1 = lsExprSeq1
			And		a.SHEET_CODE = b.SHEET_CODE
			And		a.ITEM_CODE = b.ITEM_CODE
			And		c.WORK_YM = Ar_WORK_YM
			And		b.SHEET_CODE = c.SHEET_CODE
			And		b.ACC_CODE = c.ITEM_CODE
			Group By
				b.SHEET_CODE ,
				a.ITEM_NAME,
				a.ITEM_ENG_NAME,
				c.WORK_YM,
				c.COMP_CODE ,
				c.DEPT_CODE ,
				b.ITEM_CODE
		) f
		On (
				t.SHEET_CODE = f.SHEET_CODE
			And t.WORK_YM = f.WORK_YM
			And t.COMP_CODE = f.COMP_CODE
			And t.DEPT_CODE = f.DEPT_CODE
			And	t.ITEM_CODE = f.ITEM_CODE
			)
		When Matched Then
			Update
			Set	t.CURR_LEFT = f.CURR_LEFT,
				t.CURR_RIGHT = f.CURR_RIGHT
		When Not Matched Then
			Insert (SHEET_CODE,WORK_YM,COMP_CODE,DEPT_CODE,ITEM_CODE,ITEM_NAME,CURR_LEFT,CURR_RIGHT,ITEM_ENG_NAME)
			Values (f.SHEET_CODE,f.WORK_YM,f.COMP_CODE,f.DEPT_CODE,f.ITEM_CODE,f.ITEM_NAME,f.CURR_LEFT,f.CURR_RIGHT,f.ITEM_ENG_NAME);
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
			Update	T_SHEET_MONTH_SUM_BODY a
			Set		a.CURR_LEFT = Round(a.CURR_LEFT / lnAmtUnit),
					a.CURR_RIGHT = Round(a.CURR_RIGHT / lnAmtUnit)
			Where	a.SHEET_CODE = Ar_Sheet_Code
			And		a.WORK_YM = Ar_WORK_YM;
		ElsIf lrT_SHEET_CODE.ROUND_CLS = '2' Then		--버림
			Update	T_SHEET_MONTH_SUM_BODY a
			Set		a.CURR_LEFT = Floor(a.CURR_LEFT / lnAmtUnit),
					a.CURR_RIGHT = Floor(a.CURR_RIGHT / lnAmtUnit)
			Where	a.SHEET_CODE = Ar_Sheet_Code
			And		a.WORK_YM = Ar_WORK_YM;
		ElsIf lrT_SHEET_CODE.ROUND_CLS = '3' Then		--올림
			Update	T_SHEET_MONTH_SUM_BODY a
			Set		a.CURR_LEFT = Ceil(a.CURR_LEFT / lnAmtUnit),
					a.CURR_RIGHT = Ceil(a.CURR_RIGHT / lnAmtUnit)
			Where	a.SHEET_CODE = Ar_Sheet_Code
			And		a.WORK_YM = Ar_WORK_YM;
		Else
			Update	T_SHEET_MONTH_SUM_BODY a
			Set		a.CURR_LEFT = Round(a.CURR_LEFT / lnAmtUnit),
					a.CURR_RIGHT = Round(a.CURR_RIGHT / lnAmtUnit)
			Where	a.SHEET_CODE = Ar_Sheet_Code
			And		a.WORK_YM = Ar_WORK_YM;
		End If;
	End If;
	If lrT_SHEET_CODE.ZERO_CLS = '2' Then		--당기기준
		Delete	T_SHEET_MONTH_SUM_BODY a
		Where	a.SHEET_CODE = Ar_Sheet_Code
		And		a.WORK_YM = Ar_WORK_YM
		And		Abs(a.CURR_LEFT) + Abs(a.CURR_RIGHT) = 0
		And		(a.SHEET_CODE,a.ITEM_CODE) Not In
		(
			Select
				b.SHEET_CODE,b.ITEM_CODE
			From	T_SHEET_EXPR_HEAD b
			Where	b.SHEET_CODE = Ar_Sheet_Code
			And		b.EXPR_SEQ1 = '9'
		);
	ElsIf lrT_SHEET_CODE.ZERO_CLS = '3' Then		--당기및 전기 기준
		Delete	T_SHEET_MONTH_SUM_BODY a
		Where	a.SHEET_CODE = Ar_Sheet_Code
		And		a.WORK_YM = Ar_WORK_YM
		And		Abs(a.CURR_LEFT) + Abs(a.CURR_RIGHT) = 0
		And		(a.SHEET_CODE,a.ITEM_CODE) Not In
		(
			Select
				b.SHEET_CODE,b.ITEM_CODE
			From	T_SHEET_EXPR_HEAD b
			Where	b.SHEET_CODE = Ar_Sheet_Code
			And		b.EXPR_SEQ1 = '9'
		);
	End If;
End;
/
