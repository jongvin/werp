Select
	a.DT,			--����
	a.DSC,			--����
	a.IN_COUNT,		--�԰�
	a.OUT_COUNT,		--���
	a.NO,
	Nvl(Sum(a.IN_COUNT) Over ( Order By a.SEQ,a.DT,a.NO,a.SUB_SEQ ) ,0) - 
	Nvl(Sum(a.OUT_COUNT) Over ( Order By a.SEQ,a.DT,a.NO,a.SUB_SEQ ) ,0) REMAIN_CNT		--�ܰ�
From
	(
		Select
			1 SEQ,
			F_T_DATETOSTRING(:DT_F) DT,
			'���� �̿�' DSC,
			Count(a.IN_DT) IN_COUNT,
			Count(a.OUT_DT) OUT_COUNT,
			''  NO,
			1 SUB_SEQ
		From	T_FIN_IN_OUT_AMT a
		Where	a.COMP_CODE = :COMP_CODE
		And		a.IN_DT < :DT_F
		Having	Count(*) > 0
		Union All
		Select
			2 SEQ,
			F_T_DATETOSTRING(a.IN_DT) DT,
			a.IN_DESCRIPTION DSC,
			1 IN_COUNT,
			0 OUT_COUNT,
			a.NO,
			1 SUB_SEQ
		From	T_FIN_IN_OUT_AMT a
		Where	a.COMP_CODE = :COMP_CODE
		And		a.IN_DT Between :DT_F And :DT_T
		Union All
		Select
			2 SEQ,
			F_T_DATETOSTRING(a.OUT_DT) DT,
			a.OUT_DESCRIPTION DSC,
			0,
			1 ,
			a.NO,
			2 SUB_SEQ
		From	T_FIN_IN_OUT_AMT a
		Where	a.COMP_CODE = :COMP_CODE
		And		a.IN_DT Between :DT_F And :DT_T
	) a
Order By
	a.SEQ,
	a.DT,
	a.NO,
	a.SUB_SEQ
