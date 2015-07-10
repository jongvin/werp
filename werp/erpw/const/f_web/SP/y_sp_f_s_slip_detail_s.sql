CREATE OR REPLACE PROCEDURE y_sp_f_s_slip_detail_s(as_nodecode     IN   VARCHAR2,
                                        			as_company      IN   VARCHAR2,
                                        			as_dept_code    IN   VARCHAR2,
                                        			as_costkind     IN   VARCHAR2,
                                        			as_dept_name    IN   VARCHAR2,
                                        			adt_from_date   IN   DATE,
																adt_to_date     IN   DATE,
																adt_slip_date   IN   DATE,
															   as_process      IN   VARCHAR2, 
																as_slip_name    IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 외주비와 노무비는 별도처리를 한다.
CURSOR DETAIL_CUR IS
  SELECT a.RES_TYPE,   
	      a.amt, 
	      a.notax_amt, 
	      a.vat, 
			a.v_desc, 
         a.tm_advance_deduction, 
			a.businessman_number, 
     		a.sbcr_name,  
     		a.representative_name1, 
     		a.kind_bussinesstype,  
     		a.kinditem,  
			a.main_bank,  
			a.acc_number,  
     		a.tel_number, 
     		a.fax_number, 
     		a.zip_number1, 
     		a.address1,  
			a.RECEIPT_DATE 
	FROM  ( SELECT  'S1' RES_TYPE,   
	                a.tm_prgs  		amt, 
	                a.tm_prgs_notax  notax_amt, 
	                a.tm_vat   		vat, 
	                a.tm_advance_deduction, 
						 to_char(a.yymm, 'yyyy.mm')  || '월 ' || b.sbc_name || ' 외주비'   v_desc, 
						 c.businessman_number, 
     					 c.sbcr_name,  
     					 c.representative_name1, 
     					 c.kind_bussinesstype,  
     					 c.kinditem,  
     					 c.main_bank,  
     					 c.acc_number,  
     					 c.tel_number, 
     					 c.fax_number, 
     					 c.zip_number1, 
     					 c.address1,  
						 adt_to_date  RECEIPT_DATE  
  				 from s_pay      a, 
    				   s_cn_list  b,    
        				s_sbcr     c 
   			where a.dept_code    = b.dept_code 
   			  and a.order_number = b.order_number 
   			  and b.sbcr_code    = c.sbcr_code 
   			  and a.tm_prgs      <> 0  
				  and (as_process = 'S'  or  as_process = 'A')  
   			  and a.dept_code    = as_dept_code 
   			  and a.yymm between adt_from_date and adt_to_date 
			union all 
			SELECT  'S2' RES_TYPE,   
	                a.tm_prgs  		amt, 
	                a.tm_prgs_notax  notax_amt, 
	                a.tm_vat   		vat, 
	                a.tm_advance_deduction, 
						 to_char(a.yymm, 'yyyy.mm')  || '월 ' || b.sbc_name || ' 외주비'   v_desc, 
						 c.businessman_number, 
     					 c.sbcr_name,  
     					 c.representative_name1, 
     					 c.kind_bussinesstype,  
     					 c.kinditem,  
     					 c.main_bank,  
     					 c.acc_number,  
     					 c.tel_number, 
     					 c.fax_number, 
     					 c.zip_number1, 
     					 c.address1,  
						 adt_to_date  RECEIPT_DATE  
  				 from s_pay      a, 
    				   s_cn_list  b,    
        				s_sbcr     c 
   			where a.dept_code    = b.dept_code 
   			  and a.order_number = b.order_number 
   			  and b.sbcr_code    = c.sbcr_code 
   			  and a.tm_prgs_notax <> 0 
				  and (as_process = 'S'  or  as_process = 'A')  
   			  and a.dept_code    = as_dept_code 
   			  and a.yymm between adt_from_date and adt_to_date 
	) a
ORDER BY a.RES_TYPE asc,  a.businessman_number asc;
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error 
   v_res_type         VARCHAR2(2);
   v_r_amt            NUMBER(15,0);
   v_r_vat            NUMBER(15,0);
   v_amt              NUMBER(15,0);
   v_seq              NUMBER(15,0);
   v_notax_amt        NUMBER(15,0);
   v_advance_deduction   NUMBER(15,0);
   v_vat              NUMBER(15,0);
   v_acntcode         VARCHAR2(10);
   v_c_acnt_01        VARCHAR2(10);      -- 외상매입금
   v_c_acnt_02        VARCHAR2(10);      -- 선급공사비
   v_c_acnt_03        VARCHAR2(10);      -- 부가세대급금
   v_c_acnt_04        VARCHAR2(10);      -- 공사미지급금
   v_desc     			 f_request.rqst_detail%TYPE;
   v_cust_code        VARCHAR2(10);   
   v_cust_no          NUMBER(10, 0)  DEFAULT 0;
   v_s_idno           VARCHAR2(20);   
   v_cust_name        VARCHAR2(50);
   v_rep_name         VARCHAR2(50);
   v_kindtype         VARCHAR2(50);
   v_kinditem         VARCHAR2(50);
   v_main_bank        VARCHAR2(10);
   v_acc_number       VARCHAR2(50);
   v_tel		          VARCHAR2(20);
   v_fax		          VARCHAR2(20);
   v_zip			       VARCHAR2(10);
   v_add		          VARCHAR2(100);
   v_vatcode          VARCHAR2(10);
   v_vatname          VARCHAR2(100);
   v_receipt_date     f_request.receipt_date%TYPE;
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_CHK           VARCHAR2(1);
   C_BUL           VARCHAR2(1);
   C_CNT           NUMBER(10,3);
   C_AMT           NUMBER(15,0);
   C_VAT           NUMBER(15,0);
   C_TAX_RATE      NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;
 
BEGIN
   BEGIN
		select tax_rate 
		  into C_TAX_RATE  
		  from z_code_dept 
		 where dept_code = as_dept_code ;
		-- 외주공사비
		select substr(child_name, 1, 5)  
		  into v_c_acnt_01  
		  from z_code_etc_child 
		 where class_tag = '98' || as_costkind
		   and etc_code  = 'S' ; 
		-- 선급공사비
		select substr(child_name, 1, 5)  
		  into v_c_acnt_02  
		  from z_code_etc_child 
		 where class_tag = '98' || as_costkind
		   and etc_code  = '11' ; 
		-- 부가세대급금
		select substr(child_name, 1, 5)  
		  into v_c_acnt_03  
		  from z_code_etc_child 
		 where class_tag = '98' || as_costkind
		   and etc_code  = '31' ;
		-- 공사미지급금
		select substr(child_name, 1, 5)  
		  into v_c_acnt_04  
		  from z_code_etc_child 
		 where class_tag = '98' || as_costkind
		   and etc_code  = '12' ;
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_res_type,  v_amt,       v_notax_amt,    v_vat,  v_desc,   v_advance_deduction,   
			                      v_s_idno, v_cust_name, v_rep_name,  v_kindtype, v_kinditem,    
			                      v_main_bank,   v_acc_number, v_tel,       v_fax,       v_zip, 
										 v_add,    	 v_receipt_date ;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			select max(data_no)
			  into C_SEQ
			  from dzais.autodocu 
	   	 where data_gubun = '51' 
            and write_date = adt_slip_date 
            and c_code     = as_company ; 
			if C_SEQ is null then
				C_SEQ := 0;
			END IF;
			C_SEQ := C_SEQ + 1;
			v_cust_code := null;
			IF v_s_idno is not null THEN
				select count(*), MAX(cust_code)  
              into C_CNT,    v_cust_code   
				  from base.trade 
		   	 where c_code = as_company 
               and s_idno = v_s_idno;
				if C_CNT is null then
					C_CNT := 0;
				END IF;
				IF C_CNT < 1 THEN
					select to_number(MAX(cust_code))  
	              into v_cust_no    
					  from base.trade 
			   	 where c_code = as_company    
	               and cust_code < '090000' ;
	            if v_cust_no is null then
	            	v_cust_no := 100 ; 
	            end if;
	            v_cust_no := v_cust_no + 1;
	            v_cust_code := substr(to_char(v_cust_no, '000000'),2,6);
					e_msg      := '거래처 생성 실패! [Line No: -1]' || v_s_idno;
					insert into base.trade 
					          (c_code, cust_code, cust_name, cust_sort, cust_type, s_idno, dname, 
					          tel_no, fax_no, s_address, uptae, jong, chan_amt, fg_use, dc_rmk, 
					          bank_code, deposit_no, md_gubun, mm_rcp, dd_rcp, liquor) 
					   values (as_company, v_cust_code, v_cust_name, v_cust_name, '1', v_s_idno, v_rep_name, 
					           v_tel,  v_fax,  v_add, v_kindtype, v_kinditem, 0, 0,      0, 
					           v_main_bank, v_acc_number, 'Y',     0,      0,      '0' ) ;
				END IF; 
			END IF;	
			
			
			
/* ------------------------------------------------------------------------------------------------------- */				
/*  1. 외주비 : 과세기성 : (과세=== 부가세 코드:21, 계정코드:63800 외주공사비) 									  */
/*   	          면세기성 : (면세=== 부가세 코드:23, 계정코드:63800 외주공사비) 									  */
/* ------------------------------------------------------------------------------------------------------- */			
			IF v_res_type =  'S1' THEN         -- 과세분
				v_r_amt := v_amt;
				v_r_vat := v_vat;
				v_vatcode := '21';
			ELSE IF v_res_type =  'S2' THEN    -- 면세분            
				v_r_amt := v_notax_amt;
				v_r_vat := 0;
				v_vatcode := '23';
			ELSE    
				v_r_amt := 0;
				v_r_vat := 0;
				v_vatcode  := null;
				v_acntcode := '';
			END IF;
			v_seq := 0;
			if v_vatcode = '21' then
				C_AMT := v_r_amt;
				C_VAT := v_r_vat;
			else if v_vatcode = '23' then
				C_AMT := v_r_amt;
				C_VAT := 0;
			else
				C_AMT := v_r_amt;
				C_VAT := 0;
			end if;
			
			
			-- 선급전표
			if v_res_type = 'S1' then
				if (v_amt + v_vat) < v_advance_deduction then
					v_advance_deduction := v_amt + v_vat;
				end if;
			else if v_advance_deduction > (v_amt + v_vat) then
						v_advance_deduction := v_advance_deduction - v_amt - v_vat;
			else
				v_advance_deduction := 0;
			end if;
			
			if v_advance_deduction <> 0 then
				v_seq      := v_seq + 1;
				v_acntcode := v_c_acnt_02;
				e_msg      := '가전표 생성 실패! 외주 [Line No: 1]' || C_SEQ;
				insert into dzais.autodocu 
			           (data_gubun, write_date,    data_no, data_line, data_slip, dept_code,    node_code, c_code, 
			            docu_stat, docu_type, docu_gubun, amt_gubun, dr_amt, cr_amt, acct_code, 
			            check_code1,  checkd_code1,  checkd_name1, 
			            check_code2,  checkd_code2,  checkd_name2, 
			            check_code3,  checkd_code3,  checkd_name3, 
			            check_code10, checkd_code10, checkd_name10, 
			            insert_id, insert_date) 
			    values ('51',   to_char(adt_slip_date,'yyyymmdd'), C_SEQ,   v_seq,  '1',    as_dept_code, as_nodecode,  as_company,                      
                     '0',       '11',      '3',        '3',       C_AMT,  0,      v_acntcode, 
                     'A07',        v_cust_code,   v_cust_name, 
	                  'A09',        as_dept_code,  as_dept_name, 
                     'A13',        as_dept_code,  as_dept_name, 
                     'A05',        '',            v_desc,  
                     as_slip_name, to_char(sysdate, 'yyyymmdd'));	
            
            insert into dzais.autodocu 
				           (data_gubun, write_date,    data_no, data_line, data_slip, dept_code,    node_code, c_code, 
				            docu_stat, docu_type, docu_gubun, amt_gubun, dr_amt, cr_amt, acct_code, 
				            check_code1,  checkd_code1,  checkd_name1, 
				            check_code2,  checkd_code2,  checkd_name2, 
			          		check_code3,  checkd_code3,  checkd_name3, 
				            check_code10, checkd_code10, checkd_name10, 
				            insert_id, insert_date) 
				    values ('51',   to_char(adt_slip_date,'yyyymmdd'), C_SEQ,   v_seq,  '1',   as_dept_code, as_nodecode,   as_company,                      
                        '0',       '11',      '3',        '4',       0,      v_advance_deduction,   v_acntcode,
	                     'A07',        v_cust_code,   v_cust_name, 
	                     'A09',        as_dept_code,  as_dept_name, 
	                     'A13',        as_dept_code,  as_dept_name, 
	                     'A05',        '',            v_desc,  
	                     as_slip_name, to_char(sysdate, 'yyyymmdd'));
			end if;
			
			
			-- 외주비
			v_seq      := v_seq + 1;
			v_acntcode := v_c_acnt_01;
		   e_msg      := '가전표 생성 실패! 외주 [Line No: 1]' || C_SEQ;
			insert into dzais.autodocu 
			           (data_gubun, write_date,    data_no, data_line, data_slip, dept_code,    node_code, c_code, 
			            docu_stat, docu_type, docu_gubun, amt_gubun, dr_amt, cr_amt, acct_code, 
			            check_code1,  checkd_code1,  checkd_name1, 
			            check_code2,  checkd_code2,  checkd_name2, 
			            check_code3,  checkd_code3,  checkd_name3, 
			            check_code10, checkd_code10, checkd_name10, 
			            insert_id, insert_date) 
			    values ('51',   to_char(adt_slip_date,'yyyymmdd'), C_SEQ,   v_seq,  '1',    as_dept_code, as_nodecode,  as_company,                      
                     '0',       '11',      '3',        '3',       C_AMT,  0,      v_acntcode, 
                     'A07',        v_cust_code,   v_cust_name, 
	                  'A09',        as_dept_code,  as_dept_name, 
                     'A13',        as_dept_code,  as_dept_name, 
                     'A05',        '',            v_desc,  
                     as_slip_name, to_char(sysdate, 'yyyymmdd'));			    
			if v_vatcode IS not null then
				select vatname 
				  into v_vatname 
				  from z_code_vat_view 
				 where vatcode = v_vatcode ; 
				-- 부가세 대급금
				v_acntcode := v_c_acnt_03;
				v_seq := v_seq + 1;
			   e_msg      := '가전표 생성 실패! 외주 부가세대급금[Line No: 1]' || C_SEQ;
				insert into dzais.autodocu 
				           (data_gubun, write_date,    data_no, data_line, data_slip, dept_code,    node_code, c_code, 
				            docu_stat, docu_type, docu_gubun, amt_gubun, dr_amt, cr_amt, acct_code, 
				            check_code1,  checkd_code1,  checkd_name1,
				            check_code2,  checkd_code2,  checkd_name2,
				            check_code3,  checkd_code3,  checkd_name3,
				            check_code4,  checkd_code4,  checkd_name4,
				            check_code5,  checkd_code5,  checkd_name5,
			          		check_code6,  checkd_code6,  checkd_name6,
				            check_code10, checkd_code10, checkd_name10, 
				            insert_id, insert_date) 
				    values ('51',    to_char(adt_slip_date,'yyyymmdd'), C_SEQ,   v_seq,   '1',  as_dept_code, as_nodecode,  as_company,                      
                        '0',       '11',      '3',        '3',       C_VAT,  0,      v_acntcode, 
	                     'A07',        v_cust_code,   v_cust_name, 
	                     'A09',        as_dept_code,  as_dept_name, 
	                     'A13',        as_dept_code,  as_dept_name, 
	                     'T01',        v_vatcode,     v_vatname,
	                     'F19',        '',            to_char(adt_slip_date, 'YYYYMMDD'),
	                     'T03',        '',            C_AMT,
	                     'A05',        '',            v_desc,  
	                     as_slip_name, to_char(sysdate, 'yyyymmdd'));			    
				if v_vatcode = '24' then
					C_BUL := '5';
				else
					C_BUL := NULL;
				end if;
			   e_msg      := '가전표 생성 실패! 외주 taxrela '  || C_SEQ;
				insert into dzais.taxrela  
				           (data_gubun, write_date,    data_no, data_line, data_slip, dept_code,    node_code, c_code, 
				            bal_date, ven_type, tax_gu,  gong_amt, tax_vat, ven_code, s_idno, gong_amt2, 
                        bul_gubun, msum_yn, exch_rate, exch_amt) 
				    values ('51',       to_char(adt_slip_date,'yyyymmdd'), C_SEQ,   v_seq,  '1', as_dept_code, as_nodecode, as_company,                      
                        to_char(adt_slip_date,'yyyymmdd'), '0', v_vatcode, v_r_amt, v_r_vat, v_cust_code, v_s_idno, 0,  
                        C_BUL,     '1',     0,         0) ;                         
	      end if;  
			
			v_acntcode := v_c_acnt_04;    -- 공사미지급금
			e_msg      := '가전표 생성 실패! 외주 taxrela '  || C_SEQ;
			v_seq      := v_seq + 1;
			insert into dzais.autodocu 
			           (data_gubun, write_date,    data_no, data_line, data_slip, dept_code,    node_code, c_code, 
			            docu_stat, docu_type, docu_gubun, amt_gubun, dr_amt, cr_amt, acct_code, 
			            check_code1,  checkd_code1,  checkd_name1, 
			            check_code2,  checkd_code2,  checkd_name2, 
		          	   check_code3,  checkd_code3,  checkd_name3, 
			            check_code10, checkd_code10, checkd_name10, 
			            insert_id, insert_date) 
			    values ('51',    to_char(adt_slip_date,'yyyymmdd'), C_SEQ,   v_seq,  '1', as_dept_code, as_nodecode,  as_company,                      
                     '0',       '11',      '3',        '4',       0,      C_AMT,   v_acntcode,
                     'A07',        v_cust_code,   v_cust_name, 
                     'A09',        as_dept_code,  as_dept_name, 
                     'A13',        as_dept_code,  as_dept_name, 
                     'A05',        '',            v_desc,  
                     as_slip_name, to_char(sysdate, 'yyyymmdd'));			    
			
		END LOOP;
		CLOSE DETAIL_CUR;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;   
   END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   -- ENDING...[0.1] CURSOR CLOSE 재 확인 처리 !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- 사용자 정의 Error Message
      Wk_errflag := 0;                         -- 사용자 정의 Error Code
   ELSE 
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;
EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END y_sp_f_s_slip_detail_s;
/