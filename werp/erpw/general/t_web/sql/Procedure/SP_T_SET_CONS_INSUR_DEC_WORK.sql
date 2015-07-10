Create Or Replace Procedure SP_T_SET_CONS_INSUR_DEC_WORK_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_CONS_INSUR_DEC_WORK_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_CONS_INSUR_DEC_WORK 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-22)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_SET_CONS_INSUR_DEC_WORK
	(
		COMP_CODE,
		WORK_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_DT,
		CONTENTS,
		SLIP_ID,
		SLIP_IDSEQ
	)
	Values
	(
		AR_COMP_CODE,
		AR_WORK_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_WORK_DT),
		AR_CONTENTS,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ
	);
End;
/
Create Or Replace Procedure SP_T_SET_CONS_INSUR_DEC_WORK_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_CONS_INSUR_DEC_WORK_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_CONS_INSUR_DEC_WORK 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-22)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec									T_SET_CONS_INSUR_DEC_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_CONS_INSUR_DEC_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_NO = AR_WORK_NO;
		If lrRec.SLIP_ID Is not Null Then
			Raise_Application_Error(-20009,'전표가 발행된 행은 수정될 수 없습니다.');
		End If;
	Exception When No_Data_Found Then
		Return;
	End;
	Update T_SET_CONS_INSUR_DEC_WORK
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		WORK_DT = F_T_StringToDate(AR_WORK_DT),
		CONTENTS = AR_CONTENTS,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO;
End;
/
Create Or Replace Procedure SP_T_SET_CONS_INSUR_DEC_WORK_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_CONS_INSUR_DEC_WORK_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_CONS_INSUR_DEC_WORK 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-22)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec									T_SET_CONS_INSUR_DEC_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_CONS_INSUR_DEC_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_NO = AR_WORK_NO;
		If lrRec.SLIP_ID Is not Null Then
			Raise_Application_Error(-20009,'전표가 발행된 행은 삭제될 수 없습니다.');
		End If;
	Exception When No_Data_Found Then
		Return;
	End;
	Delete T_SET_CONS_INSUR_DEC_WORK
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO;
End;
/
