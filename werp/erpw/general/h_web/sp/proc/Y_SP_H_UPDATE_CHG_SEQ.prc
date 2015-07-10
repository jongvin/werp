CREATE OR REPLACE PROCEDURE y_sp_h_update_chg_seq( as_dept_code in varchar2,
        	 						 								as_sell_code in varchar2,
																	as_cont_date in date,
																	as_cont_seq  in integer,
                                                   as_tag in varchar2) IS

--as_tag = 'lease_detail'
--       = 'rent_detail' 
BEGIN
	BEGIN
	   
		if as_tag = 'lease_detail' then
			update h_lease_master
			  set  lease_chg_seq = (select nvl(max(chg_seq),0)
			                          from h_lease_detail
											 where dept_code = as_dept_code
											   and sell_code = as_sell_code
												and cont_date = as_cont_date
												and cont_seq  = as_cont_seq)
			 where dept_code = as_dept_code
			   and sell_code = as_sell_code
				and cont_date = as_cont_date
				and cont_seq  = as_cont_seq;  
      elsif as_tag = 'rent_detail' then
		   update h_lease_master
			  set  rent_chg_seq = (select nvl(max(chg_seq),0)
			                          from h_lease_rent_detail
											 where dept_code = as_dept_code
											   and sell_code = as_sell_code
												and cont_date = as_cont_date
												and cont_seq  = as_cont_seq)
			 where dept_code = as_dept_code
			   and sell_code = as_sell_code
				and cont_date = as_cont_date
				and cont_seq  = as_cont_seq;
		end if;  		  


	END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   
--EXCEPTION
  --WHEN UserErr       THEN
       --RAISE_APPLICATION_ERROR('aa', s);
END y_sp_h_update_chg_seq;
/

