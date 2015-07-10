/* ============================================================================= */
/* 함수명 : y_sp_c_invest_process                                                */
/* 기  능 : 미이체원가내역을 집계하여 투입테이블에 넣어줌.			               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 년월                   ==> ad_date      (date)                       */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 권미생                                                               */
/* 작성일 : 2005.05.27                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_invest_process(as_dept_code  IN   VARCHAR2,
                                                  ad_date    IN   DATE ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   v_acntcode      	  c_invest_detail.acntcode%TYPE;
   v_amt          	  c_invest_detail.amt%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_AMT           NUMBER(15,0);
   C_CNT           NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN
      delete from C_INVEST_DETAIL_COPY
		  	   WHERE DEPT_CODE = as_dept_code
				  AND yymm    	 = ad_date  ;
  -- 기존 데이타 보조파일로 복사
      insert into C_INVEST_DETAIL_COPY 
                  select * from C_INVEST_DETAIL
		  	   WHERE DEPT_CODE = as_dept_code
				  AND yymm    	 = ad_date  ;

		DELETE FROM C_INVEST_DETAIL  
		  	   WHERE DEPT_CODE = as_dept_code
				  AND yymm    	 = ad_date  ;

		DELETE FROM C_INVEST_VAT                      
		  	   WHERE DEPT_CODE = as_dept_code
				  AND GL_DATE    	 = ad_date  ;

		DELETE FROM C_INVEST_PARENT  
		  	   WHERE DEPT_CODE = as_dept_code
				  AND yymm      = ad_date  ;
   -- fi의 미이체 원가분 집계 
		INSERT INTO C_INVEST_PARENT  
		  SELECT as_dept_code,ad_date,max(acct_code),max(acct_desc),nvl(sum(accounted_net),0),'N'  
			 FROM efin_cost_accounts_v  
		   WHERE dept_code   = as_dept_code
 		     AND to_char(gl_date,'yyyy.mm') || '.01' = ad_date
 		     and acct_code <> '743411' 
 		  group by acct_code;
   -- 공사관리에서 매입부가세 가져오기 
   -- (외주기성: 매입부가세)
		INSERT INTO C_INVEST_VAT
						  SELECT a.dept_code,
						         ad_date,
						         c_invest_spec_unq_seq.nextval,
						         'V0000010',
						         '매입부가세',
						         '(외주기성)' || b.sbc_name,
						         a.tm_vat            --   - a.tm_pre_vat 
							  from s_pay a,
									 s_cn_list b
							 where a.dept_code      = b.dept_code
							   and a.order_number   = b.order_number
							   and b.vatcode = '3' 
								and a.dept_code      = as_dept_code
								and a.yymm = ad_date;
-- 자재비 자료 집계 (입고조건:매입세 )       
		INSERT INTO C_INVEST_VAT
						  SELECT b.dept_code,
						         ad_date,
						         c_invest_spec_unq_seq.nextval,
						         'V0000010',
						         '매입부가세',
						         '(자재입고)' || b.name || b.ssize ,
                           b.vatamt
							  from m_input_detail b
							 where b.dept_code    = as_dept_code
							   and b.yymmdd >= ad_date
							   and b.yymmdd < add_months(ad_date,1)
								and b.inouttypecode in ('1' ,'8')
								and b.ditag in ('5','6','8')   -- 소모품/지급임차료/견본비
								and b.vattag = '3'; 

-- 자재비 자료 집계 (출고조건:매입세)       
		INSERT INTO C_INVEST_VAT
						  SELECT b.dept_code,
						         ad_date,
						         c_invest_spec_unq_seq.nextval,
						         'V0000010',
						         '매입부가세',
						         '(자재출고)' || b.name || b.ssize ,
                           round(b.amt * 0.1,0)
							  from m_output_detail b,
							       m_input_detail a
							 where b.dept_code    = as_dept_code
							   and b.yymmdd >= ad_date
							   and b.yymmdd < add_months(ad_date,1)
								and b.INOUTTYPECODE = '2' 
								and b.ditag = '1'
								and b.dept_code = a.dept_code
								and b.input_unq_num = a.input_unq_num
								and a.inouttypecode in ('1' ,'8')
								and a.vattag = '3';    
-- 자재비 손료  집계  (매입세)      
		INSERT INTO C_INVEST_VAT
						  SELECT b.dept_code,
						         ad_date,
						         c_invest_spec_unq_seq.nextval,
						         'V0000010',
						         '매입부가세',
						         '(자재손료)' || c.name || c.ssize ,
						         CASE WHEN a.vattag = '3' AND a.inouttypecode IN ('1','8') THEN  -- 불공제 이고 입고나 현장구매일경우 vat제외
						         b.amt - round(b.amt / 1.1,0) else 0 end
							  from m_tmat_proj_rent b,
							       m_tmat_stock c,
							       m_input_detail a
							 where b.dept_code    = as_dept_code
							   and b.month= ad_date
								and b.dept_code = c.dept_code
                        and b.yymmdd = c.yymmdd
                        and b.seq = c.seq
                        and b.input_unq_num = c.input_unq_num
								and c.dept_code = a.dept_code
								and c.input_unq_num = a.input_unq_num
								and a.inouttypecode in ('1' ,'8')
								and a.vattag = '3' ;   
								
  -- 예비비청구(매입부가세)								
		INSERT INTO C_INVEST_VAT
						  SELECT a.dept_code,
						         ad_date,
						         c_invest_spec_unq_seq.nextval,
						         'V0000010',
						         '매입부가세',
						         '(예비비)' || a.cont,
						         nvl(a.vat  * decode(a.cr_class,'1',1,-1),0)
							  from f_request a,
                            efin_tax_codes_v b,
                            z_code_dept c
							 where a.dept_code    = as_dept_code 
							   and a.rqst_date >= ad_date
							   and a.rqst_date < add_months(ad_date,1)
								and a.cost_type = '1'
								and a.spec_unq_num <> 0
                        and  a.dept_code = c.dept_code
                        and c.comp_code = b.org_code
                        and a.vatcode = b.tax_id
                        and b.account_code = '112421';
								
  -- 미지급(매입부가세)								
		INSERT INTO C_INVEST_VAT
						  SELECT a.dept_code,
						         ad_date,
						         c_invest_spec_unq_seq.nextval,
						         'V0000010',
						         '매입부가세',
						         '(미지급)' || a.cont,
						         nvl(a.vat,0)
							  from f_nopay_request a,
                            efin_tax_codes_v b,
                            z_code_dept c
							 where a.dept_code    = as_dept_code 
							   and a.request_date >= ad_date
							   and a.request_date < add_months(ad_date,1)
								and a.spec_unq_num <> 0
                        and  a.dept_code = c.dept_code
                        and c.comp_code = b.org_code
                        and a.vatcode = b.tax_id
                        and b.account_code = '112421';
								
  -- 공사관리의 매입부가세를 합계를 PARENT에 삽입 								
 		INSERT INTO C_INVEST_PARENT  
		  SELECT as_dept_code,ad_date,max(acct_code),max(acct_desc),nvl(sum(accounted_net),0),'N'  
			 FROM c_invest_vat  
		   WHERE dept_code   = as_dept_code
 		     AND to_char(gl_date,'yyyy.mm') || '.01' = ad_date
 		  group by acct_code;
   
		INSERT INTO C_INVEST_DETAIL 
		  SELECT * 
			 FROM C_INVEST_DETAIL_COPY C
            where exists (select C.dept_code,C.yymm,C.ACNTCODE
	                          from C_INVEST_PARENT b
   		         	       where b.dept_code 	=  c.dept_code 
   		         	         and b.yymm 			=  c.yymm 
   		         	         and b.ACNTCODE 	=  c.ACNTCODE 
   		         	         and b.dept_code 	=  as_dept_code 
   								   and b.yymm    		= ad_date);

      delete from C_INVEST_DETAIL_COPY
		  	   WHERE DEPT_CODE 	= as_dept_code
				  AND yymm    		= ad_date  ;

  y_sp_C_INVEST_PARENT(as_dept_code,ad_date);

		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '미이체원가투입 집계작업 실패! [Line No: 1]';
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
END y_sp_c_invest_process;
/
