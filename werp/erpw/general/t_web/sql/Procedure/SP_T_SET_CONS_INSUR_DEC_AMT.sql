Create Or Replace Procedure SP_T_SET_CONS_INSUR_DEC_AMT_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_INSUR_NO                                NUMBER,
	AR_DEC_NO                                  NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_DEC_AMT                                 NUMBER,
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_CONS_INSUR_DEC_AMT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_CONS_INSUR_DEC_AMT 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-22)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec						T_SET_CONS_INSUR_DEC_AMT%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_CONS_INSUR_DEC_AMT
		Where	DEPT_CODE = AR_DEPT_CODE
		And	INSUR_NO = AR_INSUR_NO
		And	DEC_NO = AR_DEC_NO;
	Exception When No_Data_Found Then
		Return;
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-2000,'전표가 발행된 행은 수정될 수 없습니다.');
	End If;
	Update T_SET_CONS_INSUR_DEC_AMT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DEC_AMT = AR_DEC_AMT,
		COMP_CODE = AR_COMP_CODE,
		WORK_NO = AR_WORK_NO,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ
	Where	DEPT_CODE = AR_DEPT_CODE
	And	INSUR_NO = AR_INSUR_NO
	And	DEC_NO = AR_DEC_NO;
End;
/
Create Or Replace Procedure SP_T_SET_CONS_INSUR_DEC_AMT_D
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_INSUR_NO                                NUMBER,
	AR_DEC_NO                                  NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_CONS_INSUR_DEC_AMT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_CONS_INSUR_DEC_AMT 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-22)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec						T_SET_CONS_INSUR_DEC_AMT%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_CONS_INSUR_DEC_AMT
		Where	DEPT_CODE = AR_DEPT_CODE
		And	INSUR_NO = AR_INSUR_NO
		And	DEC_NO = AR_DEC_NO;
	Exception When No_Data_Found Then
		Return;
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-2000,'전표가 발행된 행은 삭제될 수 없습니다.');
	End If;
	Delete T_SET_CONS_INSUR_DEC_AMT
	Where	DEPT_CODE = AR_DEPT_CODE
	And	INSUR_NO = AR_INSUR_NO
	And	DEC_NO = AR_DEC_NO;
End;
/
