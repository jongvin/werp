Create Or Replace Procedure SP_T_DEPT_CODE_PROJ_I
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CLOSE_DT                            VARCHAR2,
	AR_BUDG_APPL_DT                            VARCHAR2,
	AR_CONS_AMT                                NUMBER,
	AR_BUDG_AMT                                NUMBER,
	AR_AS_AMT                                  NUMBER,
	AR_COST_DESC_TAG                           VARCHAR2,
	AR_COST_GUESS_AMT                          Number Default 0,
	AR_F_CONS_AMT                              Number Default 0,
	AR_F_BUDG_AMT                              Number Default 0
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_CODE_PROJ_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_CODE_ORG 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Raise_Application_Error(-20009,'이 프로그램으로는 현장 또는 부서를 등록하실 수는 없습니다.');
End;
/
Create Or Replace Procedure SP_T_DEPT_CODE_PROJ_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CLOSE_DT                            VARCHAR2,
	AR_BUDG_APPL_DT                            VARCHAR2,
	AR_CONS_AMT                                NUMBER,
	AR_BUDG_AMT                                NUMBER,
	AR_AS_AMT                                  NUMBER,
	AR_COST_DESC_TAG                           VARCHAR2,
	AR_COST_GUESS_AMT                          Number Default 0,
	AR_F_CONS_AMT                              Number Default 0,
	AR_F_BUDG_AMT                              Number Default 0
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_CODE_PROJ_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_CODE_ORG 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec									T_DEPT_BUDG_HIST%RowType;
	lbFound									Boolean;
Begin
	Update T_DEPT_CODE_ORG
	Set
		MODUSERNO = AR_CRTUSERNO,
		MODDATE = SYSDATE,
		ACC_CLOSE_DT = F_T_StringToDate(AR_ACC_CLOSE_DT),
		BUDG_APPL_DT = F_T_StringToDate(AR_BUDG_APPL_DT),
		CONS_AMT = AR_CONS_AMT,
		BUDG_AMT = AR_BUDG_AMT,
		AS_AMT = AR_AS_AMT,
		COST_DESC_TAG = AR_COST_DESC_TAG,
		COST_GUESS_AMT = AR_COST_GUESS_AMT,
		F_CONS_AMT = AR_F_CONS_AMT,
		F_BUDG_AMT = AR_F_BUDG_AMT
	Where	DEPT_CODE = AR_DEPT_CODE;
	lbFound := False;
	If Nvl(AR_CONS_AMT,0) <> 0 Or Nvl(AR_BUDG_AMT,0) <> 0 Then
		If AR_BUDG_APPL_DT Is Null Then
			Raise_Application_Error(-20009,'도급금액 또는 실행금액이 있는 경우는 반드시 실행반영일을 입력하셔야 합니다.');
		End If;
		Begin
			Select
				*
			Into
				lrRec
			From	T_DEPT_BUDG_HIST a
			Where	a.DEPT_CODE = AR_DEPT_CODE
			And		a.BUDG_APPL_DT = 
			(
				Select
					Max(b.BUDG_APPL_DT)
				From	T_DEPT_BUDG_HIST b
				Where	a.DEPT_CODE = b.DEPT_CODE
			);
			lbFound := True;
		Exception When No_Data_Found Then
			lbFound := False;
		End;
		If lbFound Then
			If lrRec.BUDG_APPL_DT > F_T_StringToDate(AR_BUDG_APPL_DT) Then
				Raise_Application_Error(-20009,'최종 실행반영일보다 이전으로 실행반영을 하실 수 는 없습니다.');
			End If;
			If Nvl(AR_CONS_AMT,0) = Nvl(lrRec.CONS_AMT,0) And Nvl(AR_BUDG_AMT,0) = Nvl(lrRec.BUDG_AMT,0) Then	--금액변동이 없다면 엎어칠 필요 없다.
				Null;
			End If;
			If lrRec.BUDG_APPL_DT = F_T_StringToDate(AR_BUDG_APPL_DT) Then	--금액이 바뀌었는데 반영일이 안 바뀌었다.
				Update	T_DEPT_BUDG_HIST
				Set		CONS_AMT = AR_CONS_AMT,
						BUDG_AMT = AR_BUDG_AMT
				Where	DEPT_CODE = Ar_DEPT_CODE
				And		BUDG_APPL_DT = lrRec.BUDG_APPL_DT;
			Else
				Insert Into T_DEPT_BUDG_HIST
				(
					DEPT_CODE,
					BUDG_APPL_DT,
					CRTUSERNO,
					CRTDATE,
					CONS_AMT,
					BUDG_AMT
				)
				Values
				(
					AR_DEPT_CODE,
					F_T_StringToDate(AR_BUDG_APPL_DT),
					AR_CRTUSERNO,
					SysDate,
					AR_CONS_AMT,
					AR_BUDG_AMT
				);
			End If;
		Else
			Insert Into T_DEPT_BUDG_HIST
			(
				DEPT_CODE,
				BUDG_APPL_DT,
				CRTUSERNO,
				CRTDATE,
				CONS_AMT,
				BUDG_AMT
			)
			Values
			(
				AR_DEPT_CODE,
				F_T_StringToDate(AR_BUDG_APPL_DT),
				AR_CRTUSERNO,
				SysDate,
				AR_CONS_AMT,
				AR_BUDG_AMT
			);
		End If;
	End If;
End;
/
Create Or Replace Procedure SP_T_DEPT_CODE_PROJ_D
(
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_CODE_PROJ_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_CODE_ORG 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Raise_Application_Error(-20009,'이 프로그램으로는 현장 또는 부서를 삭제하실 수는 없습니다.');
End;
/
