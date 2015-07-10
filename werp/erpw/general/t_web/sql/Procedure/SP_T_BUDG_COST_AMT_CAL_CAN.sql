CREATE OR REPLACE Procedure SP_T_BUDG_COST_AMT_CAL_CAN
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER
)
Is
	ln_DEPT_CNT								   Number;
	lnCnt2									   Number;
Begin
	
	select count(dept_code)
	into   ln_DEPT_CNT
	from   t_budg_dept_h a
	where  a.comp_code = AR_COMP_CODE
	and	   a.clse_acc_id = AR_CLSE_ACC_ID
	and	   a.chg_seq	 = AR_CHG_SEQ
	and    a.dept_code   = AR_DEPT_CODE
	and	   a.confirm_tag = 'T';
	
	If ln_DEPT_CNT > 0 Then
	   RAISE_APPLICATION_ERROR	(-20009, '부서별 예산이 확정이 된상태입니다');
	End If;
							
	update t_budg_month_amt_h a
	set budg_month_req_amt=0 
	where comp_code = AR_COMP_CODE
	and	  clse_acc_id = AR_CLSE_ACC_ID
	and	  dept_code = AR_DEPT_CODE
	and	  chg_seq = AR_CHG_SEQ
	and	  a.budg_code_no in (select budg_code_no
		  				 	 from	t_budg_item_cost b
							 where  b.comp_code = a.comp_code
							 and	b.clse_acc_id = a.clse_acc_id
							 and	b.budg_code_no = a.budg_code_no
						    );
							
	update t_budg_dept_item_h a
	set budg_item_req_amt=0 
	where comp_code = AR_COMP_CODE
	and	  clse_acc_id = AR_CLSE_ACC_ID
	and	  dept_code = AR_DEPT_CODE
	and	  chg_seq = AR_CHG_SEQ
	and	  a.budg_code_no in (select budg_code_no
		  				 	 from	t_budg_item_cost b
							 where  b.comp_code = a.comp_code
							 and	b.clse_acc_id = a.clse_acc_id
							 and	b.budg_code_no = a.budg_code_no
						    );

End;
/