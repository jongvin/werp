Create Or Replace Procedure SP_T_LOV_FILTER_RELS_I
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_REL_SEQ                          NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_M_FILTER_SEQ                            NUMBER,
	AR_D_FILTER_SEQ                            NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_FILTER_RELS_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_FILTER_RELS 테이블 Insert
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_LOV_FILTER_RELS
	(
		LOV_NO,
		FILTER_REL_SEQ,
		DIS_SEQ,
		M_FILTER_SEQ,
		D_FILTER_SEQ
	)
	Values
	(
		AR_LOV_NO,
		AR_FILTER_REL_SEQ,
		AR_DIS_SEQ,
		AR_M_FILTER_SEQ,
		AR_D_FILTER_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_LOV_FILTER_RELS_U
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_REL_SEQ                          NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_M_FILTER_SEQ                            NUMBER,
	AR_D_FILTER_SEQ                            NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_FILTER_RELS_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_FILTER_RELS 테이블 Update
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_LOV_FILTER_RELS
	Set
		DIS_SEQ = AR_DIS_SEQ,
		M_FILTER_SEQ = AR_M_FILTER_SEQ,
		D_FILTER_SEQ = AR_D_FILTER_SEQ
	Where	LOV_NO = AR_LOV_NO
	And	FILTER_REL_SEQ = AR_FILTER_REL_SEQ;
End;
/
Create Or Replace Procedure SP_T_LOV_FILTER_RELS_D
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_REL_SEQ                          NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_FILTER_RELS_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_FILTER_RELS 테이블 Delete
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_LOV_FILTER_RELS
	Where	LOV_NO = AR_LOV_NO
	And	FILTER_REL_SEQ = AR_FILTER_REL_SEQ;
End;
/
