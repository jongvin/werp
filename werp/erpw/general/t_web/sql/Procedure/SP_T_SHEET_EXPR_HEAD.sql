Create Or Replace Procedure SP_T_SHEET_EXPR_HEAD_I
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2,
	AR_ITEM_LVL                                NUMBER,
	AR_POSITION                                VARCHAR2,
	AR_SEQ_TYPE                                VARCHAR2,
	AR_BOLD_CLS                                VARCHAR2,
	AR_OUT_CLS                                 VARCHAR2,
	AR_UPLINE_CLS                              VARCHAR2,
	AR_DOWNLINE_CLS                            VARCHAR2,
	AR_CURR_PROFIT_CLS                         VARCHAR2,
	AR_CURR_PAST_CLS                           VARCHAR2,
	AR_EXPR_SEQ1                               VARCHAR2,
	AR_ITEM_ENG_NAME                           VARCHAR2,
	AR_COST_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_EXPR_HEAD_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_EXPR_HEAD 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lnCnt		Number;
Begin
	If AR_EXPR_SEQ1 = '0' Then		--전표식인 경우
		Select
			Count(*)
		Into
			lnCnt
		From	T_SHEET_EXPR_BODY a
		Where	a.SHEET_CODE = AR_SHEET_CODE
		And		a.ITEM_CODE = AR_ITEM_CODE
		And		a.ACC_CODE Not In
		(
			Select
				b.ACC_CODE
			From	T_ACC_CODE b
		);
		If lnCnt > 0 Then
			Raise_Application_Error	(-20009, '다음 항목은 전표식이면서 없는 계정을 참조합니다.'||chr(10)||AR_ITEM_CODE||AR_ITEM_NAME);
		End If;
	ElsIf AR_EXPR_SEQ1 In ('1','2','3','4') Then		--자체식인 경우
		Select
			Count(*)
		Into
			lnCnt
		From	T_SHEET_EXPR_BODY a
		Where	a.SHEET_CODE = AR_SHEET_CODE
		And		a.ITEM_CODE = AR_ITEM_CODE
		And		a.ACC_CODE Not In
		(
			Select
				b.ITEM_CODE
			From	T_SHEET_EXPR_BODY b
			Where	b.SHEET_CODE = AR_SHEET_CODE
		);
		If lnCnt > 0 Then
			Raise_Application_Error	(-20009, '다음 항목은 자체식이면서 없는 항목을 참조합니다.'||chr(10)||AR_ITEM_CODE||AR_ITEM_NAME);
		End If;
	End If;
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_SHEET_CODE);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_ITEM_CODE);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_CRTUSERNO);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_ITEM_NAME);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_ITEM_LVL);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_POSITION);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_SEQ_TYPE);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_BOLD_CLS);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_OUT_CLS);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_UPLINE_CLS);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_DOWNLINE_CLS);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_CURR_PROFIT_CLS);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_CURR_PAST_CLS);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_EXPR_SEQ1);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_ITEM_ENG_NAME);
	pkg_t_debug.PrintMessages('T_SHEET_EXPR_HEAD',AR_COST_CODE);
	Insert Into T_SHEET_EXPR_HEAD
	(
		SHEET_CODE,
		ITEM_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITEM_NAME,
		ITEM_LVL,
		POSITION,
		SEQ_TYPE,
		BOLD_CLS,
		OUT_CLS,
		UPLINE_CLS,
		DOWNLINE_CLS,
		CURR_PROFIT_CLS,
		CURR_PAST_CLS,
		EXPR_SEQ1,
		ITEM_ENG_NAME,
		COST_CODE
	)
	Values
	(
		AR_SHEET_CODE,
		AR_ITEM_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITEM_NAME,
		AR_ITEM_LVL,
		AR_POSITION,
		AR_SEQ_TYPE,
		AR_BOLD_CLS,
		AR_OUT_CLS,
		AR_UPLINE_CLS,
		AR_DOWNLINE_CLS,
		AR_CURR_PROFIT_CLS,
		AR_CURR_PAST_CLS,
		AR_EXPR_SEQ1,
		AR_ITEM_ENG_NAME,
		AR_COST_CODE
	);
End;
/
Create Or Replace Procedure SP_T_SHEET_EXPR_HEAD_U
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2,
	AR_ITEM_LVL                                NUMBER,
	AR_POSITION                                VARCHAR2,
	AR_SEQ_TYPE                                VARCHAR2,
	AR_BOLD_CLS                                VARCHAR2,
	AR_OUT_CLS                                 VARCHAR2,
	AR_UPLINE_CLS                              VARCHAR2,
	AR_DOWNLINE_CLS                            VARCHAR2,
	AR_CURR_PROFIT_CLS                         VARCHAR2,
	AR_CURR_PAST_CLS                           VARCHAR2,
	AR_EXPR_SEQ1                               VARCHAR2,
	AR_ITEM_ENG_NAME                           VARCHAR2,
	AR_COST_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_EXPR_HEAD_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_EXPR_HEAD 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lnCnt		Number;
Begin
	If AR_EXPR_SEQ1 = '0' Then		--전표식인 경우
		Select
			Count(*)
		Into
			lnCnt
		From	T_SHEET_EXPR_BODY a
		Where	a.SHEET_CODE = AR_SHEET_CODE
		And		a.ITEM_CODE = AR_ITEM_CODE
		And		a.ACC_CODE Not In
		(
			Select
				b.ACC_CODE
			From	T_ACC_CODE b
		);
		If lnCnt > 0 Then
			Raise_Application_Error	(-20009, '다음 항목은 전표식이면서 없는 계정을 참조합니다.'||chr(10)||AR_ITEM_CODE||AR_ITEM_NAME);
		End If;
	ElsIf AR_EXPR_SEQ1 In ('1','2','3','4') Then		--자체식인 경우
		Select
			Count(*)
		Into
			lnCnt
		From	T_SHEET_EXPR_BODY a
		Where	a.SHEET_CODE = AR_SHEET_CODE
		And		a.ITEM_CODE = AR_ITEM_CODE
		And		a.ACC_CODE Not In
		(
			Select
				b.ITEM_CODE
			From	T_SHEET_EXPR_BODY b
			Where	b.SHEET_CODE = AR_SHEET_CODE
		);
		If lnCnt > 0 Then
			Raise_Application_Error	(-20009, '다음 항목은 자체식이면서 없는 항목을 참조합니다.'||chr(10)||AR_ITEM_CODE||AR_ITEM_NAME);
		End If;
	End If;
	Update T_SHEET_EXPR_HEAD
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITEM_NAME = AR_ITEM_NAME,
		ITEM_LVL = AR_ITEM_LVL,
		POSITION = AR_POSITION,
		SEQ_TYPE = AR_SEQ_TYPE,
		BOLD_CLS = AR_BOLD_CLS,
		OUT_CLS = AR_OUT_CLS,
		UPLINE_CLS = AR_UPLINE_CLS,
		DOWNLINE_CLS = AR_DOWNLINE_CLS,
		CURR_PROFIT_CLS = AR_CURR_PROFIT_CLS,
		CURR_PAST_CLS = AR_CURR_PAST_CLS,
		EXPR_SEQ1 = AR_EXPR_SEQ1,
		ITEM_ENG_NAME = AR_ITEM_ENG_NAME,
		COST_CODE = AR_COST_CODE
	Where	SHEET_CODE = AR_SHEET_CODE
	And	ITEM_CODE = AR_ITEM_CODE;
End;
/
Create Or Replace Procedure SP_T_SHEET_EXPR_HEAD_D
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_EXPR_HEAD_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_EXPR_HEAD 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete	T_SHEET_SUM_BODY
	Where	SHEET_CODE = Ar_SHEET_CODE
	And		ITEM_CODE = Ar_ITEM_CODE;

	Delete	T_SHEET_EXPR_BODY
	Where	SHEET_CODE = Ar_SHEET_CODE
	And		ITEM_CODE = Ar_ITEM_CODE;

	Delete T_SHEET_EXPR_HEAD
	Where	SHEET_CODE = AR_SHEET_CODE
	And	ITEM_CODE = AR_ITEM_CODE;
End;
/
