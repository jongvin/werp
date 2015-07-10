CREATE OR REPLACE Procedure SP_T_BUDG_CHK_CONFIRM_KIND_REQ
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_DEPT_CODE					Varchar2,
	Ar_CHG_SEQ						Number
	
)
Is
	Type T_CONFIRM_KIND Is Table Of T_BUDG_MONTH_REQ.CONFIRM_KIND%Type
		Index By Binary_Integer;
			
	lt_T_CONFIRM_KIND				T_CONFIRM_KIND;

	liStart						Number;
	liEnd						Number;

Begin
		
	Select
		CONFIRM_KIND	
	Bulk Collect Into
		lt_T_CONFIRM_KIND	
	From	T_BUDG_MONTH_REQ a
	Where   CONFIRM_KIND = '0'
	And	    a.COMP_CODE       = AR_COMP_CODE
	And     a.CLSE_ACC_ID     = AR_CLSE_ACC_ID
	And		a.DEPT_CODE       = AR_DEPT_CODE
	And		a.CHG_SEQ         = AR_CHG_SEQ;
	
	
	liStart := lt_T_CONFIRM_KIND.First;
	liEnd   := lt_T_CONFIRM_KIND.Last;
	If lt_T_CONFIRM_KIND.Count > 0 Then
		
		Raise_Application_Error(-20009,'승인이 안된 예산변경신청이 존재합니다');

	End If;
			
End;