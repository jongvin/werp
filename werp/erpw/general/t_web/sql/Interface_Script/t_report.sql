Create Or Replace View t_report
(
	REPORT_NO ,
	REPORT_NAME,
	FILE_NAME ,
	CONDITION_PAGE,
	USE_TAG,
	REMARK
)
As
Select
	b.PGRM_ABOVE_KEY * 10000000000000 + a.PGRM_SEQ_KEY REPORT_NO ,
	a.PGRM_NAME REPORT_NAME,
	'' FILE_NAME ,
	a.PGRM_ID CONDITION_PAGE,
	'T' USE_TAG,
	'' REMARK
From	z_pgrm_content a,
		(
			Select
				a.PGRM_ABOVE_KEY ,
				a.NO_SEQ ,
				a.LEVEL1 ,
				a.TITLE_NAME ,
				a.LEVEL_CODE ,
				a.RW_TAG
			From	Z_PGRM_TITLE a,
					Z_PGRM_TITLE b
			Where	a.NO_SEQ >= b.NO_SEQ
			And		b.TITLE_NAME = '회계관리'
			And		a.NO_SEQ <
					(
						Select
							Nvl(Min(c.NO_SEQ),999999999999)
						From	Z_PGRM_TITLE c
						Where	b.NO_SEQ < c.NO_SEQ
						And		b.LEVEL1 >= c.LEVEL1
					)
		) b
Where	b.PGRM_ABOVE_KEY = a.PGRM_ABOVE_KEY
And		b.LEVEL_CODE Like '05%'
And		a.PGRM_ID Is Not null
Order By
	b.NO_SEQ,
	a.NO_SEQ
/
