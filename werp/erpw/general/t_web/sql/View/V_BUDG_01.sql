--월별추가현황 (본예산, 추가예산)
Create Or Replace View V_BUDG_01
(
	comp_code,
	clse_acc_id,
	dept_code,
	chg_seq,
	budg_code_no,
	budg_ym,
	budg_month_assign_amt,
	chg_amt,
    acc_code
) 
As
select  a.comp_code,
		a.clse_acc_id,
		a.dept_code,
		b.chg_seq chg_seq,
		a.budg_code_no,
		a.budg_ym,
		a.budg_month_assign_amt,
		b.chg_amt,
		c.acc_code
from
	(
	select 
		   a.comp_code,
		   a.clse_acc_id,
		   a.dept_code,
		   a.budg_code_no,
		   a.budg_ym,
		   a.budg_month_assign_amt
	from   t_budg_month_amt a
	--where  chg_seq=0
	) a, 
	(
	select 
		   a.comp_code,
		   a.clse_acc_id,
		   a.dept_code,
		   a.chg_seq,
		   a.budg_code_no,
		   a.budg_ym,
		   sum(nvl(a.chg_amt,0)) chg_amt
		   
	from   t_budg_chg_reason a
	where  reason_code='1'
	group  by a.comp_code,
		   	  a.clse_acc_id,
		   	  a.dept_code,
		   	  a.chg_seq,
		   	  a.budg_code_no,
		   	  a.budg_ym
	) b,
	t_budg_code      c
where a.comp_code     = b.comp_code(+) 
and	  a.clse_acc_id   = b.clse_acc_id(+) 
and	  a.dept_code 	  = b.dept_code(+)
and	  a.budg_code_no  = b.budg_code_no(+)
and	  a.budg_ym 	  = b.budg_ym(+)
and    a.budg_code_no = c.budg_code_no
/
