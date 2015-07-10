Create Or Replace Procedure SP_T_FIN_SEC_NP_ITR_WORK_I
(
	AR_WORK_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_DESCRIPTION                             VARCHAR2,
	AR_CALC_DT_FROM                            VARCHAR2,
	AR_CALC_DT_TO                              VARCHAR2,
	AR_TARGET_COMP_CODE                        VARCHAR2,
	AR_NP_ITR_AMT                              NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SEC_NP_ITR_WORK_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SEC_NP_ITR_WORK 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-26)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_SEC_NP_ITR_WORK
	(
		WORK_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_DT,
		DESCRIPTION,
		CALC_DT_FROM,
		CALC_DT_TO,
		TARGET_COMP_CODE,
		NP_ITR_AMT,
		SLIP_ID,
		SLIP_IDSEQ
	)
	Values
	(
		AR_WORK_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_WORK_DT),
		AR_DESCRIPTION,
		F_T_StringToDate(AR_CALC_DT_FROM),
		F_T_StringToDate(AR_CALC_DT_TO),
		AR_TARGET_COMP_CODE,
		AR_NP_ITR_AMT,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ
	);
End;
/
Create Or Replace Procedure SP_T_FIN_SEC_NP_ITR_WORK_U
(
	AR_WORK_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_DESCRIPTION                             VARCHAR2,
	AR_CALC_DT_FROM                            VARCHAR2,
	AR_CALC_DT_TO                              VARCHAR2,
	AR_TARGET_COMP_CODE                        VARCHAR2,
	AR_NP_ITR_AMT                              NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SEC_NP_ITR_WORK_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SEC_NP_ITR_WORK 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-26)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec					T_FIN_SEC_NP_ITR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_SEC_NP_ITR_WORK
		Where	WORK_NO = AR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'전표가 발행된 자료는 수정하실 수 없습니다.');
		End If;
	Exception When No_Data_Found Then
		Null;
	End;
	Update T_FIN_SEC_NP_ITR_WORK
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		WORK_DT = F_T_StringToDate(AR_WORK_DT),
		DESCRIPTION = AR_DESCRIPTION,
		CALC_DT_FROM = F_T_StringToDate(AR_CALC_DT_FROM),
		CALC_DT_TO = F_T_StringToDate(AR_CALC_DT_TO),
		TARGET_COMP_CODE = AR_TARGET_COMP_CODE,
		NP_ITR_AMT = AR_NP_ITR_AMT
	Where	WORK_NO = AR_WORK_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_SEC_NP_ITR_WORK_D
(
	AR_WORK_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SEC_NP_ITR_WORK_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SEC_NP_ITR_WORK 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-26)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec					T_FIN_SEC_NP_ITR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_SEC_NP_ITR_WORK
		Where	WORK_NO = AR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'전표가 발행된 자료는 삭제하실 수 없습니다.');
		End If;
	Exception When No_Data_Found Then
		Null;
	End;
	Delete T_FIN_SEC_NP_ITR_WORK
	Where	WORK_NO = AR_WORK_NO;
End;
/
