 (
	adt_yymm                               date ,
	as_dept_code                           VARCHAR2
)
Is

 
    BEGIN
		UPDATE c_spec_const_detail  a
		  SET (a.ls_cnt_result_qty,a.ls_cnt_result_amt,a.ls_result_qty,a.ls_result_amt ) =
            ( SELECT nvl(sum(b.cnt_result_qty),0),nvl(sum(b.cnt_result_amt),0),nvl(sum(b.result_qty),0),nvl(sum(b.result_amt),0)
							  from c_spec_const_detail b
							 where a.spec_unq_num = b.spec_unq_num
								and b.dept_code = as_dept_code
								and b.yymm      < adt_yymm )
		 WHERE a.dept_code = as_dept_code
			AND a.yymm      = adt_yymm
			AND EXISTS (SELECT nvl(sum(b.cnt_result_qty),0)
							  from c_spec_const_detail b
							 where a.spec_unq_num = b.spec_unq_num 
								and b.dept_code = as_dept_code 
								and b.yymm        < adt_yymm );
	
			UPDATE c_spec_const_detail  
			  SET  ls_result_rate = decode(amt,0,0,decode(sign(trunc(ls_result_amt / amt * 100,2) - 100),
										1,100,trunc(round(ls_result_amt / amt * 100,9),2))),
			       ls_cnt_result_rate = decode(cnt_amt,0,0,decode(sign(trunc(ls_cnt_result_amt / cnt_amt * 100,2) - 100),
										1,100,trunc(round(ls_cnt_result_amt / cnt_amt * 100,9),2)))
			 WHERE dept_code = as_dept_code
				AND yymm      = adt_yymm ;

			UPDATE c_spec_const_detail  a
			   SET a.pre_result_amt = a.sup_unit_amt * a.sup_qty
			 WHERE a.dept_code = as_dept_code
				AND a.yymm      = adt_yymm;
	
-- 기성금액(금액 베이스로 계산),추정 금액  구하기
			UPDATE c_spec_const_detail 
			  SET pre_result_rate = decode(amt,0,0,decode(sign(trunc(pre_result_amt / amt * 100,0) - 999),
			                                 1,999,trunc(pre_result_amt / amt * 100,0))),
					result_amt = decode(pre_result_amt,0,0,decode(sign(((ls_cost_amt + cost_amt) / pre_result_amt) - 1),1,trunc(amt - ls_result_amt,0),
								 					  round((cost_amt / pre_result_amt) * amt,0))),
					cnt_result_amt = decode(pre_result_amt,0,0,decode(sign(((ls_cost_amt + cost_amt) / pre_result_amt) - 1),1,trunc(cnt_amt - ls_cnt_result_amt,0),
								 					  round((cost_amt / pre_result_amt) * cnt_amt,0)))
			 WHERE dept_code = as_dept_code
				AND yymm      = adt_yymm;
	-- 기성률
			
			UPDATE c_spec_const_detail  
			  SET  result_rate = decode(amt,0,0,decode(sign(trunc((result_amt + ls_result_amt) / amt * 100,2) - 100),
										1,100 - ls_result_rate,trunc(result_amt / amt * 100,2))),
			       cnt_result_rate = decode(cnt_amt,0,0,decode(sign(trunc((cnt_result_amt + ls_cnt_result_amt) / cnt_amt * 100,2) - 100),
										1,100 - ls_cnt_result_rate,trunc(cnt_result_amt / cnt_amt * 100,2)))
										--,
-- 			2006.06.05 김동우부장님이 삭제처리
--			       cost_rate = decode((result_amt + ls_result_amt),0,0,decode(sign(trunc((cost_amt + ls_cost_amt) / (result_amt + ls_result_amt) * 100,2) - 999),
--										1,999,trunc((cost_amt + ls_cost_amt) / (result_amt + ls_result_amt) * 100,2) - ls_cost_rate ))
			 WHERE dept_code = as_dept_code
				AND yymm      = adt_yymm ;
	
	-- 기성수량
			
			UPDATE c_spec_const_detail  
			  SET  result_qty = trunc(ROUND(decode(amt,0,0,decode(sign((result_rate + ls_result_rate) - 99.99),
										1,qty - ls_result_qty,qty * ((result_amt + ls_result_amt) / amt))),6),3),
			       cnt_result_qty = trunc(ROUND(decode(cnt_amt,0,0,decode(sign((cnt_result_rate + ls_cnt_result_rate) - 99.99),
										1,cnt_qty - ls_cnt_result_qty,cnt_qty * ((cnt_result_amt + ls_cnt_result_amt) / cnt_amt))),6),3)
			 WHERE dept_code = as_dept_code
				AND yymm      = adt_yymm;
			
   END ;