Create Or Replace Procedure SP_T_FIN_PAY_SAL_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_WORK_YM                                 VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_PAYGBN                                  VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_IGNORE_COMP_TAG                         VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_ACCNO                                   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SAL_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SAL 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_PAY_SAL
	(
		COMP_CODE,
		WORK_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_YM,
		WORK_DT,
		PAYGBN,
		CONTENTS,
		IGNORE_COMP_TAG,
		SLIP_ID,
		SLIP_IDSEQ,
		ACCNO
	)
	Values
	(
		AR_COMP_CODE,
		AR_WORK_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_YMTOSTRINGFORMAT(AR_WORK_YM),
		F_T_StringToDate(AR_WORK_DT),
		AR_PAYGBN,
		AR_CONTENTS,
		AR_IGNORE_COMP_TAG,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_ACCNO
	);
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SAL_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_WORK_YM                                 VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_PAYGBN                                  VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_IGNORE_COMP_TAG                         VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_ACCNO                                   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SAL_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SAL 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_PAY_SAL
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		WORK_YM = F_T_YMTOSTRINGFORMAT(AR_WORK_YM),
		WORK_DT = F_T_StringToDate(AR_WORK_DT),
		PAYGBN = AR_PAYGBN,
		CONTENTS = AR_CONTENTS,
		IGNORE_COMP_TAG = AR_IGNORE_COMP_TAG,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ,
		ACCNO = AR_ACCNO
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_SEQ = AR_WORK_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SAL_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SAL_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SAL 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_PAY_SAL
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_SEQ = AR_WORK_SEQ;
End;
/
