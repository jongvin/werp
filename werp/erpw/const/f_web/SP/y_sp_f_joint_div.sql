/* ============================================================================= */
/* 함수명 : y_sp_f_joint_div                                                     */
/* 기  능 : 자금청구의 내역을 공동도급사의 비율로 배분하여 입력한다.             */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 일자                   ==> ad_date      (date)                       */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.05.28                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_joint_div(as_dept_code  IN   VARCHAR2,
                                                ad_date    IN   DATE ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT rqst_date,seq,fund_type,amt,vat,cust_code
  FROM f_request 
 WHERE dept_code    = as_dept_code AND
       to_char(rqst_date,'YYYY.MM') = to_char(ad_date,'YYYY.MM')  AND
       fund_type <> '4';

CURSOR VENDER_CUR IS
select b.customer_no,b.company_tag,b.division_rate
  from r_contract_register a,
 		 r_contract_succesful_bid b
 where a.dept_code = b.dept_code (+)
   and a.cont_no   = b.cont_no (+)
	and a.chg_degree = b.chg_degree (+)
	and a.last_tag = 'Y'
   and a.dept_code = as_dept_code;

-- 공통 변수 
   v_rqst_date         f_request.rqst_date%TYPE;
   v_seq               f_request.seq%TYPE;
   v_fund_type         f_request.fund_type%TYPE;
   v_amt               f_request.amt%TYPE;
   v_vat               f_request.vat%TYPE;
   v_cust_code         f_request.cust_code%TYPE;
   v_customer_no       r_contract_succesful_bid.customer_no%TYPE;
   v_company_tag       r_contract_succesful_bid.company_tag%TYPE;
   v_division_rate     r_contract_succesful_bid.division_rate%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_CNT           NUMBER(10,3);
   T_CNT           NUMBER(10,3);
   C_AMT           NUMBER(13);
   C_VAT           NUMBER(13);
	C_TAG           VARCHAR2(1);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN
		select count(*)
		  into C_CNT
		  from r_contract_register a,
				 r_contract_succesful_bid b
		 where a.dept_code = b.dept_code 
			and a.cont_no   = b.cont_no 
			and a.chg_degree = b.chg_degree 
			and a.last_tag = 'Y'
			and a.dept_code = as_dept_code;

  		IF C_CNT < 1 THEN
		  Wk_errflag := -20020;
		  e_msg      := '공동도급현장이 아닙니다! [Line No: 2]';
		
		  GOTO EXIT_ROUTINE;
		END IF;   
		
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_rqst_date,v_seq,v_fund_type,v_amt,v_vat,v_cust_code;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			
			T_CNT := 1;
			OPEN	VENDER_CUR;
			LOOP
				FETCH VENDER_CUR INTO v_customer_no,v_company_tag,v_division_rate;
				EXIT WHEN VENDER_CUR%NOTFOUND;
				
				IF T_CNT = C_CNT THEN
					select sum(nvl(amt,0)),sum(nvl(vat,0))
					  into C_AMT,C_VAT
					  from f_joint_distribution
				    where dept_code = as_dept_code
						and rqst_date = v_rqst_date
						and seq       = v_seq;

					C_AMT := nvl(v_amt,0) - nvl(C_AMT,0);
					C_VAT := nvl(v_vat,0) - nvl(C_VAT,0);
				ELSE
					C_AMT := trunc(nvl(v_amt,0) * nvl(v_division_rate,0) / 100,0) ;
					C_VAT := trunc(nvl(v_vat,0) * nvl(v_division_rate,0) / 100,0) ;
				END IF;

				IF v_fund_type = '5' THEN
					IF v_cust_code = v_customer_no THEN
						C_TAG := 'Y';
					ELSe
						C_TAG := 'N';
					END IF;
				ELSE
					IF v_company_tag = 'Y' THEN
						C_TAG := 'Y';
					ELSE
						C_TAG := 'N';
					END IF;
				END IF;

				insert into f_joint_distribution
					VALUES ( as_dept_code,v_rqst_date,v_seq,v_customer_no,C_AMT,C_VAT,C_TAG );
				  
				T_CNT := T_CNT + 1;
			END LOOP;
			CLOSE VENDER_CUR;
		END LOOP;
		CLOSE DETAIL_CUR;

		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '공동도급 재분작업 실패! [Line No: 2]';
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
END y_sp_f_joint_div;

/
