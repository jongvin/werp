CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_REQUEST_FINISH
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_REQUEST_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_DEPT_REQUEST_FINISH.sql
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 변경신청완료 및 취소
/* 4. 변  경  이  력 : 한재원 작성(2005-12-22)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
ls_REQUEST_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
li_ROW_CNT					       NUMBER;
Begin
	If AR_REQUEST_TAG = 'T' Then
		Select	COUNT(*)
		Into	li_ROW_CNT
		From	T_BUDG_MONTH_REQ a
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And		CHG_SEQ = AR_CHG_SEQ;
		If li_ROW_CNT = 0 Then
			Raise_Application_Error(-20009,'신청내역이 없으면  신청완료가 불가능합니다.');
		End If;
		
		Select	REQUEST_TAG
		Into	ls_REQUEST_TAG
		From	T_BUDG_DEPT_H a
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And		CHG_SEQ = AR_CHG_SEQ;
		If ls_REQUEST_TAG = 'T' Then
			Raise_Application_Error(-20009,'이미 신청완료됐습니다');
		End If;
	End If;
	
	If AR_REQUEST_TAG = 'F' Then
		Select	CONFIRM_TAG
		Into	ls_CONFIRM_TAG
		From	T_BUDG_DEPT_H a
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And		CHG_SEQ = AR_CHG_SEQ;
		If ls_CONFIRM_TAG = 'T' Then
			Raise_Application_Error(-20009,'해당 예산은 이미 확정되어 신청완료취소가 불가능합니다.');
		End If;
		
		Select	REQUEST_TAG
		Into	 ls_REQUEST_TAG
		From	T_BUDG_DEPT_H a
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And		CHG_SEQ = AR_CHG_SEQ;
		If ls_REQUEST_TAG = 'F' Then
			Raise_Application_Error(-20009,'신청완료항목만 가능합니다.');
		End If;
	End If;
	
	Update T_BUDG_DEPT_H
	Set
		REQUEST_TAG = AR_REQUEST_TAG
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ;
End;
