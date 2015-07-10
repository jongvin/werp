CREATE OR REPLACE Procedure SP_T_BUDG_CHECK_REQ_CLSE_DT
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
	ln_req_clse_cls_cnt					NUMBER;

Begin
		select 
			count(req_clse_cls) 
		Into
			ln_req_clse_cls_cnt
		from	t_budg_close
		Where	COMP_CODE   = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE 	= AR_DEPT_CODE
		And		REQ_CLSE_CLS = 'T';

	If ln_req_clse_cls_cnt > 0 Then
		Raise_Application_Error(-20009,'신청 마감이 되었습니다');
	End If;
End;
/
