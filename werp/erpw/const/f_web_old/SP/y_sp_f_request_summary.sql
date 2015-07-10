/* ============================================================================= */
/* 함수명 : y_sp_f_request_summary                                               */
/* 기  능 : 각 단위시스템의 투입내역을 집계하여 자금청구내역으로 넣어준다.       */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 일자                   ==> ad_date      (date)                       */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.05.19                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_request_summary(as_dept_code  IN   VARCHAR2,
                                                      ad_date    IN   DATE ,
																		as_l_tag   IN   VARCHAR2,
																		as_q_tag   IN   VARCHAR2,
																		as_s_tag   IN   VARCHAR2,
																		as_m_tag   IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR MDETAIL_CUR IS
SELECT rqst_date,seq
  FROM f_request 
 WHERE dept_code    = as_dept_code AND
       to_char(rqst_date,'YYYY.MM') = to_char(ad_date,'YYYY.MM') AND
       res_type = 'M';

CURSOR LDETAIL_CUR IS
SELECT rqst_date,seq
  FROM f_request 
 WHERE dept_code    = as_dept_code AND
       to_char(rqst_date,'YYYY.MM') = to_char(ad_date,'YYYY.MM') AND
       res_type = 'L';

CURSOR EDETAIL_CUR IS
SELECT rqst_date,seq
  FROM f_request 
 WHERE dept_code    = as_dept_code AND
       to_char(rqst_date,'YYYY.MM') = to_char(ad_date,'YYYY.MM') AND
       res_type = 'E';

CURSOR SDETAIL_CUR IS
SELECT rqst_date,seq
  FROM f_request 
 WHERE dept_code    = as_dept_code AND
       to_char(rqst_date,'YYYY.MM') = to_char(ad_date,'YYYY.MM') AND
       res_type = 'S';

CURSOR SUB_CUR IS
SELECT a.yymm,a.seq,a.order_number,b.sbc_name
  FROM s_pay a,
		 s_cn_list b 
 WHERE a.dept_code = b.dept_code and
		 a.order_number = b.order_number and
 		 a.dept_code    = as_dept_code AND
       to_char(a.yymm,'YYYY.MM') = to_char(ad_date,'YYYY.MM')
ORDER BY yymm asc,seq asc,order_number asc;

CURSOR MAT_CUR IS
SELECT max(a.vender_code),max(b.vender_name),nvl(sum(a.amt),0),nvl(sum(a.vatamt),0)
  FROM m_input_detail a,
		 m_code_collaborator b
 WHERE a.vender_code = b.vender_code (+) and
		 a.dept_code    = as_dept_code AND
       to_char(a.yymmdd,'YYYY.MM') = to_char(ad_date,'YYYY.MM') AND
		 a.inouttypecode = 'A'
GROUP BY a.vender_code
ORDER BY a.vender_code asc;

CURSOR EQU_CUR IS
SELECT max(a.regist_no),max(b.eqp_vender_name),nvl(sum(a.monthly_amt),0),nvl(sum(a.vat),0),max(b.cust_type)
  FROM q_monthly_payment a,
		 q_code_eqp_vender b
 WHERE a.regist_no = b.regist_no (+) and
		 a.dept_code    = as_dept_code AND
       to_char(a.yymm,'YYYY.MM') = to_char(ad_date,'YYYY.MM')
GROUP BY a.regist_no
ORDER BY a.regist_no asc;
-- 공통 변수 
   v_rqst_date         f_request.rqst_date%TYPE;
   v_seq               f_request.seq%TYPE;
   v_yymm              s_pay.yymm%TYPE;
   v_order_number      s_pay.order_number%TYPE;
   v_sbc_name          s_cn_list.sbc_name%TYPE;
   v_vender_code       m_code_collaborator.vender_code%TYPE;
   v_vender_name       m_code_collaborator.vender_name%TYPE;
   v_amt               m_input_detail.amt%TYPE;
   v_vat               m_input_detail.vatamt%TYPE;
   v_regist_no         q_monthly_payment.regist_no%TYPE;
   v_cust_type         q_code_eqp_vender.cust_type%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
	C_DATE			 DATE;
   C_CODE			 VARCHAR2(13);
   C_NAME          VARCHAR2(50);
   C_ACNT_CODE     VARCHAR2(50);
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
		
		IF as_l_tag = 'Y' THEN
			OPEN	LDETAIL_CUR;
			LOOP
				FETCH LDETAIL_CUR INTO v_rqst_date,v_seq;
				EXIT WHEN LDETAIL_CUR%NOTFOUND;
				
				delete from f_joint_distribution
						where dept_code = as_dept_code
						  and rqst_date = v_rqst_date
						  and seq       = v_seq;
	
				delete from f_request
						where dept_code = as_dept_code
						  and rqst_date = v_rqst_date
						  and seq       = v_seq;
			END LOOP;
			CLOSE LDETAIL_CUR;
		END IF;

		IF as_q_tag = 'Y' THEN	
			OPEN	EDETAIL_CUR;
			LOOP
				FETCH EDETAIL_CUR INTO v_rqst_date,v_seq;
				EXIT WHEN EDETAIL_CUR%NOTFOUND;
				
				delete from f_joint_distribution
						where dept_code = as_dept_code
						  and rqst_date = v_rqst_date
						  and seq       = v_seq;
	
				delete from f_request
						where dept_code = as_dept_code
						  and rqst_date = v_rqst_date
						  and seq       = v_seq;
			END LOOP;
			CLOSE EDETAIL_CUR;
		END IF;

		IF as_s_tag = 'Y' THEN	
			OPEN	SDETAIL_CUR;
			LOOP
				FETCH SDETAIL_CUR INTO v_rqst_date,v_seq;
				EXIT WHEN SDETAIL_CUR%NOTFOUND;
				
				delete from f_joint_distribution
						where dept_code = as_dept_code
						  and rqst_date = v_rqst_date
						  and seq       = v_seq;
	
				delete from f_request
						where dept_code = as_dept_code
						  and rqst_date = v_rqst_date
						  and seq       = v_seq;
			END LOOP;
			CLOSE SDETAIL_CUR;
		END IF;

		IF as_m_tag = 'Y' THEN	
			OPEN	MDETAIL_CUR;
			LOOP
				FETCH MDETAIL_CUR INTO v_rqst_date,v_seq;
				EXIT WHEN MDETAIL_CUR%NOTFOUND;
				
				delete from f_joint_distribution
						where dept_code = as_dept_code
						  and rqst_date = v_rqst_date
						  and seq       = v_seq;
	
				delete from f_request
						where dept_code = as_dept_code
						  and rqst_date = v_rqst_date
						  and seq       = v_seq;
			END LOOP;
			CLOSE MDETAIL_CUR;
		END IF;
		select nvl(max(seq),0)
		  into C_SEQ
		  from f_request
		 where dept_code = as_dept_code
			and rqst_date = ad_date;

		C_SEQ := C_SEQ + 1;
	-- 외주비 집계
		IF as_s_tag = 'Y' THEN	
			OPEN	SUB_CUR;
			LOOP
				FETCH SUB_CUR INTO v_yymm,v_seq,v_order_number,v_sbc_name;
				EXIT WHEN SUB_CUR%NOTFOUND;
	
			  SELECT b.SBCR_CODE
				 INTO v_vender_code
				 FROM S_PAY a,   
						S_CN_LIST b  
				WHERE ( b.DEPT_CODE    = a.DEPT_CODE ) and  
						( b.ORDER_NUMBER = a.ORDER_NUMBER ) and  
						( ( a.DEPT_CODE  = as_dept_code ) AND  
						( a.YYMM			  = v_yymm ) AND  
						( a.SEQ 			  = v_seq ) AND  
						( a.ORDER_NUMBER = v_order_number ))   ;
	
				select businessman_number
				  into C_CODE
				  from s_sbcr
				 where sbcr_code = v_vender_code;
	
				select count(*)
				  into C_CNT
				  from z_code_cust_code
				 where cust_code = C_CODE;
	
				IF C_CNT < 1 THEN
					insert into z_code_cust_code
						select businessman_number,'1',sbcr_name,representative_name1,kinditem,kind_bussinesstype,
								 tel_number,fax_number,zip_number1,address1,'S',main_bank,acc_number,depositor,''
						  from s_sbcr
						 where sbcr_code = v_vender_code;
				END IF;
				
				select child_name
				  into C_ACNT_CODE
				  from z_code_etc_child
				 where class_tag = '980'
					and etc_code = 'S';

				INSERT INTO F_REQUEST  
				  SELECT a.DEPT_CODE,ad_date,C_SEQ,'S',v_sbc_name || ' ' || to_char(v_yymm,'yyyy.mm') || '월 외주비',a.ORDER_NUMBER,   
							C_CODE,c.SBCR_NAME,decode(a.tm_vat,0,'','21'),a.TM_PAY,a.TM_VAT,   
							C_ACNT_CODE,'3','1','2',decode(a.tm_vat,0,null,ad_date),'','',0,0,NULL,0  
					 FROM S_PAY a,   
							S_CN_LIST b,   
							S_SBCR  c
					WHERE ( b.DEPT_CODE    = a.DEPT_CODE ) and  
							( b.ORDER_NUMBER = a.ORDER_NUMBER ) and  
							( b.SBCR_CODE    = c.SBCR_CODE ) and  
							( ( a.DEPT_CODE  = as_dept_code ) AND  
							( a.YYMM			  = v_yymm ) AND  
							( a.SEQ 			  = v_seq ) AND  
							( a.ORDER_NUMBER = v_order_number ))   ;
				
					C_SEQ := C_SEQ + 1;
			END LOOP;
			CLOSE SUB_CUR;
		END IF;	
	-- 자재비 집계
		IF as_m_tag = 'Y' THEN
			OPEN	MAT_CUR;
			LOOP
				FETCH MAT_CUR INTO v_vender_code,v_vender_name,v_amt,v_vat;
				EXIT WHEN MAT_CUR%NOTFOUND;
	
				select businessman_number
				  into C_CODE
				  from m_code_collaborator
				 where vender_code = v_vender_code;
	
				select count(*)
				  into C_CNT
				  from z_code_cust_code
				 where cust_code = C_CODE;
	
				IF C_CNT < 1 THEN
					insert into z_code_cust_code
						select businessman_number,'1',vender_name,owner,'','',
								 tel,fax,zip,addr,'M','','','',''
						  from m_code_collaborator
						 where vender_code = v_vender_code;
				END IF;

				select MAX(name)
				  into C_NAME
				  from m_input_detail
				 where dept_code    = as_dept_code AND
						 vender_code = v_vender_code and
						 to_char(yymmdd,'YYYY.MM') = to_char(ad_date,'YYYY.MM') AND
						 inouttypecode = 'A' and
						 amt = ( SELECT max(amt)
									  FROM m_input_detail
									 WHERE dept_code    = as_dept_code AND
											 vender_code = v_vender_code and
											 to_char(yymmdd,'YYYY.MM') = to_char(ad_date,'YYYY.MM') AND
											 inouttypecode = 'A');
				select count(*)
				  into C_CNT
				  from m_input_detail
				 WHERE dept_code    = as_dept_code AND
						 vender_code  = v_vender_code and
						 to_char(yymmdd,'YYYY.MM') = to_char(ad_date,'YYYY.MM') AND
						 inouttypecode = 'A';

				IF C_CNT > 1 THEN
					C_NAME := C_NAME || ' 외';
 				END IF;

				select child_name
				  into C_ACNT_CODE
				  from z_code_etc_child
				 where class_tag = '980'
					and etc_code = 'M';

				INSERT INTO F_REQUEST  
					VALUES ( as_dept_code,ad_date,C_SEQ,'M',C_NAME,0,   
								C_CODE,v_vender_name,decode(v_vat,0,'','21'),v_amt,v_vat,   
								C_ACNT_CODE,'1','1','2',decode(v_vat,0,null,ad_date),'','',0,0,NULL,0    );
				
				C_SEQ := C_SEQ + 1;
	
			END LOOP;
			CLOSE MAT_CUR;
		END IF;	
	-- 노무비 집계
		IF as_l_tag = 'Y' THEN
			select nvl(sum(pay_amt),0)
			  into C_AMT
				 FROM l_labor_dailywork   
				WHERE ( DEPT_CODE  = as_dept_code ) AND  
						( to_char(work_date,'YYYY.MM') = to_char(ad_date,'YYYY.MM'));
			IF C_AMT <> 0 THEN
				select child_name
				  into C_ACNT_CODE
				  from z_code_etc_child
				 where class_tag = '980'
					and etc_code = 'L';

				INSERT INTO F_REQUEST  
				  VALUES ( as_dept_code,ad_date,C_SEQ,'L',to_char(ad_date,'YYYY.MM') || '월 노임',0,   
							'','','',C_AMT,0,   
							C_ACNT_CODE,'3','1','2',null,'','',0,0,NULL,0   );
			
				C_SEQ := C_SEQ + 1;
			END IF;
		END IF;	
	-- 장비비 집계
		IF as_q_tag = 'Y' THEN
			OPEN	EQU_CUR;
			LOOP
				FETCH EQU_CUR INTO v_regist_no,v_vender_name,v_amt,v_vat,v_cust_type;
				EXIT WHEN EQU_CUR%NOTFOUND;
			
				select count(*)
				  into C_CNT
				  from z_code_cust_code
				 where cust_code = v_regist_no;
	
				IF C_CNT < 1 THEN
					insert into z_code_cust_code
						select regist_no,v_cust_type,eqp_vender_name,pregident_name,'','',
								 tel_no,'','',address,'Q','','','',''
						  from q_code_eqp_vender
						 where regist_no = v_regist_no;
				END IF;

				select child_name
				  into C_ACNT_CODE
				  from z_code_etc_child
				 where class_tag = '980'
					and etc_code = 'E';
	
				INSERT INTO F_REQUEST  
					VALUES ( as_dept_code,ad_date,C_SEQ,'E',v_vender_name || ' ' || to_char(ad_date,'yyyy.mm') || '월 장비비',0,   
								v_regist_no,v_vender_name,decode(v_vat,0,'','21'),v_amt,v_vat,   
								C_ACNT_CODE,'3','1','2',decode(v_vat,0,null,ad_date),'','',0,0,NULL,0    );
				
				C_SEQ := C_SEQ + 1;
	
			END LOOP;
			CLOSE EQU_CUR;
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
END y_sp_f_request_summary;

/
