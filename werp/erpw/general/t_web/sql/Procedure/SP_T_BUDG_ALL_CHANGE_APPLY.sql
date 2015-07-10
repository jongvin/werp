CREATE OR REPLACE Procedure SP_T_BUDG_ALL_CHANGE_APPLY
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_APPLY_YN								   VARCHAR2,
	AR_CRTUSERNO							   Varchar2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_ALL_CHANGE_APPLY
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_ALL_CHANGE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-01-09)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Type T_DEPT Is Table Of T_BUDG_DEPT_H.DEPT_CODE%Type
		Index By Binary_Integer;
Type T_CHG_SEQ Is Table Of T_BUDG_DEPT_H.CHG_SEQ%Type
		Index By Binary_Integer;
Type T_BUDG_CODE_NO Is Table Of T_BUDG_BF_BASE_AMT.BUDG_CODE_NO %Type
		Index By Binary_Integer;
Type T_BUDG_YM Is Table Of T_BUDG_MONTH_AMT_H.BUDG_YM%Type
		Index By Binary_Integer;
Type T_AMT Is Table Of T_BUDG_BF_BASE_AMT.AMT%Type
		Index By Binary_Integer;

lt_T_DEPT1						T_DEPT;
lt_T_DEPT2						T_DEPT;
lt_T_DEPT3						T_DEPT;
lt_T_DEPT4						T_DEPT;
lt_T_DEPT5						T_DEPT;
lt_T_CHG_SEQ1					T_CHG_SEQ;
lt_T_CHG_SEQ2					T_CHG_SEQ;
lt_T_CHG_SEQ3					T_CHG_SEQ;
lt_T_CHG_SEQ4					T_CHG_SEQ;
lt_T_BUDG_CODE_NO1			    T_BUDG_CODE_NO;
lt_T_BUDG_CODE_NO2			    T_BUDG_CODE_NO;
lt_T_BUDG_CODE_NO3			    T_BUDG_CODE_NO;
lt_T_BUDG_CODE_NO4			    T_BUDG_CODE_NO;
lt_T_BUDG_YM1					T_BUDG_YM;
lt_T_BUDG_YM2					T_BUDG_YM;
lt_T_BUDG_YM3					T_BUDG_YM;
lt_T_BUDG_YM4					T_BUDG_YM;
lt_T_AMT1						T_AMT;
lt_T_AMT2						T_AMT;
lt_T_AMT3						T_AMT;
lt_T_AMT4						T_AMT;

li1Start						Number;
li1End							Number;
li2Start						Number;
li2End							Number;
li3Start						Number;
li3End							Number;
li4Start						Number;
li4End							Number;
lsErrm							Varchar2(2000);

ln_Count						Number;
ln_DEPT_Count					Number;
ln_DEPT_Count2					Number;
ln_DEPT_Count3					Number;
ls_budg_apply_ym				varchar2(10);
Begin

	Begin
		 Select to_char(budg_apply_ym,'YYYY-MM-DD') 
		 Into   ls_budg_apply_ym
		 From t_budg_all_change
		 Where comp_code = AR_COMP_CODE
		 And   clse_acc_id = AR_CLSE_ACC_ID
		 And   all_chg_seq = AR_ALL_CHG_SEQ;
		 Exception When NO_DATA_FOUND Then

				Raise_Application_Error(-20009,'일괄 변경차수를 등록하세요');

	End;
	--Raise_Application_Error(-20009,ls_budg_apply_ym);
	
	Select count(*)
	Into   ln_Count
	From t_budg_all_change_dept
	Where comp_code   = AR_COMP_CODE
	And	  clse_acc_id = AR_CLSE_ACC_ID
	And	  all_chg_seq = AR_ALL_CHG_SEQ;
	
	If AR_APPLY_YN = 'Y' then
		 If ln_Count > 0 then
		   	 Raise_Application_Error(-20009,'이미 일괄예산변경 적용이 되었습니다');
		 End if;
    Else
		 If ln_Count = 0 then
		   	 Raise_Application_Error(-20009,'이미 일괄예산변경 적용취소가 되었습니다');
		 End if;
    End If;
	--최초예산체크
	Begin
		select count(dept_code)
			   Into
			   ln_DEPT_Count						 
		from t_budg_dept_h a
		where chg_seq = 0
		and (a.comp_code, a.clse_acc_id,a.dept_code) in  (Select a.comp_code, a.clse_acc_id, a.dept_code
																From 
																	 (
																	 Select comp_code, clse_acc_id, dept_code, count(emp_no) b_cnt
																	 From t_budg_bf_order_stat
																	 Where all_chg_seq = AR_ALL_CHG_SEQ
																	 Group by comp_code, clse_acc_id, dept_code
																	 ) a,
																	 (
																	 Select comp_code, clse_acc_id, dept_code, count(emp_no) n_cnt
																	 From t_budg_now_order_stat
																	 Where all_chg_seq = AR_ALL_CHG_SEQ
																	 Group by comp_code, clse_acc_id, dept_code
																	 ) b
																Where a.comp_code = b.comp_code
																And	  a.clse_acc_id = b.clse_acc_id
																And	  a.dept_code = b.dept_code
																And	  a.comp_code 	= AR_COMP_CODE
																And	  a.clse_acc_id = AR_CLSE_ACC_ID
																And	  (n_cnt-b_cnt) > 0
															  );
															  
	    Select count(*)
		into
			ln_DEPT_Count2
		From 
			 (
			 Select comp_code, clse_acc_id, dept_code, count(emp_no) b_cnt
			 From t_budg_bf_order_stat
			 Where all_chg_seq = AR_ALL_CHG_SEQ
			 Group by comp_code, clse_acc_id, dept_code
			 ) a,
			 (
			 Select comp_code, clse_acc_id, dept_code, count(emp_no) n_cnt
			 From t_budg_now_order_stat
			 Where all_chg_seq = AR_ALL_CHG_SEQ
			 Group by comp_code, clse_acc_id, dept_code
			 ) b
		Where a.comp_code = b.comp_code
		And	  a.clse_acc_id = b.clse_acc_id
		And	  a.dept_code = b.dept_code
		And	  a.comp_code 	= AR_COMP_CODE
		And	  a.clse_acc_id = AR_CLSE_ACC_ID
		And	  (n_cnt-b_cnt) > 0;
	   --Raise_Application_Error(-20009,ln_DEPT_Count || ln_DEPT_Count2);
	   
       If ln_DEPT_Count < ln_DEPT_Count2 Then

	      Raise_Application_Error(-20009,'최초예산이 등록되지 않은 부서가 <br> 존재하므로 작업이 불가능합니다');
	   End If;
	End;
	
	--확정여부 체크 
	Begin
		select count(dept_code)
			   Into
			   ln_DEPT_Count3						 
		from  t_budg_dept_h a
		where confirm_tag ='F'
		and (a.comp_code, a.clse_acc_id,a.dept_code) in  (Select a.comp_code, a.clse_acc_id, a.dept_code
																From 
																	 (
																	 Select comp_code, clse_acc_id, dept_code, count(emp_no) b_cnt
																	 From t_budg_bf_order_stat
																	 Where all_chg_seq = AR_ALL_CHG_SEQ
																	 Group by comp_code, clse_acc_id, dept_code
																	 ) a,
																	 (
																	 Select comp_code, clse_acc_id, dept_code, count(emp_no) n_cnt
																	 From t_budg_now_order_stat
																	 Where all_chg_seq = AR_ALL_CHG_SEQ
																	 Group by comp_code, clse_acc_id, dept_code
																	 ) b
																Where a.comp_code = b.comp_code
																And	  a.clse_acc_id = b.clse_acc_id
																And	  a.dept_code = b.dept_code
																And	  a.comp_code 	= AR_COMP_CODE
																And	  a.clse_acc_id = AR_CLSE_ACC_ID
																And	  (n_cnt-b_cnt) > 0
															  );
															  
	   
       If ln_DEPT_Count3 > 0 Then

	      Raise_Application_Error(-20009,'확정이 안된 부서가 <br> 존재하므로 작업이 불가능합니다');
	   End If;
	End;
	
	--부서별 변경차수등록
	  --적용월 인원현황에서 사업장별 회기별 부서정보를 가져온다.
	Select
		    a.dept_code,
		    b.chg_seq
		    Bulk Collect Into
			lt_T_DEPT1,
			lt_T_CHG_SEQ1
	From
		 (
		  Select comp_code,
		 		 clse_acc_id,
				 all_chg_seq,
		 		 dept_code,
		 		 count(emp_no)
		  From t_budg_now_order_stat
		  Group  by  comp_code,
		 		 	 clse_acc_id,
					 all_chg_seq,
		 		 	 dept_code ) a,
		 (Select comp_code,
		 		 clse_acc_id,
				 dept_code,
				 max(chg_seq) +1 chg_seq
		  From t_budg_dept_h
		  Group by comp_code,
		 	      clse_acc_id,
				  dept_code ) b
	Where a.comp_code   = b.comp_code
	And	  a.clse_acc_id = b.clse_acc_id
	And	  a.dept_code   = b.dept_code
	And	  a.comp_code 	= AR_COMP_CODE
	And	  a.clse_acc_id = AR_CLSE_ACC_ID
	And	  a.all_chg_seq = AR_ALL_CHG_SEQ
	And	  (a.comp_code, a.clse_acc_id,a.dept_code) in  (Select a.comp_code, a.clse_acc_id, a.dept_code
														From 
															 (
															 Select comp_code, clse_acc_id, dept_code, count(emp_no) b_cnt
															 From t_budg_bf_order_stat
															 Where all_chg_seq=AR_ALL_CHG_SEQ
															 Group by comp_code, clse_acc_id, dept_code
															 ) a,
															 (
															 Select comp_code, clse_acc_id, dept_code, count(emp_no) n_cnt
															 From t_budg_now_order_stat
															 Where all_chg_seq=AR_ALL_CHG_SEQ
															 Group by comp_code, clse_acc_id, dept_code
															 ) b
														Where a.comp_code = b.comp_code
														And	  a.clse_acc_id = b.clse_acc_id
														And	  a.dept_code = b.dept_code
														And	  a.comp_code 	= AR_COMP_CODE
														And	  a.clse_acc_id = AR_CLSE_ACC_ID
														And	  (n_cnt-b_cnt) > 0
													  )
	order by dept_code;
	
	
	If lt_T_DEPT1.Count < 1 Then
	   Raise_Application_Error(-20009,'부서별 회기 정보가 존재하지 않습니다');
	End if;
	
	--일괄변경 취소를 위한 대상변경차수 가져오기
	Select  dept_code, chg_seq
	Bulk Collect Into
			lt_T_DEPT2,
			lt_T_CHG_SEQ2
	From t_budg_all_change_dept
	Where comp_code   =  AR_COMP_CODE
	And	  clse_acc_id =  AR_CLSE_ACC_ID
	And   all_chg_seq =  AR_ALL_CHG_SEQ;
	
	
	--월별 변경 금액 3 
	Select
		    a1.dept_code,
			a1.chg_seq,
		    a1.budg_code_no,
		    a1.budg_ym,
		    a1.amt
	Bulk Collect Into
			lt_T_DEPT3,
			lt_T_CHG_SEQ3,
			lt_T_BUDG_CODE_NO3,
			lt_T_BUDG_YM3,
			lt_T_AMT3
	From
		  (
		  Select
		  		a.comp_code,
		  		a.clse_acc_id,
		  		a.dept_code,
				c.chg_seq,
		  		a.budg_code_no,
		  		a.budg_ym,
		  		a.amt - b.amt amt
		  From
		  	  (
			  Select a.comp_code,
			  		 a.clse_acc_id,
			  		 a.dept_code,
			  		 a.budg_code_no,
			  		 --to_char(a.budg_ym,'YYYY-MM') budg_ym,
					 budg_ym,
			  		 sum( nvl(amt,0) ) amt
			  From 	 t_budg_now_appl_amt a
			  Where  a.comp_code   = AR_COMP_CODE
			  And	 a.clse_acc_id = AR_CLSE_ACC_ID
			  And	 a.all_chg_seq = AR_ALL_CHG_SEQ
			  Group by a.comp_code,
			  		   a.clse_acc_id,
			  		   a.dept_code,
					   a.budg_code_no,
			  		   a.budg_ym
			  Order by a.dept_code,
			  		   a.budg_code_no,
			  		   a.budg_ym
		  	  ) a,
			  (
			  Select a.comp_code,
			  		 a.clse_acc_id,
			  		 a.dept_code,
			  		 a.budg_code_no,
			  		 --to_char(a.budg_ym,'YYYY-MM') budg_ym,
					 budg_ym,
			  		 sum(nvl(amt,0)) amt
			  From 	 t_budg_bf_base_amt a
			  Where  a.comp_code   = AR_COMP_CODE
			  And	 a.clse_acc_id = AR_CLSE_ACC_ID
			  And	 a.all_chg_seq = AR_ALL_CHG_SEQ
			  Group by a.comp_code,
			  		   a.clse_acc_id,
			  		   a.dept_code,
					   a.budg_code_no,
			  		   a.budg_ym
			  Order by a.dept_code,
			  		   a.budg_code_no,
			  		   a.budg_ym
			  ) b,
			  (select comp_code, clse_acc_id, dept_code, max(chg_seq) + 1 chg_seq
			  from t_budg_dept_h
			  group by comp_code,
			  		   clse_acc_id,
			  		   dept_code
			  ) c
		   Where a.comp_code   = b.comp_code
		   And	 a.clse_acc_id = b.clse_acc_id
		   And	 a.dept_code   = b.dept_code
		   And	 a.budg_code_no= b.budg_code_no
		   And	 a.budg_ym	   = b.budg_ym
		   and   b.comp_code   = c.comp_code
		   and	 b.clse_acc_id = c.clse_acc_id
		   and	 b.dept_code   = c.dept_code	   
		   And	  (a.comp_code, a.clse_acc_id,a.dept_code) in  (Select a.comp_code, a.clse_acc_id, a.dept_code
														   	    From 
															    (
																	 Select comp_code, clse_acc_id, dept_code, count(emp_no) b_cnt
																	 From t_budg_bf_order_stat
																	 Where all_chg_seq = AR_ALL_CHG_SEQ
																	 Group by comp_code, clse_acc_id, dept_code
																	 ) a,
																	 (
																	 Select comp_code, clse_acc_id, dept_code, count(emp_no) n_cnt
																	 From t_budg_now_order_stat
																	 Where all_chg_seq = AR_ALL_CHG_SEQ
																	 Group by comp_code, clse_acc_id, dept_code
																	 ) b
																Where a.comp_code   = b.comp_code
																And	  a.clse_acc_id = b.clse_acc_id
																And	  a.dept_code   = b.dept_code
																And	  a.comp_code 	= AR_COMP_CODE
																And	  a.clse_acc_id = AR_CLSE_ACC_ID
																And	  (n_cnt-b_cnt) > 0
													  			)
		   ) a1
		   order by dept_code;
	
	--차수별 변경금액
    select
		    a1.dept_code,
			a1.chg_seq,
		    a1.budg_code_no,
		    a1.amt
	Bulk Collect Into
			lt_T_DEPT4,
			lt_T_CHG_SEQ4,
			lt_T_BUDG_CODE_NO4,
			lt_T_AMT4
	from
		  (
		  select
		  		a.comp_code,
		  		a.clse_acc_id,
		  		a.dept_code,
				c.chg_seq,
		  		a.budg_code_no,
		  		a.amt - b.amt amt
		  from
		  	  (
			  select a.comp_code,
			  		 a.clse_acc_id,
			  		 a.dept_code,
			  		 a.budg_code_no,
			  		 sum( nvl(amt,0) ) amt
			  from 	 t_budg_now_appl_amt a
			  where  a.comp_code   = AR_COMP_CODE
			  and	 a.clse_acc_id = AR_CLSE_ACC_ID
			  and	 a.all_chg_seq = AR_ALL_CHG_SEQ
			  group by a.comp_code,
			  		   a.clse_acc_id,
			  		   a.dept_code,
					   a.budg_code_no
			  order by a.dept_code,
			  		   a.budg_code_no
		  	  ) a,
			  (
			  select a.comp_code,
			  		 a.clse_acc_id,
			  		 a.dept_code,
			  		 a.budg_code_no,
			  		 sum(nvl(amt,0)) amt
			  from 	 t_budg_bf_base_amt a
			  where  a.comp_code   =  AR_COMP_CODE
			  and	 a.clse_acc_id =  AR_CLSE_ACC_ID
			  and	 a.all_chg_seq =  AR_ALL_CHG_SEQ
			  group by a.comp_code,
			  		   a.clse_acc_id,
			  		   a.dept_code,
					   a.budg_code_no
			  order by a.dept_code,
			  		   a.budg_code_no
			  ) b,
			  (select comp_code, clse_acc_id, dept_code, max(chg_seq) + 1 chg_seq
			  from t_budg_dept_h
			  group by comp_code,
			  		   clse_acc_id,
			  		   dept_code
			  ) c
		   where a.comp_code   = b.comp_code
		   and	 a.clse_acc_id = b.clse_acc_id
		   and	 a.dept_code   = b.dept_code
		   and	 a.budg_code_no= b.budg_code_no
		   and   b.comp_code   = c.comp_code
		   and	 b.clse_acc_id = c.clse_acc_id
		   and	 b.dept_code   = c.dept_code  
		   and	  (a.comp_code, a.clse_acc_id,a.dept_code) in  (select a.comp_code, a.clse_acc_id, a.dept_code
														   	    from 
															    (
																	 select comp_code, clse_acc_id, dept_code, count(emp_no) b_cnt
																	 from t_budg_bf_order_stat
																	 where all_chg_seq = AR_ALL_CHG_SEQ
																	 group by comp_code, clse_acc_id, dept_code
																	 ) a,
																	 (
																	 select comp_code, clse_acc_id, dept_code, count(emp_no) n_cnt
																	 from t_budg_now_order_stat
																	 where all_chg_seq = AR_ALL_CHG_SEQ
																	 group by comp_code, clse_acc_id, dept_code
																	 ) b
																where a.comp_code   = b.comp_code
																and	  a.clse_acc_id = b.clse_acc_id
																and	  a.dept_code   = b.dept_code
																and	  a.comp_code 	=  AR_COMP_CODE
																and	  a.clse_acc_id =  AR_CLSE_ACC_ID
																and	  (n_cnt-b_cnt) > 0
													  			)
		   ) a1
		   order by dept_code;
		   
		   
	
	
	li1Start := lt_T_DEPT1.First;--일괄변경적용대상
	li1End   := lt_T_DEPT1.Last;
	
	li2Start := lt_T_DEPT2.First;--변경 취소 대상
	li2End   := lt_T_DEPT2.Last;
	
	li3Start := lt_T_DEPT3.First; --월별변경금액
	li3End   := lt_T_DEPT3.Last;
	
	li4Start := lt_T_DEPT4.First; --차수별 변경금액
	li4End   := lt_T_DEPT4.Last;

	
	 
	--****일괄예산변경적용시
	If  AR_APPLY_YN = 'Y' Then --ls_budg_apply_ym
		For li1I In li1Start..li1End Loop --변경되는 부서반복
			--예산변경등록
			SP_T_BUDG_DEPT_H_I(AR_COMP_CODE, AR_CLSE_ACC_ID, lt_T_DEPT1(li1I),
							  lt_T_CHG_SEQ1(li1I), AR_CRTUSERNO, 'F',ls_budg_apply_ym,'F');
							  
			--예산변경확정
			Update	T_BUDG_DEPT_H
			Set		CONFIRM_TAG = 'T'
			Where	COMP_CODE   = AR_COMP_CODE
			And		CLSE_ACC_ID = AR_CLSE_ACC_ID
			And		DEPT_CODE   = lt_T_DEPT1(li1I)
			And		CHG_SEQ     = lt_T_CHG_SEQ1(li1I);
			
			--일괄변경부서별변경차수등록
			SP_T_BUDG_ALL_CHANGE_DEPT_I(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_ALL_CHG_SEQ, lt_T_DEPT1(li1I),lt_T_CHG_SEQ1(li1I), AR_CRTUSERNO);
		End Loop;	
			--월별 금액 반영
			For li3I In li3Start..li3End Loop		   
					
				Update T_BUDG_MONTH_AMT_H
				Set    budg_month_assign_amt = budg_month_assign_amt + lt_T_AMT3(li3I)
				Where  comp_code    = AR_COMP_CODE
				And    clse_acc_id  = AR_CLSE_ACC_ID
				And    dept_code    = lt_T_DEPT3(li3I)
				And    chg_seq 	    = lt_T_CHG_SEQ3(li3I)
				And    budg_code_no = lt_T_BUDG_CODE_NO3(li3I)
				And    reserved_seq = 1
				And    budg_ym	    = lt_T_BUDG_YM3(li3I);
				
				 --예산변경내역사유등록
				Insert into t_budg_chg_reason
				(
				 comp_code,
				 clse_acc_id,
				 dept_code,
				 chg_seq,
				 budg_code_no,
				 reserved_seq,
				 budg_ym,
				 reason_no,
				 reason_code,
				 chg_amt
				)
				values
				(
				 AR_COMP_CODE,
				 AR_CLSE_ACC_ID,
				 lt_T_DEPT3(li3I),
				 lt_T_CHG_SEQ3(li3I),
				 lt_T_BUDG_CODE_NO3(li3I),
				 1,
				 lt_T_BUDG_YM3(li3I),
				 1,
				 1,
				 lt_T_AMT3(li3I)
				);
			End Loop;
			
			--차수별 금액 반영
			For li4I In li4Start..li4End Loop		   
					
				Update	T_BUDG_DEPT_ITEM_H
				Set	    BUDG_ITEM_ASSIGN_AMT = BUDG_ITEM_ASSIGN_AMT +  lt_T_AMT4(li4I),
						BUDG_ADD_AMT = BUDG_ADD_AMT +  lt_T_AMT4(li4I)
				Where	COMP_CODE    = AR_COMP_CODE
				And	    CLSE_ACC_ID  = AR_CLSE_ACC_ID
				And	    DEPT_CODE    = lt_T_DEPT4(li4I)
				And	    CHG_SEQ      = lt_T_CHG_SEQ4(li4I)
				And	    BUDG_CODE_NO =  lt_T_BUDG_CODE_NO4(li4I)
				And	    RESERVED_SEQ =  1;
				
			End Loop;

		--확정예산 반영
		For li1I In li1Start..li1End Loop 
		
			SP_T_BUDG_LAST_CONFIRM(Ar_COMP_CODE,Ar_CLSE_ACC_ID,lt_T_DEPT1(li1I),Ar_CRTUSERNO);
		
		End Loop;
				--Raise_Application_Error(-20009,ls_budg_apply_ym);				   
				--예산변경차액이 0이 아닐경우 월별예산, 월별예산변경
				 
	End If;
	--변경된 부서만 등록할것인가 모든부서를 할것인가

	--****일괄예산변경적용취소시
	If  AR_APPLY_YN = 'N' Then
		
		For li2I In li2Start..li2End Loop 
		
			--예산변경취소
			Update	T_BUDG_DEPT_H
			Set		CONFIRM_TAG = 'F'
			Where	COMP_CODE   = AR_COMP_CODE
			And		CLSE_ACC_ID = AR_CLSE_ACC_ID
			And		DEPT_CODE   = lt_T_DEPT2(li2I)
			And		CHG_SEQ     = lt_T_CHG_SEQ2(li2I);
			
			SP_T_BUDG_LAST_CONFIRM(Ar_COMP_CODE,Ar_CLSE_ACC_ID,lt_T_DEPT2(li2I),Ar_CRTUSERNO);
			
			--일괄변경부서별변경차수삭제
			SP_T_BUDG_ALL_CHANGE_DEPT_D(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_ALL_CHG_SEQ, lt_T_DEPT2(li2I) ,lt_T_CHG_SEQ2(li2I));
			
			--예산변경내역사유삭제
			BEGIN
			Delete from T_BUDG_CHG_REASON
			Where comp_code = AR_COMP_CODE
			And   clse_acc_id = AR_CLSE_ACC_ID
			And   dept_code   = lt_T_DEPT2(li2I)
			And   chg_seq 	  = lt_T_CHG_SEQ2(li2I);
			EXCEPTION when others then
					  NULL;
			END;
			--차수별 월별 예산 삭제
			Delete from T_BUDG_MONTH_AMT_H
			Where comp_code    = AR_COMP_CODE
			and   clse_acc_id  = AR_CLSE_ACC_ID
			and   dept_code    = lt_T_DEPT2(li2I)
			and   chg_seq 	    = lt_T_CHG_SEQ2(li2I);
				
			--차수별 예산 삭제
			Delete from T_BUDG_DEPT_ITEM_H
			Where comp_code    = AR_COMP_CODE
			And   clse_acc_id  = AR_CLSE_ACC_ID
			And   dept_code    = lt_T_DEPT2(li2I)
			And   chg_seq 	    = lt_T_CHG_SEQ2(li2I);
			
			
			--예산변경취소
			Delete T_BUDG_DEPT_H
			Where	COMP_CODE = AR_COMP_CODE
			And	CLSE_ACC_ID = AR_CLSE_ACC_ID
			And	DEPT_CODE = lt_T_DEPT2(li2I)
			And	CHG_SEQ = lt_T_CHG_SEQ2(li2I);
			
			
			Update	T_BUDG_DEPT
			Set		LAST_CONFIRMED_SEQ = lt_T_CHG_SEQ2(li2I) -1,
					LAST_WORK_SEQ = lt_T_CHG_SEQ2(li2I) -1
			Where	COMP_CODE = AR_COMP_CODE
			And		CLSE_ACC_ID = AR_CLSE_ACC_ID
			And		DEPT_CODE = lt_T_DEPT2(li2I);
			
		End Loop;
		

			--Exception When Others Then
				--lsErrm := SqlErrm;
				--lsErrm := Replace(lsErrm,'ORA-20009:','');
				--Raise_Application_Error(-20009,'부서/현장 :' ||lt_T_DEPT3(li3I)||'의 예산적용취소 에러'||chr(10)||lsErrm);
			--End;

	End If;
	--예산변경내역삭제
	--부서별 변경차수확정취소
	--일괄변경부서별변경차수삭제
	--부서별예산변경차수삭제

	--SP_T_BUDG_ALL_CHANGE_DETAIL(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_ALL_CHG_SEQ, AR_CRTUSERNO, AR_BUDG_APPLY_YM);
End;
/
