 /* ============================================================================ */
/* 함수명 : y_sp_m_slip_tmat_rent(gl)               		                        */
/* 기  능 : 자재관리-손료전표 발행                                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 년월                   ==> as_date(DATE)        		               */
/*        : 결재선번호             ==> ai_unq_num(NUMBER)                        */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2005.04.28                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_slip_tmat_rent (as_dept_code    IN   VARCHAR2,
																	 as_date         IN   DATE,
																	 ai_unq_num      IN   NUMBER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT a.month,a.amt,b.name || b.ssize
  FROM m_tmat_proj_rent a,
		 m_tmat_stock b
 WHERE a.dept_code = b.dept_code
	AND a.input_unq_num = b.input_unq_num
	AND a.dept_code = as_dept_code
	AND trunc(a.month,'MM')= as_date
	AND decode(a.INVOICE_NUM,null,'0',f_slip_status(a.INVOICE_NUM)) IN ('0','C','3') ;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_DATE              DATE;
	V_AMT               NUMBER(20,5);
	V_CONT              VARCHAR2(100);
	C_DEPT_NAME         VARCHAR2(50);
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_DR_AMT            NUMBER(20,5);
	C_CR_AMT            NUMBER(20,5);
	C_TOT_AMT           NUMBER(20,5);
   C_CHK_CNT           NUMBER(20,5);  
   C_CNT               NUMBER(20,5);  
	C_CASH_RT           NUMBER(20,5);  
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_INVOICE           VARCHAR2(50);
	C_TEMP              VARCHAR2(50);
	C_PROJ              VARCHAR2(10);
	C_VENDOR_ID         INTEGER;	
	C_VENDOR_SITE_ID    INTEGER;
	C_WORK_DT           VARCHAR2(10);
	C_FOLDER            VARCHAR2(10);
	C_SOURCE            VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(8);
	C_DR_ACNTCODE       VARCHAR2(8);
	C_VATNAME           VARCHAR2(50);
BEGIN
 BEGIN
-- 현장별 사업장코드를 가지고 온다	
		select comp_code ,long_name
		  into C_COMP_CODE,C_DEPT_NAME
 		  from z_code_dept 
		 where dept_code = as_dept_code;
		C_SOURCE := '자재';
-- 현장별프로젝트코드를 구한다.
		select a.proj_code
		  into C_PROJ
		 from ( select a.dept_code,c.proj_code
			 		 from  z_code_dept a,
						  ( select proj_unq_key,step     
								from r_proj_view_business_form) b,
							r_proj c
				   where a.proj_unq_key = b.proj_unq_key
					  and b.proj_unq_key = c.proj_unq_key
					  and b.step = c.step ) a
		 where a.dept_code =  as_dept_code;  
	SELECT attribute1
	  INTO C_ORG_ID
	  FROM efin_corporations_v
	 WHERE corporation_code = C_COMP_CODE;
-- 전표 마스터번호를 구한다.
	select efin_invoice_header_itf_s.nextval
	  into C_GROUP_ID
	  from dual;
-- 결재선 정보를 저장한다.
	y_sp_d_efin_invoice_copy(C_GROUP_ID,ai_unq_num,'A',last_day(as_date));
	C_FOLDER := C_COMP_CODE || '99999';
-- 공급처 테이블에 거래처가 존재하는지 Check하여 미존재시 insert한다.
	IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,as_dept_code) = False THEN
-- Interface테이블에 거래처를 생성한다.
		y_sp_comm_slip_supplier(C_COMP_CODE,C_DEPT_NAME,as_dept_code,'부서(현장)',as_dept_code,'211111','','','','','');
	END IF;
	-- 공급처테이블에서 vendor_id와 vendor_site_id를 가져온다
	--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
	--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
	--		  from efin_supplier_v
	--		 where org_id = C_ORG_ID
	--			and vat_registration_num = V_CUST_CODE; 
	C_TOT_AMT := 0;
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_DATE,V_AMT,V_CONT;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
			C_DR_ACNTCODE := '743411';
	-- 차변금액
			C_TOT_AMT := C_TOT_AMT + V_AMT;
	-- GL Interface 테이블에 자료를 생성한다.
			y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 가설재손료',last_day(as_date),last_day(as_date),
												C_DEPT_NAME,as_dept_code,V_AMT,'','',as_dept_code,C_PROJ,'',C_DR_ACNTCODE,
												'손료','자재','','',C_FOLDER,'',C_ORG_ID,C_DEPT_NAME,V_CONT,'V','','','','');
	END LOOP;
	CLOSE DETAIL_CUR;
-- GL Interface 테이블에 자료를 생성한다.
	y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 가설재손료',last_day(as_date),last_day(as_date),
										C_DEPT_NAME,as_dept_code,'',C_TOT_AMT,'',as_dept_code,C_PROJ,'','115351',
										'손료','자재','','',C_FOLDER,'',C_ORG_ID,C_DEPT_NAME,'가설재손료','V','','','','');
-- 테이블에 전표마스터번호를 Setting 한다.
		update m_tmat_proj_rent
			set invoice_num = C_GROUP_ID
		 where dept_code = as_dept_code
			AND trunc(month,'MM')= as_date
			AND decode(INVOICE_NUM,null,'0',f_slip_status(INVOICE_NUM)) IN ('0','C','3');
-- 배치화일을 Update 한다.
		y_sp_comm_slip_batch_flag(C_ORG_ID,'Journal');
      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '자재손료전표생성 실패! [Line No: 159]';
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
END y_sp_m_slip_tmat_rent;
