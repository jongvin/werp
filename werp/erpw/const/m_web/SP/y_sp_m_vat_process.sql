/* ============================================================================= */
/* 함수명 : y_sp_m_vat_process                                                   */
/* 기  능 : 자재입고내역을 세금계산서발행테이블에 넣어준다.                      */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 년월                   ==> ad_date      (date)                       */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2005.03.17                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_vat_process(as_dept_code  IN   VARCHAR2,
                                                  ad_date    IN   DATE ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
select max(b.approym) approym,
		 max(b.approseq) approseq,
		 max(b.chg_cnt) chg_cnt,
		 sum(a.amt) amt,
		 sum(a.vatamt) vatamt,
		 max(a.sbcr_code) sbcr_code
from m_input_detail a,
     m_approval_detail b
where a.dept_code = b.dept_code
  and a.approval_unq_num = b.approval_unq_num
  and a.dept_code = as_dept_code
  and trunc(a.yymmdd,'MM') = trunc(ad_date,'MM')
  and a.approval_unq_num <> 0
  and a.vat_unq_num = 0
  and a.inouttypecode <> '3'
group by b.approym,b.approseq,b.chg_cnt,a.sbcr_code;

CURSOR DETAIL_CUR1 IS
select sum(a.amt) amt,
		 sum(a.vatamt) vatamt,
		 max(a.sbcr_code) sbcr_code
from m_input_detail a
where a.dept_code = as_dept_code
  and trunc(a.yymmdd,'MM') = trunc(ad_date,'MM')
  and a.approval_unq_num = 0
  and a.vat_unq_num = 0
  and a.inouttypecode = '8'
group by a.sbcr_code;

CURSOR DETAIL_CUR2 IS
select mtrcode,name,ssize,unitcode,qty,unitprice,amt,vatamt,input_unq_num
  from m_input_detail 
 where dept_code = as_dept_code
   and trunc(yymmdd,'MM') = trunc(ad_date,'MM')
   and ditag = '2'
   and tmat_unq_num = 0
   and inouttypecode <> '3';


-- 공통 변수 
   v_approym      	  m_approval.approym%TYPE;
   v_approseq       	  m_approval.approseq%TYPE;
   v_chg_cnt		  	  m_approval.chg_cnt%TYPE;
   v_qty 			 	  m_input_detail.qty%TYPE;
   v_amt 			 	  m_input_detail.amt%TYPE;
   v_vatamt         	  m_input_detail.vatamt%TYPE;
   v_sbcr_code      	  m_input_detail.sbcr_code%TYPE;
   v_input_unq_num  	  m_input_detail.input_unq_num%TYPE;
   v_mtrcode        	  m_input_detail.mtrcode%TYPE;
   v_name         	  m_input_detail.name%TYPE;
   v_ssize         	  m_input_detail.ssize%TYPE;
   v_unitcode       	  m_input_detail.unitcode%TYPE;
   v_unitprice      	  m_input_detail.unitprice%TYPE;

   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_TITLE		    m_approval.approtitle%TYPE;
   C_PAYMENTMETHOD m_approval.paymentmethod%TYPE;
   C_VAT_UNQ_NUM   m_vat.vat_unq_num%TYPE;
	C_LAST_DAY      DATE;
   C_RENTRATE	    m_code_material.rentrate%TYPE;
   C_YEARS		    m_code_material.years%TYPE;
   C_QTY           NUMBER(15,3);
   C_PRICE         NUMBER(15,0);
   C_AMT           NUMBER(15,0);
   C_CNT           NUMBER(10,3);
   C_AMT1          NUMBER(15,0);
   C_ORG_AMT       NUMBER(15,0);
   C_REMAIND_AMT   NUMBER(15,0);
   C_MONTH_AMT     NUMBER(15,0);
   C_SA_AMT        NUMBER(15,0);
   C_RAMT          NUMBER(15,0);
   C_YEAR_AMT      NUMBER(15,0);
   C_SEQ           INTEGER        DEFAULT 0;
   c_start_mm    	 INTEGER        DEFAULT 0;
   c_remaind_mm    INTEGER        DEFAULT 0;
   c_i   	       INTEGER        DEFAULT 0;
   c_j	          INTEGER        DEFAULT 0;
   c_tot_cnt       INTEGER        DEFAULT 0;
   c_year_cnt      INTEGER        DEFAULT 0;

BEGIN  
   BEGIN
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_approym,v_approseq,v_chg_cnt,v_amt,v_vatamt,v_sbcr_code;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			
			select approtitle,paymentmethod,last_day(ad_date),m_spec_unq_no.nextval
			  into C_TITLE,C_PAYMENTMETHOD,C_LAST_DAY,C_VAT_UNQ_NUM
			  from m_approval
			 where dept_code = as_dept_code
				and approym   = v_approym
				and approseq  = v_approseq
				and chg_cnt   = v_chg_cnt;

		
			INSERT INTO m_vat  
			VALUES ( as_dept_code,v_sbcr_code,C_VAT_UNQ_NUM,ad_date,'','',C_LAST_DAY,v_amt,v_vatamt,C_TITLE,'','',null,'',C_PAYMENTMETHOD,0,v_amt + v_vatamt,0 )  ;


			UPDATE M_INPUT_DETAIL  
			  SET VAT_UNQ_NUM = C_VAT_UNQ_NUM 
			WHERE dept_code = as_dept_code
			  and trunc(yymmdd,'MM') = trunc(ad_date,'MM')
			  and vat_unq_num = 0
			  and approval_unq_num in ( select b.approval_unq_num
													from m_approval a,
														  m_approval_detail b
												  where a.dept_code = b.dept_code (+)
													 and a.approym = b.approym (+)
													 and a.approseq = b.approseq (+)
													 and a.chg_cnt  = b.chg_cnt (+)
												 	 and a.dept_code = as_dept_code
													 and a.approym   = v_approym
													 and a.approseq  = v_approseq
													 and a.chg_cnt   = v_chg_cnt );
		END LOOP;
		CLOSE DETAIL_CUR;

		OPEN	DETAIL_CUR1;
		LOOP
			FETCH DETAIL_CUR1 INTO v_amt,v_vatamt,v_sbcr_code;
			EXIT WHEN DETAIL_CUR1%NOTFOUND;
			
			select last_day(ad_date),m_spec_unq_no.nextval
			  into C_LAST_DAY,C_VAT_UNQ_NUM
			  from dual;
	
			INSERT INTO m_vat  
			VALUES ( as_dept_code,v_sbcr_code,C_VAT_UNQ_NUM,ad_date,'','',C_LAST_DAY,v_amt,v_vatamt,'현장구매분','','',null,'','',0,v_amt + v_vatamt,0 )  ;


			UPDATE M_INPUT_DETAIL  
			  SET VAT_UNQ_NUM = C_VAT_UNQ_NUM 
			WHERE dept_code = as_dept_code
			  and trunc(yymmdd,'MM') = trunc(ad_date,'MM')
			  and vat_unq_num = 0
			  and approval_unq_num = 0
			  and inouttypecode = '8'
			  and sbcr_code = v_sbcr_code ;

		END LOOP;
		CLOSE DETAIL_CUR1;

		OPEN	DETAIL_CUR2;
		LOOP
			FETCH DETAIL_CUR2 INTO v_mtrcode,v_name,v_ssize,v_unitcode,v_qty,v_unitprice,v_amt,v_vatamt,v_input_unq_num;
			EXIT WHEN DETAIL_CUR2%NOTFOUND;
			
			select last_day(ad_date),m_spec_unq_no.nextval,rentrate,years,to_number(to_char(ad_date,'mm'))
			  into C_LAST_DAY,C_VAT_UNQ_NUM,C_RENTRATE,C_YEARS,c_start_mm
			  from m_code_material
			 where mtrcode = v_mtrcode;
	
			INSERT INTO m_tmat_master  
			VALUES ( C_VAT_UNQ_NUM,as_dept_code,v_input_unq_num,v_mtrcode,v_name,v_ssize,v_unitcode,C_RENTRATE,C_YEARS,C_LAST_DAY,v_qty,v_unitprice,v_amt,v_vatamt,sysdate,'')  ;

			UPDATE M_INPUT_DETAIL  
			  SET TMAT_UNQ_NUM = C_VAT_UNQ_NUM 
			WHERE dept_code = as_dept_code
			  and input_unq_num = v_input_unq_num ;

-- 가설재손료계산
			c_remaind_mm := 12 - c_start_mm + 1;
			c_year_cnt := 4;

			c_tot_cnt := 1;
			C_AMT1 := trunc(v_unitprice * 0.528 * ( c_remaind_mm / 12),0);
			C_ORG_AMT := v_unitprice;
			C_REMAIND_AMT := v_unitprice - C_AMT1;
			C_MONTH_AMT := trunc((C_AMT1 / c_remaind_mm),0);
			C_SA_AMT := 0;
			FOR c_i IN 1..c_year_cnt LOOP
				FOR c_j IN c_start_mm..12 LOOP
					IF c_j = 12 THEN
						C_MONTH_AMT := C_AMT1 - C_SA_AMT;
					END IF;

					INSERT INTO m_tmat_rent  
					VALUES ( C_VAT_UNQ_NUM,ADD_MONTHS(trunc(ad_date,'MM'),c_tot_cnt - 1), C_ORG_AMT,C_MONTH_AMT,C_ORG_AMT - C_MONTH_AMT) ;

					C_ORG_AMT := C_ORG_AMT - C_MONTH_AMT;
					C_SA_AMT := C_SA_AMT + C_MONTH_AMT;
					c_tot_cnt := c_tot_cnt + 1;

				END LOOP;
				c_start_mm := 1;
				IF c_i = 3 THEN
					C_AMT1 := trunc(C_REMAIND_AMT);
				ELSE
					C_AMT1 := trunc(C_REMAIND_AMT * 0.528,0);
				END IF;
				C_MONTH_AMT := trunc((C_AMT1 / 12),0);
				C_ORG_AMT := C_REMAIND_AMT;
				C_REMAIND_AMT := C_REMAIND_AMT - C_AMT1;
				C_SA_AMT := 0;
			END LOOP;
		END LOOP;
		CLOSE DETAIL_CUR2;

		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '입고전표 집계작업 실패! [Line No: 1]';
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
END y_sp_m_vat_process;

/
