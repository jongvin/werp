Create Or Replace Procedure SP_T_SET_IND_INSUR_TARGET_SL_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_INSUR_WORK_NO                           NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_IND_INSUR_TARGET_SLIP_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_IND_INSUR_TARGET_SLIP 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec							T_SET_IND_INSUR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_IND_INSUR_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_INSUR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'전표가 발행된 행은 수정 또는 삭제가 안됩니다.');
		End If;
	Exception When No_Data_Found Then
		Return;
	End;
	Insert Into T_SET_IND_INSUR_TARGET_SLIP
	(
		COMP_CODE,
		INSUR_WORK_NO,
		SLIP_ID,
		SLIP_IDSEQ
	)
	Values
	(
		AR_COMP_CODE,
		AR_INSUR_WORK_NO,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ
	);
End;
/
Create Or Replace Procedure SP_T_SET_IND_INSUR_TARGET_SL_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_INSUR_WORK_NO                           NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_IND_INSUR_TARGET_SLIP_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_IND_INSUR_TARGET_SLIP 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec							T_SET_IND_INSUR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_IND_INSUR_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_INSUR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'전표가 발행된 행은 수정 또는 삭제가 안됩니다.');
		End If;
	Exception When No_Data_Found Then
		Return;
	End;
End;
/
Create Or Replace Procedure SP_T_SET_IND_INSUR_TARGET_SL_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_INSUR_WORK_NO                           NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_IND_INSUR_TARGET_SLIP_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_IND_INSUR_TARGET_SLIP 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec							T_SET_IND_INSUR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_IND_INSUR_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_INSUR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'전표가 발행된 행은 수정 또는 삭제가 안됩니다.');
		End If;
	Exception When No_Data_Found Then
		Return;
	End;
	Delete T_SET_IND_INSUR_TARGET_SLIP
	Where	COMP_CODE = AR_COMP_CODE
	And	INSUR_WORK_NO = AR_INSUR_WORK_NO
	And	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
End;
/
