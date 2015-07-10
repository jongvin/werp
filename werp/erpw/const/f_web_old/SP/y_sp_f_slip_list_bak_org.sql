/* ============================================================================= */
/* 함수명 : y_sp_f_slip_list                                                     */
/* 기  능 : 자동전표생성마스터.                                                  */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 시작일                 ==> adt_from_date(date)                       */
/*        : 종료일                 ==> adt_to_date(date)                         */
/*        : 전표일                 ==> adt_slip_date(date)                       */
/*        : 발의자                 ==> as_slip_name(string)                      */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.08.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_slip_list(as_dept_code    IN   VARCHAR2,
                                        		adt_from_yymm   IN   DATE,
															adt_to_yymm     IN   DATE,
															adt_slip_date   IN   DATE,
															as_slip_name    IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
  SELECT a.RES_TYPE,   
     		a.RQST_DETAIL,
         a.cust_code, 
     		a.VATCODE,  
     		a.RECEIPT_DATE,
			a.rqst_date,
			a.seq
	FROM  ( SELECT max(a.RES_TYPE) res_type,  
						max(a.RQST_DETAIL) RQST_DETAIL,
						max(a.cust_code) cust_code,
						max(a.VATCODE) VATCODE,
						max(a.RECEIPT_DATE) RECEIPT_DATE,
						max(a.rqst_date) rqst_date,
						max(a.seq)  seq
				 FROM F_REQUEST a
				WHERE ( a.DEPT_CODE =  as_dept_code  ) AND  
						( a.RQST_DATE >= adt_from_yymm  )  AND
						( a.RQST_DATE <= adt_to_yymm    ) and 
						( a.ACNTCODE is not null) and 
						( a.vatcode is null)
			GROUP BY a.dept_code ,a.res_type,a.cust_code
			union all 
			  SELECT a.RES_TYPE,   
						a.RQST_DETAIL,
						a.cust_code, 
						a.VATCODE,  
						a.RECEIPT_DATE,
						a.rqst_date,
						a.seq
				 FROM F_REQUEST a   
				WHERE ( a.DEPT_CODE = as_dept_code ) AND  
						( a.RQST_DATE >= adt_from_yymm )  AND 
						( a.RQST_DATE <=  adt_to_yymm  ) and 
						( a.ACNTCODE is not null) and 
						( a.vatcode is not null)) a
ORDER BY a.RES_TYPE asc,a.cust_code asc;

-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   v_res_type         f_request.res_type%TYPE;
   v_rqst_detail      f_request.rqst_detail%TYPE;
   v_cust_code        f_request.cust_code%TYPE;
   v_vatcode          f_request.vatcode%TYPE;
   v_receipt_date     f_request.receipt_date%TYPE;
   v_rqst_date        f_request.rqst_date%TYPE;
   v_seq              f_request.seq%TYPE;
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_DATE			 DATE;
   C_CHK           VARCHAR2(1);
   C_CNT           NUMBER(10,3);
   C_WORK_NO       NUMBER(6,0);
	C_KIND_CODE     VARCHAR2(3);
	C_EVIDENCE_KIND VARCHAR2(3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_res_type,v_rqst_detail,v_cust_code,v_vatcode,v_receipt_date,v_rqst_date,v_seq;
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
						  SELECT CUST_CODE,'Y','Y',CUST_TYPE,CUST_NAME,'','','',REPRESENTATIVE_NAME,   
									'',BUSINESS_CONDITION,KIND_BUSINESSTYPE,TEL_NUMBER,FAX_NUMBER,ZIP_NUMBER,   
									ADDR,'','','',sysdate,'',null 
							 FROM Z_CODE_CUST_CODE  
							WHERE CUST_CODE = v_cust_code ;
				END IF;
			END IF;				

			IF v_res_type = 'S' THEN
				C_KIND_CODE := 'CM1';
			END IF;
			IF v_res_type = 'M' THEN
				C_KIND_CODE := 'CM2';
			END IF;
			IF v_res_type = 'E' THEN
				C_KIND_CODE := 'CM3';
			END IF;
			IF v_res_type = 'L' THEN
				C_KIND_CODE := 'CM4';
			END IF;
			IF v_res_type = 'X' THEN
				C_KIND_CODE := 'CM5';
			END IF;

			IF substrb(v_vatcode,1,1) = '2' THEN
				C_EVIDENCE_KIND := '011';
			ELSE IF substrb(v_vatcode,1,1) = 'B' THEN
					C_EVIDENCE_KIND := '021';
				ELSE
					C_EVIDENCE_KIND := '999';
				END IF;
			END IF;

		   e_msg      := '가전표 마스타 생성 실패! [Line No: 0]';
			INSERT INTO ERPC.AM_WORK_MASTER  
			VALUES ( adt_slip_date,C_SEQ,C_SEQ,'1',as_dept_code,C_KIND_CODE,'001',as_slip_name,sysdate,'1',v_cust_code,   
						v_receipt_date,C_EVIDENCE_KIND,0,'N','',null,'N','',null,'N','',null,null,'',0,'','N','',null )  ;


-- 가전표_디테일을 입력한다
		   e_msg      := '가전표 마스타 생성 실패! [Line No: 1]'|| C_SEQ || v_res_type;
			IF v_vatcode is null and v_cust_code is not null THEN
				Y_SP_F_SLIP_DETAIL1(as_dept_code,adt_from_yymm,adt_to_yymm,adt_slip_date,v_cust_code,v_res_type,C_KIND_CODE,C_SEQ);
			END IF;
			
		   e_msg      := '가전표 마스타 생성 실패! [Line No: 2]' || C_SEQ;
			IF v_vatcode is null and v_cust_code is null THEN
				Y_SP_F_SLIP_DETAIL2(as_dept_code,adt_from_yymm,adt_to_yymm,adt_slip_date,v_res_type,C_KIND_CODE,C_SEQ);
			END IF;
			
		   e_msg      := '가전표 마스타 생성 실패! [Line No: 3]';
			IF v_vatcode is not null THEN
				Y_SP_F_SLIP_DETAIL3(as_dept_code,v_rqst_date,v_seq,adt_slip_date,C_KIND_CODE,C_SEQ);
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
END y_sp_f_slip_list;

/
