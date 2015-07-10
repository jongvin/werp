CREATE OR REPLACE PROCEDURE y_sp_h_income_ont_cmpt_temp(as_spec_unq_num  IN   NUMBER,
																		  as_dept_code     IN   VARCHAR2,
																		  as_sell_code     IN   VARCHAR2,
																		  as_dongho        IN   VARCHAR2,
																		  as_seq           IN   INTEGER,
																		  as_input_date    IN   DATE,
																		  as_input_amt     IN   NUMBER,
																		  as_input_class   IN   VARCHAR2,
																		  as_input_deposit IN   VARCHAR2,
																		  as_user                   IN   VARCHAR2) IS
-- 연체율 구하는 커서
CURSOR DETAIL_CUR (V_AGREE_DATE DATE, V_DAYS INTEGER )IS
SELECT rate,cutoff_std,cutoff_unit,s_date,e_date
  FROM h_sale_delay_rate
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND rate_kind  = '02'
	AND e_date >= V_AGREE_DATE
	AND s_date <= as_input_date
	AND MNTH = (SELECT min(MNTH)
					  FROM H_SALE_DELAY_RATE
					 WHERE dept_code  = as_dept_code
						AND sell_code  = as_sell_code
						AND dongho     = as_dongho
						AND seq        = as_seq
						AND rate_kind  = '01'
						AND e_date >= V_AGREE_DATE
						AND s_date <= as_input_date
						and ADD_MONTHS(V_AGREE_DATE, MNTH) > as_input_date);
-- 할인율 구하는 커서
CURSOR DETAIL_CUR1 (V_AGREE_DATE DATE )IS
SELECT rate,cutoff_std,cutoff_unit,s_date,e_date
  FROM h_sale_discount_rate
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND rate_kind  = '02'
	AND e_date >= as_input_date
	AND s_date <= V_AGREE_DATE;
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   C_LAST_DEGREE       H_SALE_ONTIME_AGREE_TEMP.DEGREE_CODE%TYPE;    -- 마지막약정차수
   C_MAX_DEGREE        H_SALE_ONTIME_AGREE.DEGREE_CODE%TYPE;    -- 마지막약정차수(잔금,인상분 포함)
   C_LAST_SEQ          H_SALE_ONTIME_INCOME_TEMP.DEGREE_SEQ%TYPE;    -- 마지막회수
   C_AGREE_DATE        H_SALE_ONTIME_AGREE_TEMP.AGREE_DATE%TYPE;     -- 약정일자
   C_AGREE_AMT         H_SALE_ONTIME_AGREE_TEMP.AGREE_AMT%TYPE;       -- 약정금액
   C_DELAY_AMT         H_SALE_ONTIME_AGREE_TEMP.AGREE_AMT%TYPE;       -- 연체료
   C_DISCOUNT_AMT      H_SALE_ONTIME_AGREE_TEMP.AGREE_AMT%TYPE;       -- 할인료
   C_DELAY_DAY         H_SALE_ONTIME_INCOME_TEMP.DISCOUNT_DAYS%TYPE;       -- 연체일자
   C_DISCOUNT_DAY      H_SALE_ONTIME_INCOME_TEMP.DISCOUNT_DAYS%TYPE;       -- 할인일자
   C_R_AMT             H_SALE_ONTIME_AGREE_TEMP.AGREE_AMT%TYPE;       -- 납입금액
   C_WORK_AMT          H_SALE_ONTIME_AGREE_TEMP.AGREE_AMT%TYPE;       -- 약정대상금액
   C_TEMP_AMT          H_SALE_ONTIME_AGREE_TEMP.AGREE_AMT%TYPE;       -- 약정계산금액
   C_S_DATE        	  H_SALE_ONTIME_AGREE_TEMP.AGREE_DATE%TYPE;     -- 시작일자
   C_E_DATE        	  H_SALE_ONTIME_AGREE_TEMP.AGREE_DATE%TYPE;     -- 종료일자
   C_FR_DATE        	  H_SALE_ONTIME_AGREE_TEMP.AGREE_DATE%TYPE;     -- 입주개시일
   C_TO_DATE        	  H_SALE_ONTIME_AGREE_TEMP.AGREE_DATE%TYPE;     -- 입주종료일
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
		select NVL(ontime_contract_delay_yn,'N'),NVL(ontime_remain_discount_yn,'N')
		  into C_CONT_YN,C_REMAIND_YN
		  from h_code_house
		 where dept_code = as_dept_code
			and sell_code = as_sell_code;
	--
		select NVL(max(degree_code), '50')
		  into C_MAX_DEGREE
		  from H_SALE_ONTIME_AGREE_TEMP
		 where spec_unq_num  = as_spec_unq_num
		   and dept_code     = as_dept_code
			and sell_code     = as_sell_code
			and dongho        = as_dongho
			and seq           = as_seq ;
		c_input_amt := as_input_amt;
-- 마지막 약정차수 및 회수를 구한다.
		select COUNT(*)
		  into C_CNT
		  from H_SALE_ONTIME_AGREE_TEMP
		 where spec_unq_num  = as_spec_unq_num
		   and dept_code     = as_dept_code
			and sell_code = as_sell_code
			and dongho    = as_dongho
			and seq       = as_seq
			and f_pay_yn  = 'N';
		if C_CNT > 0 THEN
			select min(degree_code), min(agree_date)
			  into C_LAST_DEGREE, C_AGREE_DATE
			  from H_SALE_ONTIME_AGREE_TEMP
			 where spec_unq_num  = as_spec_unq_num
			   and dept_code     = as_dept_code
				and sell_code = as_sell_code
				and dongho    = as_dongho
				and seq       = as_seq
				and f_pay_yn  = 'N';
			select NVL(MAX(degree_seq),0)
			  into C_LAST_SEQ
			  from H_SALE_ONTIME_INCOME_TEMP
			 where spec_unq_num  = as_spec_unq_num
			   and dept_code     = as_dept_code
				and sell_code   = as_sell_code
				and dongho      = as_dongho
				and seq         = as_seq
				and degree_code = C_LAST_DEGREE;
			C_LAST_SEQ := C_LAST_SEQ + 1;
		else
			select count(*)
			  into C_CNT
			  from H_SALE_ONTIME_AGREE_TEMP
			 where spec_unq_num  = as_spec_unq_num
			   and dept_code     = as_dept_code
				and sell_code = as_sell_code
				and dongho    = as_dongho
				and seq       = as_seq ;
-- 마지막 차수에 초과 납부를 처리하기 위하여 '50' 으로 하지 않음.
--				and degree_code > '49';
 			if C_CNT < 1 THEN
   			Wk_errflag := '-20001';
		      e_msg  := ' 약정차수가 없습니다. 동호==>' || as_dongho;
 	         GOTO EXIT_ROUTINE;
 			end if;
--			C_LAST_DEGREE := '50';
			select NVL(MAX(degree_seq),0)
			  into C_LAST_SEQ
			  from H_SALE_ONTIME_INCOME_TEMP
			 where spec_unq_num  = as_spec_unq_num
			   and dept_code     = as_dept_code
				and sell_code   = as_sell_code
				and dongho      = as_dongho
				and seq         = as_seq
				and degree_code = C_LAST_DEGREE;
			if C_LAST_SEQ < 70 THEN
				C_LAST_SEQ := 70;
			else
				C_LAST_SEQ := C_LAST_SEQ + 1;
			end if;
		end if;
-- LOOP 시작
		LOOP
	-- 일수 및 약정금액을 구한다
			select nvl((agree_date - as_input_date) * -1,0),nvl(AGREE_AMT,0),agree_date
			  into C_DAYS,C_AGREE_AMT,C_AGREE_DATE
			  from H_SALE_ONTIME_AGREE_TEMP
			 where spec_unq_num  = as_spec_unq_num
			   and dept_code     = as_dept_code
				and sell_code = as_sell_code
				and dongho    = as_dongho
				and seq       = as_seq
				and degree_code = C_LAST_DEGREE;
			if C_AGREE_AMT = 0 then
				EXIT;
			end if;
-- 약정일 이전만 계산한다.
			IF C_LAST_DEGREE < '49' and C_AGREE_DATE > as_input_date THEN
				EXIT;
			END IF;
----
			if C_LAST_DEGREE > '49' and C_LAST_SEQ < 70 then
				select moveinto_fr_date,moveinto_to_date
				  into C_FR_DATE,C_TO_DATE
				  from h_sale_master
				 where dept_code = as_dept_code
					and sell_code = as_sell_code
					and dongho    = as_dongho
					and seq       = as_seq;
					if C_TO_DATE < as_input_date then
						select nvl((moveinto_to_date - as_input_date) * -1,0)
						  into C_DAYS
						  from h_sale_master
						 where dept_code = as_dept_code
							and sell_code = as_sell_code
							and dongho    = as_dongho
							and seq       = as_seq;
					else
						C_DAYS := 0;
					end if;
			end if;
	-- 휴일적용여부를 체크한다.
			if C_DAYS > 0 THEN -- 연체료일 경우
				select count(*),nvl(max(process_days),0)
				  into C_CNT,C_TEMP_CNT
				  from h_dept_holiday
				 where dept_code = as_dept_code
					and sell_code = as_sell_code
					and delay_discount_div = '1'
					and yymmdd = C_AGREE_DATE;
				if C_CNT > 0 then
					if C_DAYS <= C_TEMP_CNT then
						C_DAYS := 0;
					end if;
				else
					select count(*),nvl(max(process_days),0)
					  into C_CNT,C_TEMP_CNT
					  from h_com_holiday
					 where yymmdd = C_AGREE_DATE;
					if C_CNT > 0 then
						if C_DAYS <= C_TEMP_CNT then
							C_DAYS := 0;
						end if;
					end if;
				end if;
			end if;
			if C_DAYS < 0 THEN -- 할인료일 경우
				select count(*),nvl(max(process_days),0)
				  into C_CNT,C_TEMP_CNT
				  from h_dept_holiday
				 where dept_code = as_dept_code
					and sell_code = as_sell_code
					and delay_discount_div = '2'
					and yymmdd = C_AGREE_DATE;
				if C_CNT > 0 then
					C_CNT := C_DAYS * -1;
					if C_CNT <= C_TEMP_CNT then
						C_DAYS := 0;
					end if;
				else
					select count(*),nvl(max(process_days),0)
					  into C_CNT,C_TEMP_CNT
					  from h_com_holiday
					 where yymmdd = C_AGREE_DATE;
					if C_CNT > 0 then
						C_CNT := C_DAYS * -1;
						if C_CNT <= C_TEMP_CNT then
							C_DAYS := 0;
						end if;
					end if;
				end if;
			end if;
	-- 기납입금액누계를 구한다.
			select nvl(sum(r_amt),0)
			  into C_R_AMT
			  from H_SALE_ONTIME_INCOME_TEMP
			 where spec_unq_num  = as_spec_unq_num
			   and dept_code     = as_dept_code
				and sell_code = as_sell_code
				and dongho    = as_dongho
				and seq       = as_seq
				and degree_code = C_LAST_DEGREE;
	-- 계산할 약정금액을 구한다(대상금액).
			C_WORK_AMT := C_AGREE_AMT - C_R_AMT;
	-----------------------------------------------------------------------------
	-- 일수가 0일경우 바로 입금처리, +일경우 연체료, -일경우 할인료를 계산한다.
	-----------------------------------------------------------------------------
			-- &&&&&&&&&&&&&
			if C_LAST_DEGREE < '10' then
				C_R_CONT_YN    := C_CONT_YN;
			else
				C_R_CONT_YN    := 'Y';
			end if ;
			if C_LAST_DEGREE > '49' then
				C_R_REMAIND_YN := C_REMAIND_YN;
			end if ;
			if C_LAST_DEGREE >= '10' and C_LAST_DEGREE < '50' then
				C_R_REMAIND_YN := 'Y';
			end if ;
--
			if C_LAST_DEGREE > '49' and C_LAST_SEQ < 70 then
				select moveinto_fr_date,moveinto_to_date
				  into C_FR_DATE,C_TO_DATE
				  from h_sale_master
				 where dept_code = as_dept_code
					and sell_code = as_sell_code
					and dongho    = as_dongho
					and seq       = as_seq;
				if as_input_date >= C_FR_DATE and as_input_date <= C_TO_DATE then
					C_DAYS := 0;
				end if;
			end if;
--			if C_LAST_DEGREE > '49' and C_LAST_SEQ > 69 then
-- 계약금 약정만 있는경우에 loop 방지
			if C_LAST_SEQ > 69 then
				C_TEMP_AMT := c_input_amt;
				c_input_amt := 0;
				C_DELAY_DAY    := 0;
				C_DISCOUNT_DAY := 0;
				C_DELAY_AMT    := 0;
				C_DISCOUNT_AMT := 0;
			else
				if C_DAYS = 0  THEN
					if C_WORK_AMT < c_input_amt THEN
						C_TEMP_AMT   := C_WORK_AMT;
						c_input_amt := c_input_amt - C_WORK_AMT;
					else
						C_TEMP_AMT   := c_input_amt;
						c_input_amt := 0;
					end if;
					C_DELAY_DAY    := 0;
					C_DISCOUNT_DAY := 0;
					C_DELAY_AMT    := 0;
					C_DISCOUNT_AMT := 0;
				else
					if C_DAYS > 0 THEN
						C_DELAY_DAY    := 0;
						C_DISCOUNT_DAY := 0;
						C_DELAY_AMT    := 0;
						C_DISCOUNT_AMT := 0;
						if C_R_CONT_YN = 'Y' then             -- &&&&&&&&&&&&&&&&&&&&&&
							C_DELAY_DAY   := C_DAYS;
							C_TEMP_RATE := 0;
						-- 납입대상금액계산
							OPEN	DETAIL_CUR(C_AGREE_DATE,C_DAYS);
							LOOP
								FETCH DETAIL_CUR INTO C_RATE,C_CUTOFF_STD,C_CUTOFF_UNIT,C_S_DATE,C_E_DATE;
								EXIT WHEN DETAIL_CUR%NOTFOUND;
								if C_AGREE_DATE >= C_S_DATE and as_input_date <= C_E_DATE then
									C_TEMP_RATE := ( C_DELAY_DAY / 365 ) * ( C_RATE / 100 ) ;
									EXIT;
								end if;
								if C_AGREE_DATE >= C_S_DATE then
									select nvl(C_E_DATE - C_AGREE_DATE ,0)
									  into C_TEMP_CNT
									  from dual;
								else
									if as_input_date <= C_E_DATE then
										select nvl(as_input_date - C_S_DATE + 1,0)
										  into C_TEMP_CNT
										  from dual;
									else
										select nvl(C_E_DATE - C_S_DATE + 1,0)
										  into C_TEMP_CNT
										  from dual;
									end if;
								end if;
								C_TEMP_RATE := C_TEMP_RATE + (C_TEMP_CNT / 365) * (C_RATE / 100);
							END LOOP;
							CLOSE DETAIL_CUR;
							C_TEMP_RATE := C_TEMP_RATE + 1;
							if C_TEMP_RATE <> 0 then
								C_TEMP_AMT := c_input_amt / C_TEMP_RATE; -- 납입대상금액
							else
								C_TEMP_AMT := 0;
							end if;
							if C_WORK_AMT <= C_TEMP_AMT then
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
									if C_AGREE_DATE >= C_S_DATE and as_input_date <= C_E_DATE then
										C_TEMP_RATE := 1 + ( C_DELAY_DAY / 365 ) * ( C_RATE / 100 ) ;
										if C_CUTOFF_STD = '01' then
											C_DELAY_AMT := trunc(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
										else
											if C_CUTOFF_STD = '02' then
												C_DELAY_AMT := trunc(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
											else
												C_DELAY_AMT := round(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
											end if;
										end if;
										EXIT;
									end if;
									if C_AGREE_DATE >= C_S_DATE then
										select nvl(C_E_DATE - C_AGREE_DATE ,0)
										  into C_TEMP_CNT
										  from dual;
									else
										if as_input_date <= C_E_DATE then
											select nvl(as_input_date - C_S_DATE + 1,0)
											  into C_TEMP_CNT
											  from dual;
										else
											select nvl(C_E_DATE - C_S_DATE + 1,0)
											  into C_TEMP_CNT
											  from dual;
										end if;
									end if;
									C_TEMP_RATE := 1 + (C_TEMP_CNT / 365) * (C_RATE / 100);
									if C_CUTOFF_STD = '01' then
										C_DELAY_AMT := C_DELAY_AMT + trunc(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
									else
										if C_CUTOFF_STD = '02' then
											C_DELAY_AMT := C_DELAY_AMT + trunc(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
										else
											C_DELAY_AMT := C_DELAY_AMT + round(((C_WORK_AMT * C_TEMP_RATE) - C_WORK_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
										end if;
									end if;
								END LOOP;
								CLOSE DETAIL_CUR;
								C_TEMP_AMT := C_WORK_AMT;
								c_input_amt := c_input_amt - (C_WORK_AMT + C_DELAY_AMT);
							else
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
									if C_AGREE_DATE >= C_S_DATE and as_input_date <= C_E_DATE then
										C_TEMP_RATE := 1 + ( C_DELAY_DAY / 365 ) * ( C_RATE / 100 ) ;
										C_TEMP_AMT := c_input_amt / C_TEMP_RATE;
										if C_CUTOFF_STD = '01' then
											C_DELAY_AMT := trunc((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
										else
											if C_CUTOFF_STD = '02' then
												C_DELAY_AMT := trunc((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
											else
												C_DELAY_AMT := round((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
											end if;
										end if;
										EXIT;
									end if;
									if C_AGREE_DATE >= C_S_DATE then
										select nvl(C_E_DATE - C_AGREE_DATE ,0)
										  into C_TEMP_CNT
										  from dual;
									else
										if as_input_date <= C_E_DATE then
											select nvl(as_input_date - C_S_DATE + 1,0)
											  into C_TEMP_CNT
											  from dual;
										else
											select nvl(C_E_DATE - C_S_DATE + 1,0)
											  into C_TEMP_CNT
											  from dual;
										end if;
									end if;
									C_TEMP_RATE := 1 + (C_TEMP_CNT / 365) * (C_RATE / 100);
									if C_TEMP_RATE <> 0 then
										C_TEMP_AMT := c_input_amt / C_TEMP_RATE;
									else
										C_TEMP_AMT := 0;
									end if;
									if C_CUTOFF_STD = '01' then
										C_DELAY_AMT := C_DELAY_AMT + trunc((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
									else
										if C_CUTOFF_STD = '02' then
											C_DELAY_AMT := C_DELAY_AMT + trunc((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
										else
											C_DELAY_AMT := C_DELAY_AMT + round((c_input_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
										end if;
									end if;
								END LOOP;
								CLOSE DETAIL_CUR;
								C_TEMP_AMT   := c_input_amt - C_DELAY_AMT;
								c_input_amt := 0;
							end if;
						else                 --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
-- 						if C_R_CONT_YN <> 'Y' then          --   &&&&&&&&&&&&&&&&&&&&&&&&
--							C_DELAY_AMT := 0;
--							C_TEMP_AMT  := c_input_amt;
							if C_WORK_AMT < c_input_amt THEN
								C_TEMP_AMT   := C_WORK_AMT;
								c_input_amt := c_input_amt - C_WORK_AMT;
							else
								C_TEMP_AMT   := c_input_amt;
								c_input_amt := 0;
							end if;
						end if;
					else
						C_DELAY_DAY    := 0;
						C_DISCOUNT_DAY := 0;
						C_DELAY_AMT    := 0;
						C_DISCOUNT_AMT := 0;
						if C_R_REMAIND_YN = 'Y' THEN  -- 할인료계산
							C_DISCOUNT_DAY   := C_DAYS * -1;
							C_TEMP_RATE := 0;
							-- 납입대상금액계산
							OPEN	DETAIL_CUR1(C_AGREE_DATE);
							LOOP
								FETCH DETAIL_CUR1 INTO C_RATE,C_CUTOFF_STD,C_CUTOFF_UNIT,C_S_DATE,C_E_DATE;
								EXIT WHEN DETAIL_CUR1%NOTFOUND;
								if C_AGREE_DATE <= C_E_DATE and as_input_date >= C_S_DATE then
									C_TEMP_RATE := ( C_DISCOUNT_DAY / 365 ) * ( C_RATE / 100 ) ;
									EXIT;
								end if;
								if as_input_date >= C_S_DATE then
									select nvl(C_E_DATE - as_input_date ,0)
									  into C_TEMP_CNT
									  from dual;
								else
									if C_AGREE_DATE <= C_E_DATE then
										select nvl(C_AGREE_DATE - C_S_DATE + 1,0)
										  into C_TEMP_CNT
										  from dual;
									else
										select nvl(C_E_DATE - C_S_DATE + 1,0)
										  into C_TEMP_CNT
										  from dual;
									end if;
								end if;
								C_TEMP_RATE := C_TEMP_RATE + (C_TEMP_CNT / 365) * (C_RATE / 100);
							END LOOP;
							CLOSE DETAIL_CUR1;
							C_TEMP_RATE := 1 - C_TEMP_RATE ;
							if C_TEMP_RATE <> 0 then
								C_TEMP_AMT := c_input_amt / C_TEMP_RATE; -- 납입대상금액
							else
								C_TEMP_AMT := 0;
							end if;
							if C_WORK_AMT <= C_TEMP_AMT then
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
									if C_AGREE_DATE <= C_E_DATE and as_input_date >= C_S_DATE then
										C_TEMP_RATE := 1 - ( C_DISCOUNT_DAY / 365 ) * ( C_RATE / 100 ) ;
										if C_CUTOFF_STD = '01' then
											C_DISCOUNT_AMT := trunc((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT,0) * C_COMP_UNIT;
										else
											if C_CUTOFF_STD = '02' then
												C_DISCOUNT_AMT := trunc((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
											else
												C_DISCOUNT_AMT := round((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT,0) * C_COMP_UNIT;
											end if;
										end if;
										EXIT;
									end if;
									if as_input_date >= C_S_DATE then
										select nvl(C_E_DATE - as_input_date ,0)
										  into C_TEMP_CNT
										  from dual;
									else
										if C_AGREE_DATE <= C_E_DATE then
											select nvl(C_AGREE_DATE - C_S_DATE + 1,0)
											  into C_TEMP_CNT
											  from dual;
										else
											select nvl(C_E_DATE - C_S_DATE + 1,0)
											  into C_TEMP_CNT
											  from dual;
										end if;
									end if;
									C_TEMP_RATE := 1 - (C_TEMP_CNT / 365) * (C_RATE / 100);
									if C_CUTOFF_STD = '01' then
										C_DISCOUNT_AMT := C_DISCOUNT_AMT + trunc((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT,0) * C_COMP_UNIT;
									else
										if C_CUTOFF_STD = '02' then
											C_DISCOUNT_AMT := C_DISCOUNT_AMT + trunc((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
										else
											C_DISCOUNT_AMT := C_DISCOUNT_AMT + round((C_WORK_AMT - (C_WORK_AMT * C_TEMP_RATE)) / C_COMP_UNIT,0) * C_COMP_UNIT;
										end if;
									end if;
								END LOOP;
								CLOSE DETAIL_CUR1;
								C_TEMP_AMT := C_WORK_AMT;
								c_input_amt := c_input_amt - (C_WORK_AMT - C_DISCOUNT_AMT);
							else
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
									if C_AGREE_DATE <= C_E_DATE and as_input_date >= C_S_DATE then
										C_TEMP_RATE := 1 - ( C_DISCOUNT_DAY / 365 ) * ( C_RATE / 100 ) ;
										C_TEMP_AMT := c_input_amt / C_TEMP_RATE;
										if C_CUTOFF_STD = '01' then
											C_DISCOUNT_AMT := trunc((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
										else
											if C_CUTOFF_STD = '02' then
												C_DISCOUNT_AMT := trunc((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
											else
												C_DISCOUNT_AMT := round((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
											end if;
										end if;
										EXIT;
									end if;
									if as_input_date >= C_S_DATE then
										select nvl(C_E_DATE - as_input_date ,0)
										  into C_TEMP_CNT
										  from dual;
									else
										if C_AGREE_DATE <= C_E_DATE then
											select nvl(C_AGREE_DATE - C_S_DATE + 1,0)
											  into C_TEMP_CNT
											  from dual;
										else
											select nvl(C_E_DATE - C_S_DATE + 1,0)
											  into C_TEMP_CNT
											  from dual;
										end if;
									end if;
									C_TEMP_RATE := 1 - (C_TEMP_CNT / 365) * (C_RATE / 100);
									if C_TEMP_RATE <> 0 then
										C_TEMP_AMT := c_input_amt / C_TEMP_RATE;
									else
										C_TEMP_AMT := 0;
									end if;
									if C_CUTOFF_STD = '01' then
										C_DISCOUNT_AMT := C_DISCOUNT_AMT + trunc((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
									else
										if C_CUTOFF_STD = '02' then
											C_DISCOUNT_AMT := C_DISCOUNT_AMT + trunc((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
										else
											C_DISCOUNT_AMT := C_DISCOUNT_AMT + round((C_TEMP_AMT - c_input_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
										end if;
									end if;
								END LOOP;
								CLOSE DETAIL_CUR1;
								C_TEMP_AMT   := c_input_amt + C_DISCOUNT_AMT;
								c_input_amt := 0;
							end if;
						else
							if C_WORK_AMT < c_input_amt THEN
								C_TEMP_AMT   := C_WORK_AMT;
								c_input_amt := c_input_amt - C_WORK_AMT;
							else
								C_TEMP_AMT   := c_input_amt;
								c_input_amt := 0;
							end if;
						end if;
					end if;
				end if;
			end if;
	-----------------------------------------------------------------------------
	-----------------------------------------------------------------------------
	-----------------------------------------------------------------------------
	-- 계산된 값을 분양_세대별수입금에 넣어준다.
			INSERT INTO H_SALE_ONTIME_INCOME_TEMP
				VALUES ( as_spec_unq_num, as_dept_code,as_sell_code,as_dongho,as_seq,C_LAST_DEGREE,C_LAST_SEQ,as_input_date,
							as_input_class,as_input_deposit,C_TEMP_AMT,
							C_DELAY_DAY,C_DELAY_AMT,C_DISCOUNT_DAY,C_DISCOUNT_AMT,null,0,as_user,sysdate,'Y',
							null, null, null, null  )  ;
	-- 기납입금액누계를 구한다.
			select nvl(sum(r_amt),0)
			  into C_R_AMT
			  from H_SALE_ONTIME_INCOME_TEMP
			 where spec_unq_num  = as_spec_unq_num
			   and dept_code     = as_dept_code
				and sell_code = as_sell_code
				and dongho    = as_dongho
				and seq       = as_seq
				and degree_code = C_LAST_DEGREE;
	-- 입금완료구분값을 구한다.
			if C_AGREE_AMT <= C_R_AMT THEN
				C_PAY_YN := 'Y';
			else
				C_PAY_YN := 'N';
			end if;
	-- 약정사항에 입금완료구분값과 입금합계값을 넣어준다.
			UPDATE H_SALE_ONTIME_AGREE_TEMP
				SET F_PAY_YN = C_PAY_YN,
					 TOT_AMT = C_R_AMT
			 where spec_unq_num  = as_spec_unq_num
			   and dept_code     = as_dept_code
				and sell_code = as_sell_code
				and dongho    = as_dongho
				and seq       = as_seq
				and degree_code = C_LAST_DEGREE;
	-- 납입금액이 0이면 종료한다.
         IF c_input_amt = 0 THEN
            EXIT;
         END IF;
	-- 납입금액이 0가 아니면 다음차수를 구하여 나머지금액처리를 한다.  &&&&
			if C_LAST_DEGREE >= C_MAX_DEGREE then
				C_LAST_DEGREE := C_MAX_DEGREE;
				select NVL(MAX(degree_seq),0)
				  into C_LAST_SEQ
				  from H_SALE_ONTIME_INCOME_TEMP
				 where spec_unq_num  = as_spec_unq_num
				   and dept_code     = as_dept_code
					and sell_code   = as_sell_code
					and dongho      = as_dongho
					and seq         = as_seq
					and degree_code = C_LAST_DEGREE;
				select f_pay_yn
				  into C_PAY_YN
				  from H_SALE_ONTIME_AGREE_TEMP
				 where spec_unq_num  = as_spec_unq_num
				   and dept_code     = as_dept_code
					and sell_code = as_sell_code
					and dongho    = as_dongho
					and seq       = as_seq
					and degree_code = C_LAST_DEGREE;
				if C_PAY_YN = 'Y' and C_LAST_SEQ < 70 then
					C_LAST_SEQ := 70;
				else
					C_LAST_SEQ := C_LAST_SEQ + 1;
				end if;
			else
				select COUNT(*)
				  into C_CNT
				  from H_SALE_ONTIME_AGREE_TEMP
				 where spec_unq_num  = as_spec_unq_num
				   and dept_code     = as_dept_code
					and sell_code = as_sell_code
					and dongho    = as_dongho
					and seq       = as_seq
					and degree_code > C_LAST_DEGREE;
				if C_CNT > 0 then
					select min(degree_code)
					  into C_LAST_DEGREE
					  from H_SALE_ONTIME_AGREE_TEMP
					 where spec_unq_num  = as_spec_unq_num
					   and dept_code     = as_dept_code
						and sell_code = as_sell_code
						and dongho    = as_dongho
						and seq       = as_seq
						and degree_code > C_LAST_DEGREE;
					select NVL(MAX(degree_seq),0)
					  into C_LAST_SEQ
					  from H_SALE_ONTIME_INCOME_TEMP
					 where spec_unq_num  = as_spec_unq_num
					   and dept_code     = as_dept_code
						and sell_code   = as_sell_code
						and dongho      = as_dongho
						and seq         = as_seq
						and degree_code = C_LAST_DEGREE;
					C_LAST_SEQ := C_LAST_SEQ + 1;
				else
					EXIT;
				end if;
			end if;
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
END y_sp_h_income_ont_cmpt_temp;
/

