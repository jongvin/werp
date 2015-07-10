select a.detail_code,a.cnt_price,a.price
from y_chg_budget_detail a,
    (select proj_code,
            no,
            detail_code,
            count(distinct cnt_price)
       from y_chg_budget_detail
      where proj_code = '2001002'
        and no = 1
   group by proj_code,no,detail_code
//     having count(detail_code) > 1 ) b
    having count(distinct cnt_price) > 1 ) b,
    (select proj_code,
            no,
            detail_code,
            count(distinct price)
       from y_chg_budget_detail
      where proj_code = '2001002'
        and no = 1
   group by proj_code,no,detail_code
//     having count(detail_code) > 1 ) b
    having count(distinct price) > 1 ) c
where a.proj_code = '2001002'
  and a.no = 1
  and (a.detail_code = b.detail_code
   or  a.detail_code = c.detail_code);
                       
