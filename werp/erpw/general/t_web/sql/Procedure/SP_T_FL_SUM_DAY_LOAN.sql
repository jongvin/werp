Create Or Replace Procedure SP_T_FL_SUM_DAY_LOAN
(
	AR_WORK_DT                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_SUM_DAY_LOAN
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 집계
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-21)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
	lddtDt									Date;
Begin
	lddtDt := F_T_StringToDate(AR_WORK_DT);
	Merge Into T_FL_DAY_LOAN_LIST t
	Using
	(
		Select
			a.FL_LOAN_KIND_CODE,
			lddtDt WORK_DT,
			AR_CRTUSERNO CRTUSERNO,
			SysDate CRTDATE,
			b.LOAN_LIMIT_AMT,
			b.LOAN_USE_AMT
		From	T_FL_LOAN_KIND_CODE a,
				(
					Select
						a.FL_LOAN_KIND_CODE,
						Sum(a.LIMIT_AMT) LOAN_LIMIT_AMT,
						Sum(b.REMAIN_AMT) LOAN_USE_AMT
					From	T_FIN_LOAN_CONT a,
							(
								Select
									b.LOAN_CONT_NO,
									Sum(a.LOAN_AMT) LOAN_AMT,
									Sum(a.REFUND_AMT) REFUND_AMT,
									Nvl(Sum(a.LOAN_AMT),0) - Nvl(Sum(a.REFUND_AMT),0) REMAIN_AMT
								From	T_FIN_LOAN_REFUND_LIST a,
										T_FIN_LOAN_SHEET b
								Where	a.LOAN_NO = b.LOAN_NO
								And		a.REFUND_INTR_DT <= lddtDt
								Group By
									b.LOAN_CONT_NO
							) b
					Where	a.LOAN_CONT_NO = b.LOAN_CONT_NO (+)
					Group By
						a.FL_LOAN_KIND_CODE
				) b
		Where	a.FL_LOAN_KIND_CODE = b.FL_LOAN_KIND_CODE (+)
	) s
	On
	(
		s.FL_LOAN_KIND_CODE = t.FL_LOAN_KIND_CODE
	And	s.WORK_DT = t.WORK_DT
	)
	When Matched Then
	Update
	Set	LOAN_LIMIT_AMT = s.LOAN_LIMIT_AMT,
		LOAN_USE_AMT = s.LOAN_USE_AMT,
		MODUSERNO = s.CRTUSERNO,
		MODDATE = s.CRTDATE
	When Not Matched Then
	Insert
	(
		FL_LOAN_KIND_CODE,
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		LOAN_LIMIT_AMT,
		LOAN_USE_AMT
	)
	Values
	(
		s.FL_LOAN_KIND_CODE,
		s.WORK_DT,
		s.CRTUSERNO,
		s.CRTDATE,
		s.LOAN_LIMIT_AMT,
		s.LOAN_USE_AMT
	);
End;
/
