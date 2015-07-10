Create Or Replace Procedure SP_T_FL_SUM_DAY_FUND
(
	AR_WORK_DT                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_M_MARKET_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 집계
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-21)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
	lddtDt									Date;
Begin
	lddtDt := F_T_StringToDate(AR_WORK_DT);
	Merge Into T_FL_DAY_FUND_IN_OUT t
	Using
	(
		Select
			a.ITEM_CODE,
			lddtDt WORK_DT,
			AR_CRTUSERNO CRTUSERNO,
			SysDate CRTDATE,
			Sum(c.EXEC_AMT) AMT
		From	T_FL_FUND_IN_OUT_CODE a,
				T_FL_FUND_REL_FLOW_CODE b,
				(Select * From T_FL_DAY_EXEC_B c Where c.WORK_DT = lddtDt ) c
		Where	a.ITEM_CODE = b.ITEM_CODE
		And		b.FLOW_CODE_B = c.FLOW_CODE_B (+)
		Group By
			a.ITEM_CODE
	) s
	On
	(
		s.ITEM_CODE = t.ITEM_CODE
	And	s.WORK_DT = t.WORK_DT
	)
	When Matched Then
	Update
	Set	AMT = s.AMT,
		MODUSERNO = s.CRTUSERNO,
		MODDATE = s.CRTDATE
	When Not Matched Then
	Insert
	(
		ITEM_CODE,
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		AMT
	)
	Values
	(
		s.ITEM_CODE,
		s.WORK_DT,
		s.CRTUSERNO,
		s.CRTDATE,
		s.AMT
	);
End;
/
