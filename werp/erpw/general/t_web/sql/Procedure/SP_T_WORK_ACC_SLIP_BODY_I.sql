Create Or Replace Procedure SP_T_WORK_ACC_SLIP_BODY_EMY_I
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_CRTUSERNO                               VARCHAR2, 
	AR_WORK_CODE                               VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_WORK_ACC_SLIP_BODY_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_WORK_ACC_SLIP_BODY 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-26)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
lrT_WORK_ACC_CODE	T_WORK_ACC_CODE%RowType;
lrT_DEPT_CODE_ORG	T_DEPT_CODE_ORG%RowType;
lrT_DEPT_CLASS_CODE T_DEPT_CLASS_CODE%RowType;

Begin

	Begin
		SELECT
			/*
			WORK_CODE,
			ACC_CODE,
			ACC_POSITION,
			SUMMARY_CODE,
			SUMMARY1,
			SUMMARY2,
			VAT_CODE,
			SEQ,
			USE_TAG
			*/
			*
		INTO lrT_WORK_ACC_CODE
		FROM
			T_WORK_ACC_CODE
		WHERE
			WORK_CODE=AR_WORK_CODE
			AND COST_DEPT_KND_TAG =
			(
				SELECT
					COST_DEPT_KND_TAG
				FROM
					T_DEPT_CODE_ORG
				WHERE
					DEPT_CODE=AR_DEPT_CODE
			)
			AND USE_TAG = 'T';
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'해당 자동전표 상대계정정보가 존재하지 않습니다.');
	End;
	
	Begin
		SELECT
			*
		INTO lrT_DEPT_CODE_ORG
		FROM
			T_DEPT_CODE_ORG
		WHERE
			DEPT_CODE=AR_DEPT_CODE;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'해당 자동전표 상대계정정보가 존재하지 않습니다.');
	End;

	Begin
		SELECT
			*
		INTO lrT_DEPT_CLASS_CODE
		FROM		  
			T_DEPT_CLASS_CODE
		WHERE
			DEPT_CODE = AR_DEPT_CODE
			AND DFLT_TAG='T';
	Exception When No_Data_Found Then
		--Raise_Application_Error(-20009,'해당 자동전표 상대계정정보가 존재하지 않습니다.');
		NULL;
	End;

	Insert Into T_WORK_ACC_SLIP_BODY
	(
		SLIP_ID,
		SLIP_IDSEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_CODE,
		ACC_CODE,
		SUMMARY_CODE,
		SUMMARY1,
		SUMMARY2,
		VAT_CODE,
		TAX_COMP_CODE,
		COMP_CODE,
		DEPT_CODE,
		CLASS_CODE
	)
	Values
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_WORK_CODE,
		lrT_WORK_ACC_CODE.ACC_CODE,
		lrT_WORK_ACC_CODE.SUMMARY_CODE,
		lrT_WORK_ACC_CODE.SUMMARY1,
		lrT_WORK_ACC_CODE.SUMMARY2,
		lrT_WORK_ACC_CODE.VAT_CODE,
		lrT_DEPT_CODE_ORG.TAX_COMP_CODE,
		lrT_DEPT_CODE_ORG.COMP_CODE,
		lrT_DEPT_CODE_ORG.DEPT_CODE,
		lrT_DEPT_CLASS_CODE.CLASS_CODE
	);
End;
/