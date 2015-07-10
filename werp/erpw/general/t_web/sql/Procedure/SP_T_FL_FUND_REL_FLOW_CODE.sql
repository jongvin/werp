Create Or Replace Procedure SP_T_FL_FUND_REL_FLOW_CODE_I
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_FLOW_CODE_B                             NUMBER,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FUND_REL_FLOW_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FUND_REL_FLOW_CODE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-04-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_FUND_REL_FLOW_CODE
	(
		ITEM_CODE,
		FLOW_CODE_B,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_ITEM_CODE,
		AR_FLOW_CODE_B,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_FL_FUND_REL_FLOW_CODE_U
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_FLOW_CODE_B                             NUMBER,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FUND_REL_FLOW_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FUND_REL_FLOW_CODE 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-04-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FL_FUND_REL_FLOW_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	ITEM_CODE = AR_ITEM_CODE
	And	FLOW_CODE_B = AR_FLOW_CODE_B;
End;
/
Create Or Replace Procedure SP_T_FL_FUND_REL_FLOW_CODE_D
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_FLOW_CODE_B                             NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FUND_REL_FLOW_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FUND_REL_FLOW_CODE 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-04-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FL_FUND_REL_FLOW_CODE
	Where	ITEM_CODE = AR_ITEM_CODE
	And	FLOW_CODE_B = AR_FLOW_CODE_B;
End;
/
