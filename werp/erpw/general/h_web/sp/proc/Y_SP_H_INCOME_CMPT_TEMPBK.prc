CREATE OR REPLACE PROCEDURE Y_Sp_H_Income_Cmpt_Tempbk(as_spec_unq_num IN NUMBER,
															  as_dept_code     IN   VARCHAR2,
															  as_sell_code     IN   VARCHAR2,
															  as_dongho        IN   VARCHAR2,
															  as_seq           IN   INTEGER,
                                               as_input_date    IN   DATE,
															  as_input_class   IN   VARCHAR2,
															  as_input_deposit IN   VARCHAR2,
															  as_user          IN   VARCHAR2) IS
CURSOR DETAIL_CUR (V_AGREE_DATE DATE)IS
SELECT rate,cutoff_std,cutoff_unit,s_date,e_date
  FROM H_SALE_DELAY_RATE
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND rate_kind  = '01'
	AND e_date >= V_AGREE_DATE
	AND s_date <= as_input_date
	AND MNTH = (SELECT MIN(MNTH)
					  FROM H_SALE_DELAY_RATE
					 WHERE dept_code  = as_dept_code
						AND sell_code  = as_sell_code
						AND dongho     = as_dongho
						AND seq        = as_seq
						AND rate_kind  = '01'
						AND e_date >= V_AGREE_DATE
						AND s_date <= as_input_date
						AND ADD_MONTHS(V_AGREE_DATE, MNTH) > as_input_date);
CURSOR DETAIL_CUR1 (V_AGREE_DATE DATE )IS
SELECT rate,cutoff_std,cutoff_unit,s_date,e_date
  FROM H_SALE_DISCOUNT_RATE
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND rate_kind  = '01'
	AND e_date >= as_input_date
	AND s_date <= V_AGREE_DATE;
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   C_LAST_DEGREE       H_SALE_AGREE.DEGREE_CODE%TYPE;    -- 마지막약정차수
   C_MAX_DEGREE        H_SALE_AGREE.DEGREE_CODE%TYPE;    -- 마지막약정차수(잔금,인상분 포함)
   C_LAST_SEQ          H_SALE_INCOME.DEGREE_SEQ%TYPE;    -- 마지막회수
   C_AGREE_DATE        H_SALE_AGREE.AGREE_DATE%TYPE;     -- 약정일자
   C_SELL_AMT          H_SALE_AGREE.SELL_AMT%TYPE;       -- 약정금액
   C_LAND_AMT          H_SALE_AGREE.SELL_AMT%TYPE;       -- 약정토지금액
   C_BUILD_AMT         H_SALE_AGREE.SELL_AMT%TYPE;       -- 약정건물금액
   C_VAT_AMT           H_SALE_AGREE.SELL_AMT%TYPE;       -- 약정부가세
   C_DELAY_AMT         H_SALE_AGREE.SELL_AMT%TYPE;       -- 연체료
   C_DISCOUNT_AMT      H_SALE_AGREE.SELL_AMT%TYPE;       -- 할인료
   C_DELAY_DAY         H_SALE_INCOME.DISCOUNT_DAYS%TYPE;       -- 연체일자
   C_DISCOUNT_DAY      H_SALE_INCOME.DISCOUNT_DAYS%TYPE;       -- 할인일자
   C_R_AMT             H_SALE_AGREE.SELL_AMT%TYPE;       -- 납입금액
   C_R_LAND_AMT        H_SALE_AGREE.SELL_AMT%TYPE;       -- 납입토지금액
   C_R_BUILD_AMT       H_SALE_AGREE.SELL_AMT%TYPE;       -- 납입건물금액
   C_R_VAT_AMT         H_SALE_AGREE.SELL_AMT%TYPE;       -- 납입부가세
   C_C_LAND_AMT        H_SALE_AGREE.SELL_AMT%TYPE;       -- 납입토지금액
   C_C_BUILD_AMT       H_SALE_AGREE.SELL_AMT%TYPE;       -- 납입건물금액
   C_C_VAT_AMT         H_SALE_AGREE.SELL_AMT%TYPE;       -- 납입부가세
   C_WORK_AMT          H_SALE_AGREE.SELL_AMT%TYPE;       -- 약정대상금액
   C_TEMP_AMT          H_SALE_AGREE.SELL_AMT%TYPE;       -- 약정계산금액
   C_S_DATE        	  H_SALE_AGREE.AGREE_DATE%TYPE;     -- 시작일자
   C_E_DATE        	  H_SALE_AGREE.AGREE_DATE%TYPE;     -- 종료일자
   C_FR_DATE        	  H_SALE_AGREE.AGREE_DATE%TYPE;     -- 입주개시일
   C_TO_DATE        	  H_SALE_AGREE.AGREE_DATE%TYPE;     -- 입주종료일
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
	C_CLASS					VARCHAR2(1);
	C_PAY_YN					VARCHAR2(1);
	C_CONT_YN				VARCHAR2(1);
	C_REMAIND_YN			VARCHAR2(1);
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
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN
		-- &&&&&&&&&&&&&&
		-- 계약금 또는 잔금일 경우 이자(계약금:연체여부,잔금:할인여부)계산 여부를 구한다.분양구분테이블
		SELECT NVL(contract_delay_yn,'N'),NVL(remain_discount_yn,'N')
		  INTO C_CONT_YN,C_REMAIND_YN
		  FROM H_CODE_HOUSE
		 WHERE dept_code = as_dept_code
			AND sell_code = as_sell_code;
	--
		SELECT NVL(MAX(degree_code), '50')
		  INTO C_MAX_DEGREE
		  FROM H_SALE_AGREE
		 WHERE dept_code     = as_dept_code
			AND sell_code     = as_sell_code
			AND dongho        = as_dongho
			AND seq           = as_seq ;
		c_input_amt := 90000000000;
-- 마지막 약정차수 및 회수를 구한다.
		SELECT COUNT(*)
		  INTO C_CNT
		  FROM H_SALE_AGREE_TEMP
		 WHERE spec_unq_num = as_spec_unq_num
			AND dept_code = as_dept_code
			AND sell_code = as_sell_code
			AND dongho    = as_dongho
			AND seq       = as_seq
			AND f_pay_yn  = 'N';
		IF C_CNT > 0 THEN
			SELECT MIN(degree_code), MIN(agree_date)
			  INTO C_LAST_DEGREE, C_AGREE_DATE
			  FROM H_SALE_AGREE_TEMP
			 WHERE spec_unq_num = as_spec_unq_num
				AND dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND f_pay_yn  = 'N';
			-- 해당 일자까지 미납금액이 없는 경우는 계산 제외함.
			/*IF C_AGREE_DATE IS NULL OR C_AGREE_DATE > as_input_date THEN
 	         GOTO EXIT_ROUTINE;
 			END IF;*/
			SELECT NVL(MAX(degree_seq),0)
			  INTO C_LAST_SEQ
			  FROM H_SALE_INCOME_TEMP
			 WHERE spec_unq_num = as_spec_unq_num
				AND dept_code = as_dept_code
				AND sell_code   = as_sell_code
				AND dongho      = as_dongho
				AND seq         = as_seq
				AND degree_code = C_LAST_DEGREE;
			C_LAST_SEQ := C_LAST_SEQ + 1;
		ELSE
	         GOTO EXIT_ROUTINE;
		END IF;
-- LOOP 시작
		LOOP
	-- 일수 및 약정금액을 구한다
			SELECT NVL((agree_date - as_input_date) * -1,0),NVL(sell_amt_tmp,0),NVL(land_amt,0),NVL(build_amt,0),NVL(vat_amt,0),agree_date
			  INTO C_DAYS,C_SELL_AMT,C_LAND_AMT,C_BUILD_AMT,C_VAT_AMT,C_AGREE_DATE
			  FROM H_SALE_AGREE_TEMP
			 WHERE spec_unq_num = as_spec_unq_num
				AND dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = C_LAST_DEGREE;
			IF C_SELL_AMT = 0 THEN
				EXIT;
			END IF;
-- 국민기금은 약정차수로 연체료 계산함(2004.07.02 이양헌)
			/*IF C_LAST_DEGREE <> '81' AND C_LAST_DEGREE > '49' AND C_LAST_SEQ < 70 THEN
				SELECT moveinto_fr_date,moveinto_to_date
				  INTO C_FR_DATE,C_TO_DATE
				  FROM H_SALE_MASTER
				 WHERE dept_code = as_dept_code
					AND sell_code = as_sell_code
					AND dongho    = as_dongho
					AND seq       = as_seq;
				IF C_FR_DATE > as_input_date THEN
					SELECT NVL((moveinto_fr_date - as_input_date) * -1,0)
					  INTO C_DAYS
					  FROM H_SALE_MASTER
					 WHERE dept_code = as_dept_code
						AND sell_code = as_sell_code
						AND dongho    = as_dongho
						AND seq       = as_seq;
				ELSE
					IF C_TO_DATE < as_input_date THEN
						SELECT NVL((moveinto_to_date - as_input_date) * -1,0)
						  INTO C_DAYS
						  FROM H_SALE_MASTER
						 WHERE dept_code = as_dept_code
							AND sell_code = as_sell_code
							AND dongho    = as_dongho
							AND seq       = as_seq;
					ELSE
						C_DAYS := 0;
					END IF;
				END IF;
			END IF;*/
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
			SELECT NVL(SUM(r_amt),0),NVL(SUM(r_land_amt),0),NVL(SUM(r_build_amt),0),NVL(SUM(r_vat_amt),0)
			  INTO C_R_AMT,C_R_LAND_AMT,C_R_BUILD_AMT,C_R_VAT_AMT
			  FROM H_SALE_INCOME_TEMP
			 WHERE spec_unq_num = as_spec_unq_num
				AND dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = C_LAST_DEGREE;
	-- 계산할 약정금액을 구한다(대상금액).  국민기금을 약정차수로 처리하므로 삭제함(2004.07.02 이양헌)
--			if C_LAST_DEGREE = '50' and C_LAST_SEQ < 70 then
--				select nvl(fund_amt,0)
--				  into C_FUND_AMT
--				  from h_sale_master
--				 where dept_code = as_dept_code
--					and sell_code = as_sell_code
--					and dongho    = as_dongho
--					and seq       = as_seq;
--				C_WORK_AMT := C_SELL_AMT - C_R_AMT - C_FUND_AMT;
--			else
--				C_WORK_AMT := C_SELL_AMT - C_R_AMT;
--			end if;
			C_WORK_AMT := C_SELL_AMT - C_R_AMT;
	-----------------------------------------------------------------------------
	-- 일수가 0일경우 바로 입금처리, +일경우 연체료, -일경우 할인료를 계산한다.
	-----------------------------------------------------------------------------
			-- &&&&&&&&&&&&&
			IF C_LAST_DEGREE < '10' THEN
				C_R_CONT_YN    := C_CONT_YN;
			ELSE
				C_R_CONT_YN    := 'Y';
			END IF ;
			IF C_LAST_DEGREE > '49' THEN
				C_R_REMAIND_YN := C_REMAIND_YN;
			END IF ;
			IF C_LAST_DEGREE >= '10' AND C_LAST_DEGREE < '50' THEN
				C_R_REMAIND_YN := 'Y';
			END IF ;
         
--			if C_LAST_DEGREE > '49' and C_LAST_SEQ > 69 then
-- 계약금 약정만 있는경우에 loop 방지
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
						IF C_R_CONT_YN = 'Y' THEN             -- &&&&&&&&&&&&&&&&&&&&&&&&
							C_DELAY_DAY   := C_DAYS;
							C_TEMP_RATE := 0;
						-- 납입대상금액계산
                     
							OPEN	DETAIL_CUR(C_AGREE_DATE);
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
								OPEN	DETAIL_CUR(C_AGREE_DATE);
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
								OPEN	DETAIL_CUR(C_AGREE_DATE);
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
						ELSE                 -- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&
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
	-- 납입금액을 가지고 토지,건물,부가세를 구한다.
			IF C_WORK_AMT = C_TEMP_AMT THEN
				C_C_LAND_AMT  := C_LAND_AMT - C_R_LAND_AMT;
				C_C_BUILD_AMT := C_BUILD_AMT - C_R_BUILD_AMT;
				C_C_VAT_AMT   := C_VAT_AMT - C_R_VAT_AMT;
			ELSE
				IF C_SELL_AMT <> 0 THEN
					C_C_LAND_AMT  := TRUNC(C_LAND_AMT / C_SELL_AMT * C_TEMP_AMT,0);
					C_C_BUILD_AMT := TRUNC(C_BUILD_AMT / C_SELL_AMT * C_TEMP_AMT,0);
					C_C_VAT_AMT   := TRUNC(C_VAT_AMT / C_SELL_AMT * C_TEMP_AMT,0);
				ELSE
					C_C_LAND_AMT  := 0;
					C_C_BUILD_AMT := 0;
					C_C_VAT_AMT   := 0;
				END IF;
			END IF;
	-----------------------------------------------------------------------------
	-- 계산된 값을 분양_세대별수입금에 넣어준다.
			IF C_LAST_SEQ < 70 THEN
				INSERT INTO H_SALE_INCOME_TEMP
					VALUES ( as_spec_unq_num,as_dept_code,as_sell_code,as_dongho,as_seq,C_LAST_DEGREE,C_LAST_SEQ,as_input_date,
								as_input_class,as_input_deposit,C_TEMP_AMT,C_C_LAND_AMT,C_C_BUILD_AMT,C_C_VAT_AMT,
								C_DELAY_DAY,C_DELAY_AMT,C_DISCOUNT_DAY,C_DISCOUNT_AMT,as_user,SYSDATE,NULL,0,NULL,0,'Y' )  ;
	       END IF;
	-- 기납입금액누계를 구한다.
			SELECT NVL(SUM(r_amt),0)
			  INTO C_R_AMT
			  FROM H_SALE_INCOME_TEMP
			 WHERE spec_unq_num = as_spec_unq_num
				AND dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = C_LAST_DEGREE;
	-- 입금완료구분값을 구한다.
			IF C_SELL_AMT <= C_R_AMT THEN
				C_PAY_YN := 'Y';
			ELSE
				C_PAY_YN := 'N';
			END IF;
-- 국민기금을 약정차수로 처리하므로 삭제함(2004.07.02 이양헌)
--			if C_FUND_AMT > 0 THEN
--				C_FUND_AMT := C_FUND_AMT + C_R_AMT;
--				if C_SELL_AMT <= C_FUND_AMT THEN
--					C_PAY_YN := 'Y';
--				end if;
--			end if;
	-- 약정사항에 입금완료구분값과 입금합계값을 넣어준다.
			UPDATE H_SALE_AGREE_TEMP
				SET F_PAY_YN = C_PAY_YN,
					 TOT_AMT = C_R_AMT
			 WHERE spec_unq_num = as_spec_unq_num
				AND dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = C_LAST_DEGREE;
	-- 납입금액이 0이면 종료한다.
         IF c_input_amt = 0 THEN
            EXIT;
         END IF;
	-- 납입금액이 0가 아니면 다음차수를 구하여 나머지금액처리를 한다.
			IF C_LAST_DEGREE >= C_MAX_DEGREE THEN
				C_LAST_DEGREE := C_MAX_DEGREE;
				SELECT NVL(MAX(degree_seq),0)
				  INTO C_LAST_SEQ
				  FROM H_SALE_INCOME_TEMP
				 WHERE spec_unq_num = as_spec_unq_num
					AND dept_code = as_dept_code
					AND sell_code   = as_sell_code
					AND dongho      = as_dongho
					AND seq         = as_seq
					AND degree_code = C_LAST_DEGREE;
				SELECT f_pay_yn
				  INTO C_PAY_YN
				  FROM H_SALE_AGREE_TEMP
				 WHERE spec_unq_num = as_spec_unq_num
					AND dept_code = as_dept_code
					AND sell_code = as_sell_code
					AND dongho    = as_dongho
					AND seq       = as_seq
					AND degree_code = C_LAST_DEGREE;
				IF C_PAY_YN = 'Y' AND C_LAST_SEQ < 70 THEN
					C_LAST_SEQ := 70;
				ELSE
					C_LAST_SEQ := C_LAST_SEQ + 1;
				END IF;
			ELSE
				SELECT COUNT(*)
				  INTO C_CNT
				  FROM H_SALE_AGREE_TEMP
				 WHERE spec_unq_num = as_spec_unq_num
					AND dept_code = as_dept_code
					AND sell_code = as_sell_code
					AND dongho    = as_dongho
					AND seq       = as_seq
					AND degree_code > C_LAST_DEGREE;
				IF C_CNT > 0 THEN
					SELECT MIN(degree_code)
					  INTO C_LAST_DEGREE
					  FROM H_SALE_AGREE_TEMP
					 WHERE spec_unq_num = as_spec_unq_num
						AND dept_code = as_dept_code
						AND sell_code = as_sell_code
						AND dongho    = as_dongho
						AND seq       = as_seq
						AND degree_code > C_LAST_DEGREE;
					SELECT NVL(MAX(degree_seq),0)
					  INTO C_LAST_SEQ
					  FROM H_SALE_INCOME_TEMP
					 WHERE spec_unq_num = as_spec_unq_num
						AND dept_code = as_dept_code
						AND sell_code   = as_sell_code
						AND dongho      = as_dongho
						AND seq         = as_seq
						AND degree_code = C_LAST_DEGREE;
					C_LAST_SEQ := C_LAST_SEQ + 1;
				ELSE
					EXIT;
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
END Y_Sp_H_Income_Cmpt_Tempbk;
/

