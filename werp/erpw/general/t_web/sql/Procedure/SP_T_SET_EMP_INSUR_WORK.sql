Create Or Replace Procedure SP_T_SET_EMP_INSUR_WORK_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_INSUR_WORK_NO                           NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_TARGET_DT_F                             VARCHAR2,
	AR_TARGET_DT_T                             VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_EMP_INSUR_WORK_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_EMP_INSUR_WORK 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_SET_EMP_INSUR_WORK
	(
		COMP_CODE,
		INSUR_WORK_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_DT,
		TARGET_DT_F,
		TARGET_DT_T,
		CONTENTS,
		SLIP_ID,
		SLIP_IDSEQ
	)
	Values
	(
		AR_COMP_CODE,
		AR_INSUR_WORK_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_WORK_DT),
		F_T_StringToDate(AR_TARGET_DT_F),
		F_T_StringToDate(AR_TARGET_DT_T),
		AR_CONTENTS,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ
	);
End;
/
Create Or Replace Procedure SP_T_SET_EMP_INSUR_WORK_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_INSUR_WORK_NO                           NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_TARGET_DT_F                             VARCHAR2,
	AR_TARGET_DT_T                             VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_EMP_INSUR_WORK_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_EMP_INSUR_WORK 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec							T_SET_EMP_INSUR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_EMP_INSUR_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_INSUR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'전표가 발행된 행은 수정 또는 삭제가 안됩니다.');
		End If;
	Exception When No_Data_Found Then
		Return;
	End;
	Update T_SET_EMP_INSUR_WORK
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		WORK_DT = F_T_StringToDate(AR_WORK_DT),
		TARGET_DT_F = F_T_StringToDate(AR_TARGET_DT_F),
		TARGET_DT_T = F_T_StringToDate(AR_TARGET_DT_T),
		CONTENTS = AR_CONTENTS
	Where	COMP_CODE = AR_COMP_CODE
	And	INSUR_WORK_NO = AR_INSUR_WORK_NO;
End;
/
Create Or Replace Procedure SP_T_SET_EMP_INSUR_WORK_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_INSUR_WORK_NO                           NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_EMP_INSUR_WORK_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_EMP_INSUR_WORK 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec							T_SET_EMP_INSUR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_EMP_INSUR_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_INSUR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'전표가 발행된 행은 수정 또는 삭제가 안됩니다.');
		End If;
	Exception When No_Data_Found Then
		Return;
	End;
	Delete T_SET_EMP_INSUR_WORK
	Where	COMP_CODE = AR_COMP_CODE
	And	INSUR_WORK_NO = AR_INSUR_WORK_NO;
End;
/
