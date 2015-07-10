CREATE OR REPLACE PROCEDURE "SP_E_MONTHLY_SUMMARY" (arg_dept_code  IN   VARCHAR2,
                                                    arg_yyyymm    IN   DATE ) IS
																		 
													 																		 
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error 
		
BEGIN
		
		/*외주 안전관리비 집계 */
		INSERT INTO E_SAFTY_COST_TOTAL (DEPT_CODE, 
				 								  YYMM, 
												  UNQ_NUM, 
											     ITEM_CODE, 
												  BIZ, 
												  USEMEMO, 
											     AMT, 
												  VAT, 
												  USE_DATE, 
											     REMARK) 
						           ( select dept_code,
									       	  yymm,
												  e_sc_unq_seq.nextval,
												  item_code,
												  '1',
												  usememo,
												  amt,
												  vat,
												  yymm,
												  remark
									  	   from e_safty_cost
									 	  where dept_code = arg_dept_code
									       and to_char(yymm, 'yyyymmdd')   = arg_yyyymm);
		
		/*노무 안전관리비 집계 */
		INSERT INTO E_SAFTY_COST_TOTAL (DEPT_CODE, 
				 								  YYMM, 
												  UNQ_NUM, 
											     ITEM_CODE, 
												  BIZ, 
												  USEMEMO, 
											     AMT, 
												  VAT, 
												  USE_DATE, 
											     REMARK) 
						           ( select aa.dept_code,
									           aa.yymm,
												  e_sc_unq_seq.nextval,
												  aa.item_code,
												  '2',
												  '월출역 집계',
												  amt,
												  0,
												  null,
												  null
									      from (select  a.dept_code,
												       	  to_char(a.work_date,'yyyymm')||'01' yymm,
															  a.item_code,
															  sum(nvl(a.pay_amt,0)) amt
															  
												  	   from l_labor_dailywork a,
														     (select civil_register_number
															     from l_labor_basic
																 where safety_man= 'T') bas
												 	  where a.dept_code = arg_dept_code
												       and to_char(work_date,'yyyymm')||'01' = arg_yyyymm
														 and a.civil_register_number = bas.civil_register_number
													group by a.dept_code,
												       	  to_char(a.work_date,'yyyymm')||'01',
															  a.item_code 
									           )aa
									  );
									  
		/*자재 안전관리비 집계 */									
		INSERT INTO E_SAFTY_COST_TOTAL (DEPT_CODE, 
				 								  YYMM, 
												  UNQ_NUM, 
											     ITEM_CODE, 
												  BIZ, 
												  USEMEMO, 
											     AMT, 
												  VAT, 
												  USE_DATE, 
											     REMARK) 
						           ( select dept_code,
									           arg_yyyymm,
												  e_sc_unq_seq.nextval,
												  item_code,
												  '3',
												  name,
												  amt,
												  vatamt,
												  yymmdd,
												  ssize||'/'||unitcode
									      from m_input_detail
										  where dept_code = arg_dept_code
										    and to_char(yymmdd,'yyyymm')||'01' = arg_yyyymm
											 and ditag = '3'
											 and ( inouttypecode = '1'
                                   or   inouttypecode = '8')
									  );
											   
		INSERT INTO E_SAFTY_COST_TOTAL (DEPT_CODE, 
				 								  YYMM, 
												  UNQ_NUM, 
											     ITEM_CODE, 
												  BIZ, 
												  USEMEMO, 
											     AMT, 
												  VAT, 
												  USE_DATE, 
											     REMARK) 
									( select a.dept_code,
												arg_yyyymm,
												e_sc_unq_seq.nextval,
												a.item_code,
												'3',
												a.name,
												b.amt,
												0,
												b.yymmdd,
												a.ssize||'/'||a.unitcode
										from m_input_detail a,
											  m_price_month b
										where b.dept_code = a.dept_code
											and b.yymmdd   = a.yymmdd
											and b.seq      = a.seq
											and b.input_unq_num = a.input_unq_num
											and b.dept_code = arg_dept_code
											and to_char(b.month,'yyyymm')||'01' = arg_yyyymm
											and a.ditag = '3'
											and a.inouttypecode = '9' );
										
		/*자금청구 안전관리비 집계 */
		INSERT INTO E_SAFTY_COST_TOTAL (DEPT_CODE, 
				 								  YYMM, 
												  UNQ_NUM, 
											     ITEM_CODE, 
												  BIZ, 
												  USEMEMO, 
											     AMT, 
												  VAT, 
												  USE_DATE, 
											     REMARK) 
						           ( select dept_code,
									       	  rqst_date,
												  e_sc_unq_seq.nextval,
												  item_code,
												  '4',
												  rqst_detail,
												  amt,
												  vat,
												  receipt_date,
												  cust_name
									  	   from f_request
									 	  where dept_code = arg_dept_code
									       and to_char(rqst_date,'yyyymm')||'01' = arg_yyyymm
											 and res_type = 'S');

		  		
EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
			 --RAISE_APPLICATION_ERROR(-20021, v_high_detail_code_prev||'/'||rec_y_stand_parent.high_detail_code);
END SP_E_MONTHLY_SUMMARY;
/
