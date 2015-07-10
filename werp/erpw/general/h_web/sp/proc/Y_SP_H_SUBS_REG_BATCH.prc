CREATE OR REPLACE PROCEDURE y_sp_h_subs_reg_batch(as_unq_no        IN   NUMBER,
                                                  as_dept_code     IN   VARCHAR2,
                                                  as_sell_code     IN   VARCHAR2) IS
CURSOR DETAIL_CUR IS
select cust_code, cust_name, seq_no, subs_order, reg_no,
       subs_date, dong, ho, phone, bank, process, error_process, error_data, error_data_message
  from h_subs_reg_batch
 where unq_no    = as_unq_no
   and dept_code = as_dept_code
	and sell_code = as_sell_code;


-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   C_CNT               INTEGER;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error

   C_CUST_CODE         H_SUBS_REG_BATCH.CUST_CODE%TYPE;
	C_CUST_NAME         H_SUBS_REG_BATCH.CUST_NAME%TYPE;
	C_SEQ_NO            H_SUBS_REG_BATCH.SEQ_NO%TYPE;
	C_SUBS_ORDER        H_SUBS_REG_BATCH.SUBS_ORDER%TYPE;
	C_REG_NO            H_SUBS_REG_BATCH.REG_NO%TYPE;
	C_SUBS_DATE         H_SUBS_REG_BATCH.SUBS_DATE%TYPE;
	C_DONG              H_SUBS_REG_BATCH.DONG%TYPE;
	C_HO                H_SUBS_REG_BATCH.HO%TYPE;
	C_PHONE             H_SUBS_REG_BATCH.PHONE%TYPE;
	C_BANK              H_SUBS_REG_BATCH.BANK%TYPE;
	C_PROCESS           H_SUBS_REG_BATCH.PROCESS%TYPE;
	C_ERROR_PROCESS     H_SUBS_REG_BATCH.ERROR_PROCESS%TYPE;
	C_ERROR_DATA        H_SUBS_REG_BATCH.ERROR_DATA%TYPE;
	C_ERROR_DATA_MESSAGE H_SUBS_REG_BATCH.ERROR_DATA_MESSAGE%TYPE;
	C_PYONG             H_SUBS_MASTER.PYONG%TYPE;
	C_STYLE             H_SUBS_MASTER.STYLE%TYPE;
	c_subs_no            integer;
	sql_stmt            VARCHAR2(100);
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN

		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO C_CUST_CODE, C_CUST_NAME,C_SEQ_NO,C_SUBS_ORDER,C_REG_NO,
	                            C_SUBS_DATE,C_DONG,C_HO,C_PHONE,C_BANK,C_PROCESS,
	                            C_ERROR_PROCESS,C_ERROR_DATA,C_ERROR_DATA_MESSAGE;
			EXIT WHEN DETAIL_CUR%NOTFOUND;

			SELECT COUNT(*)
			  INTO C_CNT
			  FROM H_CODE_CUST
			 WHERE CUST_CODE = C_CUST_CODE;

			IF C_CNT = 0 THEN
			   INSERT INTO H_CODE_CUST (CUST_CODE,   CUST_NAME,   CUST_DIV, CUST_DIV2, HOME_PHONE, DM_DEMAND)  
				       VALUES           (C_CUST_CODE, C_CUST_NAME, '01',     '01',      C_PHONE,    '01');
			END IF;

			SELECT COUNT(*)
			  INTO C_CNT
			  FROM H_SUBS_MASTER
			 WHERE DEPT_CODE = as_dept_code
			   AND SELL_CODE = as_sell_code
				AND CUST_CODE = C_CUST_CODE
				AND SUBS_DATE IS NOT NULL;

			IF C_CNT < 1 THEN

				select nvl(max(subs_no), 0)
				  into c_subs_no
				  from h_subs_master
				 where dept_code = as_dept_code
				   and sell_code = as_sell_code;
            BEGIN
					SELECT PYONG, STYLE
					  INTO C_PYONG, C_STYLE
					  FROM H_SALE_MASTER
					 WHERE DEPT_CODE = AS_DEPT_CODE
					   AND SELL_CODE = AS_SELL_CODE
						AND DONGHO = C_DONG||C_HO
						AND SEQ    = 1;
				EXCEPTION
				WHEN NO_DATA_FOUND       THEN
					  C_PROCESS := 'Y';
					  C_ERROR_PROCESS := 'Y';
					  C_ERROR_DATA    := 'Y';
					  C_ERROR_DATA_MESSAGE := '동호가 없습니다. 확인요망';
					  GOTO UPDATE_BATCH;
				END;

				INSERT INTO H_SUBS_MASTER
				VALUES (as_dept_code, as_sell_code, c_subs_no + 1, C_CUST_CODE, '', '',
						   '', '', C_PYONG,  C_STYLE, '', '', '', C_SUBS_ORDER, '',
						   C_SUBS_DATE, C_DONG||C_HO, 0, 0, NULL, '', '', '', '', 0, '', '01', '');

				C_PROCESS := 'Y';
				C_ERROR_PROCESS := 'N';
				C_ERROR_DATA    := 'N';
				C_ERROR_DATA_MESSAGE := '청약마스터 자동 등록';
			ELSE IF C_CNT >= 1 THEN

					   C_PROCESS := 'Y';
						C_ERROR_PROCESS := 'Y';
						C_ERROR_DATA    := 'Y';
						C_ERROR_DATA_MESSAGE := '청약마스터에 해당 당첨자가 중복 등록되있슴 확인요망';
						GOTO UPDATE_BATCH;
				  END IF;

			   C_PROCESS := 'Y';
				C_ERROR_PROCESS := 'N';
				C_ERROR_DATA    := 'N';
				C_ERROR_DATA_MESSAGE := '';
			END IF;

         UPDATE H_SUBS_MASTER  --한현장에 특정청약자가 한번이상 등록 되지 않는 전제
			   SET SUBS_DATE = C_SUBS_DATE,
				    SUBS_ORDER = C_SUBS_ORDER,
					 PRIZE_DONGHO = C_DONG||C_HO
			 WHERE DEPT_CODE = as_dept_code
			   AND SELL_CODE = as_sell_code
				AND CUST_CODE = C_CUST_CODE
				AND SUBS_NO   = C_REG_NO;


		   <<UPDATE_BATCH>>
			UPDATE H_SUBS_REG_BATCH
			   set process = c_process,
				    error_process = c_error_process,
					 error_data    = c_error_data,
					 error_data_message = c_error_data_message
			 where unq_no    = as_unq_no
			   and dept_code = as_dept_code
				and sell_code = as_sell_code
				and cust_code = c_cust_code
				and seq_no    = c_seq_no;

			commit;

		END LOOP;
		CLOSE DETAIL_CUR;



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
END y_sp_h_subs_reg_batch;
/

