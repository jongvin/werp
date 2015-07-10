/* ============================================================================= */
/* 함수명 : y_sp_f_request_trans                                                 */
/* 기  능 : 자금청구를 이월한다.                                                 */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 일자                   ==> ad_date      (date)                       */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.05.19                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_request_trans(as_dept_code  IN   VARCHAR2,
                                                    ad_date    IN   DATE ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
	C_DATE			 DATE;
   C_CODE			 VARCHAR2(13);
   C_NAME          VARCHAR2(50);
   C_CNT           NUMBER(10,3);
   C_AMT           NUMBER(20,3);
   C_REMAIND_AMT   NUMBER(20,3);
   C_REQUEST_AMT   NUMBER(20,3);
   C_REQUEST_MAT   NUMBER(20,3);
   C_REQUEST_LAB   NUMBER(20,3);
   C_REQUEST_EQU   NUMBER(20,3);
   C_REQUEST_SUB   NUMBER(20,3);
   C_REQUEST_EXP   NUMBER(20,3);
   C_PAYMENT_AMT   NUMBER(20,3);
   T_REMAIND_AMT   NUMBER(20,3);
   T_REQUEST_AMT   NUMBER(20,3);
   T_REQUEST_MAT   NUMBER(20,3);
   T_REQUEST_LAB   NUMBER(20,3);
   T_REQUEST_EQU   NUMBER(20,3);
   T_REQUEST_SUB   NUMBER(20,3);
   T_REQUEST_EXP   NUMBER(20,3);
   T_PAYMENT_AMT   NUMBER(20,3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN
		select count(*)
		  into C_CNT
		  from f_summary_amt
		 where dept_code = as_dept_code
			and to_char(yymm,'YYYY.MM') >= to_char(ad_date,'YYYY.MM');

		IF C_CNT > 0 THEN
			delete from f_summary_amt
  				   where dept_code = as_dept_code
					  and to_char(yymm,'YYYY.MM') >= to_char(ad_date,'YYYY.MM');
		END IF;

		select count(*)
		  into C_CNT
		  from f_summary_amt
		 where dept_code = as_dept_code
         and to_char(yymm,'YYYY.MM') = to_char(ad_date,'YYYY.MM');

  		IF C_CNT < 1 THEN
			select count(*)
			  into C_CNT
			  from f_request
			 where dept_code = as_dept_code
			   and to_char(rqst_date,'YYYY.MM') < to_char(ad_date,'YYYY.MM');
			IF C_CNT < 1 THEN
				select nvl(sum(cash_amt),0) + nvl(sum(bill_amt),0) + nvl(sum(check_amt),0) + nvl(sum(bank_amt),0) 
							+ nvl(sum(etc_amt),0)
				  into C_REMAIND_AMT
				  from f_receive_amt
				 where dept_code = as_dept_code
					and to_char(receive_date,'YYYY.MM') < to_char(ad_date,'YYYY.MM');

				insert into f_summary_amt
					VALUES ( as_dept_code,to_date(to_char(ad_date,'YYYY.MM') || '.01','YYYY.MM.DD'),nvl(C_REMAIND_AMT,0),0,0,0,0,0,0,0);
			ELSE
				begin
					select max(rqst_date)
					  into C_DATE
					  from f_request
					 where dept_code = as_dept_code
						and to_char(rqst_date,'YYYY.MM') < to_char(ad_date,'YYYY.MM');

					EXCEPTION
					WHEN others THEN 
						  IF SQL%NOTFOUND THEN
							  e_msg      := '날짜구하기 실패! [Line No: 1]';
							  Wk_errflag := -20020;
						
							  GOTO EXIT_ROUTINE;
						  END IF;   
				END;
				begin
					select nvl(sum(amt),0) + nvl(sum(vat),0)
					  into C_REQUEST_AMT
					  from f_request
					 where dept_code = as_dept_code
						and to_char(rqst_date,'YYYY.MM') = to_char(C_DATE,'YYYY.MM')
						and receipt_rqst_type = '2';

					select nvl(sum(amt),0) + nvl(sum(vat),0)
					  into C_REQUEST_MAT
					  from f_request
					 where dept_code = as_dept_code
						and to_char(rqst_date,'YYYY.MM') = to_char(C_DATE,'YYYY.MM')
						and receipt_rqst_type = '2'
						and res_type = 'M';

					select nvl(sum(amt),0) + nvl(sum(vat),0)
					  into C_REQUEST_LAB
					  from f_request
					 where dept_code = as_dept_code
						and to_char(rqst_date,'YYYY.MM') = to_char(C_DATE,'YYYY.MM')
						and receipt_rqst_type = '2'
						and res_type = 'L';

					select nvl(sum(amt),0) + nvl(sum(vat),0)
					  into C_REQUEST_EQU
					  from f_request
					 where dept_code = as_dept_code
						and to_char(rqst_date,'YYYY.MM') = to_char(C_DATE,'YYYY.MM')
						and receipt_rqst_type = '2'
						and res_type = 'E';

					select nvl(sum(amt),0) + nvl(sum(vat),0)
					  into C_REQUEST_SUB
					  from f_request
					 where dept_code = as_dept_code
						and to_char(rqst_date,'YYYY.MM') = to_char(C_DATE,'YYYY.MM')
						and receipt_rqst_type = '2'
						and res_type = 'S';

					select nvl(sum(amt),0) + nvl(sum(vat),0)
					  into C_REQUEST_EXP
					  from f_request
					 where dept_code = as_dept_code
						and to_char(rqst_date,'YYYY.MM') = to_char(C_DATE,'YYYY.MM')
						and receipt_rqst_type = '2'
						and res_type = 'X';


					EXCEPTION
					WHEN others THEN 
						  IF SQL%NOTFOUND THEN
							  e_msg      := '청구구하기 실패! [Line No: 2]';
							  Wk_errflag := -20020;
						
							  GOTO EXIT_ROUTINE;
						  END IF;   
				END;
				begin
					select nvl(sum(amt),0) + nvl(sum(vat),0)
					  into C_PAYMENT_AMT
					  from f_payment
					 where dept_code = as_dept_code
						and to_char(pay_date,'YYYY.MM') = to_char(C_DATE,'YYYY.MM');
	
					EXCEPTION
					WHEN others THEN 
						  IF SQL%NOTFOUND THEN
							  e_msg      := '정산구하기 실패! [Line No: 3]';
							  Wk_errflag := -20020;
						
							  GOTO EXIT_ROUTINE;
						  END IF;   
				END;
				begin
					select nvl(sum(cash_amt),0) + nvl(sum(bill_amt),0) + nvl(sum(check_amt),0) + nvl(sum(bank_amt),0) 
								+ nvl(sum(etc_amt),0)
					  into C_REMAIND_AMT
					  from f_receive_amt
					 where dept_code = as_dept_code
						and to_char(receive_date,'YYYY.MM') = to_char(C_DATE,'YYYY.MM');
	
					EXCEPTION
					WHEN others THEN 
						  IF SQL%NOTFOUND THEN
							  e_msg      := '입고금액구하기 실패! [Line No: 4]';
							  Wk_errflag := -20020;
						
							  GOTO EXIT_ROUTINE;
						  END IF;   
				END;
				begin
					select count(*)
					  into C_CNT
					  from f_summary_amt
					 where dept_code = as_dept_code
						and to_char(yymm,'YYYY.MM') = to_char(C_DATE,'YYYY.MM');
					IF C_CNT < 1 THEN
						T_REMAIND_AMT := 0;
						T_REQUEST_AMT := 0;
						T_PAYMENT_AMT := 0;
						T_REQUEST_MAT := 0;
						T_REQUEST_LAB := 0;
						T_REQUEST_EQU := 0;
						T_REQUEST_SUB := 0;
						T_REQUEST_EXP := 0;
					ELSE
						select nvl(remaind_amt,0),nvl(request_amt,0),nvl(payment_amt,0),nvl(request_mat,0),
								 nvl(request_lab,0),nvl(request_equ,0),nvl(request_sub,0),nvl(request_exp,0)
						  into T_REMAIND_AMT,T_REQUEST_AMT,T_PAYMENT_AMT,T_REQUEST_MAT,T_REQUEST_LAB,
								 T_REQUEST_EQU,T_REQUEST_SUB,T_REQUEST_EXP
						  from f_summary_amt
						 where dept_code = as_dept_code
							and to_char(yymm,'YYYY.MM') = to_char(C_DATE,'YYYY.MM');
					END IF;
	
					C_REMAIND_AMT := C_REMAIND_AMT - C_PAYMENT_AMT;
	
					EXCEPTION
					WHEN others THEN 
						  IF SQL%NOTFOUND THEN
							  e_msg      := '전월누계구하기 실패! [Line No: 5]';
							  Wk_errflag := -20020;
						
							  GOTO EXIT_ROUTINE;
						  END IF;   
				END;
				begin
					insert into f_summary_amt
						VALUES ( as_dept_code,to_date(to_char(ad_date,'YYYY.MM') || '.01','YYYY.MM.DD'),
									nvl(C_REMAIND_AMT + T_REMAIND_AMT,0),nvl(C_REQUEST_AMT + T_REQUEST_AMT,0),
									nvl(C_PAYMENT_AMT + T_PAYMENT_AMT,0),nvl(C_REQUEST_MAT + T_REQUEST_MAT,0),
									nvl(C_REQUEST_LAB + T_REQUEST_LAB,0),nvl(C_REQUEST_EQU + T_REQUEST_EQU,0),
									nvl(C_REQUEST_SUB + T_REQUEST_SUB,0),nvl(C_REQUEST_EXP + T_REQUEST_EXP,0));
					EXCEPTION
					WHEN others THEN 
						  IF SQL%NOTFOUND THEN
							  e_msg      := '입력 실패! [Line No: 6]';
							  Wk_errflag := -20020;
						
							  GOTO EXIT_ROUTINE;
						  END IF;   
				END;
			END IF;
		END IF;
		
		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '자금청구 집계작업 실패! [Line No: 2]';
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
END y_sp_f_request_trans;

/
