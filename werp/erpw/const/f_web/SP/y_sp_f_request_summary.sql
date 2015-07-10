/* ============================================================================= */
/* 함수명 : y_sp_f_request_summary                                               */
/* 기  능 : 각 단위시스템의 투입내역을 집계하여 자금청구내역으로 넣어준다.       */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 일자                   ==> ad_date      (date)                       */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2006.04.05                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_request_summary(as_dept_code  IN   VARCHAR2,
                                                      ad_date    IN   DATE ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR MAIN_CUR IS
select 'S',c.businessman_number,
		c.sbcr_name,b.sbc_name || ' ' || to_char(a.yymm,'YYYY.MM') || '월 기성',a.tm_netpay_amt - a.tm_vat,a.tm_vat,a.pay_dt,a.slipdate,a.invoice_num,0,0,'1'
from s_pay a,
     s_cn_list b,
	  s_sbcr c
where a.dept_code = b.dept_code
  and a.order_number = b.order_number
  and b.sbcr_code = c.sbcr_code
  and a.dept_code = as_dept_code
  and trunc(a.yymm,'MM') = trunc(ad_date,'MM')
union all
select 'S',c.businessman_number,
		c.sbcr_name,b.sbc_name || ' ' || to_char(a.accept_dt,'YYYY.MM') || '월 선급금지불',a.guarantee_amt,a.guarantee_vat,a.accept_dt,a.accept_dt,a.invoice_num,0,0,'1'
from s_guarantee_accept a,
     s_cn_list b,
	  s_sbcr c
where a.dept_code = b.dept_code
  and a.order_number = b.order_number
  and b.sbcr_code = c.sbcr_code
  and a.dept_code = as_dept_code
  and trunc(a.accept_dt,'MM') = trunc(ad_date,'MM')
  and guarantee_class = '2'
union all
select 'M',c.businessman_number,
		c.sbcr_name,a.cont,a.amt,a.vatamount,a.yyyymmdd,a.work_dt,a.invoice_num,0,0,'1'
from m_vat a,
	  s_sbcr c
where a.sbcr_code = c.sbcr_code
  and a.dept_code = as_dept_code
  and trunc(a.work_dt,'MM') = trunc(ad_date,'MM')
union all
select 'L','','',to_char(max(a.work_date),'YYYY.MM') || '월 노무비',nvl(sum(a.pay_amt),0),0,null,null,'',nvl(sum(a.income_tax),0),nvl(sum(civil_tax),0),'1'
from l_labor_dailywork a
where a.dept_code = as_dept_code
  and trunc(a.work_date,'MM') = trunc(ad_date,'MM')
  and a.civil_register_number in (select civil_register_number
												from l_labor_basic
										 	  where dept_code = as_dept_code
												 and salery_bank_num is null)
union all
select 'L','','',to_char(max(a.work_date),'YYYY.MM') || '월 노무비',nvl(sum(a.pay_amt),0),0,null,null,'',nvl(sum(a.income_tax),0),nvl(sum(civil_tax),0),'3'
from l_labor_dailywork a
where a.dept_code = as_dept_code
  and trunc(a.work_date,'MM') = trunc(ad_date,'MM')
  and a.civil_register_number not in (select civil_register_number
												from l_labor_basic
										 	  where dept_code = as_dept_code
												 and salery_bank_num is null)
union all
select 'E',a.regist_no,
		b.eqp_vender_name,to_char(a.yymm,'YYYY.MM') || '월 장비비',a.monthly_amt,a.vat,a.yymm,a.yymm,a.invoice_num,0,0,'1'
from q_monthly_payment a,
	  q_code_eqp_vender b
where a.regist_no = b.regist_no
  and a.dept_code = as_dept_code
  and trunc(a.yymm,'MM') = trunc(ad_date,'MM');

-- 공통 변수 
   v_res_class         VARCHAR2(1);
   v_cust_code         VARCHAR2(20);
   v_cust_name         VARCHAR2(30);
   v_rqst_detail       VARCHAR2(100);
   v_amt               NUMBER(20,0);
   v_vat               NUMBER(20,0);
   v_receipt_date      DATE;
   v_work_date         DATE;
   v_invoice_num       VARCHAR2(50);
	v_income_amt        NUMBER(20,0);
	v_civi_amt          NUMBER(20,0);
   v_exe_type          VARCHAR2(1);
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_CNT           NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;
	C_L_CHK         VARCHAR2(1);

BEGIN
   BEGIN
		delete from f_joint_distribution
			where dept_code = as_dept_code
			  and to_char(rqst_date,'YYYYMMDD') || seq in ( select to_char(rqst_date,'YYYYMMDD') || seq
                                                           from f_request
																		 	 where dept_code = as_dept_code
																				and trunc(rqst_date,'MM') = trunc(ad_date,'MM')
																				and res_class in ('M','L','E','S'));

		delete from f_request
			where dept_code = as_dept_code
			  and trunc(rqst_date,'MM') = trunc(ad_date,'MM')
			  and res_class in ('M','E','S');

		select NVL(COUNT(*),0)
		  into C_CNT
		  from f_request
		 where dept_code = as_dept_code
		   and trunc(rqst_date,'MM') = trunc(ad_date,'MM')
			and res_class = 'L'
			and invoice_num is not null;

		IF C_CNT = 0 THEN
			delete from f_request
				where dept_code = as_dept_code
				  and trunc(rqst_date,'MM') = trunc(ad_date,'MM')
				  and res_class = 'L';
		END IF;

		OPEN	MAIN_CUR;
		LOOP
			FETCH MAIN_CUR INTO v_res_class,v_cust_code,v_cust_name,v_rqst_detail,v_amt,v_vat,v_receipt_date,v_work_date,v_invoice_num,v_income_amt,v_civi_amt,v_exe_type;
			EXIT WHEN MAIN_CUR%NOTFOUND;
			IF V_RES_CLASS = 'L' THEN
				IF C_CNT = 0 AND v_amt > 0 THEN
					select nvl(max(seq),0) + 1
					  into C_SEQ
					  from f_request
					 where dept_code = as_dept_code
						and rqst_date = ad_date;			
		
					 INSERT INTO F_REQUEST          
					 VALUES ( as_dept_code,ad_date,C_SEQ,'1',v_exe_type,v_rqst_detail,v_cust_code,v_cust_name,'','',v_amt,v_vat,
								 v_receipt_date,'','',0,0,'3',0,'','1','2',v_work_date,0,null,'',0,0,0,'','','',v_res_class,v_invoice_num,'1','1',v_income_amt,v_civi_amt,'F' )  ;    
				END IF;
			ELSE
				select nvl(max(seq),0) + 1
				  into C_SEQ
				  from f_request
				 where dept_code = as_dept_code
					and rqst_date = ad_date;			
	
				 INSERT INTO F_REQUEST          
				 VALUES ( as_dept_code,ad_date,C_SEQ,'1','3',v_rqst_detail,v_cust_code,v_cust_name,'','',v_amt,v_vat,
							 v_receipt_date,'','',0,0,'3',0,'','1','2',v_work_date,0,null,'',0,0,0,'','','',v_res_class,v_invoice_num,'1','',0,0,'F' )  ;    
			END IF; 

		END LOOP;
		CLOSE MAIN_CUR;

--		EXCEPTION
--		WHEN others THEN 
--			  IF SQL%NOTFOUND THEN                   -- 메세지는 외주,자재,노무,장비에서 처리함
--				  Wk_errflag := -20020;
--				   e_msg      := '자금청구 자재비 집계작업 실패! [Line No: 626]';
			
--				  GOTO EXIT_ROUTINE;
--			  END IF;   
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
END y_sp_f_request_summary;

/
