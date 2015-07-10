CREATE OR REPLACE Procedure SP_T_BUDG_ALL_CHANGE_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BUDG_APPLY_YM                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_ALL_CHANGE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_ALL_CHANGE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
ln_Count						               Number;
ls_clse_acc_id								   Varchar2(4);
Begin
	
	select count(*)
	into   ln_Count
	from t_budg_dept_h
	where comp_code   = AR_COMP_CODE
	and	  clse_acc_id = AR_CLSE_ACC_ID;

	if ln_Count = 0 then
	   	  Raise_Application_Error(-20009,'부서별 최초예산이 배정되지 않아 <br> 일괄예산변경등록을 할 수 없습니다');		  
	end if;
	
	select to_char(sysdate,'YYYY')
	into   ls_clse_acc_id
	from dual;

	if ls_clse_acc_id > AR_CLSE_ACC_ID then
	   	  Raise_Application_Error(-20009,'회기가 지나 일괄 예산변경을 할수 없습니다');		  
	end if;
	
	Insert Into T_BUDG_ALL_CHANGE
	(
		COMP_CODE,
		CLSE_ACC_ID,
		ALL_CHG_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BUDG_APPLY_YM
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_ALL_CHG_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		to_Date(AR_BUDG_APPLY_YM,'yyyy-mm')
	);
	SP_T_BUDG_ALL_CHANGE_DETAIL(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_ALL_CHG_SEQ, AR_CRTUSERNO, AR_BUDG_APPLY_YM);

End;
/
Create Or Replace Procedure SP_T_BUDG_ALL_CHANGE_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_BUDG_APPLY_YM                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_ALL_CHANGE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_ALL_CHANGE 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_BUDG_ALL_CHANGE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BUDG_APPLY_YM = to_Date(AR_BUDG_APPLY_YM,'YYYY-MM')
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
End;
/
CREATE OR REPLACE Procedure SP_T_BUDG_ALL_CHANGE_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_ALL_CHANGE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_ALL_CHANGE 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
ls_clse_acc_id								   Varchar2(4);
Begin

	select to_char(sysdate,'YYYY')
	into   ls_clse_acc_id
	from dual;

	if ls_clse_acc_id > AR_CLSE_ACC_ID then
	   	  Raise_Application_Error(-20009,'회기가 지나 일괄 예산변경취소를  할수 없습니다');		  
	end if;
	
	--부서별변경차수가 존재할경우(일괄변경확정이 된상태면) 삭제 불가
	SP_T_BUDG_ALL_CHANGE_CHECK(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_ALL_CHG_SEQ);
	--다음 차수가 존재할경우 삭제 불가
	SP_T_POST_BUDG_ALL_CHANGE_CHK(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_ALL_CHG_SEQ);
	--전월말기준금액 삭제
	Delete T_BUDG_BF_BASE_AMT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	
	--전월말인원현황 삭제 
	Delete T_BUDG_BF_ORDER_STAT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	
	--적용월기준 금액삭제
	Delete T_BUDG_NOW_APPL_AMT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	
	--적용월인원현황 삭제 
	Delete T_BUDG_NOW_ORDER_STAT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	
	--일괄변경차수 삭제 
	Delete T_BUDG_ALL_CHANGE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	
	 
End;
/

