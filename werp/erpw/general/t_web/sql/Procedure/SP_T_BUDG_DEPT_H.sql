CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_H_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CONFIRM_TAG                             VARCHAR2,
	AR_BUDG_APPLY_YM                           VARCHAR2,
	AR_REQUEST_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_DEPT_H_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_DEPT_H 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-12-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
Begin
	 Select	CONFIRM_TAG
	 Into	ls_CONFIRM_TAG
	 From	T_BUDG_DEPT_H a
	 Where	COMP_CODE = AR_COMP_CODE
	 And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	 And	DEPT_CODE = AR_DEPT_CODE
	 And	CHG_SEQ = AR_CHG_SEQ - 1;
	 If ls_CONFIRM_TAG = 'F' Then
		Raise_Application_Error(-20009,'전차수 예산이 미확정되어 변경신청이 불가능합니다.');
	 End If;
	 
	 Insert Into T_BUDG_DEPT_H
	 (
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CHG_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CONFIRM_TAG,
		BUDG_APPLY_YM
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_CHG_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CONFIRM_TAG,
		To_Date(AR_BUDG_APPLY_YM,'YYYY-MM')
	);	 
	 	
	Insert Into T_BUDG_DEPT_ITEM_H
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CHG_SEQ,
		BUDG_CODE_NO,
		RESERVED_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		TARGET_DEPT_CODE,
		BUDG_ADD_AMT,
		BUDG_ITEM_REQ_AMT,
		BUDG_ITEM_ASSIGN_AMT,
		REMARKS
	)   
	Select 
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		AR_CHG_SEQ,
		BUDG_CODE_NO,
		RESERVED_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		TARGET_DEPT_CODE,
		BUDG_ADD_AMT,
		BUDG_ITEM_REQ_AMT,
		BUDG_ITEM_ASSIGN_AMT,
		REMARKS
	FROM   T_BUDG_DEPT_ITEM_H
	Where  Comp_code= AR_COMP_CODE
	And	   CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	   DEPT_CODE = AR_DEPT_CODE
	And	   chg_seq = AR_CHG_SEQ - 1;
		 
		
	Insert Into T_BUDG_MONTH_AMT_H
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CHG_SEQ,
		BUDG_CODE_NO,
		RESERVED_SEQ,
		BUDG_YM,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BUDG_MONTH_REQ_AMT,
		BUDG_MONTH_ASSIGN_AMT,
		REMARKS
	) 
	Select 
		   	COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
			AR_CHG_SEQ,
			BUDG_CODE_NO,
			RESERVED_SEQ,
			BUDG_YM,
			CRTUSERNO,
			CRTDATE,
			MODUSERNO,
			MODDATE,
			BUDG_MONTH_REQ_AMT,
			BUDG_MONTH_ASSIGN_AMT,
			REMARKS
	From T_BUDG_MONTH_AMT_H
	Where  Comp_code= AR_COMP_CODE
	And	   CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	   DEPT_CODE = AR_DEPT_CODE
	And	   CHG_SEQ = AR_CHG_SEQ-1;
	
	Update	T_BUDG_DEPT
	Set		LAST_WORK_SEQ = AR_CHG_SEQ
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE;	 
End;
/

CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_H_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CONFIRM_TAG                             VARCHAR2,
	AR_BUDG_APPLY_YM                           VARCHAR2,
	AR_REQUEST_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_DEPT_H_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_DEPT_H 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2005-12-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
Begin
	If AR_CHG_SEQ = 0 Then
	   SP_T_BUDG_CHECK_REQ_CLSE_DT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE);
	End If; 
	Select	CONFIRM_TAG
	Into	ls_CONFIRM_TAG
	From	T_BUDG_DEPT_H a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ;
	If ls_CONFIRM_TAG = 'T' Then
		Raise_Application_Error(-20009,'해당 예산은 이미 확정되어 삭제가 불가능합니다.');
	End If;
	Update T_BUDG_DEPT_H
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CONFIRM_TAG = AR_CONFIRM_TAG,
		BUDG_APPLY_YM = to_date(AR_BUDG_APPLY_YM,'YYYY-MM'),
		REQUEST_TAG = AR_REQUEST_TAG
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
End;
/
CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_H_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_DEPT_H_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_DEPT_H 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2005-12-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
ls_R_CNT					            	NUMBER;
Begin
	If AR_CHG_SEQ = 0 Then
	   SP_T_BUDG_CHECK_REQ_CLSE_DT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE);
	End If; 
	Select	CONFIRM_TAG
	Into	ls_CONFIRM_TAG
	From	T_BUDG_DEPT_H a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ;
	If ls_CONFIRM_TAG = 'T' Then
		Raise_Application_Error(-20009,'해당 예산은 이미 확정되어 변경신청취소가 불가능합니다.');
	End If;
	
	Select	count(CONFIRM_TAG)
	Into	ls_R_CNT
	From	T_BUDG_DEPT_H a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ > AR_CHG_SEQ;
	If ls_R_CNT > 0 Then
		Raise_Application_Error(-20009,'다음차수가 존재하기 때문에 현재차수를 삭제할수 없습니다');
	End If;
	
	Delete T_BUDG_MONTH_AMT_H
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
	
	Delete T_BUDG_DEPT_ITEM_H
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
	
	if AR_CHG_SEQ > 0 then
	    Delete T_BUDG_MONTH_REQ_DETAIL
		Where	COMP_CODE = AR_COMP_CODE
		And	CLSE_ACC_ID = AR_CLSE_ACC_ID
		And	DEPT_CODE = AR_DEPT_CODE
		And	CHG_SEQ = AR_CHG_SEQ;
		
		Delete T_BUDG_MONTH_REQ
		Where	COMP_CODE = AR_COMP_CODE
		And	CLSE_ACC_ID = AR_CLSE_ACC_ID
		And	DEPT_CODE = AR_DEPT_CODE
		And	CHG_SEQ = AR_CHG_SEQ;
	End If;
	
	Delete T_BUDG_DEPT_H
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
	If AR_CHG_SEQ = 0 then
		Delete T_BUDG_DEPT
		Where	COMP_CODE = AR_COMP_CODE
		And	CLSE_ACC_ID = AR_CLSE_ACC_ID
		And	DEPT_CODE = AR_DEPT_CODE;
	elsif AR_CHG_SEQ > 0 then
		Update	T_BUDG_DEPT
		Set		LAST_CONFIRMED_SEQ = AR_CHG_SEQ -1,
		        LAST_WORK_SEQ = AR_CHG_SEQ -1
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE;
	End If;
End;
/
