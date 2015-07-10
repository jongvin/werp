 /* ============================================================================ */
/* 함수명 : y_sp_m_slip_trans(gl)                  		                        */
/* 기  능 : 자재관리-전입전표 발행                                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 년월                   ==> as_date(DATE)        		               */
/*        : 입고순번               ==> ai_seq(INTEGER)        		               */
/*        : 결재선번호             ==> ai_unq_num(NUMBER)                        */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2005.08.02                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_slip_trans (as_dept_code    IN   VARCHAR2,
																	 as_date         IN   DATE,
																	 ai_seq          IN INTEGER, 
																	 ai_unq_num      IN   NUMBER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT ditag,amt,name || ssize cont1
  FROM m_input_detail 
 WHERE dept_code = as_dept_code
	AND yymmdd= as_date
   AND seq = ai_seq;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_DITAG             VARCHAR2(1);
	V_AMT               NUMBER(20,5);
	V_CONT              VARCHAR2(100);
	C_DEPT_CODE         VARCHAR2(10);
	C_DEPT_NAME1        VARCHAR2(50);
	C_DEPT_NAME2        VARCHAR2(50);
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
   C_CNT               NUMBER(20,5);  
	C_AMT               NUMBER(20,5);
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_INVOICE           VARCHAR2(50);
	C_TEMP              VARCHAR2(50);
	C_PROJ1             VARCHAR2(10);
	C_PROJ2             VARCHAR2(10);
	C_WORK_DT           VARCHAR2(10);
	C_FOLDER            VARCHAR2(10);
	C_SOURCE            VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(8);
	C_DR_ACNTCODE       VARCHAR2(8);
	C_VATNAME           VARCHAR2(50);
BEGIN
 BEGIN
-- 현장별 사업장코드를 가지고 온다	
		select relative_proj_code
		  into C_DEPT_CODE
 		  from m_input 
		 WHERE dept_code = as_dept_code
			AND yymmdd= as_date
			AND seq = ai_seq;
		select comp_code ,long_name
		  into C_COMP_CODE,C_DEPT_NAME1
 		  from z_code_dept 
		 where dept_code = as_dept_code;
		select long_name
		  into C_DEPT_NAME2
 		  from z_code_dept 
		 where dept_code = C_DEPT_CODE;
		C_SOURCE := '자재';
-- 현장별프로젝트코드를 구한다.
		select a.proj_code
		  into C_PROJ1
		 from ( select a.dept_code,c.proj_code
			 		 from  z_code_dept a,
						  ( select proj_unq_key,step     
								from r_proj_view_business_form) b,
							r_proj c
				   where a.proj_unq_key = b.proj_unq_key
					  and b.proj_unq_key = c.proj_unq_key
					  and b.step = c.step ) a
		 where a.dept_code =  as_dept_code;  
		select a.proj_code
		  into C_PROJ2
		 from ( select a.dept_code,c.proj_code
			 		 from  z_code_dept a,
						  ( select proj_unq_key,step     
								from r_proj_view_business_form) b,
							r_proj c
				   where a.proj_unq_key = b.proj_unq_key
					  and b.proj_unq_key = c.proj_unq_key
					  and b.step = c.step ) a
		 where a.dept_code =  C_DEPT_CODE;  
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
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_DITAG,V_AMT,V_CONT;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
-- 공급처 테이블에 거래처가 존재하는지 Check하여 미존재시 insert한다.
		IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,as_dept_code) = False THEN
-- Interface테이블에 거래처를 생성한다.
			y_sp_comm_slip_supplier(C_COMP_CODE,C_DEPT_NAME1,as_dept_code,'부서(현장)',as_dept_code,'211111','','','','','');
		END IF;
-- 공급처 테이블에 거래처가 존재하는지 Check하여 미존재시 insert한다.
		IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,C_DEPT_CODE) = False THEN
-- Interface테이블에 거래처를 생성한다.
			y_sp_comm_slip_supplier(C_COMP_CODE,C_DEPT_NAME2,C_DEPT_CODE,'부서(현장)',C_DEPT_CODE,'211111','','','','','');
		END IF;
		IF V_DITAG = '1' THEN
			C_DR_ACNTCODE := '115331';
		ELSE 
			C_DR_ACNTCODE := '115351';
		END IF;
-- 차변금액
		C_AMT := V_AMT * -1;
-- GL Interface 테이블에 자료를 생성한다.
		IF (C_AMT <> 0) THEN
			y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME2 || ' 전출',last_day(as_date),as_date,
												C_DEPT_NAME2,C_DEPT_CODE,C_AMT,'','',C_DEPT_CODE,C_PROJ2,'',C_DR_ACNTCODE,
												'전출','자재','','',C_FOLDER,'',C_ORG_ID,C_DEPT_NAME2,V_CONT,'V','','','','');
			y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME1 || ' 전출',last_day(as_date),as_date,
												C_DEPT_NAME1,as_dept_code,V_AMT,'','',as_dept_code,C_PROJ1,'',C_DR_ACNTCODE,
												'전출','자재','','',C_FOLDER,'',C_ORG_ID,C_DEPT_NAME1,V_CONT,'V','','','','');
		END IF;
	END LOOP;
	CLOSE DETAIL_CUR;
-- 테이블에 전표마스터번호를 Setting 한다.
			update m_input
				set invoice_num = C_GROUP_ID
			 where dept_code = as_dept_code
				and yymmdd = as_date
				and seq = ai_seq;
-- 배치화일을 Update 한다.
		y_sp_comm_slip_batch_flag(C_ORG_ID,'Journal');
      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '자재전입전표생성 실패! [Line No: 159]';
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
END y_sp_m_slip_trans;
/

