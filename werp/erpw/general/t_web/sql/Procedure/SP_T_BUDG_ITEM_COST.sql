Create Or Replace Procedure SP_T_BUDG_ITEM_COST_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_BUDG_CODE_NO                          NUMBER,
	AR_ITEM_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2,
	AR_DAY_CALC_TAG                            VARCHAR2,
	AR_UNIT_TAG                                VARCHAR2,
	AR_GRADE_UNIT_TAG                          VARCHAR2,
	AR_UNIT_COST                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_ITEM_COST_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_ITEM_COST 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-02-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	
	--확정여부체크
	if( F_T_CONFIRM_CHECK(AR_COMP_CODE, AR_CLSE_ACC_ID) <> 0) then
		Raise_Application_Error(-20009,'회기가 확정되어  단가를 수정할 수 없습니다');
	end if;
	
	Insert Into T_BUDG_ITEM_COST
	(
		COMP_CODE,
		CLSE_ACC_ID,
		BUDG_CODE_NO,
		ITEM_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITEM_NAME,
		DAY_CALC_TAG,
		UNIT_TAG,
		GRADE_UNIT_TAG,
		UNIT_COST
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_BUDG_CODE_NO,
		AR_ITEM_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITEM_NAME,
		AR_DAY_CALC_TAG,
		AR_UNIT_TAG,
		AR_GRADE_UNIT_TAG,
		AR_UNIT_COST
	);
	
	
	
End;
/
Create Or Replace Procedure SP_T_BUDG_ITEM_COST_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_ITEM_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2,
	AR_DAY_CALC_TAG                            VARCHAR2,
	AR_UNIT_TAG                                VARCHAR2,
	AR_GRADE_UNIT_TAG                          VARCHAR2,
	AR_UNIT_COST                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_ITEM_COST_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_ITEM_COST 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-02-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	
	--확정여부체크
	if( F_T_CONFIRM_CHECK(AR_COMP_CODE, AR_CLSE_ACC_ID) <> 0) then
		Raise_Application_Error(-20009,'회기가 확정되어  단가를 수정할 수 없습니다');
	end if;
	
	Update T_BUDG_ITEM_COST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITEM_NAME = AR_ITEM_NAME,
		DAY_CALC_TAG = AR_DAY_CALC_TAG,
		UNIT_TAG = AR_UNIT_TAG,
		GRADE_UNIT_TAG = AR_GRADE_UNIT_TAG,
		UNIT_COST = AR_UNIT_COST
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	ITEM_NO = AR_ITEM_NO;
End;
/
CREATE OR REPLACE Procedure SP_T_BUDG_ITEM_COST_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_ITEM_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_ITEM_COST_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_ITEM_COST 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-02-13)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
ln_Cnt			NUMBER;															
Begin
	--확정여부체크
	if( F_T_CONFIRM_CHECK(AR_COMP_CODE, AR_CLSE_ACC_ID) <> 0) then
		Raise_Application_Error(-20009,'회기가 확정되어  단가를 수정할 수 없습니다');
	end if;
	
	Select count(*)
	Into   ln_Cnt
	from   T_BUDG_ITEM_GRADE_COST
	Where  COMP_CODE    = AR_COMP_CODE
	And	   CLSE_ACC_ID  = AR_CLSE_ACC_ID
	And	   BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	   ITEM_NO      = AR_ITEM_NO
	And	   UNIT_COST	> 0;
	
	If ln_Cnt > 0 Then
	   Raise_Application_Error(-20009,'직급별 단가 금액이 0이 아닌 <br>상태에서 삭제가 불가능합니다.');
	End If;
	
	Delete T_BUDG_ITEM_GRADE_COST
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	ITEM_NO = AR_ITEM_NO;
	
	Delete T_BUDG_ITEM_COST
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	ITEM_NO = AR_ITEM_NO;
End;
/

