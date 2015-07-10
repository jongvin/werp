Create Or Replace Procedure SP_T_FIN_SEC_ITR_AMT_I
(
	AR_SECU_NO                                 NUMBER,
	AR_ITR_CALC_NO                             NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_KIND_TAG                                VARCHAR2,
	AR_CALC_DT_FROM                            VARCHAR2,
	AR_CALC_DT_TO                              VARCHAR2,
	AR_CALC_DAYS                               NUMBER,
	AR_NP_ITR_AMT                              NUMBER,
	AR_ITR_AMT                                 NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SEC_ITR_AMT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SEC_ITR_AMT 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	If AR_CALC_DT_FROM Is Null Then
		Raise_Application_Error(-20009,'이자계산 시작일은 반드시 입력하셔야 합니다.');
	End If;
	If AR_CALC_DT_TO Is Null Then
		Raise_Application_Error(-20009,'이자계상일은 반드시 입력하셔야 합니다.');
	End If;
	If F_T_StringToDate(AR_CALC_DT_FROM) > F_T_StringToDate(AR_CALC_DT_TO) Then
		Raise_Application_Error(-20009,'이자계상일은 이자계산시작일의 이전일 수 없습니다.');
	End If;

	Insert Into T_FIN_SEC_ITR_AMT
	(
		SECU_NO,
		ITR_CALC_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		KIND_TAG,
		CALC_DT_FROM,
		CALC_DT_TO,
		CALC_DAYS,
		NP_ITR_AMT,
		ITR_AMT,
		SLIP_ID,
		SLIP_IDSEQ,
		REMARKS
	)
	Values
	(
		AR_SECU_NO,
		AR_ITR_CALC_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_KIND_TAG,
		F_T_StringToDate(AR_CALC_DT_FROM),
		F_T_StringToDate(AR_CALC_DT_TO),
		F_T_StringToDate(AR_CALC_DT_TO) - F_T_StringToDate(AR_CALC_DT_FROM),
		AR_NP_ITR_AMT,
		AR_ITR_AMT,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FIN_SEC_ITR_AMT_U
(
	AR_SECU_NO                                 NUMBER,
	AR_ITR_CALC_NO                             NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_KIND_TAG                                VARCHAR2,
	AR_CALC_DT_FROM                            VARCHAR2,
	AR_CALC_DT_TO                              VARCHAR2,
	AR_CALC_DAYS                               NUMBER,
	AR_NP_ITR_AMT                              NUMBER,
	AR_ITR_AMT                                 NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SEC_ITR_AMT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SEC_ITR_AMT 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	If AR_SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'전표가 발행된 것은 수정될 수 없습니다.');
	End If;
	If AR_CALC_DT_FROM Is Null Then
		Raise_Application_Error(-20009,'이자계산 시작일은 반드시 입력하셔야 합니다.');
	End If;
	If AR_CALC_DT_TO Is Null Then
		Raise_Application_Error(-20009,'이자계상일은 반드시 입력하셔야 합니다.');
	End If;
	If F_T_StringToDate(AR_CALC_DT_FROM) > F_T_StringToDate(AR_CALC_DT_TO) Then
		Raise_Application_Error(-20009,'이자계상일은 이자계산시작일의 이전일 수 없습니다.');
	End If;
	Update T_FIN_SEC_ITR_AMT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		KIND_TAG = AR_KIND_TAG,
		CALC_DT_FROM = F_T_StringToDate(AR_CALC_DT_FROM),
		CALC_DT_TO = F_T_StringToDate(AR_CALC_DT_TO),
		CALC_DAYS = F_T_StringToDate(AR_CALC_DT_TO) - F_T_StringToDate(AR_CALC_DT_FROM),
		NP_ITR_AMT = AR_NP_ITR_AMT,
		ITR_AMT = AR_ITR_AMT,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ,
		REMARKS = AR_REMARKS
	Where	SECU_NO = AR_SECU_NO
	And	ITR_CALC_NO = AR_ITR_CALC_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_SEC_ITR_AMT_D
(
	AR_SECU_NO                                 NUMBER,
	AR_ITR_CALC_NO                             NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SEC_ITR_AMT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SEC_ITR_AMT 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec									T_FIN_SEC_ITR_AMT%RowType;
Begin
	Select
		*
	Into
		lrRec
	From	T_FIN_SEC_ITR_AMT
	Where	ITR_CALC_NO = AR_ITR_CALC_NO;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'전표가 발행된 것은 삭제될 수 없습니다.');
	End If;
	Delete T_FIN_SEC_ITR_AMT
	Where	SECU_NO = AR_SECU_NO
	And		ITR_CALC_NO = AR_ITR_CALC_NO;
End;
/
