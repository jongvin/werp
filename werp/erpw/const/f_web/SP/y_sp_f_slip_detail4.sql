/* ============================================================================= */
/* 함수명 : y_sp_f_slip_detail4                                                  */
/* 기  능 : 자동전표생성디테일(노무비).                  */
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
CREATE OR REPLACE PROCEDURE y_sp_f_slip_detail4(as_dept_code    IN   VARCHAR2, 
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

-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   v_rqst_detail   f_request.RQST_DETAIL%TYPE;
   v_cust_code     f_request.CUST_CODE%TYPE;
   v_deptdetail_code      erpc.am_code_dept_rela.DEPTDETAIL_CODE%TYPE;
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_DATE			 DATE;
   C_ACNT_CODE     f_request.ACNTCODE%TYPE;
   C_CNT           NUMBER(10,3);
   C_AMT           NUMBER(12,0);
   C_WORK_CNT      INTEGER;
   C_PERS_CNT      INTEGER;
   C_SODUK_AMT     NUMBER(12,0);
   C_TAX_CNT       NUMBER(12,0);
   C_INCOME_TAX    NUMBER(12,0);
   C_CIVIL_TAX     NUMBER(12,0);
   C_WORK_NO       NUMBER(6,0);
	C_KIND_CODE     VARCHAR2(3);
	C_EVIDENCE_KIND VARCHAR2(3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN
		C_SEQ := 1;
		C_AMT := 0;

	   e_msg      := '노무비 자동전표 발행 ! [Line No: 1]';
	   
		SELECT MAX(DEPTDETAIL_CODE) 
        INTO v_deptdetail_code 
 		   FROM ERPC.AM_CODE_DEPT_RELA  
        WHERE dept_code = as_dept_code 
          and DEPTDETAIL_CODE <> '530'
        ;

		-- 노무비는 거래처에 현장코드를 입력한다.
		C_ACNT_CODE := '50120501';    --노무비 잡급(원천)
		
		--출역일수
	   e_msg      := '노무비 자동전표 발행 ! [Line No: 2]';
		select sum(count(*))
		  into C_WORK_CNT 
        from (select distinct work_date   
                from l_labor_dailywork
               where dept_code = as_dept_code 
                 and work_date between adt_from_yymm and adt_to_yymm
             ) a
        group by a.work_date; 
		if C_WORK_CNT is null  then 
			C_WORK_CNT := 0;        
      end if;        

		--총지급액
	   e_msg      := '노무비 자동전표 발행 ! [Line No: 3]';
		select sum(pay_amt)  
		  into C_AMT  
		  from l_labor_dailywork
		 where dept_code = as_dept_code 
		   and work_date between adt_from_yymm and adt_to_yymm ;
		if C_AMT is null  then 
			C_AMT := 0;        
      end if;        

		--총인원수
	   e_msg      := '노무비 자동전표 발행 ! [Line No: 4]';
		select sum(count(*))
		  into C_PERS_CNT
        from (select distinct civil_register_number    
                from l_labor_dailywork
               where dept_code = as_dept_code 
                 and work_date between adt_from_yymm and adt_to_yymm
             ) a
        group by a.civil_register_number; 
		if C_PERS_CNT is null  then 
			C_PERS_CNT := 0;        
      end if;        

		--소득금액
	   e_msg      := '노무비 자동전표 발행 ! [Line No: 5]';
		select sum(pay_amt)  
		  into C_SODUK_AMT  
		  from l_labor_dailywork
		 where income_tax <> 0        
		   and dept_code = as_dept_code 
		   and work_date between adt_from_yymm and adt_to_yymm ; 
		if C_SODUK_AMT is null  then 
			C_SODUK_AMT := 0;        
      end if;        

		--과세인원수
	   e_msg      := '노무비 자동전표 발행 ! [Line No: 6]';
		select sum(count(*))
		  into C_TAX_CNT
        from (select distinct civil_register_number           
                from l_labor_dailywork
               where income_tax <> 0 
                 and dept_code = as_dept_code 
                 and work_date between adt_from_yymm and adt_to_yymm
             ) a
        group by a.civil_register_number;   
		if C_TAX_CNT is null  then 
			C_TAX_CNT := 0;        
      end if;        
        
		--소득세, 주민세
	   e_msg      := '노무비 자동전표 발행 ! [Line No: 7]';
		select sum(income_tax),   
		       sum(civil_tax) 
		  into C_INCOME_TAX,  
		       C_CIVIL_TAX   
		  from l_labor_dailywork
		 where dept_code = as_dept_code 
		   and work_date between adt_from_yymm and adt_to_yymm ; 
		if C_INCOME_TAX is null  then 
			C_INCOME_TAX := 0;        
      end if;        
		if C_CIVIL_TAX  is null  then 
			C_CIVIL_TAX  := 0;        
      end if;        

	   e_msg      := '노무비 자동전표 발행 ! [Line No: 8]';
		INSERT INTO erpc.AM_WORK_DETAIL  
		VALUES ( adt_slip_date,arg_seq,C_SEQ,C_SEQ,as_dept_code,as_class,'01',as_dept_code,v_deptdetail_code,   
				 C_ACNT_CODE,C_ACNT_CODE,C_AMT,0,C_AMT,0,0,0,to_char(adt_to_yymm,'YYYY.MM') || '월 노임',to_char(adt_to_yymm,'YYYY.MM') || '월 노임',   
				 '01',v_cust_code,null,null,null,null,null,null,null,null,null,null,null,null,null,'015',null,   
				 null,null,C_WORK_CNT,0,C_AMT,0,C_SODUK_AMT,C_INCOME_TAX,C_CIVIL_TAX,C_PERS_CNT,C_TAX_CNT,adt_slip_date,adt_slip_date,NULL,null,null,null,null,null,
				 null,null,null,arg_slip_name,sysdate,arg_slip_name,sysdate,null) ; 

   		C_SEQ := C_SEQ + 1;

--		IF as_class = 'CM5' THEN
--			C_ACNT_CODE := '10117901';    -- 전도금
--		ELSE
--			C_ACNT_CODE := '20110101';    -- 외상매입금
--		END IF;
		
		C_ACNT_CODE := '20113504';    -- 미지급비용(잡급)

	   e_msg      := '노무비 자동전표 발행 ! [Line No: 9]';
		INSERT INTO erpc.AM_WORK_DETAIL  
		VALUES ( adt_slip_date,arg_seq,C_SEQ,C_SEQ,as_dept_code,as_class,'01',as_dept_code,v_deptdetail_code,   
				 C_ACNT_CODE,C_ACNT_CODE,0,0,0,C_AMT,0,C_AMT,to_char(adt_to_yymm,'YYYY.MM') || '월 노임',to_char(adt_to_yymm,'YYYY.MM') || '월 노임',   
				 '01',v_cust_code,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,   
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
END y_sp_f_slip_detail4;

/
