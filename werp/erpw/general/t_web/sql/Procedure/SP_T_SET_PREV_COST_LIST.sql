Create Or Replace Procedure SP_T_SET_PREV_COST_LIST_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_LIST_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_AMT                                     NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_PREV_COST_LIST_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_PREV_COST_LIST 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_SET_PREV_COST_LIST
	(
		COMP_CODE,
		WORK_NO,
		LIST_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		EMP_NO,
		AMT,
		SLIP_ID,
		SLIP_IDSEQ,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_WORK_NO,
		AR_LIST_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_EMP_NO,
		AR_AMT,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_SET_PREV_COST_LIST_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_LIST_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_AMT                                     NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_PREV_COST_LIST_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_PREV_COST_LIST 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_SET_PREV_COST_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		EMP_NO = AR_EMP_NO,
		AMT = AR_AMT,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ,
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO
	And	LIST_NO = AR_LIST_NO;
End;
/
Create Or Replace Procedure SP_T_SET_PREV_COST_LIST_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_LIST_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_PREV_COST_LIST_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_PREV_COST_LIST 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_SET_PREV_COST_LIST
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO
	And	LIST_NO = AR_LIST_NO;
End;
/
