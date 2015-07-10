--부서별변경차수가 존재할경우(일괄변경확정이 된상태면) 체크 
CREATE OR REPLACE Procedure SP_T_BUDG_ALL_CHANGE_CHECK
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER
)
Is
	ln_BUDG_ALL_CHANGE_DEPT_ROW_CNT					NUMBER;
Begin
	
	Select	count(*)
	Into	ln_BUDG_ALL_CHANGE_DEPT_ROW_CNT
	From	T_BUDG_ALL_CHANGE_DEPT a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		ALL_CHG_SEQ = AR_ALL_CHG_SEQ;
	If ln_BUDG_ALL_CHANGE_DEPT_ROW_CNT > 0 Then
		Raise_Application_Error(-20009,'일괄예산변경이 적용되어 일괄예산변경취소가 불가능합니다..');
	End If;
End;