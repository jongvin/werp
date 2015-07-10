Create Or Replace Procedure SP_T_FL_FLOW_COMP_B_I
(
	AR_FLOW_CODE_B                             NUMBER,
	AR_COMP_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FLOW_COMP_B_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FLOW_COMP_B 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_FLOW_COMP_B
	(
		FLOW_CODE_B,
		COMP_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_FLOW_CODE_B,
		AR_COMP_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_FL_FLOW_COMP_B_U
(
	AR_FLOW_CODE_B                             NUMBER,
	AR_COMP_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FLOW_COMP_B_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FLOW_COMP_B 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FL_FLOW_COMP_B
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	FLOW_CODE_B = AR_FLOW_CODE_B
	And	COMP_CODE = AR_COMP_CODE;
End;
/
Create Or Replace Procedure SP_T_FL_FLOW_COMP_B_D
(
	AR_FLOW_CODE_B                             NUMBER,
	AR_COMP_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FLOW_COMP_B_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FLOW_COMP_B 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FL_FLOW_COMP_B
	Where	FLOW_CODE_B = AR_FLOW_CODE_B
	And	COMP_CODE = AR_COMP_CODE;
End;
/
