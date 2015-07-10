CREATE OR REPLACE PACKAGE BODY H_Calc_Income_Lease IS

PROCEDURE y_sp_h_lease_calc(as_dept_code              IN   VARCHAR2,
															  as_sell_code              IN   VARCHAR2,
															  as_cont_date                 IN   DATE,
															  as_cont_seq                    IN   INTEGER,
                                               as_input_date             IN   DATE,
															  as_daily_seq              IN   INTEGER,
                                               as_input_amt              IN   NUMBER,
															  as_input_deposit          IN   VARCHAR2,
															  as_user                   IN   VARCHAR2 ) IS
CURSOR DETAIL_CUR (V_AGREE_DATE DATE, V_DAYS INTEGER )IS
SELECT rate,cutoff_std,cutoff_unit,s_date,e_date
  FROM H_LEASE_DELAY_RATE
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND cont_date  = as_cont_date
	AND cont_seq   = as_cont_seq
	AND rate_kind  = '04'
	AND e_date >= V_AGREE_DATE
	AND s_date <= as_input_date
	AND MNTH = (SELECT MIN(MNTH)
					  FROM H_LEASE_DELAY_RATE
					 WHERE dept_code  = as_dept_code
						AND sell_code  = as_sell_code
						AND cont_date  = as_cont_date
	               AND cont_seq   = as_cont_seq
						AND rate_kind  = '04'
						AND e_date >= V_AGREE_DATE
						AND s_date <= as_input_date
						AND ADD_MONTHS(V_AGREE_DATE, MNTH) > as_input_date);
CURSOR DETAIL_CUR1 (V_AGREE_DATE DATE )IS
SELECT rate,cutoff_std,cutoff_unit,s_date,e_date
  FROM H_LEASE_DISCOUNT_RATE
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND cont_date  = as_cont_date
	AND cont_seq   = as_cont_seq
	AND rate_kind  = '03'
	AND e_date >= as_input_date
	AND s_date <= V_AGREE_DATE;
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   C_LAST_DEGREE       H_LEASE_GRT_AGREE.DEGREE_CODE%TYPE;    -- 마지막약정차수
   C_MAX_DEGREE        H_LEASE_GRT_AGREE.DEGREE_CODE%TYPE;    -- 마지막약정차수(잔금,인상분 포함)
   C_LAST_SEQ          H_LEASE_GRT_INCOME.DEGREE_SEQ%TYPE;    -- 마지막회수
   C_AGREE_DATE        H_LEASE_GRT_AGREE.AGREE_DATE%TYPE;     -- 약정일자
   C_LEASE_AMT         H_LEASE_GRT_AGREE.AMT%TYPE;       -- 약정금액
   C_DELAY_AMT         H_LEASE_GRT_AGREE.AMT%TYPE;       -- 연체료
   C_DISCOUNT_AMT      H_LEASE_GRT_AGREE.AMT%TYPE;       -- 할인료
   C_DELAY_DAY         H_LEASE_GRT_INCOME.DISCOUNT_DAYS%TYPE;       -- 연체일자
   C_DISCOUNT_DAY      H_LEASE_GRT_INCOME.DISCOUNT_DAYS%TYPE;       -- 할인일자
   C_R_AMT             H_LEASE_GRT_AGREE.AMT%TYPE;       -- 납입금액
   C_WORK_AMT          H_LEASE_GRT_AGREE.AMT%TYPE;       -- 약정대상금액
   C_TEMP_AMT          H_LEASE_GRT_AGREE.AMT%TYPE;       -- 약정계산금액
   C_S_DATE        	  H_LEASE_GRT_AGREE.AGREE_DATE%TYPE;     -- 시작일자
   C_E_DATE        	  H_LEASE_GRT_AGREE.AGREE_DATE%TYPE;     -- 종료일자
   C_FR_DATE        	  H_LEASE_GRT_AGREE.AGREE_DATE%TYPE;     -- 입주개시일
   C_TO_DATE        	  H_LEASE_GRT_AGREE.AGREE_DATE%TYPE;     -- 입주종료일
	C_DAILY_SEQ         H_LEASE_GRT_INCOME_DAILY.DAILY_SEQ%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
	C_VAT_YN					VARCHAR2(1);
	C_PAY_YN					VARCHAR2(1);
	C_R_CONT_YN				VARCHAR2(1);
	C_R_REMAIND_YN			VARCHAR2(1);
	C_CUTOFF_STD			VARCHAR2(2);
	C_CUTOFF_UNIT			VARCHAR2(2);
	C_COMP_UNIT				INTEGER;
   C_RATE               NUMBER(30,9);  --
   C_TEMP_RATE          NUMBER(30,9);  --
   C_DAYS               NUMBER(30,9);  --
   C_TEMP_CNT           NUMBER(10,5);  -- 공제일자
   C_CNT                NUMBER(10,5);  --
   c_input_amt          NUMBER(30,9);  --
   C_LEASE_SUPPLY       NUMBER(30,9);  --
   C_LEASE_VAT          NUMBER(30,9);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN

		-- &&&&&&&&&&&&&&
		-- 임대료 연체료 계산 여부를 구한다.분양구분테이블
		SELECT NVL(lease_delay_yn,'N')
		  INTO C_R_CONT_YN
		  FROM H_CODE_HOUSE
		 WHERE dept_code = as_dept_code
			AND sell_code = as_sell_code;
		-- 임대료 할인료는 계산하지 않는다.
      C_R_REMAIND_YN := 'N' ;
	--
		SELECT NVL(MAX(degree_code), '50')
		  INTO C_MAX_DEGREE
		  FROM H_LEASE_GRT_AGREE
		 WHERE dept_code     = as_dept_code
			AND sell_code     = as_sell_code
			AND cont_date        = as_cont_date
			AND cont_seq           = as_cont_seq;
		c_input_amt := as_input_amt;
-- 마지막 약정차수 및 회수를 구한다.
		SELECT COUNT(*)
		  INTO C_CNT
		  FROM H_LEAS_LEASE_AGREE
		 WHERE dept_code     = as_dept_code
			AND sell_code     = as_sell_code
			AND dongho        = as_dongho
			AND seq           = as_seq
			AND f_pay_yn      = 'N';
		IF C_CNT > 0 THEN
			SELECT MIN(degree_code)
			  INTO C_LAST_DEGREE
			  FROM H_LEAS_LEASE_AGREE
			 WHERE dept_code     = as_dept_code
				AND sell_code     = as_sell_code
				AND dongho        = as_dongho
				AND seq      		= as_seq
			 	AND f_pay_yn      = 'N';
			SELECT NVL(MAX(degree_seq),0)
			  INTO C_LAST_SEQ
			  FROM H_LEAS_LEASE_INCOME
			 WHERE dept_code     = as_dept_code
				AND sell_code     = as_sell_code
				AND dongho        = as_dongho
				AND seq           = as_seq
			 	AND degree_code   = C_LAST_DEGREE;
			C_LAST_SEQ := C_LAST_SEQ + 1;
		ELSE
			SELECT COUNT(*)
			  INTO C_CNT
			  FROM H_LEAS_LEASE_AGREE
			 WHERE dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq;
-- 마지막 차수에 초과 납부를 처리하기 위하여
 			IF C_CNT < 1 THEN
   			Wk_errflag := '-20002';
		      e_msg  := ' 약정차수가 없습니다. 동호==>' || as_dongho;
 	         GOTO EXIT_ROUTINE;
 			END IF;
			SELECT MAX(degree_code)
			  INTO C_LAST_DEGREE
			  FROM H_LEAS_LEASE_AGREE
			 WHERE dept_code     = as_dept_code
				AND sell_code     = as_sell_code
				AND dongho        = as_dongho
				AND seq      		= as_seq  ;
			SELECT NVL(MAX(degree_seq),0)
			  INTO C_LAST_SEQ
			  FROM H_LEAS_LEASE_INCOME
			 WHERE dept_code     = as_dept_code
				AND sell_code     = as_sell_code
				AND dongho        = as_dongho
				AND seq           = as_seq
			 	AND degree_code   = C_LAST_DEGREE;
			IF C_LAST_SEQ < 70 THEN
				C_LAST_SEQ := 70;
			ELSE
				C_LAST_SEQ := C_LAST_SEQ + 1;
			END IF;
		END IF;
-- LOOP 시작
		LOOP
	-- 일수 및 약정금액을 구한다
			SELECT NVL((agree_date - as_input_date) * -1,0),NVL(LEASE_AMT,0),agree_date,vat_yn
			  INTO C_DAYS,C_LEASE_AMT,C_AGREE_DATE,C_VAT_YN
			  FROM H_LEAS_LEASE_AGREE
			 WHERE dept_code     = as_dept_code
				AND sell_code     = as_sell_code
				AND dongho        = as_dongho
				AND seq           = as_seq
			 	AND degree_code   = C_LAST_DEGREE;
	-- 휴일적용여부를 체크한다.
			IF C_DAYS > 0 THEN -- 연체료일 경우
				SELECT COUNT(*),NVL(MAX(process_days),0)
				  INTO C_CNT,C_TEMP_CNT
				  FROM H_DEPT_HOLIDAY
				 WHERE dept_code = as_dept_code
					AND sell_code = as_sell_code
					AND delay_discount_div = '1'
					AND yymmdd = C_AGREE_DATE;
				IF C_CNT > 0 THEN
					IF C_DAYS <= C_TEMP_CNT THEN
						C_DAYS := 0;
					END IF;
				ELSE
					SELECT COUNT(*),NVL(MAX(process_days),0)
					  INTO C_CNT,C_TEMP_CNT
					  FROM H_COM_HOLIDAY
					 WHERE yymmdd = C_AGREE_DATE;
					IF C_CNT > 0 THEN
						IF C_DAYS <= C_TEMP_CNT THEN
							C_DAYS := 0;
						END IF;
					END IF;
				END IF;
			END IF;
			IF C_DAYS < 0 THEN -- 할인료일 경우
				SELECT COUNT(*),NVL(MAX(process_days),0)
				  INTO C_CNT,C_TEMP_CNT
				  FROM H_DEPT_HOLIDAY
				 WHERE dept_code = as_dept_code
					AND sell_code = as_sell_code
					AND delay_discount_div = '2'
					AND yymmdd = C_AGREE_DATE;
				IF C_CNT > 0 THEN
					C_CNT := C_DAYS * -1;
					IF C_CNT <= C_TEMP_CNT THEN
						C_DAYS := 0;
					END IF;
				ELSE
					SELECT COUNT(*),NVL(MAX(process_days),0)
					  INTO C_CNT,C_TEMP_CNT
					  FROM H_COM_HOLIDAY
					 WHERE yymmdd = C_AGREE_DATE;
					IF C_CNT > 0 THEN
						C_CNT := C_DAYS * -1;
						IF C_CNT <= C_TEMP_CNT THEN
							C_DAYS := 0;
						END IF;
					END IF;
				END IF;
			END IF;
	-- 기납입금액누계를 구한다.
			SELECT NVL(SUM(r_amt),0)
			  INTO C_R_AMT
			  FROM H_LEAS_LEASE_INCOME
			 WHERE dept_code     = as_dept_code
				AND sell_code     = as_sell_code
				AND dongho        = as_dongho
				AND seq           = as_seq
			 	AND degree_code   = C_LAST_DEGREE;
	-- 계산할 약정금액을 구한다(대상금액).
			C_WORK_AMT := C_LEASE_AMT - C_R_AMT;
	-----------------------------------------------------------------------------
	-- 일수가 0일경우 바로 입금처리, +일경우 연체료, -일경우 할인료를 계산한다.
	-----------------------------------------------------------------------------
			IF C_LAST_SEQ > 69 THEN
				C_TEMP_AMT := c_input_amt;
				c_input_amt := 0;
				C_DELAY_DAY    := 0;
				C_DISCOUNT_DAY := 0;
				C_DELAY_AMT    := 0;
				C_DISCOUNT_AMT := 0;
			ELSE
				IF C_DAYS = 0  THEN
					IF C_WORK_AMT < c_input_amt THEN
						C_TEMP_AMT   := C_WORK_AMT;
						c_input_amt := c_input_amt - C_WORK_AMT;
					ELSE
						C_TEMP_AMT   := c_input_amt;
						c_input_amt := 0;
					END IF;
					C_DELAY_DAY    := 0;
					C_DISCOUNT_DAY := 0;
					C_DELAY_AMT    := 0;
					C_DISCOUNT_AMT := 0;
				ELSE
					IF C_DAYS > 0 THEN
						C_DELAY_DAY    := 0;
						C_DISCOUNT_DAY := 0;
						C_DELAY_AMT    := 0;
						C_DISCOUNT_AMT := 0;
						IF C_R_CONT_YN = 'Y' THEN             -- &&&&&&&&&&&&&&&&&&&&&&
							C_DELAY_DAY   := C_DAYS;
							C_TEMP_RATE := 0;
						-- 납입대상금액계산
							OPEN	DETAIL_CUR(C_AGREE_DATE,C_DAYS);
							LOOP
								FETCH DETAIL_CUR INTO C_RATE,C_CUTOFF_STD,C_CUTOFF_UNIT,C_S_DATE,C_E_DATE;
								EXIT WHEN DETAIL_CUR%NOTFOUND;
								IF C_AGREE_DATE >= C_S_DATE AND as_input_date <= C_E_DATE THEN
									C_TEMP_RATE := ( C_DELAY_DAY / 365 ) * ( C_RATE / 100 ) ;
									EXIT;
								END IF;
								IF C_AGREE_DATE >= C_S_DATE THEN
									SELECT NVL(C_E_DATE - C_AGREE_DATE ,0)
									  INTO C_TEMP_CNT
									  FROM dual;
								ELSE
									IF as_input_date <= C_E_DATE THEN
										SELECT NVL(as_input_date - C_S_DATE + 1,0)
										  INTO C_TEMP_CNT
										  FROM dual;
									ELSE
										SELECT NVL(C_E_DATE - C_S_DATE + 1,0)
										  INTO C_TEMP_CNT
										  FROM dual;
									END IF;
								END IF;
								C_TEMP_RATE := C_TEMP_RATE + (C_TEMP_CNT / 365) * (C_RATE / 100);
							END LOOP;
							CLOSE DETAIL_CUR;
							C_TEMP_RATE := C_TEMP_RATE + 1;
							IF C_TEMP_RATE <> 0 THEN
								C_TEMP_AMT := c_input_amt / C_TEMP_RATE; -- 납입대상금액
							ELSE
								C_TEMP_AMT := 0;
							END IF;
							IF C_WORK_AMT <= C_TEMP_AMT THEN
								OPEN	DETAIL_CUR(C_AGREE_DATE,C_DAYS);
								LOOP
									FETCH DETAIL_CUR INTO C_RATE,C_CUTOFF_STD,C_CUTOFF_UNIT,C_S_DATE,C_E_DATE;
									EXIT WHEN DETAIL_CUR%NOTFOUND;
									C_COMP_UNIT :=
										CASE C_CUTOFF_UNIT
											WHEN '01' THEN 1
											WHEN '02' THEN 10
											WHEN '03' THEN 100
											WHEN '04' THEN 1000
											WHEN '05' THEN 10000
											WHEN '06' THEN 100000
											ELSE 1
										END;
									IF C_AGREE_DATE >= C_S_DATE AND as_input_date <= C_E_DATE THEN
										C_TEMP_RATE := 1 + ( C_DELAY_DAY / 365 ) * ( C_RATE / 100 ) ;
										IF C_CUTOFF_STD = '01' THEN
											C_DELAY_AMT := TRUNC(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
										ELSE
											IF C_CUTOFF_STD = '02' THEN
												C_DELAY_AMT := TRUNC(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
											ELSE
												C_DELAY_AMT := ROUND(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
											END IF;
										END IF;
										EXIT;
									END IF;
									IF C_AGREE_DATE >= C_S_DATE THEN
										SELECT NVL(C_E_DATE - C_AGREE_DATE ,0)
										  INTO C_TEMP_CNT
										  FROM dual;
									ELSE
										IF as_input_date <= C_E_DATE THEN
											SELECT NVL(as_input_date - C_S_DATE + 1,0)
											  INTO C_TEMP_CNT
											  FROM dual;
										ELSE
											SELECT NVL(C_E_DATE - C_S_DATE + 1,0)
											  INTO C_TEMP_CNT
											  FROM dual;
										END IF;
									END IF;
									C_TEMP_RATE := 1 + (C_TEMP_CNT / 365) * (C_RATE / 100);
									IF C_CUTOFF_STD = '01' THEN
										C_DELAY_AMT := C_DELAY_AMT + TRUNC(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
									ELSE
										IF C_CUTOFF_STD = '02' THEN
											C_DELAY_AMT := C_DELAY_AMT + TRUNC(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
										ELSE
											C_DELAY_AMT := C_DELAY_AMT + ROUND(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
										END IF;
									END IF;
								END LOOP;
								CLOSE DETAIL_CUR;
								C_TEMP_AMT := C_WORK_AMT;
								c_input_amt := c_input_amt - (C_WORK_AMT + C_DELAY_AMT);
							ELSE
								OPEN	DETAIL_CUR(C_AGREE_DATE,C_DAYS);
								LOOP
									FETCH DETAIL_CUR INTO C_RATE,C_CUTOFF_STD,C_CUTOFF_UNIT,C_S_DATE,C_E_DATE;
									EXIT WHEN DETAIL_CUR%NOTFOUND;
									C_COMP_UNIT :=
										CASE C_CUTOFF_UNIT
											WHEN '01' THEN 1
											WHEN '02' THEN 10
											WHEN '03' THEN 100
											WHEN '04' THEN 1000
											WHEN '05' THEN 10000
											WHEN '06' THEN 100000
											ELSE 1
										END;
									IF C_AGREE_DATE >= C_S_DATE AND as_input_date <= C_E_DATE THEN
										C_TEMP_RATE := 1 + ( C_DELAY_DAY / 365 ) * ( C_RATE / 100 ) ;
										C_TEMP_AMT := c_input_amt / C_TEMP_RATE;
										IF C_CUTOFF_STD = '01' THEN
											C_DELAY_AMT := TRUNC((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
										ELSE
											IF C_CUTOFF_STD = '02' THEN
												C_DELAY_AMT := TRUNC((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
											ELSE
												C_DELAY_AMT := ROUND((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
											END IF;
										END IF;
										EXIT;
									END IF;
									IF C_AGREE_DATE >= C_S_DATE THEN
										SELECT NVL(C_E_DATE - C_AGREE_DATE ,0)
										  INTO C_TEMP_CNT
										  FROM dual;
									ELSE
										IF as_input_date <= C_E_DATE THEN
											SELECT NVL(as_input_date - C_S_DATE + 1,0)
											  INTO C_TEMP_CNT
											  FROM dual;
										ELSE
											SELECT NVL(C_E_DATE - C_S_DATE + 1,0)
											  INTO C_TEMP_CNT
											  FROM dual;
										END IF;
									END IF;
									C_TEMP_RATE := 1 + (C_TEMP_CNT / 365) * (C_RATE / 100);
									IF C_TEMP_RATE <> 0 THEN
										C_TEMP_AMT := c_input_amt / C_TEMP_RATE;
									ELSE
										C_TEMP_AMT := 0;
									END IF;
									IF C_CUTOFF_STD = '01' THEN
										C_DELAY_AMT := C_DELAY_AMT + TRUNC((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
									ELSE
										IF C_CUTOFF_STD = '02' THEN
											C_DELAY_AMT := C_DELAY_AMT + TRUNC((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
										ELSE
											C_DELAY_AMT := C_DELAY_AMT + ROUND((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
										END IF;
									END IF;
								END LOOP;
								CLOSE DETAIL_CUR;
								C_TEMP_AMT   := c_input_amt - C_DELAY_AMT;
								c_input_amt := 0;
							END IF;
						ELSE                 --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- 						if C_R_CONT_YN <> 'Y' then          --   &&&&&&&&&&&&&&&&&&&&&&&&
--							C_DELAY_AMT := 0;
--							C_TEMP_AMT  := c_input_amt;
							IF C_WORK_AMT < c_input_amt THEN
								C_TEMP_AMT   := C_WORK_AMT;
								c_input_amt := c_input_amt - C_WORK_AMT;
							ELSE
								C_TEMP_AMT   := c_input_amt;
								c_input_amt := 0;
							END IF;
						END IF;
					ELSE
						C_DELAY_DAY    := 0;
						C_DISCOUNT_DAY := 0;
						C_DELAY_AMT    := 0;
						C_DISCOUNT_AMT := 0;
						IF C_R_REMAIND_YN = 'Y' THEN  -- 할인료계산
							C_DISCOUNT_DAY   := C_DAYS * -1;
							C_TEMP_RATE := 0;
							-- 납입대상금액계산
							OPEN	DETAIL_CUR1(C_AGREE_DATE);
							LOOP
								FETCH DETAIL_CUR1 INTO C_RATE,C_CUTOFF_STD,C_CUTOFF_UNIT,C_S_DATE,C_E_DATE;
								EXIT WHEN DETAIL_CUR1%NOTFOUND;
								IF C_AGREE_DATE <= C_E_DATE AND as_input_date >= C_S_DATE THEN
									C_TEMP_RATE := ( C_DISCOUNT_DAY / 365 ) * ( C_RATE / 100 ) ;
									EXIT;
								END IF;
								IF as_input_date >= C_S_DATE THEN
									SELECT NVL(C_E_DATE - as_input_date ,0)
									  INTO C_TEMP_CNT
									  FROM dual;
								ELSE
									IF C_AGREE_DATE <= C_E_DATE THEN
										SELECT NVL(C_AGREE_DATE - C_S_DATE + 1,0)
										  INTO C_TEMP_CNT
										  FROM dual;
									ELSE
										SELECT NVL(C_E_DATE - C_S_DATE + 1,0)
										  INTO C_TEMP_CNT
										  FROM dual;
									END IF;
								END IF;
								C_TEMP_RATE := C_TEMP_RATE + (C_TEMP_CNT / 365) * (C_RATE / 100);
							END LOOP;
							CLOSE DETAIL_CUR1;
							C_TEMP_RATE := 1 - C_TEMP_RATE ;
							IF C_TEMP_RATE <> 0 THEN
								C_TEMP_AMT := c_input_amt / C_TEMP_RATE; -- 납입대상금액
							ELSE
								C_TEMP_AMT := 0;
							END IF;
							IF C_WORK_AMT <= C_TEMP_AMT THEN
								OPEN	DETAIL_CUR1(C_AGREE_DATE);
								LOOP
									FETCH DETAIL_CUR1 INTO C_RATE,C_CUTOFF_STD,C_CUTOFF_UNIT,C_S_DATE,C_E_DATE;
									EXIT WHEN DETAIL_CUR1%NOTFOUND;
									C_COMP_UNIT :=
										CASE C_CUTOFF_UNIT
											WHEN '01' THEN 1
											WHEN '02' THEN 10
											WHEN '03' THEN 100
											WHEN '04' THEN 1000
											WHEN '05' THEN 10000
											WHEN '06' THEN 100000
											ELSE 1
										END;
									IF C_AGREE_DATE <= C_E_DATE AND as_input_date >= C_S_DATE THEN
										C_TEMP_RATE := 1 - ( C_DISCOUNT_DAY / 365 ) * ( C_RATE / 100 ) ;
										IF C_CUTOFF_STD = '01' THEN
											C_DISCOUNT_AMT := TRUNC((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT,0) * C_COMP_UNIT;
										ELSE
											IF C_CUTOFF_STD = '02' THEN
												C_DISCOUNT_AMT := TRUNC((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
											ELSE
												C_DISCOUNT_AMT := ROUND((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT,0) * C_COMP_UNIT;
											END IF;
										END IF;
										EXIT;
									END IF;
									IF as_input_date >= C_S_DATE THEN
										SELECT NVL(C_E_DATE - as_input_date ,0)
										  INTO C_TEMP_CNT
										  FROM dual;
									ELSE
										IF C_AGREE_DATE <= C_E_DATE THEN
											SELECT NVL(C_AGREE_DATE - C_S_DATE + 1,0)
											  INTO C_TEMP_CNT
											  FROM dual;
										ELSE
											SELECT NVL(C_E_DATE - C_S_DATE + 1,0)
											  INTO C_TEMP_CNT
											  FROM dual;
										END IF;
									END IF;
									C_TEMP_RATE := 1 - (C_TEMP_CNT / 365) * (C_RATE / 100);
									IF C_CUTOFF_STD = '01' THEN
										C_DISCOUNT_AMT := C_DISCOUNT_AMT + TRUNC((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT,0) * C_COMP_UNIT;
									ELSE
										IF C_CUTOFF_STD = '02' THEN
											C_DISCOUNT_AMT := C_DISCOUNT_AMT + TRUNC((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
										ELSE
											C_DISCOUNT_AMT := C_DISCOUNT_AMT + ROUND((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT,0) * C_COMP_UNIT;
										END IF;
									END IF;
								END LOOP;
								CLOSE DETAIL_CUR1;
								C_TEMP_AMT := C_WORK_AMT;
								c_input_amt := c_input_amt - (C_WORK_AMT - C_DISCOUNT_AMT);
							ELSE
								OPEN	DETAIL_CUR1(C_AGREE_DATE);
								LOOP
									FETCH DETAIL_CUR1 INTO C_RATE,C_CUTOFF_STD,C_CUTOFF_UNIT,C_S_DATE,C_E_DATE;
									EXIT WHEN DETAIL_CUR1%NOTFOUND;
									C_COMP_UNIT :=
										CASE C_CUTOFF_UNIT
											WHEN '01' THEN 1
											WHEN '02' THEN 10
											WHEN '03' THEN 100
											WHEN '04' THEN 1000
											WHEN '05' THEN 10000
											WHEN '06' THEN 100000
											ELSE 1
										END;
									IF C_AGREE_DATE <= C_E_DATE AND as_input_date >= C_S_DATE THEN
										C_TEMP_RATE := 1 - ( C_DISCOUNT_DAY / 365 ) * ( C_RATE / 100 ) ;
										C_TEMP_AMT := c_input_amt / C_TEMP_RATE;
										IF C_CUTOFF_STD = '01' THEN
											C_DISCOUNT_AMT := TRUNC((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
										ELSE
											IF C_CUTOFF_STD = '02' THEN
												C_DISCOUNT_AMT := TRUNC((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
											ELSE
												C_DISCOUNT_AMT := ROUND((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
											END IF;
										END IF;
										EXIT;
									END IF;
									IF as_input_date >= C_S_DATE THEN
										SELECT NVL(C_E_DATE - as_input_date ,0)
										  INTO C_TEMP_CNT
										  FROM dual;
									ELSE
										IF C_AGREE_DATE <= C_E_DATE THEN
											SELECT NVL(C_AGREE_DATE - C_S_DATE + 1,0)
											  INTO C_TEMP_CNT
											  FROM dual;
										ELSE
											SELECT NVL(C_E_DATE - C_S_DATE + 1,0)
											  INTO C_TEMP_CNT
											  FROM dual;
										END IF;
									END IF;
									C_TEMP_RATE := 1 - (C_TEMP_CNT / 365) * (C_RATE / 100);
									IF C_TEMP_RATE <> 0 THEN
										C_TEMP_AMT := c_input_amt / C_TEMP_RATE;
									ELSE
										C_TEMP_AMT := 0;
									END IF;
									IF C_CUTOFF_STD = '01' THEN
										C_DISCOUNT_AMT := C_DISCOUNT_AMT + TRUNC((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
									ELSE
										IF C_CUTOFF_STD = '02' THEN
											C_DISCOUNT_AMT := C_DISCOUNT_AMT + TRUNC((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
										ELSE
											C_DISCOUNT_AMT := C_DISCOUNT_AMT + ROUND((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
										END IF;
									END IF;
								END LOOP;
								CLOSE DETAIL_CUR1;
								C_TEMP_AMT   := c_input_amt + C_DISCOUNT_AMT;
								c_input_amt := 0;
							END IF;
						ELSE
							IF C_WORK_AMT < c_input_amt THEN
								C_TEMP_AMT   := C_WORK_AMT;
								c_input_amt := c_input_amt - C_WORK_AMT;
							ELSE
								C_TEMP_AMT   := c_input_amt;
								c_input_amt := 0;
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;
	-----------------------------------------------------------------------------
	-----------------------------------------------------------------------------
	-- 계산된 값을 분양_보증금납입에 넣어준다.
			IF C_VAT_YN = 'Y' THEN
				C_LEASE_SUPPLY := TRUNC(C_TEMP_AMT / 1.1,0);
				C_LEASE_VAT    := C_TEMP_AMT - C_LEASE_SUPPLY ;
			ELSE
				C_LEASE_SUPPLY := C_TEMP_AMT;
				C_LEASE_VAT    := 0;
			END IF;
			INSERT INTO H_LEAS_LEASE_INCOME
				VALUES ( as_dept_code,as_sell_code,as_dongho,as_seq,C_LAST_DEGREE,C_LAST_SEQ,
							as_input_date,as_input_deposit,C_TEMP_AMT,C_LEASE_SUPPLY,C_LEASE_VAT,
							C_DELAY_DAY,C_DELAY_AMT,C_DISCOUNT_DAY,C_DISCOUNT_AMT,NULL,0,as_user,SYSDATE,'N',as_daily_seq )  ;
	-- 기납입금액누계를 구한다.
			SELECT NVL(SUM(r_amt),0)
			  INTO C_R_AMT
			  FROM H_LEAS_LEASE_INCOME
			 WHERE dept_code     = as_dept_code
				AND sell_code     = as_sell_code
				AND dongho        = as_dongho
				AND seq           = as_seq
			 	AND degree_code   = C_LAST_DEGREE;
	-- 입금완료구분값을 구한다.
			IF C_LEASE_AMT <= C_R_AMT THEN
				C_PAY_YN := 'Y';
			ELSE
				C_PAY_YN := 'N';
			END IF;
	-- 약정사항에 입금완료구분값과 입금합계값을 넣어준다.
			UPDATE H_LEAS_LEASE_AGREE
				SET F_PAY_YN = C_PAY_YN,
					 PAY_TOT_AMT = C_R_AMT
			 WHERE dept_code     = as_dept_code
				AND sell_code     = as_sell_code
				AND dongho        = as_dongho
				AND seq           = as_seq
			 	AND degree_code   = C_LAST_DEGREE;
	-- 납입금액이 0이면 종료한다.
         IF c_input_amt = 0 THEN
            EXIT;
         END IF;
	-- 납입금액이 0가 아니면 다음차수를 구하여 나머지금액처리를 한다.
			SELECT COUNT(*)
			  INTO C_CNT
			  FROM H_LEAS_LEASE_AGREE
			 WHERE dept_code     = as_dept_code
				AND sell_code     = as_sell_code
				AND dongho        = as_dongho
				AND seq           = as_seq
				AND degree_code > C_LAST_DEGREE;
			IF C_CNT > 0 THEN
				SELECT MIN(degree_code)
				  INTO C_LAST_DEGREE
				  FROM H_LEAS_LEASE_AGREE
				 WHERE dept_code     = as_dept_code
					AND sell_code     = as_sell_code
					AND dongho        = as_dongho
					AND seq           = as_seq
					AND degree_code   > C_LAST_DEGREE;
				SELECT NVL(MAX(degree_seq),0)
				  INTO C_LAST_SEQ
				  FROM H_LEAS_LEASE_INCOME
				 WHERE dept_code     = as_dept_code
					AND sell_code     = as_sell_code
					AND dongho        = as_dongho
					AND seq           = as_seq
					AND degree_code   = C_LAST_DEGREE;
				C_LAST_SEQ := C_LAST_SEQ + 1;
			ELSE
				SELECT NVL(MAX(degree_seq),0)
				  INTO C_LAST_SEQ
				  FROM H_LEAS_LEASE_INCOME
				 WHERE dept_code     = as_dept_code
					AND sell_code     = as_sell_code
					AND dongho        = as_dongho
					AND seq           = as_seq
					AND degree_code   = C_LAST_DEGREE;
				SELECT f_pay_yn
				  INTO C_PAY_YN
				  FROM H_LEAS_LEASE_AGREE
				 WHERE dept_code     = as_dept_code
					AND sell_code     = as_sell_code
					AND dongho        = as_dongho
					AND seq           = as_seq
					AND degree_code   = C_LAST_DEGREE;
				IF C_PAY_YN = 'Y' AND C_LAST_SEQ < 70 THEN
					C_LAST_SEQ := 70;
				ELSE
					C_LAST_SEQ := C_LAST_SEQ + 1;
				END IF;
			END IF;
		END LOOP;
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
END y_sp_h_lease_calc;

PROCEDURE y_sp_h_lease_cmpt(as_dept_code              IN   VARCHAR2,
															  as_sell_code              IN   VARCHAR2,
															  as_dongho                 IN   VARCHAR2,
															  as_seq                    IN   INTEGER,
                                               as_input_date             IN   DATE,
                                               as_input_amt              IN   NUMBER,
															  as_input_deposit          IN   VARCHAR2,
															  as_user                   IN   VARCHAR2 ) IS
----------------------------이후자료저장
CURSOR DAILY_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ, AMT, DEPOSIT_NO
  FROM h_leas_lease_income_daily
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND receipt_date > as_input_date;

-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   C_RECEIPT_DATE      H_LEAS_LEASE_INCOME_DAILY.RECEIPT_DATE%TYPE;
	C_DAILY_SEQ         H_LEAS_LEASE_INCOME_DAILY.DAILY_SEQ%TYPE;
	C_AMT                H_LEAS_LEASE_INCOME_DAILY.AMT%TYPE;
	C_DEPOSIT_NO         H_LEAS_LEASE_INCOME_DAILY.DEPOSIT_NO%TYPE;

   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN
	OPEN DAILY_CUR;

	SELECT MIN(RECEIPT_DATE), MIN(DAILY_SEQ)
	  INTO C_RECEIPT_DATE, C_DAILY_SEQ
	  FROM h_leas_lease_income_daily
	 WHERE dept_code  = as_dept_code
		AND sell_code  = as_sell_code
		AND dongho     = as_dongho
		AND seq        = as_seq
		AND receipt_date > as_input_date;

	IF C_RECEIPT_DATE > '1900.01.01' AND C_DAILY_SEQ > 0 THEN
	   --------------------------------이후자료삭제
		H_Calc_Income_Lease.y_sp_h_delete_daily_lease(as_dept_code, as_sell_code, as_dongho, as_seq,
										C_RECEIPT_DATE, C_DAILY_SEQ, 0);
	END IF;

	SELECT NVL(MAX(daily_seq), 0) + 1
	  INTO C_DAILY_SEQ
	  FROM h_leas_lease_income_daily
	 WHERE dept_code     = as_dept_code
		AND sell_code     = as_sell_code
		AND dongho        = as_dongho
		AND seq           = as_seq
		AND receipt_date  = as_input_date;
	INSERT INTO H_LEAS_LEASE_INCOME_DAILY   --일자별 납입금 테이블에 INSERT한다
        VALUES (as_dept_code, as_sell_code, as_dongho, as_seq, as_input_date, C_DAILY_SEQ, as_input_amt,
		        as_input_deposit);

	-----------------------------------현자료입금처리

	H_Calc_Income_Lease.y_sp_h_lease_calc(as_dept_code,as_sell_code,as_dongho ,as_seq ,as_input_date,C_DAILY_SEQ,
                      as_input_amt,as_input_deposit,as_user);

	LOOP
		FETCH DAILY_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ, C_AMT, C_DEPOSIT_NO ;
		EXIT WHEN DAILY_CUR%NOTFOUND;

		-----------------------------------이후자료 재입금
		H_Calc_Income_Lease.y_sp_h_lease_cmpt(as_dept_code, as_sell_code, as_dongho, as_seq, C_RECEIPT_DATE, C_AMT,
		                                      C_DEPOSIT_NO, '재계산');
	END LOOP;


	CLOSE DAILY_CUR;

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
END y_sp_h_lease_cmpt;



PROCEDURE y_sp_h_delete_daily_lease(as_dept_code    IN   VARCHAR2,
	                                                    as_sell_code    IN   VARCHAR2,
	                                                    as_dongho       IN   VARCHAR2,
	                                                    as_seq          IN   INTEGER,
																		 as_receipt_date IN   DATE,
																		 as_daily_seq    IN   INTEGER,
																		 as_recalc_tag   IN   INTEGER) IS

--as_recalc_tag  1  *삭제하려는 차수 삭제, *이후차수 삭제, *이후차수에 대해서 재계산
--as_recalc_tag  0  *삭제하려는 차수 삭제, *이후차수 삭제  (재계산 안함)

--삭제할 차수 포함해서 이후에 대해서 보관한다. 삭제용
CURSOR DAILY_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ
  FROM h_leas_lease_income_daily
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND (    receipt_date > as_receipt_date
	     OR  (receipt_date = as_receipt_date AND
		       daily_seq    >= as_daily_seq)
		 )
ORDER BY receipt_date, daily_seq;
--삭제할 차수 이후에 대해서 보관한다. 재입금 처리용(재계산)
CURSOR DAILY_RECALC_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ, AMT, DEPOSIT_NO
  FROM h_leas_lease_income_daily
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND (    receipt_date > as_receipt_date
	     OR  (receipt_date = as_receipt_date AND
		       daily_seq    > as_daily_seq)
		 )
ORDER BY receipt_date, daily_seq;
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
C_RECEIPT_DATE       H_leas_lease_INCOME_DAILY.RECEIPT_DATE%TYPE;
C_DAILY_SEQ          H_leas_lease_INCOME_DAILY.DAILY_SEQ%TYPE;
C_AMT                H_leas_lease_INCOME_DAILY.AMT%TYPE;
C_DEPOSIT_NO         H_leas_lease_INCOME_DAILY.DEPOSIT_NO%TYPE;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_CNT                NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	BEGIN
		OPEN	DAILY_CUR;
		OPEN	DAILY_RECALC_CUR; --재계산하기 위해서 삭제 하기전에 가져온다
-----------------------------------------삭제처리
		LOOP
			FETCH DAILY_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ ;
			EXIT WHEN DAILY_CUR%NOTFOUND;

			UPDATE h_leas_lease_agree
			  SET (pay_tot_amt,f_pay_yn)=
				   (SELECT agree.pay_tot_amt - in_sum.amt,
				           CASE WHEN agree.pay_tot_amt - in_sum.amt = agree.lease_amt
				                THEN 'Y'
								 	 ELSE 'N'
							  END CASE
					   FROM h_leas_lease_agree agree,
					       (SELECT income.degree_code,
					               SUM(NVL(income.r_amt, 0)) amt
					          FROM h_leas_lease_income income
							   WHERE income.dept_code = as_dept_code
							     AND income.sell_code = as_sell_code
								  AND income.dongho    = as_dongho
								  AND income.seq       = as_seq
								  AND income.receipt_date = C_RECEIPT_DATE
								  AND income.daily_seq    = C_DAILY_SEQ
							  GROUP BY income.degree_code) in_sum

					  WHERE agree.dept_code = as_dept_code
					    AND agree.sell_code = as_sell_code
					    AND agree.dongho    = as_dongho
					    AND agree.seq       = as_seq
					    AND agree.degree_code = in_sum.degree_code
						 AND h_leas_lease_agree.degree_code = in_sum.degree_code)
			WHERE h_leas_lease_agree.dept_code = as_dept_code
			  AND h_leas_lease_agree.sell_code = as_sell_code
			  AND h_leas_lease_agree.dongho    = as_dongho
			  AND h_leas_lease_agree.seq       = as_seq
			  AND h_leas_lease_agree.degree_code IN (SELECT income.degree_code
												          FROM h_leas_lease_income income
														   WHERE income.dept_code = as_dept_code
														     AND income.sell_code = as_sell_code
															  AND income.dongho    = as_dongho
															  AND income.seq       = as_seq
															  AND income.receipt_date = C_RECEIPT_DATE
								                       AND income.daily_seq    = C_DAILY_SEQ);


	     DELETE FROM h_leas_lease_income income
		   WHERE income.dept_code = as_dept_code
		     AND income.sell_code = as_sell_code
			  AND income.dongho    = as_dongho
			  AND income.seq       = as_seq
			  AND income.receipt_date = C_RECEIPT_DATE
	        AND income.daily_seq    = C_DAILY_SEQ;
		  DELETE FROM h_leas_lease_income_daily daily
		   WHERE daily.dept_code = as_dept_code
		     AND daily.sell_code = as_sell_code
			  AND daily.dongho    = as_dongho
			  AND daily.seq       = as_seq
			  AND daily.receipt_date = C_RECEIPT_DATE
	        AND daily.daily_seq    = C_DAILY_SEQ;

      END LOOP;
		CLOSE DAILY_CUR;

-----------------------------------------재계산처리
      IF as_recalc_tag = 1 THEN
			LOOP
				FETCH DAILY_RECALC_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ, C_AMT, C_DEPOSIT_NO;
				EXIT WHEN DAILY_RECALC_CUR%NOTFOUND;


			   H_Calc_Income_Lease.y_sp_h_lease_cmpt(as_dept_code, as_sell_code, as_dongho, as_seq, C_RECEIPT_DATE, C_AMT,
				 					 C_DEPOSIT_NO, '재계산');
			END LOOP;
		END IF;

		CLOSE DAILY_RECALC_CUR;

	 EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '일자별수입금 삭제및 재계산 실패! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
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
END y_sp_h_delete_daily_lease;


PROCEDURE y_sp_h_delay_recalc_lease(as_dept_code    IN   VARCHAR2,
                                                as_sell_code    IN   VARCHAR2,
                                                as_dongho       IN   VARCHAR2,
                                                as_seq          IN   INTEGER,
																as_degree_code  IN   VARCHAR2,
																as_degree_seq   IN   INTEGER,
																as_receipt_date IN   DATE,
																as_daily_seq    IN   INTEGER,
																as_delay_amt    IN   NUMBER,
																as_discount_amt IN   NUMBER) IS



--업데이트하는 차수 이후에 대해서 보관한다.
CURSOR DAILY_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ, AMT, DEPOSIT_NO
  FROM h_leas_lease_income_daily
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND ((receipt_date > as_receipt_date) OR
		  (receipt_date = as_receipt_date AND daily_seq > as_daily_seq));
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
C_TEMP_STR           VARCHAR(20);
C_ORG_DELAY_AMT      NUMBER(13);
C_ORG_DISCOUNT_AMT   NUMBER(13);
C_DELAY_OFFSET       NUMBER(13);
C_DISCOUNT_OFFSET    NUMBER(13);
C_TOTAL_OFFSET       NUMBER(13);
C_R_AMT              NUMBER(13);
C_WORK_AMT           NUMBER(13);
C_DAILY_AMT          NUMBER(13);
C_INCOME_AMT         NUMBER(13);
R_AMT_CHG_TAG        VARCHAR2(1);
C_RECEIPT_DATE       H_LEAS_LEASE_INCOME_DAILY.RECEIPT_DATE%TYPE;
C_DAILY_SEQ          H_LEAS_LEASE_INCOME_DAILY.DAILY_SEQ%TYPE;
C_AMT                H_LEAS_LEASE_INCOME_DAILY.AMT%TYPE;
C_DEPOSIT_NO         H_LEAS_LEASE_INCOME_DAILY.DEPOSIT_NO%TYPE;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_CNT                NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	BEGIN

		SELECT r_amt, delay_amt, discount_amt
		  INTO C_R_AMT, C_ORG_DELAY_AMT, C_ORG_DISCOUNT_AMT
		  FROM h_leas_lease_income income
		 WHERE income.dept_code = as_dept_code
	      AND income.sell_code = as_sell_code
		   AND income.dongho    = as_dongho
		   AND income.seq       = as_seq
		   AND income.degree_code = as_degree_code
		   AND income.degree_seq  = as_degree_seq;

		C_DELAY_OFFSET    := as_delay_amt    - C_ORG_DELAY_AMT;
		C_DISCOUNT_OFFSET := as_discount_amt - C_ORG_DISCOUNT_AMT;
		C_TOTAL_OFFSET    := C_DELAY_OFFSET + C_DISCOUNT_OFFSET;

		IF C_TOTAL_OFFSET = 0 THEN --이게 0 이면 게산할필요가 없다.연체료/할인료만 업데이트하고 끝

		   UPDATE H_LEAS_LEASE_INCOME
			   SET delay_amt    = as_delay_amt,
					 discount_amt = as_discount_amt
			 WHERE dept_code = as_dept_code
		      AND sell_code = as_sell_code
			   AND dongho    = as_dongho
			   AND seq       = as_seq
			   AND degree_code = as_degree_code
			   AND degree_seq  = as_degree_seq;
			RETURN;
		END IF;

		SELECT NVL(SUM(NVL(income.r_amt, 0) + NVL(income.delay_amt, 0) - NVL(income.discount_amt, 0)), 0)
		  INTO C_WORK_AMT
		  FROM h_leas_lease_income income
		 WHERE income.dept_code = as_dept_code
	      AND income.sell_code = as_sell_code
		   AND income.dongho    = as_dongho
		   AND income.seq       = as_seq
		   AND income.receipt_date = as_receipt_date
		   AND income.daily_seq    = as_daily_seq
			AND ((income.degree_code > as_degree_code) OR
			     (income.degree_code = as_degree_code AND income.degree_seq > as_degree_seq));

      IF C_WORK_AMT > 0 THEN
			IF C_WORK_AMT < C_TOTAL_OFFSET THEN --현차수이후에 쪼개진 입금액이 있으면...원금수정..토건부수정
			   IF (C_TOTAL_OFFSET-C_WORK_AMT) > 0 THEN
				   C_R_AMT := C_R_AMT - (C_TOTAL_OFFSET-C_WORK_AMT);
				ELSE
				   C_R_AMT := C_R_AMT + (C_TOTAL_OFFSET-C_WORK_AMT);
				END IF;

				R_AMT_CHG_TAG := 'Y';
			ELSE
			   R_AMT_CHG_TAG := 'N';
			END IF;
		ELSE
			IF C_DELAY_OFFSET > 0 THEN
				C_R_AMT := C_R_AMT - C_DELAY_OFFSET;
			ELSE
			   C_R_AMT := C_R_AMT + C_DELAY_OFFSET;
			END IF;
			IF C_DISCOUNT_OFFSET > 0 THEN
				C_R_AMT := C_R_AMT + 0; --C_DISCOUNT_OFFSET;
			ELSE
			   C_R_AMT := C_R_AMT - C_DISCOUNT_OFFSET;
			END IF;
			R_AMT_CHG_TAG := 'Y';

		END IF;

		IF R_AMT_CHG_TAG = 'Y' THEN

			UPDATE H_LEAS_LEASE_INCOME
			   SET r_amt        = C_R_AMT,
				    delay_amt    = as_delay_amt,
					 discount_amt = as_discount_amt,

					 input_id     = '연체',
					 modi_yn      = 'Y'
			 WHERE dept_code = as_dept_code
		      AND sell_code = as_sell_code
			   AND dongho    = as_dongho
			   AND seq       = as_seq
			   AND degree_code = as_degree_code
			   AND degree_seq  = as_degree_seq;

		ELSE --원금 안 변했으면 연체료와 할인료 업데이트

		   UPDATE H_LEAS_LEASE_INCOME
			   SET delay_amt    = as_delay_amt,
					 discount_amt = as_discount_amt,
					 input_id     = '연체',
					 modi_yn      = 'Y'
			 WHERE dept_code = as_dept_code
		      AND sell_code = as_sell_code
			   AND dongho    = as_dongho
			   AND seq       = as_seq
			   AND degree_code = as_degree_code
			   AND degree_seq  = as_degree_seq;

		END IF;
      DELETE h_leas_lease_income income
		 WHERE income.dept_code = as_dept_code
	      AND income.sell_code = as_sell_code
		   AND income.dongho    = as_dongho
		   AND income.seq       = as_seq
		   AND income.receipt_date = as_receipt_date
		   AND income.daily_seq    = as_daily_seq
			AND ((income.degree_code > as_degree_code) OR
			     (income.degree_code = as_degree_code AND income.degree_seq > as_degree_seq));

		--약정 완납구분 업데이트
		UPDATE h_leas_lease_agree
		  SET (pay_tot_amt,f_pay_yn)=
			   (SELECT in_sum.amt,
			           CASE WHEN in_sum.amt = agree.lease_amt
			                THEN 'Y'
							 	 ELSE 'N'
						  END CASE
				   FROM h_leas_lease_agree agree,
				       (SELECT income.degree_code,
				               SUM(NVL(income.r_amt, 0)) amt
				          FROM h_leas_lease_income income
						   WHERE income.dept_code = as_dept_code
						     AND income.sell_code = as_sell_code
							  AND income.dongho    = as_dongho
							  AND income.seq       = as_seq
							  AND income.degree_code = as_degree_code
						  GROUP BY income.degree_code) in_sum

				  WHERE agree.dept_code = as_dept_code
				    AND agree.sell_code = as_sell_code
				    AND agree.dongho    = as_dongho
				    AND agree.seq       = as_seq
				    AND agree.degree_code = in_sum.degree_code
					 AND h_leas_lease_agree.degree_code = in_sum.degree_code)
		WHERE h_leas_lease_agree.dept_code = as_dept_code
		  AND h_leas_lease_agree.sell_code = as_sell_code
		  AND h_leas_lease_agree.dongho    = as_dongho
		  AND h_leas_lease_agree.seq       = as_seq
		  AND h_leas_lease_agree.degree_code = as_degree_code;

		SELECT amt,  deposit_no
		  INTO C_DAILY_AMT, C_DEPOSIT_NO

		  FROM h_leas_lease_income_daily daily
		 WHERE daily.dept_code = as_dept_code
	      AND daily.sell_code = as_sell_code
		   AND daily.dongho    = as_dongho
		   AND daily.seq       = as_seq
		   AND daily.receipt_date = as_receipt_date
		   AND daily.daily_seq    = as_daily_seq;

		SELECT NVL(SUM(NVL(income.r_amt, 0) + NVL(income.delay_amt, 0) - NVL(income.discount_amt, 0)), 0)
		  INTO C_INCOME_AMT
		  FROM h_leas_lease_income income
		 WHERE income.dept_code = as_dept_code
	      AND income.sell_code = as_sell_code
		   AND income.dongho    = as_dongho
		   AND income.seq       = as_seq
		   AND income.receipt_date = as_receipt_date
		   AND income.daily_seq    = as_daily_seq;



		IF C_DAILY_AMT > C_INCOME_AMT THEN
			H_Calc_Income_Lease.y_sp_h_lease_calc(as_dept_code,as_sell_code,as_dongho ,as_seq ,as_receipt_date,as_daily_seq,
                      C_DAILY_AMT - C_INCOME_AMT, C_DEPOSIT_NO,'재계산1');

		END IF;

		--DIALY 에서 이후 입금분에 대해서 재입금 처리

		SELECT MIN(TO_CHAR(RECEIPT_DATE,'yyyymmdd')||TO_CHAR(DAILY_SEQ,'0000'))
		  INTO C_TEMP_STR
		  FROM h_leas_lease_income_daily
		 WHERE dept_code  = as_dept_code
			AND sell_code  = as_sell_code
			AND dongho     = as_dongho
			AND seq        = as_seq
			AND ((receipt_date > as_receipt_date) OR
			     (receipt_date = as_receipt_date AND daily_seq > as_daily_seq));
		C_RECEIPT_DATE:= TO_DATE(SUBSTR(C_TEMP_STR,1,8));
		C_DAILY_SEQ   := TO_NUMBER(SUBSTR(C_TEMP_STR,10,4));

		IF C_RECEIPT_DATE > '1900.01.01' AND C_DAILY_SEQ > 0 THEN

		   OPEN DAILY_CUR;  --삭제하기전 저장
		   --------------------------------이후자료삭제


			H_Calc_Income_Lease.y_sp_h_delete_daily_lease(as_dept_code, as_sell_code, as_dongho, as_seq,
												C_RECEIPT_DATE, C_DAILY_SEQ, 0);
			LOOP
				FETCH DAILY_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ, C_AMT, C_DEPOSIT_NO;

				EXIT WHEN DAILY_CUR%NOTFOUND;

				-----------------------------------이후자료 재입금
				IF C_AMT <> 0 THEN
			   	H_Calc_Income_Lease.y_sp_h_lease_cmpt(as_dept_code, as_sell_code, as_dongho, as_seq, C_RECEIPT_DATE, C_AMT,
										 C_DEPOSIT_NO, '재계산2');

				END IF;
			END LOOP;
			CLOSE DAILY_CUR;
		END IF;

	 EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '연체료/할인료변경 및 재계산 실패! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
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
END y_sp_h_delay_recalc_lease;



END;
/

