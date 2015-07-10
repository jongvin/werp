CREATE OR REPLACE Procedure SP_T_PROF_LOSS_COPY
(
	AR_EMP_NO                                  VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_YEAR                                    VARCHAR2,
	AR_MONTH                                   VARCHAR2
)
Is
	lsClose					Varchar2(2);
	lnAmt					Number;
Begin

--RAISE_APPLICATION_ERROR(-20000, AR_EMP_NO || AR_DEPT_CODE || AR_YEAR || AR_MONTH);
delete 
from t_prof_loss
where emp_no = AR_EMP_NO;

insert into t_prof_loss
(
	  emp_no,
	  acc_code,
	  acc_name,
	  c_amt,
	  c2_amt,
	  c_amt_sum,
	  c2_amt_sum,
	  b_amt_sum,
	  b2_amt_sum,
	  tot_sum,
	  tot2_sum
)	

select
	  AR_EMP_NO,
	  aa.acc_code,
	  aa.acc_name,
	  decode(bb.acc_lvl, '2', '', decode(bb.acc_remain_position, 'D', c_amt- c2_amt, c2_amt-c_amt)) c_amt,
	  decode(bb.acc_lvl, '2', decode(bb.acc_remain_position, 'D', c_amt- c2_amt, c2_amt-c_amt), '') c2_amt,
	  decode(bb.acc_lvl, '2','', decode(bb.acc_remain_position, 'D', c_amt_sum- c2_amt_sum, c2_amt_sum-c_amt_sum)) c_amt_sum,
	  decode(bb.acc_lvl, '2',decode(bb.acc_remain_position, 'D', c_amt_sum- c2_amt_sum, c2_amt_sum-c_amt_sum),'') c2_amt_sum,
	  decode(bb.acc_lvl, '2','',decode(bb.acc_remain_position, 'D', b_amt_sum- b2_amt_sum, b2_amt_sum-b_amt_sum)) b_amt_sum,
	  decode(bb.acc_lvl, '2',decode(bb.acc_remain_position, 'D', b_amt_sum- b2_amt_sum, b2_amt_sum-b_amt_sum),'') b2_amt_sum,
	  decode(bb.acc_lvl, '2','',decode(bb.acc_remain_position, 'D', tot_sum- tot2_sum, tot2_sum-tot_sum)) tot_sum,
	  decode(bb.acc_lvl, '2',decode(bb.acc_remain_position, 'D', tot_sum- tot2_sum, tot2_sum-tot_sum),'') tot2_sum
from
	(
	select a.acc_code, 
		   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
		   nvl(c_amt,0) c_amt,
		   nvl(c2_amt,0) c2_amt,
		   nvl(c_amt_sum,0) c_amt_sum,
		   nvl(c2_amt_sum,0) c2_amt_sum,
		   nvl(b_amt_sum,0) b_amt_sum,
		   nvl(b2_amt_sum,0) b2_amt_sum,
		   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
		   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
	from
		(  	
		select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
		from   t_acc_trans_daily_sum a,
			   (select acc_code, acc_shrt_name, acc_name, computer_acc
			    from t_acc_code 
				where  acc_grp = 5
				and	   acc_lvl between 2 and 4 ) b,
			   (select dept_code 
			    from   t_dept_code
			    --where  cost_desc_tag = :COST_DESC_TAG
				where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
			    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
		where a.acc_code = b.acc_code
		and	  a.dept_code = c.dept_code
		and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
		group by grouping sets(b.computer_acc, a.acc_code)
		) a,
		(  	
		select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
		from   t_acc_trans_daily_sum a,
			   (select acc_code, acc_shrt_name, acc_name, computer_acc
			    from t_acc_code 
				where  acc_grp = 5
				and	   acc_lvl between 2 and 4 ) b,
			   (select dept_code 
			    from    t_dept_code
			    --where	  cost_desc_tag = :COST_DESC_TAG
				where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
			    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
		where a.acc_code = b.acc_code
		and	  a.dept_code = c.dept_code
		and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
		group by grouping sets(b.computer_acc, a.acc_code)
		) a2,
		(  	
		select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
		from   t_acc_trans_daily_sum a,
			   (select acc_code, acc_shrt_name, acc_name, computer_acc
			    from t_acc_code 
				where  acc_grp = 5
				and	   acc_lvl between 2 and 4 ) b,
			   (select dept_code 
			    from    t_dept_code
			    --where	  cost_desc_tag = :COST_DESC_TAG
				where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
			    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
		where a.acc_code = b.acc_code
		and	  a.dept_code = c.dept_code
		and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
		group by grouping sets(b.computer_acc, a.acc_code)
		) a3,
		t_acc_code b
	where a.acc_code = a2.acc_code(+)
	and	  a.acc_code = a3.acc_code(+)
	and   a.acc_code = b.acc_code
	and	  b.fund_input_cls='F'
	--order by acc_code, acc_lvl

	
	union all
	
	select to_char(530000000 - 1) acc_code,
		   '  매 출 이 익' acc_name,
		   nvl(aa.c_amt,0) - nvl(aa2.c_amt,0) c_amt,
		   nvl(aa.c2_amt,0) - nvl(aa2.c2_amt,0) c2_amt,
		   nvl(aa.c_amt_sum,0) - nvl(aa2.c_amt_sum,0) c_amt_sum,
		   nvl(aa.c2_amt_sum,0) - nvl(aa2.c2_amt_sum,0) c2_amt_sum,
		   nvl(aa.b_amt_sum,0) - nvl(aa2.b_amt_sum,0) b_amt_sum,
		   nvl(aa.b2_amt_sum,0) - nvl(aa2.b2_amt_sum,0) b2_amt_sum,
		   (nvl(aa.c_amt_sum,0) + nvl(aa.b_amt_sum,0)) - (nvl(aa2.c_amt_sum,0) + nvl(aa2.b_amt_sum,0)) tot_sum,
		   (nvl(aa.c2_amt_sum,0) + nvl(aa.b2_amt_sum,0)) - (nvl(aa2.c2_amt_sum,0) + nvl(aa2.b2_amt_sum,0)) tot2_sum
	from
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='510000000'
		--order by acc_code, acc_lvl
		) aa,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa2
	where aa.div=aa2.div(+)
	
	union all
	
	select to_char(540000000-1) acc_code,
		   '  영 업 이 익' acc_name,
		   nvl(aa.c_amt,0) - nvl(aa2.c_amt,0) - nvl(aa3.c_amt,0) c_amt,
		   nvl(aa.c2_amt,0) - nvl(aa2.c2_amt,0) - nvl(aa3.c2_amt,0) c2_amt,
		   nvl(aa.c_amt_sum,0) - nvl(aa2.c_amt_sum,0) - nvl(aa3.c_amt_sum,0) c_amt_sum,
		   nvl(aa.c2_amt_sum,0) - nvl(aa2.c2_amt_sum,0) - nvl(aa3.c2_amt_sum,0)  c2_amt_sum,
		   nvl(aa.b_amt_sum,0) - nvl(aa2.b_amt_sum,0) - nvl(aa3.b_amt_sum,0) b_amt_sum,
		   nvl(aa.b2_amt_sum,0) - nvl(aa2.b2_amt_sum,0) - nvl(aa3.b2_amt_sum,0) b2_amt_sum,
		   (nvl(aa.c_amt_sum,0) + nvl(aa.b_amt_sum,0)) - (nvl(aa2.c_amt_sum,0) + nvl(aa2.b_amt_sum,0)) - (nvl(aa3.c_amt_sum,0) + nvl(aa3.b_amt_sum,0)) tot_sum,
		   (nvl(aa.c2_amt_sum,0) + nvl(aa.b2_amt_sum,0)) - (nvl(aa2.c2_amt_sum,0) + nvl(aa2.b2_amt_sum,0)) - (nvl(aa3.c2_amt_sum,0) + nvl(aa3.b2_amt_sum,0)) tot2_sum
	from
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='510000000'
		--order by acc_code, acc_lvl
		) aa,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa2,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa3
	where aa.div=aa2.div(+)
	and	  aa.div=aa3.div(+)
	
	union all
	
	select to_char(560000000-1) acc_code,
		   '  경 상 이 익' acc_name,
		   nvl(aa.c_amt,0) - nvl(aa2.c_amt,0) - nvl(aa3.c_amt,0) - nvl(aa4.c_amt,0) + nvl(aa5.c_amt,0) c_amt,
		   nvl(aa.c2_amt,0) - nvl(aa2.c2_amt,0) - nvl(aa3.c2_amt,0) - nvl(aa4.c2_amt,0) + nvl(aa5.c2_amt,0) c2_amt,
		   nvl(aa.c_amt_sum,0) - nvl(aa2.c_amt_sum,0) - nvl(aa3.c_amt_sum,0) - nvl(aa4.c_amt_sum,0) + nvl(aa5.c_amt_sum,0) c_amt_sum,
		   nvl(aa.c2_amt_sum,0) - nvl(aa2.c2_amt_sum,0) - nvl(aa3.c2_amt_sum,0) - nvl(aa4.c2_amt_sum,0) + nvl(aa5.c2_amt_sum,0) c2_amt_sum,
		   nvl(aa.b_amt_sum,0) - nvl(aa2.b_amt_sum,0) - nvl(aa3.b_amt_sum,0) - nvl(aa4.b_amt_sum,0) + nvl(aa5.b_amt_sum,0) b_amt_sum,
		   nvl(aa.b2_amt_sum,0) - nvl(aa2.b2_amt_sum,0) - nvl(aa3.b2_amt_sum,0) - nvl(aa4.b2_amt_sum,0) + nvl(aa5.b2_amt_sum,0)  b2_amt_sum,
		   (nvl(aa.c_amt_sum,0) + nvl(aa.b_amt_sum,0)) - (nvl(aa2.c_amt_sum,0) + nvl(aa2.b_amt_sum,0)) - (nvl(aa3.c_amt_sum,0) + nvl(aa3.b_amt_sum,0)) - (nvl(aa4.c_amt_sum,0) + nvl(aa4.b_amt_sum,0)) + (nvl(aa5.c_amt_sum,0) + nvl(aa5.b_amt_sum,0)) tot_sum,
		   (nvl(aa.c2_amt_sum,0) + nvl(aa.b2_amt_sum,0)) - (nvl(aa2.c2_amt_sum,0) + nvl(aa2.b2_amt_sum,0)) - (nvl(aa3.c2_amt_sum,0) + nvl(aa3.b2_amt_sum,0)) - (nvl(aa4.c2_amt_sum,0) + nvl(aa4.b2_amt_sum,0)) + (nvl(aa5.c2_amt_sum,0) + nvl(aa5.b2_amt_sum,0)) tot2_sum
	from
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='510000000'
		--order by acc_code, acc_lvl
		) aa,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa2,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa3,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='550000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='550000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='550000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa4,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='540000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='540000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='540000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa5
	where aa.div=aa2.div(+)
	and	  aa.div=aa3.div(+)
	and	  aa.div=aa4.div(+)
	and	  aa.div=aa5.div(+)
	
	union all
	
	select to_char(580000000-1) acc_code,
		   '  법인세 차감전 이익' acc_name,
		   nvl(aa.c_amt,0) - nvl(aa2.c_amt,0) - nvl(aa3.c_amt,0) - nvl(aa4.c_amt,0) + nvl(aa5.c_amt,0) - nvl(aa6.c_amt,0) + nvl(aa7.c_amt,0) c_amt,
		   nvl(aa.c2_amt,0) - nvl(aa2.c2_amt,0) - nvl(aa3.c2_amt,0) - nvl(aa4.c2_amt,0) + nvl(aa5.c2_amt,0) - nvl(aa6.c2_amt,0) + nvl(aa7.c2_amt,0) c2_amt,
		   nvl(aa.c_amt_sum,0) - nvl(aa2.c_amt_sum,0) - nvl(aa3.c_amt_sum,0) - nvl(aa4.c_amt_sum,0) + nvl(aa5.c_amt_sum,0) - nvl(aa6.c_amt_sum,0) + nvl(aa7.c_amt_sum,0) c_amt_sum,
		   nvl(aa.c2_amt_sum,0) - nvl(aa2.c2_amt_sum,0) - nvl(aa3.c2_amt_sum,0) - nvl(aa4.c2_amt_sum,0) + nvl(aa5.c2_amt_sum,0) - nvl(aa6.c2_amt_sum,0) + nvl(aa7.c2_amt_sum,0) c2_amt_sum,
		   nvl(aa.b_amt_sum,0) - nvl(aa2.b_amt_sum,0) - nvl(aa3.b_amt_sum,0) - nvl(aa4.b_amt_sum,0) + nvl(aa5.b_amt_sum,0) - nvl(aa6.b_amt_sum,0) + nvl(aa7.b_amt_sum,0)  b_amt_sum,
		   nvl(aa.b2_amt_sum,0) - nvl(aa2.b2_amt_sum,0) - nvl(aa3.b2_amt_sum,0) - nvl(aa4.b2_amt_sum,0) + nvl(aa5.b2_amt_sum,0) - nvl(aa6.b2_amt_sum,0) + nvl(aa7.b2_amt_sum,0) b2_amt_sum,
		   (nvl(aa.c_amt_sum,0) + nvl(aa.b_amt_sum,0)) - (nvl(aa2.c_amt_sum,0) + nvl(aa2.b_amt_sum,0)) - (nvl(aa3.c_amt_sum,0) + nvl(aa3.b_amt_sum,0)) - (nvl(aa4.c_amt_sum,0) + nvl(aa4.b_amt_sum,0)) + (nvl(aa5.c_amt_sum,0) + nvl(aa5.b_amt_sum,0)) - (nvl(aa6.c_amt_sum,0) + nvl(aa6.b_amt_sum,0)) + (nvl(aa7.c_amt_sum,0) + nvl(aa7.b_amt_sum,0)) tot_sum,
		   (nvl(aa.c2_amt_sum,0) + nvl(aa.b2_amt_sum,0)) - (nvl(aa2.c2_amt_sum,0) + nvl(aa2.b2_amt_sum,0)) - (nvl(aa3.c2_amt_sum,0) + nvl(aa3.b2_amt_sum,0)) - (nvl(aa4.c2_amt_sum,0) + nvl(aa4.b2_amt_sum,0)) + (nvl(aa5.c2_amt_sum,0) + nvl(aa5.b2_amt_sum,0)) - (nvl(aa6.c2_amt_sum,0) + nvl(aa6.b2_amt_sum,0)) + (nvl(aa7.c2_amt_sum,0) + nvl(aa7.b2_amt_sum,0)) tot2_sum
	from
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='510000000'
		--order by acc_code, acc_lvl
		) aa,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa2,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa3,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='550000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='550000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='550000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa4,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='540000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='540000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='540000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa5,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='570000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='570000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='570000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa6,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='560000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='560000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='560000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa7
	where aa.div=aa2.div(+)
	and	  aa.div=aa3.div(+)
	and	  aa.div=aa4.div(+)
	and	  aa.div=aa5.div(+)
	and	  aa.div=aa6.div(+)
	and	  aa.div=aa7.div(+)
	
	union all
	
	select '590000000' acc_code,
		   '  당 기 순 이익' acc_name,
		   nvl(aa.c_amt,0) - nvl(aa2.c_amt,0) - nvl(aa3.c_amt,0) - nvl(aa4.c_amt,0) + nvl(aa5.c_amt,0) - nvl(aa6.c_amt,0) + nvl(aa7.c_amt,0) - nvl(aa8.c_amt,0) c_amt,
		   nvl(aa.c2_amt,0) - nvl(aa2.c2_amt,0) - nvl(aa3.c2_amt,0) - nvl(aa4.c2_amt,0) + nvl(aa5.c2_amt,0) - nvl(aa6.c2_amt,0) + nvl(aa7.c2_amt,0) - nvl(aa8.c2_amt,0) c2_amt,
		   nvl(aa.c_amt_sum,0) - nvl(aa2.c_amt_sum,0) - nvl(aa3.c_amt_sum,0) - nvl(aa4.c_amt_sum,0) + nvl(aa5.c_amt_sum,0) - nvl(aa6.c_amt_sum,0) + nvl(aa7.c_amt_sum,0) - nvl(aa8.c_amt_sum,0) c_amt_sum,
		   nvl(aa.c2_amt_sum,0) - nvl(aa2.c2_amt_sum,0) - nvl(aa3.c2_amt_sum,0) - nvl(aa4.c2_amt_sum,0) + nvl(aa5.c2_amt_sum,0) - nvl(aa6.c2_amt_sum,0) + nvl(aa7.c2_amt_sum,0) - nvl(aa8.c2_amt_sum,0) c2_amt_sum,
		   nvl(aa.b_amt_sum,0) - nvl(aa2.b_amt_sum,0) - nvl(aa3.b_amt_sum,0) - nvl(aa4.b_amt_sum,0) + nvl(aa5.b_amt_sum,0) - nvl(aa6.b_amt_sum,0) + nvl(aa7.b_amt_sum,0) - nvl(aa8.b_amt_sum,0) b_amt_sum,
		   nvl(aa.b2_amt_sum,0) - nvl(aa2.b2_amt_sum,0) - nvl(aa3.b2_amt_sum,0) - nvl(aa4.b2_amt_sum,0) + nvl(aa5.b2_amt_sum,0) - nvl(aa6.b2_amt_sum,0) + nvl(aa7.b2_amt_sum,0) - nvl(aa8.b2_amt_sum,0) b2_amt_sum,
		   (nvl(aa.c_amt_sum,0) + nvl(aa.b_amt_sum,0)) - (nvl(aa2.c_amt_sum,0) + nvl(aa2.b_amt_sum,0)) - (nvl(aa3.c_amt_sum,0) + nvl(aa3.b_amt_sum,0)) - (nvl(aa4.c_amt_sum,0) + nvl(aa4.b_amt_sum,0)) + (nvl(aa5.c_amt_sum,0) + nvl(aa5.b_amt_sum,0)) - (nvl(aa6.c_amt_sum,0) + nvl(aa6.b_amt_sum,0)) + (nvl(aa7.c_amt_sum,0) + nvl(aa7.b_amt_sum,0)) - (nvl(aa8.c_amt_sum,0) + nvl(aa8.b_amt_sum,0)) tot_sum,
		   (nvl(aa.c2_amt_sum,0) + nvl(aa.b2_amt_sum,0)) - (nvl(aa2.c2_amt_sum,0) + nvl(aa2.b2_amt_sum,0)) - (nvl(aa3.c2_amt_sum,0) + nvl(aa3.b2_amt_sum,0)) - (nvl(aa4.c2_amt_sum,0) + nvl(aa4.b2_amt_sum,0)) + (nvl(aa5.c2_amt_sum,0) + nvl(aa5.b2_amt_sum,0)) - (nvl(aa6.c2_amt_sum,0) + nvl(aa6.b2_amt_sum,0)) + (nvl(aa7.c2_amt_sum,0) + nvl(aa7.b2_amt_sum,0)) - (nvl(aa8.c2_amt_sum,0) + nvl(aa8.b2_amt_sum,0)) tot2_sum
	from
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='510000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='510000000'
		--order by acc_code, acc_lvl
		) aa,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='520000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa2,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='530000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa3,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='550000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='550000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='550000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa4,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='540000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='540000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='540000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa5,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='570000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='570000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='570000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa6,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='560000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='560000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='560000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa7,
		(
		select '11' div,
			   a.acc_code, 
			   decode(acc_lvl, '4', lpad(' ', acc_lvl*2-1) || b.acc_shrt_name, lpad('  ', acc_lvl) || b.acc_shrt_name) acc_name, 
			   nvl(c_amt,0) c_amt,
			   nvl(c2_amt,0) c2_amt,
			   nvl(c_amt_sum,0) c_amt_sum,
			   nvl(c2_amt_sum,0) c2_amt_sum,
			   nvl(b_amt_sum,0) b_amt_sum,
			   nvl(b2_amt_sum,0) b2_amt_sum,
			   nvl(c_amt_sum,0) + nvl(b_amt_sum,0) tot_sum,
			   nvl(c2_amt_sum,0) + nvl(b2_amt_sum,0) tot2_sum
		from
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt_sum, sum(cr_sum) c2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from   t_dept_code
				    --where  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	   dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='580000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) between AR_YEAR || '01' and AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) b_amt_sum,sum(cr_sum) b2_amt_sum
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='580000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 4) = AR_YEAR - 1
			group by grouping sets(b.computer_acc, a.acc_code)
			) a2,
			(  	
			select b.computer_acc, a.acc_code, sum(dr_sum) c_amt,sum(cr_sum) c2_amt
			from   t_acc_trans_daily_sum a,
				   (select acc_code, acc_shrt_name, acc_name, computer_acc
				    from t_acc_code 
					where  acc_grp = 5
					and	   acc_lvl between 2 and 4 ) b,
				   (select dept_code 
				    from    t_dept_code
				    --where	  cost_desc_tag = :COST_DESC_TAG
					where	   acc_clost_dt_sys >=AR_YEAR || AR_MONTH || '-01'
				    and	  dept_code like '%' || AR_DEPT_CODE || '%' ) c
			where a.acc_code = b.acc_code
			and	  a.acc_code ='580000000'
			and	  a.dept_code = c.dept_code
			and	  substr(conf_ymd, 1, 6) = AR_YEAR || AR_MONTH
			group by grouping sets(b.computer_acc, a.acc_code)
			) a3,
			t_acc_code b
		where a.acc_code = a2.acc_code(+)
		and	  a.acc_code = a3.acc_code(+)
		and   a.acc_code = b.acc_code
		and	  b.fund_input_cls='F'
		--and	  a.acc_code ='520000000'
		--order by acc_code, acc_lvl
		) aa8
	where aa.div=aa2.div(+)
	and	  aa.div=aa3.div(+)
	and	  aa.div=aa4.div(+)
	and	  aa.div=aa5.div(+)
	and	  aa.div=aa6.div(+)
	and	  aa.div=aa7.div(+)
	and	  aa.div=aa8.div(+)
	) aa,
	t_acc_code bb
where aa.acc_code = bb.acc_code
order by 1;	
End;
/
