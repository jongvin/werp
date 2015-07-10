/* ============================================================================= */
/* 함수명 : y_sp_f_slip_detail2                                                  */
/* 기  능 : 자동전표생성디테일(부가세없고거래처없는거, 노무비 제외).             */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 시작일                 ==> adt_from_date(date)                       */
/*        : 종료일                 ==> adt_to_date(date)                         */
/*        : 전표일                 ==> adt_slip_date(date)                       */
/*        : 비목구분               ==> arg_res_type(string)                      */
/*        : 전표종류코드           ==> as_class(string)                          */
/*        : 전표번호               ==> arg_seq(integer)                          */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.08.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_slip_detail2(as_dept_code    IN   VARCHAR2,
                                        		   adt_from_yymm   IN   DATE,
															   adt_to_yymm     IN   DATE,
															   adt_slip_date   IN   DATE,
																arg_res_type    IN   VARCHAR2,
																as_class        IN   VARCHAR2,
															   arg_seq         IN   INTEGER, 
															   arg_slip_name   IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT rqst_date, 
		 seq, 
     	 RQST_DETAIL,    
     	 CUST_CODE,    
     	 VATCODE,    
     	 AMT,
   	 VAT,    
     	 ACNTCODE,    
     	 RECEIPT_DATE 
  FROM F_REQUEST 
 WHERE ( DEPT_CODE =  as_dept_code  ) AND   
     	 ( RQST_DATE >= adt_from_yymm  )  AND 
     	 ( RQST_DATE <= adt_to_yymm ) and 
    	 ( cust_code is null ) and 
     	 ( res_type  = arg_res_type ) and  
       ( ACNTCODE is not null) and  
     	 ( vatcode is null)
order by rqst_date asc ,seq asc     ;

-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   v_rqst_date     f_request.rqst_date%TYPE;
   v_seq           f_request.seq%TYPE;
   v_rqst_detail   f_request.RQST_DETAIL%TYPE;
   v_cust_code     f_request.CUST_CODE%TYPE;
   v_vatcode       f_request.vatcode%TYPE;
   v_amt           f_request.AMT%TYPE;
   v_vat           f_request.VAT%TYPE;
   v_acntcode      f_request.ACNTCODE%TYPE;
   v_deptdetail_code      erpc.am_code_dept_rela.DEPTDETAIL_CODE%TYPE;
   v_receipt_date  f_request.receipt_date%TYPE;
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_DATE			 DATE;
   C_ACNT_CODE     f_request.ACNTCODE%TYPE;
   C_CNT           NUMBER(10,3);
   C_AMT           NUMBER(12,0);
   C_VAT           NUMBER(11,0);
   C_TOT           NUMBER(12,0);
   C_WORK_NO       NUMBER(6,0);
	C_KIND_CODE     VARCHAR2(3);
	C_EVIDENCE_KIND VARCHAR2(3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN
		C_SEQ := 1;
		C_AMT := 0;
		C_VAT := 0;
		C_TOT := 0;

		SELECT MAX(DEPTDETAIL_CODE) 
        INTO v_deptdetail_code 
 		   FROM ERPC.AM_CODE_DEPT_RELA  
        WHERE dept_code = as_dept_code 
          and DEPTDETAIL_CODE <> '530'
        ;

		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_rqst_date,v_seq,v_rqst_detail,v_cust_code,v_vatcode,v_amt,v_vat,v_acntcode,v_receipt_date;
			EXIT WHEN DETAIL_CUR%NOTFOUND;

			C_AMT := C_AMT + v_amt;
			C_VAT := C_VAT + v_vat;	

			IF v_vatcode = '21' or v_vatcode = '22' or v_vatcode = '24' or substrb(v_vatcode,1,1) = 'B' THEN
				C_TOT := v_amt;
			END IF;

			IF v_vatcode = '23' or v_vatcode = '2x' THEN
				C_TOT := v_amt + v_vat;
			END IF;

			IF v_vatcode is null THEN
				C_TOT := v_amt;
			END IF;

			INSERT INTO erpc.AM_WORK_DETAIL  
			VALUES ( adt_slip_date,arg_seq,C_SEQ,C_SEQ,as_dept_code,as_class,'01',as_dept_code,v_deptdetail_code,   
					 v_acntcode,v_acntcode,C_TOT,v_vat,v_amt,0,0,0,v_rqst_detail,v_rqst_detail,   
					 '01',v_cust_code,v_vatcode,v_receipt_date,null,null,null,null,null,null,null,null,null,null,null,null,null,   
					 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
					 null,null,null,arg_slip_name,sysdate,arg_slip_name,sysdate,null) ; 

			C_SEQ := C_SEQ + 1;

		END LOOP;
		CLOSE DETAIL_CUR;

--		IF as_class = 'CM5' THEN
--			C_ACNT_CODE := '10117901';    -- 전도금
--		ELSE
--			C_ACNT_CODE := '20110101';    -- 외상매입금
--		END IF;
		
		C_ACNT_CODE := '20113503';    -- 미지급비용(전도금)

		C_TOT := C_AMT + C_VAT;

		INSERT INTO erpc.AM_WORK_DETAIL  
		VALUES ( adt_slip_date,arg_seq,C_SEQ,C_SEQ,as_dept_code,as_class,'01',as_dept_code,v_deptdetail_code,   
				 C_ACNT_CODE,C_ACNT_CODE,0,0,0,C_TOT,0,C_TOT,'현장전도금청구분','현장전도금청구분',   
				 '01',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,   
				 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
				 null,null,null,arg_slip_name,sysdate,arg_slip_name,sysdate,null) ; 

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
END y_sp_f_slip_detail2;

/
