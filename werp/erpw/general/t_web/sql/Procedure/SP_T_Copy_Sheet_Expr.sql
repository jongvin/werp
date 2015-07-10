Create Or Replace Procedure SP_T_COPY_SHEET_EXPR
(
	Ar_Target_Sheet_Code			T_SHEET_EXPR_HEAD.Sheet_Code%Type,
	Ar_Source_Sheet_Code			T_SHEET_EXPR_HEAD.Sheet_Code%Type,
	Ar_CRTUSERNO					T_SHEET_EXPR_HEAD.CRTUSERNO%Type
)
Is
Begin
	Delete T_SHEET_EXPR_BODY
	Where	Sheet_Code = Ar_Target_Sheet_Code;
	Delete	T_SHEET_EXPR_HEAD
	Where	Sheet_Code = Ar_Target_Sheet_Code;
	Insert Into T_SHEET_EXPR_HEAD
	(
		SHEET_CODE ,
		ITEM_CODE ,
		CRTUSERNO ,
		CRTDATE ,
		MODUSERNO ,
		MODDATE ,
		ITEM_NAME ,
		ITEM_LVL ,
		POSITION ,
		SEQ_TYPE ,
		BOLD_CLS ,
		OUT_CLS ,
		UPLINE_CLS ,
		DOWNLINE_CLS ,
		CURR_PROFIT_CLS ,
		CURR_PAST_CLS ,
		EXPR_SEQ1 ,
		ITEM_ENG_NAME ,
		COST_CODE
	)
	Select
		Ar_Target_Sheet_Code ,
		a.ITEM_CODE ,
		a.CRTUSERNO ,
		a.CRTDATE ,
		a.MODUSERNO ,
		a.MODDATE ,
		a.ITEM_NAME ,
		a.ITEM_LVL ,
		a.POSITION ,
		a.SEQ_TYPE ,
		a.BOLD_CLS ,
		a.OUT_CLS ,
		a.UPLINE_CLS ,
		a.DOWNLINE_CLS ,
		a.CURR_PROFIT_CLS ,
		a.CURR_PAST_CLS ,
		a.EXPR_SEQ1 ,
		a.ITEM_ENG_NAME ,
		a.COST_CODE
	From	T_SHEET_EXPR_HEAD a
	Where	a.SHEET_CODE = Ar_Source_Sheet_Code;
	Insert Into T_SHEET_EXPR_BODY
	(
		SHEET_CODE,
		ITEM_CODE,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE,
		POSITION,
		REMAIN_CLS,
		CALC_CLS
	)
	Select
		Ar_Target_Sheet_Code,
		ITEM_CODE,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE,
		POSITION,
		REMAIN_CLS,
		CALC_CLS
	From	T_SHEET_EXPR_BODY
	Where	SHEET_CODE = Ar_Source_Sheet_Code;
End;
/
