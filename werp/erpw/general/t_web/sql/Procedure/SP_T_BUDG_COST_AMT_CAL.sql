--단가가 적용되는 예산에 단가적용하기
CREATE OR REPLACE Procedure SP_T_BUDG_COST_AMT_CAL
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER
)
Is
	lnCnt									Number;
Begin
	
	--차수별 월별예산체크
	
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
		from  t_budg_month_amt_h a,
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
		and	  a.comp_code	= 'A0'
		and   a.clse_acc_id = '2007'
		and	  a.dept_code	= 'A01111'
		and	  a.chg_seq		= 0
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
		t.BUDG_ITEM_REQ_AMT    = f.month_budg_amt_sum,
		t.BUDG_ITEM_ASSIGN_AMT = f.month_budg_amt_sum
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
		from  t_budg_month_amt_h a,
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
		and	  a.dept_code	= AR_DEPT_CODE
		and	  a.chg_seq		= 0
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
		t.BUDG_MONTH_REQ_AMT    = f.month_budg_amt,
		t.BUDG_MONTH_ASSIGN_AMT = f.month_budg_amt
	When Not Matched Then
	Insert
	(
		t.COMP_CODE
		
	)
	values
	(
		f.COMP_CODE
	);
End;
/
