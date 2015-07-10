Create Or Replace Procedure SP_T_LOV_COPY
(
	Ar_Lov_No_F					Number,
	Ar_Lov_No_T					Number
)
Is
Begin
	Insert Into T_LOV_ARGS
	(
		LOV_NO ,
		ARG_SEQ ,
		DIS_SEQ ,
		NAME ,
		TYPE ,
		DEFAULT_VALUE ,
		SESSION_TAG ,
		SESSION_NAME
	)
	Select
		Ar_Lov_No_T ,
		a.ARG_SEQ ,
		a.DIS_SEQ ,
		a.NAME ,
		a.TYPE ,
		a.DEFAULT_VALUE ,
		a.SESSION_TAG ,
		a.SESSION_NAME
	From	T_LOV_ARGS a
	Where	LOV_NO = Ar_Lov_No_F;

	Insert Into T_LOV_COLS
	(
		LOV_NO ,
		COL_SEQ ,
		DIS_SEQ ,
		NAME ,
		TITLE ,
		WIDTH ,
		ALIGN ,
		MASK ,
		VISIBLE
	)
	Select
		Ar_Lov_No_T ,
		a.COL_SEQ ,
		a.DIS_SEQ ,
		a.NAME ,
		a.TITLE ,
		a.WIDTH ,
		a.ALIGN ,
		a.MASK ,
		a.VISIBLE
	From	T_LOV_COLS a
	Where	LOV_NO = Ar_Lov_No_F;

	Insert Into T_LOV_FILTERS
	(
		LOV_NO ,
		FILTER_SEQ ,
		DIS_SEQ ,
		FILTER_NAME ,
		TYPE ,
		DATE_TYPE ,
		DEFAULT_ARG_NAME ,
		RETURN_ARG_NAME ,
		LABEL_NAME ,
		LABEL_WIDTH ,
		WIDTH ,
		SQL ,
		TEXT_COL ,
		VALUE_COL
	)
	Select
		Ar_Lov_No_T ,
		a.FILTER_SEQ ,
		a.DIS_SEQ ,
		a.FILTER_NAME ,
		a.TYPE ,
		a.DATE_TYPE ,
		a.DEFAULT_ARG_NAME ,
		a.RETURN_ARG_NAME ,
		a.LABEL_NAME ,
		a.LABEL_WIDTH ,
		a.WIDTH ,
		a.SQL ,
		a.TEXT_COL ,
		a.VALUE_COL
	From	T_LOV_FILTERS a
	Where	LOV_NO = Ar_Lov_No_F;

	Insert Into T_LOV_FILTER_ARGS
	(
		LOV_NO ,
		FILTER_SEQ ,
		FILTER_ARG_SEQ ,
		DIS_SEQ ,
		TYPE ,
		FILTER_ARG_NAME ,
		DEFAULT_VALUE
	)
	Select
		Ar_Lov_No_T ,
		a.FILTER_SEQ ,
		a.FILTER_ARG_SEQ ,
		a.DIS_SEQ ,
		a.TYPE ,
		a.FILTER_ARG_NAME ,
		a.DEFAULT_VALUE
	From	T_LOV_FILTER_ARGS a
	Where	LOV_NO = Ar_Lov_No_F;

	Insert Into T_LOV_FILTER_RELS
	(
		LOV_NO ,
		FILTER_REL_SEQ ,
		DIS_SEQ ,
		M_FILTER_SEQ ,
		D_FILTER_SEQ
	)
	Select
		Ar_Lov_No_T ,
		a.FILTER_REL_SEQ ,
		a.DIS_SEQ ,
		a.M_FILTER_SEQ ,
		a.D_FILTER_SEQ
	From	T_LOV_FILTER_RELS a
	Where	LOV_NO = Ar_Lov_No_F;
End;
/
