Create Or Replace Procedure SP_T_FL_FLOW_CODE_I
(
	AR_FLOW_CODE                               NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_P_NO                                    NUMBER,
	AR_FLOW_ITEM_NAME                          VARCHAR2,
	AR_FLOW_ITEM_KIND                          VARCHAR2,
	AR_LEVEL_SEQ                               NUMBER,
	AR_IS_LEAF_TAG                             VARCHAR2,
	AR_DEPT_PLN_FUNC_NO                        NUMBER,
	AR_DEPT_EXE_FUNC_NO                        NUMBER,
	AR_DEPT_FOR_FUNC_NO                        NUMBER,
	AR_MNG_CODE                                Varchar2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FLOW_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FLOW_CODE 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_FLOW_CODE
	(
		FLOW_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		P_NO,
		FLOW_ITEM_NAME,
		FLOW_ITEM_KIND,
		LEVEL_SEQ,
		IS_LEAF_TAG,
		DEPT_PLN_FUNC_NO,
		DEPT_EXE_FUNC_NO,
		DEPT_FOR_FUNC_NO,
		MNG_CODE
	)
	Values
	(
		AR_FLOW_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_P_NO,
		AR_FLOW_ITEM_NAME,
		Nvl(AR_FLOW_ITEM_KIND,'X'),
		AR_LEVEL_SEQ,
		Nvl(AR_IS_LEAF_TAG,'T'),
		AR_DEPT_PLN_FUNC_NO,
		AR_DEPT_EXE_FUNC_NO,
		AR_DEPT_FOR_FUNC_NO,
		AR_MNG_CODE
	);
End;
/
Create Or Replace Procedure SP_T_FL_FLOW_CODE_U
(
	AR_FLOW_CODE                               NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_P_NO                                    NUMBER,
	AR_FLOW_ITEM_NAME                          VARCHAR2,
	AR_FLOW_ITEM_KIND                          VARCHAR2,
	AR_LEVEL_SEQ                               NUMBER,
	AR_IS_LEAF_TAG                             VARCHAR2,
	AR_DEPT_PLN_FUNC_NO                        NUMBER,
	AR_DEPT_EXE_FUNC_NO                        NUMBER,
	AR_DEPT_FOR_FUNC_NO                        NUMBER,
	AR_MNG_CODE                                Varchar2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FLOW_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FLOW_CODE 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FL_FLOW_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		P_NO = AR_P_NO,
		FLOW_ITEM_NAME = AR_FLOW_ITEM_NAME,
		FLOW_ITEM_KIND = Nvl(AR_FLOW_ITEM_KIND,'X'),
		LEVEL_SEQ = AR_LEVEL_SEQ,
		IS_LEAF_TAG = Nvl(AR_IS_LEAF_TAG,'T'),
		DEPT_PLN_FUNC_NO = AR_DEPT_PLN_FUNC_NO,
		DEPT_EXE_FUNC_NO = AR_DEPT_EXE_FUNC_NO,
		DEPT_FOR_FUNC_NO = AR_DEPT_FOR_FUNC_NO,
		MNG_CODE = AR_MNG_CODE
	Where	FLOW_CODE = AR_FLOW_CODE;
End;
/
Create Or Replace Procedure SP_T_FL_FLOW_CODE_D
(
	AR_FLOW_CODE                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FLOW_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FLOW_CODE 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FL_FLOW_CODE
	Where	FLOW_CODE = AR_FLOW_CODE;
End;
/
