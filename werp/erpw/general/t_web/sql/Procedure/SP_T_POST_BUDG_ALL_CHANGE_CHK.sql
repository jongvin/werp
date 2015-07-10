--다음 일괄변경차수가 존재하는지 체크 
CREATE OR REPLACE Procedure SP_T_POST_BUDG_ALL_CHANGE_CHK
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER
)
Is
	ln_BUDG_ALL_CHANGE_ROW_CNT					NUMBER;
Begin
	
	Select	count(*)
	Into	ln_BUDG_ALL_CHANGE_ROW_CNT
	From	T_BUDG_ALL_CHANGE a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		ALL_CHG_SEQ > AR_ALL_CHG_SEQ;
	If ln_BUDG_ALL_CHANGE_ROW_CNT > 0 Then
		Raise_Application_Error(-20009,'다음 차수가 존재하기 때문에 일괄예산변경취소가 불가능합니다.');
	End If;
End;