CREATE OR REPLACE Procedure SP_T_BUDG_COST_AMT_CAL_ALL_CAN
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CHG_SEQ                                 NUMBER
)
Is
	Type T_DEPT_CODE Is Table Of T_BUDG_MONTH_AMT_H.DEPT_CODE%Type 
	Index By Binary_Integer;
	ln_DEPT_CNT								   Number;
	lnCnt2									   Number;
	liI										   Number;	 
	lt_T_DEPT_CODE				T_DEPT_CODE;
Begin
	
	select count(dept_code)
	into   ln_DEPT_CNT
	from   t_budg_dept_h a
	where  a.comp_code = AR_COMP_CODE
	and	   a.clse_acc_id = AR_CLSE_ACC_ID
	and	   a.chg_seq	 = AR_CHG_SEQ
	and	   a.confirm_tag = 'T';
	
	If ln_DEPT_CNT > 0 Then
	   RAISE_APPLICATION_ERROR	(-20009, '확정된 부서별 예산이 존재합니다');
	End If;
	
	select dept_code
	BULK COLLECT INTO
		   lt_T_DEPT_CODE
	from   t_budg_dept_h a
	where  a.comp_code = AR_COMP_CODE
	and	   a.clse_acc_id = AR_CLSE_ACC_ID
	and	   a.chg_seq	 = AR_CHG_SEQ;
	
	If lt_T_DEPT_CODE.Count < 0 Then
	   RAISE_APPLICATION_ERROR	(-20009, '예산 신청 부서가 존재하지 않습니다');
	End If;
	
	FOR liI IN lt_T_DEPT_CODE.First..lt_T_DEPT_CODE.Last LOOP
						
		update t_budg_month_amt_h a
		set budg_month_req_amt=0 
		where comp_code = AR_COMP_CODE
		and	  clse_acc_id = AR_CLSE_ACC_ID
		and	  chg_seq 	  = AR_CHG_SEQ
		and	  dept_code   = lt_T_DEPT_CODE(liI)
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
		and	  chg_seq = AR_CHG_SEQ
		and	  dept_code   = lt_T_DEPT_CODE(liI)
		and	  a.budg_code_no in (select budg_code_no
			  				 	 from	t_budg_item_cost b
								 where  b.comp_code = a.comp_code
								 and	b.clse_acc_id = a.clse_acc_id
								 and	b.budg_code_no = a.budg_code_no
							    );
	End Loop;

End;
/