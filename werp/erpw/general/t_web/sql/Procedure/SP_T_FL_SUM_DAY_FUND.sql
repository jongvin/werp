Create Or Replace Procedure SP_T_FL_SUM_DAY_FUND
(
	AR_WORK_DT                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_M_MARKET_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : ����
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
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
