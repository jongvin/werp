Create Or Replace Procedure SP_T_SET_COST_CONV_SLIP_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_COST_CONV_SLIP_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_COST_CONV_SLIP 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_SET_COST_CONV_SLIP
	(
		COMP_CODE,
		WORK_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_DT,
		SLIP_ID,
		SLIP_IDSEQ,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_WORK_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		To_Date(AR_WORK_DT||'-01','YYYY-MM-DD'),
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_SET_COST_CONV_SLIP_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_COST_CONV_SLIP_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_COST_CONV_SLIP 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_SET_COST_CONV_SLIP
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		WORK_DT = To_Date(AR_WORK_DT||'-01','YYYY-MM-DD'),
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ,
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO;
End;
/
Create Or Replace Procedure SP_T_SET_COST_CONV_SLIP_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_COST_CONV_SLIP_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_COST_CONV_SLIP 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_SET_COST_CONV_SLIP
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO;
End;
/
