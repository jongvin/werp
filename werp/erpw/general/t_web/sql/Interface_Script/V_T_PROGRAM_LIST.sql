Create Or Replace View V_T_PROGRAM_LIST
(
	MENU_NO,
	PROGRAM_NO,
	MENU_NAME,
	PROGRAM_NAME ,
	PROGRAM_ID,
	MENU_SEQ,
	PROGRAM_SEQ,
	RW_TAG
)
As
Select
	b.PGRM_ABOVE_KEY,
	a.PGRM_SEQ_KEY ,
	b.TITLE_NAME,
	a.PGRM_NAME ,
	a.PGRM_ID,
	b.NO_SEQ MENU_SEQ,
	a.NO_SEQ PROGRAM_SEQ,
	a.RW_TAG
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
And		b.LEVEL_CODE Like '04%'
Order By
	b.NO_SEQ,
	a.NO_SEQ
/
