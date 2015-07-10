CREATE OR REPLACE Procedure SP_T_BUDG_COST_AMT_CAL_ALL
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CHG_SEQ                                 NUMBER
)
Is
  	Type T_DEPT_CODE Is Table Of T_BUDG_MONTH_AMT_H.DEPT_CODE%Type 
	Index By Binary_Integer;										   
	ln_DEPT_CNT									   Number;
	lnCnt2									   Number;
	lt_T_DEPT_CODE							   T_DEPT_CODE;
Begin
	
	select dept_code
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
	
	Merge Into T_BUDG_DEPT_ITEM_H t
	Using
	(
		select
			  a.comp_code,
			  a.clse_acc_id,
			  a.dept_code,
			  a.chg_seq,
			  a.budg_code_no,
			  a.reserved_seq,
			  sum( F_T_Get_Month_Budg_Amt(a.comp_code, a.clse_acc_id, a.budg_code_no,to_char(a.budg_ym,'MM'), a.dept_code)) month_budg_amt_sum
		from  (select *
			  from t_budg_month_amt_h a
			  where	  a.comp_code	= AR_COMP_CODE
				and   a.clse_acc_id = AR_CLSE_ACC_ID
				and	  a.dept_code	= lt_T_DEPT_CODE(liI)
				and	  a.chg_seq		= AR_CHG_SEQ ) a,
			  (select comp_code,
			  		  clse_acc_id,
					  budg_code_no,
					  sum(unit_cost)
			   from   t_budg_item_cost
			   group by comp_code,
			  		    clse_acc_id,
					    budg_code_no ) b
		where a.comp_code   = b.comp_code
		and	  a.clse_acc_id = b.clse_acc_id
		and	  a.budg_code_no= b.budg_code_no
		and	  a.comp_code	= AR_COMP_CODE
		and   a.clse_acc_id = AR_CLSE_ACC_ID
		and	  a.dept_code	= lt_T_DEPT_CODE(liI)
		and	  a.chg_seq		= AR_CHG_SEQ
		group by 
			  	 a.comp_code,
			  	 a.clse_acc_id,
			  	 a.dept_code,
			  	 a.chg_seq,
			  	 a.budg_code_no,
			  	 a.reserved_seq
	) f
	On
	(
			f.COMP_CODE    = t.COMP_CODE
		And	f.CLSE_ACC_ID  = t.CLSE_ACC_ID
		And	f.DEPT_CODE    = t.DEPT_CODE
		And	f.CHG_SEQ      = t.CHG_SEQ
		And	f.BUDG_CODE_NO = t.BUDG_CODE_NO
		And	f.RESERVED_SEQ = t.RESERVED_SEQ
	)
	When Matched Then
	Update
	set
		t.BUDG_ITEM_REQ_AMT    = f.month_budg_amt_sum
		
	When Not Matched Then
	Insert
	(
		t.COMP_CODE
	)
	Values
	(
		f.COMP_CODE
		
	);
	
	Merge Into T_BUDG_MONTH_AMT_H t
	Using
	(
		select
			  a.comp_code,
			  a.clse_acc_id,
			  a.dept_code,
			  a.chg_seq,
			  a.budg_code_no,
			  a.reserved_seq,
			  a.budg_ym,
			  a.budg_month_req_amt,
			  a.budg_month_assign_amt,
			  F_T_Get_Month_Budg_Amt(a.comp_code, a.clse_acc_id, a.budg_code_no,to_char(a.budg_ym,'MM'), a.dept_code) month_budg_amt
		from  (select *
			  from t_budg_month_amt_h a
			  where	  a.comp_code	= AR_COMP_CODE
				and   a.clse_acc_id = AR_CLSE_ACC_ID
				and	  a.dept_code	= lt_T_DEPT_CODE(liI)
				and	  a.chg_seq		= AR_CHG_SEQ ) a,
			  (select comp_code,
			  		  clse_acc_id,
					  budg_code_no,
					  sum(unit_cost)
			   from   t_budg_item_cost
			   group by comp_code,
			  		    clse_acc_id,
					    budg_code_no ) b
		where a.comp_code   = b.comp_code
		and	  a.clse_acc_id = b.clse_acc_id
		and	  a.budg_code_no= b.budg_code_no
		and	  a.comp_code	= AR_COMP_CODE
		and   a.clse_acc_id = AR_CLSE_ACC_ID
		and	  a.dept_code	= lt_T_DEPT_CODE(liI)
		and	  a.chg_seq		= AR_CHG_SEQ
	) f
	On
	(
			f.COMP_CODE    = t.COMP_CODE
		And	f.CLSE_ACC_ID  = t.CLSE_ACC_ID
		And	f.DEPT_CODE    = t.DEPT_CODE
		And	f.CHG_SEQ      = t.CHG_SEQ
		And	f.BUDG_CODE_NO = t.BUDG_CODE_NO
		And	f.RESERVED_SEQ = t.RESERVED_SEQ
		And	f.BUDG_YM      = t.BUDG_YM
	)
	When Matched Then
	Update
	set
		t.BUDG_MONTH_REQ_AMT    = f.month_budg_amt

	When Not Matched Then
	Insert
	(
		t.COMP_CODE
		
	)
	values
	(
		f.COMP_CODE
	);
	End Loop;
End;
/
