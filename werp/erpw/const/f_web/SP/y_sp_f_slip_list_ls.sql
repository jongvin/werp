/* ============================================================================= */
/* 함수명 : y_sp_f_slip_list_ls                                                  */
/* 기  능 : 자동전표생성마스터(노무, 외주만 집계함)                              */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 시작일                 ==> adt_from_date(date)                       */
/*        : 종료일                 ==> adt_to_date(date)                         */
/*        : 전표일                 ==> adt_slip_date(date)                       */
/*        : 발의자                 ==> as_slip_name(string)                      */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.08.14                                                           */
/* 작성일 : 2004.06.29  (작성:이양헌, 협의:김보희)                               */
/*   	외주비 : 과세/면세가 함께 있는 기성 : (과세=== 부가세 코드:21, 계정코드:50130101 외주공사비(공제) ) */
/*   				                             (면세=== 부가세 코드:B1, 계정코드:50130101 외주공사비(공제) ) */
/*   	         면세만 있는 기성             (면세=== 부가세 코드:B1, 계정코드:50130102 외주공사비(공통) ) */
/*   	         과세만 있는 기성         (100%과세=== 부가세 코드:21, 계정코드:50130101 외주공사비(공제) ) */
/*   	                                  (기타    === 부가세 코드:25, 계정코드:50130102 외주공사비(공통) ) */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_slip_list_ls(as_dept_code    IN   VARCHAR2,
                                        			adt_from_date   IN   DATE,
																adt_to_date     IN   DATE,
																adt_slip_date   IN   DATE,
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
						 to_char(adt_to_date, 'yyyy.mm') || '월 ' || b.sbc_name || ' 외주비'   v_desc, 
						 c.businessman_number, 
     					 c.sbcr_name,  
     					 c.representative_name1, 
     					 c.kind_bussinesstype,  
     					 c.kinditem,  
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
   			  and a.dept_code    = as_dept_code 
   			  and a.yymm between adt_from_date and adt_to_date 
			union all 
			SELECT  'S2' RES_TYPE,   
	                a.tm_prgs  		amt, 
	                a.tm_prgs_notax  notax_amt, 
	                a.tm_vat   		vat, 
	                a.tm_advance_deduction, 
						 to_char(adt_to_date, 'yyyy.mm') || '월 ' || b.sbc_name || ' 외주비'   v_desc, 
						 c.businessman_number, 
     					 c.sbcr_name,  
     					 c.representative_name1, 
     					 c.kind_bussinesstype,  
     					 c.kinditem,  
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
   			  and a.dept_code    = as_dept_code 
   			  and a.yymm between adt_from_date and adt_to_date 
			union all 
			  SELECT 'L' RES_TYPE,   
			         0  amt, 
			         0  notax_amt,  
			         0  vat, 
	               0  tm_advance_deduction, 
						'노무비'  v_desc,
						 null  businessman_number, 
     					 null  sbcr_name,  
     					 null  representative_name1, 
     					 null  kind_businesstype,  
     					 null  kinditem,  
     					 null  tel_number, 
     					 null  fax_number, 
     					 null  zip_number1, 
     					 null  address1,  
						 null  RECEIPT_DATE
				 FROM dual 
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
   v_w_amt            NUMBER(15,0);
   v_seq              NUMBER(15,0);
   v_notax_amt        NUMBER(15,0);
   v_advance_deduction   NUMBER(15,0);
   v_vat              NUMBER(15,0);
   v_acntcode         VARCHAR2(10);
   v_c_acnt1		    VARCHAR2(10);
	v_c_acnt2          VARCHAR2(10);   
   v_desc     			 f_request.rqst_detail%TYPE;
   v_cust_code        f_request.cust_code%TYPE;
   v_cust_name        VARCHAR2(50);
   v_rep_name         VARCHAR2(50);
   v_kindtype         VARCHAR2(50);
   v_kinditem         VARCHAR2(50);
   v_tel		          VARCHAR2(20);
   v_fax		          VARCHAR2(20);
   v_zip			       VARCHAR2(10);
   v_add		          VARCHAR2(100);
   v_vatcode          f_request.vatcode%TYPE;
   v_receipt_date     f_request.receipt_date%TYPE;
   v_deptdetail_code  VARCHAR2(10);
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_CHK           VARCHAR2(1);
   C_CNT           NUMBER(10,3);
   C_TOT           NUMBER(15,0);
   C_TAX_RATE      NUMBER(10,3);
   C_WORK_NO       NUMBER(6,0);
	C_KIND_CODE     VARCHAR2(3);
	C_EVIDENCE_KIND VARCHAR2(3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN

		select tax_rate 
		  into C_TAX_RATE  
		  from z_code_dept 
		 where dept_code = as_dept_code ;
   
		SELECT MIN(DEPTDETAIL_CODE) 
        INTO v_deptdetail_code 
 		   FROM ERPC.AM_CODE_DEPT_RELA  
        WHERE dept_code = as_dept_code 
          and DEPTDETAIL_CODE <> '530'
        ;
		-- 외주공사비(공제)
		select child_name 
		  into v_c_acnt1  
		  from z_code_etc_child 
		 where class_tag = '980' 
		   and etc_code  = 'S1' ; 
		   
		-- 외주공사비(공통)
		select child_name 
		  into v_c_acnt2  
		  from z_code_etc_child 
		 where class_tag = '980' 
		   and etc_code  = 'S2' ; 
 
   
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_res_type,  v_amt,       v_notax_amt, v_vat,      v_advance_deduction,        v_desc,      
			                      v_cust_code, v_cust_name, v_rep_name,  v_kindtype, v_kinditem,     v_tel,       v_fax,       v_zip, 
										 v_add,    	 v_receipt_date ;
			EXIT WHEN DETAIL_CUR%NOTFOUND;

			select COUNT(*)
			  into C_CNT
			  from am_work_workno
 		    where work_date = adt_slip_date;

			IF C_CNT < 1 THEN
			   e_msg      := '전표번호 생성 실패! [Line No: -3]';
				INSERT INTO ERPC.AM_WORK_WORKNO
				VALUES ( adt_slip_date,1 )  ;
				C_SEQ := 1;
			ELSE
				select work_no_last
				  into C_SEQ
				  from am_work_workno
		   	 where work_date = adt_slip_date;
				
				C_SEQ := C_SEQ + 1;
				
			   e_msg      := '전표번호 수정 실패! [Line No: -2]';
				UPDATE ERPC.AM_WORK_WORKNO  
				  SET WORK_NO_LAST = C_SEQ  
				WHERE WORK_DATE = adt_slip_date;  
			END IF;

			IF v_cust_code is not null THEN
				select COUNT(*)
				  into C_CNT
				  from sm_code_cust
				 where cust_code = v_cust_code;
				
				IF C_CNT < 1 THEN
					e_msg      := '거래처 생성 실패! [Line No: -1]' || v_cust_code;
						INSERT INTO ERPC.SM_CODE_CUST  
						  values(v_cust_code,'Y','Y','001',v_cust_name,v_cust_name,'','',v_rep_name,   
									'',v_kindtype,v_kinditem,v_tel,v_fax,v_zip,   
									v_add,'','','',sysdate,'',null) ; 
				END IF;
			END IF;				

			-- 외주비와 노무비만 처리함.
			IF substrb(v_res_type,1,1) = 'S' THEN
				C_KIND_CODE := 'CM1';
			ELSE
				C_KIND_CODE := 'CM4';
			END IF;

/* ------------------------------------------------------------------------------------------------------- */				
/*  1. 외주비 : 과세/면세가 함께 있는 기성 : (과세=== 부가세 코드:21, 계정코드:50130101 외주공사비(공제) ) */
/*    			                              (면세=== 부가세 코드:B1, 계정코드:50130101 외주공사비(공제) ) */
/*  2. 	         면세만 있는 기성           (면세=== 부가세 코드:B1, 계정코드:50130102 외주공사비(공통) ) */
/*  3. 	         과세만 있는 기성       (100%과세=== 부가세 코드:21, 계정코드:50130101 외주공사비(공제) ) */
/*   	                                   (기타    === 부가세 코드:25, 계정코드:50130102 외주공사비(공통) ) */
/* ------------------------------------------------------------------------------------------------------- */				
			IF v_res_type =  'S1' THEN         -- 과세분
				v_r_amt := v_amt;
				v_r_vat := v_vat;
				IF  v_notax_amt = 0 THEN        -- 3. 과세만 있는 기성
					IF C_TAX_RATE = 100 then     -- 3.  100% 과세
						v_acntcode := v_c_acnt1;  -- 외주공사비(공제)  계정
						v_vatcode := '21';
					ELSE                         -- 3.  100% 과세가 아닌경우
						v_acntcode := v_c_acnt2;  -- 외주공사비(공통)  계정
						v_vatcode := '25';
					END IF;			
				ELSE	                          -- 1. 과세/면세가 함께 있는 기성
					v_acntcode := v_c_acnt1;     -- 외주공사비(공제)  계정
					v_vatcode := '21';
				END IF;
			ELSE IF v_res_type =  'S2' THEN    -- 면세분            
					v_r_amt := v_notax_amt;
					v_r_vat := 0;
					IF  v_amt = 0 THEN           -- 2. 면세만 있는 기성
						v_acntcode := v_c_acnt2;  -- 외주공사비(공통)  계정
						v_vatcode := 'B1';
					ELSE	                       -- 1. 과세/면세가 함께 있는 기성
						v_acntcode := v_c_acnt1;  -- 외주공사비(공제)  계정
						v_vatcode := 'B1';
					END IF;
				ELSE    --  노무비는 Y_SP_F_SLIP_DETAIL4  PROCEDURE 에서 처리함.
					v_r_amt := 0;
					v_r_vat := 0;
					v_vatcode  := '';
					v_acntcode := '';
				END IF;
			END IF;

			IF substrb(v_vatcode,1,1) = '2' THEN
				C_EVIDENCE_KIND := '011';
			ELSE IF substrb(v_vatcode,1,1) = 'B' THEN
					C_EVIDENCE_KIND := '021';
				ELSE
					C_EVIDENCE_KIND := '999';
				END IF;
			END IF;

		   e_msg      := '가전표 마스타 생성 실패! 노무/외주[Line No: 0]';
			INSERT INTO ERPC.AM_WORK_MASTER  
			VALUES ( adt_slip_date,C_SEQ,C_SEQ,'01',as_dept_code,C_KIND_CODE,'002',as_slip_name,sysdate,'01',v_cust_code,   
						v_receipt_date,C_EVIDENCE_KIND,null,'N',null,null,'N',null,null,'N',null,null,null,null,null,null,'N',null,null )  ;


			IF C_KIND_CODE = 'CM4' THEN
			   e_msg      := '가전표 생성 실패! 노무 [Line No: 1]' || C_SEQ;
				Y_SP_F_SLIP_DETAIL4(as_dept_code,adt_from_date,adt_to_date,adt_slip_date,v_res_type,
			           C_KIND_CODE,C_SEQ, as_slip_name);
			ELSE
				IF v_vatcode = '23' or v_vatcode = '2x' THEN
					C_TOT := v_r_amt + v_r_vat;
				ELSE
					C_TOT := v_r_amt;
				END IF;

				v_seq := 1;

			   e_msg      := '가전표 생성 실패! 외주 [Line No: 2]' || C_SEQ;
				INSERT INTO erpc.AM_WORK_DETAIL  
				VALUES ( adt_slip_date,C_SEQ,v_seq,v_seq,as_dept_code,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,   
						 v_acntcode,v_acntcode,C_TOT,v_r_vat,v_r_amt,0,0,0,v_desc,v_desc,   
						 '01',v_cust_code,v_vatcode,v_receipt_date,null,null,null,null,null,null,null,null,null,null,null,null,null,   
						 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
						 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ; 
				
				if v_advance_deduction = 0 then
					v_w_amt := v_r_amt + v_r_vat;
				else if v_res_type = 'S1' then
						if (v_amt + v_vat) >= v_advance_deduction then 
						   v_w_amt := v_amt + v_vat - v_advance_deduction;
						else
							v_advance_deduction := v_amt + v_vat;
							v_w_amt := 0;
						end if;
					else if v_advance_deduction > (v_amt + v_vat) then
							v_advance_deduction := v_advance_deduction - v_amt - v_vat;
							v_w_amt := v_notax_amt - v_advance_deduction;
						else
							v_advance_deduction := 0;
							v_w_amt := v_notax_amt ;
						end if;
					end if;
				end if;

				if v_w_amt <> 0 then
					v_acntcode := '20110101';    -- 외상매입금

					v_seq := v_seq + 1;

					C_TOT := v_w_amt;
			
					INSERT INTO erpc.AM_WORK_DETAIL  
					VALUES ( adt_slip_date,C_SEQ,v_seq,v_seq,as_dept_code,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,   
							 v_acntcode,v_acntcode,0,0,0,C_TOT,0,C_TOT,v_desc,v_desc,   
							 '01',v_cust_code,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,   
							 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
							 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ; 
				end if;
				
				if v_advance_deduction <> 0 then
					v_acntcode := '10116711';    -- 선급금(공사)
	
					v_seq := v_seq + 1;
					
					C_TOT := v_advance_deduction;
			
					INSERT INTO erpc.AM_WORK_DETAIL  
					VALUES ( adt_slip_date,C_SEQ,v_seq,v_seq,as_dept_code,C_KIND_CODE,'01',as_dept_code,v_deptdetail_code,   
							 v_acntcode,v_acntcode,0,0,0,C_TOT,0,C_TOT,v_desc,v_desc,   
							 '01',v_cust_code,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,   
							 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
							 null,null,null,as_slip_name,sysdate,as_slip_name,sysdate,null) ; 
				end if;
			
			END IF;

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
END y_sp_f_slip_list_ls;

/
