CREATE OR REPLACE package body h_calc_income_rent is

PROCEDURE y_sp_h_rent_calc(as_dept_code              IN   VARCHAR2,
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
  FROM h_lease_delay_rate
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND cont_date  = as_cont_date
	AND cont_seq   = as_cont_seq
	AND rate_kind  = '03'
	AND e_date >= V_AGREE_DATE
	AND s_date <= as_input_date
	AND MNTH = (SELECT min(MNTH)
					  FROM H_SALE_DELAY_RATE
					 WHERE dept_code  = as_dept_code
						AND sell_code  = as_sell_code
						AND cont_date  = as_cont_date
	               AND cont_seq   = as_cont_seq
						AND rate_kind  = '03'
						AND e_date >= V_AGREE_DATE
						AND s_date <= as_input_date
						and ADD_MONTHS(V_AGREE_DATE, MNTH) > as_input_date);
CURSOR DETAIL_CUR1 (V_AGREE_DATE DATE )IS
SELECT rate,cutoff_std,cutoff_unit,s_date,e_date
  FROM h_lease_discount_rate
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND cont_date  = as_cont_date
	AND cont_seq        = as_cont_seq
	AND rate_kind  = '03'
	AND e_date >= as_input_date
	AND s_date <= V_AGREE_DATE;
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------

-- 공통 변수
   C_LAST_DEGREE       H_LEASE_rent_AGREE.DEGREE_CODE%TYPE;    -- 마지막약정차수
   C_MAX_DEGREE        H_LEASE_rent_AGREE.DEGREE_CODE%TYPE;    -- 마지막약정차수(잔금,인상분 포함)
   C_LAST_SEQ          H_LEASE_rent_INCOME.DEGREE_SEQ%TYPE;    -- 마지막회수
   C_AGREE_DATE        H_LEASE_rent_AGREE.AGREE_DATE%TYPE;     -- 약정일자
   C_RENT_AMT         H_LEASE_RENT_AGREE.rent_AMT%TYPE;       -- 약정금액
   C_DELAY_AMT         H_LEASE_rent_AGREE.rent_AMT%TYPE;       -- 연체료
   C_DISCOUNT_AMT      H_LEASE_rent_AGREE.rent_AMT%TYPE;       -- 할인료
   C_DELAY_DAY         H_LEASE_rent_INCOME.DISCOUNT_DAYS%TYPE;       -- 연체일자
   C_DISCOUNT_DAY      H_LEASE_rent_INCOME.DISCOUNT_DAYS%TYPE;       -- 할인일자
   C_R_AMT             H_LEASE_rent_AGREE.rent_AMT%TYPE;       -- 납입금액
   C_WORK_AMT          H_LEASE_rent_AGREE.rent_AMT%TYPE;       -- 약정대상금액
   C_TEMP_AMT          H_LEASE_rent_AGREE.rent_AMT%TYPE;       -- 약정계산금액
   C_S_DATE        	  H_LEASE_rent_AGREE.AGREE_DATE%TYPE;     -- 시작일자
   C_E_DATE        	  H_LEASE_rent_AGREE.AGREE_DATE%TYPE;     -- 종료일자
   C_FR_DATE        	  H_LEASE_rent_AGREE.AGREE_DATE%TYPE;     -- 입주개시일
   C_TO_DATE        	  H_LEASE_rent_AGREE.AGREE_DATE%TYPE;     -- 입주종료일
	C_DAILY_SEQ         H_LEASE_rent_INCOME_DAILY.DAILY_SEQ%TYPE;
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
   C_RENT_SUPPLY       NUMBER(30,9);  --
   C_RENT_VAT          NUMBER(30,9);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN

		-- &&&&&&&&&&&&&&
		-- 임대료 연체료 계산 여부를 구한다.분양구분테이블
		select NVL(rent_delay_yn,'N')
		  into C_R_CONT_YN
		  from h_code_house
		 where dept_code = as_dept_code
			and sell_code = as_sell_code;
		-- 임대료 할인료는 계산하지 않는다.
      C_R_REMAIND_YN := 'N' ;
	--
		select NVL(max(degree_code), '50')
		  into C_MAX_DEGREE
		  from H_LEASE_rent_AGREE
		 where dept_code     = as_dept_code
			and sell_code     = as_sell_code
			and cont_date     = as_cont_date
			and cont_seq           = as_cont_seq;
		c_input_amt := as_input_amt;
-- 마지막 약정차수 및 회수를 구한다.
		select COUNT(*)
		  into C_CNT
		  from H_LEASE_rent_AGREE
		 where dept_code     = as_dept_code
			and sell_code     = as_sell_code
			and cont_date     = as_cont_date
			and cont_seq           = as_cont_seq
			and f_pay_yn      = 'N';
		if C_CNT > 0 THEN
			select min(degree_code)
			  into C_LAST_DEGREE
			  from H_LEASE_rent_AGREE
			 where dept_code     = as_dept_code
				and sell_code     = as_sell_code
				and cont_date     = as_cont_date
				and cont_seq      		= as_cont_seq
			 	and f_pay_yn      = 'N';
			select NVL(MAX(degree_seq),0)
			  into C_LAST_SEQ
			  from H_LEASE_rent_INCOME
			 where dept_code     = as_dept_code
				and sell_code     = as_sell_code
				and cont_date     = as_cont_date
				and cont_seq           = as_cont_seq
			 	and degree_code   = C_LAST_DEGREE;
			C_LAST_SEQ := C_LAST_SEQ + 1;
		else
			select count(*)
			  into C_CNT
			  from H_LEASE_rent_AGREE
			 where dept_code = as_dept_code
				and sell_code = as_sell_code
				and cont_date = as_cont_date
				and cont_seq       = as_cont_seq;
-- 마지막 차수에 초과 납부를 처리하기 위하여
 			if C_CNT < 1 THEN
   			Wk_errflag := '-20002';
		      e_msg  := ' 약정차수가 없습니다. 동호==>' ;
 	         GOTO EXIT_ROUTINE;
 			end if;
			select max(degree_code)
			  into C_LAST_DEGREE
			  from H_LEASE_rent_AGREE
			 where dept_code     = as_dept_code
				and sell_code     = as_sell_code
				and cont_date     = as_cont_date
				and cont_seq      		= as_cont_seq  ;
			select NVL(MAX(degree_seq),0)
			  into C_LAST_SEQ
			  from H_LEASE_rent_INCOME
			 where dept_code     = as_dept_code
				and sell_code     = as_sell_code
				and cont_date     = as_cont_date
				and cont_seq           = as_cont_seq
			 	and degree_code   = C_LAST_DEGREE;
			if C_LAST_SEQ < 70 THEN
				C_LAST_SEQ := 70;
			else
				C_LAST_SEQ := C_LAST_SEQ + 1;
			end if;
		end if;
-- LOOP 시작
		LOOP
	-- 일수 및 약정금액을 구한다
			select nvl((agree_date - as_input_date) * -1,0),nvl(rent_AMT,0),agree_date, vat_yn
			  into C_DAYS,C_RENT_AMT,C_AGREE_DATE, C_VAT_YN
			  from H_LEASE_rent_AGREE
			 where dept_code     = as_dept_code
				and sell_code     = as_sell_code
				and cont_date     = as_cont_date
				and cont_seq           = as_cont_seq
			 	and degree_code   = C_LAST_DEGREE;
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
			  from H_LEASE_rent_INCOME
			 where dept_code     = as_dept_code
				and sell_code     = as_sell_code
				and cont_date     = as_cont_date
				and cont_seq           = as_cont_seq
			 	and degree_code   = C_LAST_DEGREE;
	-- 계산할 약정금액을 구한다(대상금액).
			C_WORK_AMT := C_RENT_AMT - C_R_AMT;
	-----------------------------------------------------------------------------
	-- 일수가 0일경우 바로 입금처리, +일경우 연체료, -일경우 할인료를 계산한다.
	-----------------------------------------------------------------------------
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
	      IF C_VAT_YN = 'Y' THEN
				C_RENT_SUPPLY := Trunc(C_TEMP_AMT / 1.1,0);
				C_RENT_VAT    := C_TEMP_AMT - C_RENT_SUPPLY ;
			ELSE
				C_RENT_SUPPLY := C_TEMP_AMT;
				C_RENT_VAT    := 0;
			END IF;
	-- 계산된 값을 분양_보증금납입에 넣어준다.
			INSERT INTO H_LEASE_rent_INCOME
				VALUES ( as_dept_code,as_sell_code,as_cont_date,as_cont_seq,C_LAST_DEGREE,C_LAST_SEQ,
							as_input_date,as_daily_seq, as_input_deposit,C_TEMP_AMT,C_RENT_SUPPLY, C_RENT_VAT,
							C_DELAY_DAY,C_DELAY_AMT,C_DISCOUNT_DAY,C_DISCOUNT_AMT,null,null,as_user,sysdate,'N')  ;
	-- 기납입금액누계를 구한다.
			select nvl(sum(r_amt),0)
			  into C_R_AMT
			  from H_LEASE_rent_INCOME
			 where dept_code     = as_dept_code
				and sell_code     = as_sell_code
				and cont_date     = as_cont_date
				and cont_seq      = as_cont_seq
			 	and degree_code   = C_LAST_DEGREE;
	-- 입금완료구분값을 구한다.
			if C_RENT_AMT <= C_R_AMT THEN
				C_PAY_YN := 'Y';
			else
				C_PAY_YN := 'N';
			end if;
	-- 약정사항에 입금완료구분값과 입금합계값을 넣어준다.
			UPDATE H_LEASE_rent_AGREE
				SET F_PAY_YN = C_PAY_YN,
					 PAY_TOT_AMT = C_R_AMT
			 where dept_code     = as_dept_code
				and sell_code     = as_sell_code
				and cont_date     = as_cont_date
				and cont_seq      = as_cont_seq
			 	and degree_code   = C_LAST_DEGREE;
	-- 납입금액이 0이면 종료한다.
         IF c_input_amt = 0 THEN
            EXIT;
         END IF;
	-- 납입금액이 0가 아니면 다음차수를 구하여 나머지금액처리를 한다.
			select COUNT(*)
			  into C_CNT
			  from H_LEASE_rent_AGREE
			 where dept_code     = as_dept_code
				and sell_code     = as_sell_code
				and cont_date     = as_cont_date
				and cont_seq      = as_cont_seq
				and degree_code > C_LAST_DEGREE;
			if C_CNT > 0 then
				select min(degree_code)
				  into C_LAST_DEGREE
				  from H_LEASE_rent_AGREE
				 where dept_code     = as_dept_code
					and sell_code     = as_sell_code
					and cont_date     = as_cont_date
					and cont_seq           = as_cont_seq
					and degree_code   > C_LAST_DEGREE;
				select NVL(MAX(degree_seq),0)
				  into C_LAST_SEQ
				  from H_LEASE_rent_INCOME
				 where dept_code     = as_dept_code
					and sell_code     = as_sell_code
					and cont_date     = as_cont_date
					and cont_seq           = as_cont_seq
					and degree_code   = C_LAST_DEGREE;
				C_LAST_SEQ := C_LAST_SEQ + 1;
			else
				select NVL(MAX(degree_seq),0)
				  into C_LAST_SEQ
				  from H_LEASE_rent_INCOME
				 where dept_code     = as_dept_code
					and sell_code     = as_sell_code
					and cont_date     = as_cont_date
					and cont_seq           = as_cont_seq
					and degree_code   = C_LAST_DEGREE;
				select f_pay_yn
				  into C_PAY_YN
				  from H_LEASE_rent_AGREE
				 where dept_code     = as_dept_code
					and sell_code     = as_sell_code
					and cont_date     = as_cont_date
					and cont_seq      = as_cont_seq
					and degree_code   = C_LAST_DEGREE;
				if C_PAY_YN = 'Y' and C_LAST_SEQ < 70 then
					C_LAST_SEQ := 70;
				else
					C_LAST_SEQ := C_LAST_SEQ + 1;
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
END y_sp_h_rent_calc;

PROCEDURE y_sp_h_rent_cmpt(as_dept_code              IN   VARCHAR2,
															  as_sell_code              IN   VARCHAR2,
															  as_cont_date              IN   DATE,
															  as_cont_seq               IN   INTEGER,
                                               as_input_date             IN   DATE,
                                               as_input_amt              IN   NUMBER,
															  as_input_deposit          IN   VARCHAR2,
															  as_user                   IN   VARCHAR2 ) IS
----------------------------이후자료저장
CURSOR DAILY_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ, AMT, DEPOSIT_NO
  FROM h_lease_rent_income_daily
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND cont_date  = as_cont_date
	AND cont_seq        = as_cont_seq
	AND receipt_date > as_input_date
order by receipt_date, daily_seq;

-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   C_RECEIPT_DATE      H_LEASE_rent_INCOME_DAILY.RECEIPT_DATE%TYPE;
	C_DAILY_SEQ         H_LEASE_rent_INCOME_DAILY.DAILY_SEQ%TYPE;
	C_AMT                H_LEASE_rent_INCOME_DAILY.AMT%TYPE;
	C_DEPOSIT_NO         H_LEASE_rent_INCOME_DAILY.DEPOSIT_NO%TYPE;

   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN
	OPEN DAILY_CUR;

	SELECT min(RECEIPT_DATE), min(DAILY_SEQ)
	  INTO C_RECEIPT_DATE, C_DAILY_SEQ
	  FROM h_lease_rent_income_daily
	 WHERE dept_code  = as_dept_code
		AND sell_code  = as_sell_code
		AND cont_date  = as_cont_date
		AND cont_seq   = as_cont_seq
		AND receipt_date > as_input_date;

	IF C_RECEIPT_DATE > '1900.01.01' AND C_DAILY_SEQ > 0 THEN
	   --------------------------------이후자료삭제
		h_calc_income_rent.y_sp_h_delete_daily_rent(as_dept_code, as_sell_code, as_cont_date, as_cont_seq,
										C_RECEIPT_DATE, C_DAILY_SEQ, 0);
	END IF;

	select nvl(max(daily_seq), 0) + 1
	  into C_DAILY_SEQ
	  from h_lease_rent_income_daily
	 where dept_code     = as_dept_code
		and sell_code     = as_sell_code
		and cont_date     = as_cont_date
		and cont_seq      = as_cont_seq
		and receipt_date  = as_input_date;
	INSERT INTO H_LEASE_rent_INCOME_DAILY   --일자별 납입금 테이블에 INSERT한다
        VALUES (as_dept_code, as_sell_code, as_cont_date, as_cont_seq, as_input_date, C_DAILY_SEQ, as_input_amt,
		        null,as_input_deposit,null,null,null,null);

	-----------------------------------현자료입금처리

	h_calc_income_rent.y_sp_h_rent_calc(as_dept_code,as_sell_code,as_cont_date ,as_cont_seq ,as_input_date,C_DAILY_SEQ,
                      as_input_amt,as_input_deposit,as_user);

	LOOP
		FETCH DAILY_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ, C_AMT, C_DEPOSIT_NO ;
		EXIT WHEN DAILY_CUR%NOTFOUND;

		-----------------------------------이후자료 재입금
		h_calc_income_rent.y_sp_h_rent_cmpt(as_dept_code, as_sell_code, as_cont_date, as_cont_seq, C_RECEIPT_DATE, C_AMT,
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
END y_sp_h_rent_cmpt;



PROCEDURE y_sp_h_delete_daily_rent(as_dept_code    IN   VARCHAR2,
	                                                    as_sell_code    IN   VARCHAR2,
	                                                    as_cont_date    IN   DATE,
	                                                    as_cont_seq          IN   INTEGER,
																		 as_receipt_date IN   DATE,
																		 as_daily_seq    IN   INTEGER,
																		 as_recalc_tag   IN   integer) IS

--as_recalc_tag  1  *삭제하려는 차수 삭제, *이후차수 삭제, *이후차수에 대해서 재계산
--as_recalc_tag  0  *삭제하려는 차수 삭제, *이후차수 삭제  (재계산 안함)

--삭제할 차수 포함해서 이후에 대해서 보관한다. 삭제용
CURSOR DAILY_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ
  FROM h_lease_rent_income_daily
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND cont_date  = as_cont_date
	AND cont_seq        = as_cont_seq
	AND (    receipt_date > as_receipt_date
	     or  (receipt_date = as_receipt_date and
		       daily_seq    >= as_daily_seq)
		 )
ORDER BY receipt_date, daily_seq;
--삭제할 차수 이후에 대해서 보관한다. 재입금 처리용(재계산)
CURSOR DAILY_RECALC_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ, AMT, DEPOSIT_NO
  FROM h_lease_rent_income_daily
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND cont_date  = as_cont_date
	AND cont_seq        = as_cont_seq
	AND (    receipt_date > as_receipt_date
	     or  (receipt_date = as_receipt_date and
		       daily_seq    > as_daily_seq)
		 )
ORDER BY receipt_date, daily_seq;
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
C_RECEIPT_DATE       H_lease_rent_INCOME_DAILY.RECEIPT_DATE%TYPE;
C_DAILY_SEQ          H_lease_rent_INCOME_DAILY.DAILY_SEQ%TYPE;
C_AMT                H_lease_rent_INCOME_DAILY.AMT%TYPE;
C_DEPOSIT_NO         H_lease_rent_INCOME_DAILY.DEPOSIT_NO%TYPE;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_CNT                NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	begin
		OPEN	DAILY_CUR;
		OPEN	DAILY_RECALC_CUR; --재계산하기 위해서 삭제 하기전에 가져온다
-----------------------------------------삭제처리
		LOOP
			FETCH DAILY_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ ;
			EXIT WHEN DAILY_CUR%NOTFOUND;

			update h_lease_rent_agree
			  set (pay_tot_amt,f_pay_yn)=
				   (select agree.pay_tot_amt - in_sum.amt,
				           case when agree.pay_tot_amt - in_sum.amt = agree.rent_amt
				                then 'Y'
								 	 else 'N'
							  end case
					   from h_lease_rent_agree agree,
					       (select income.degree_code,
					               sum(nvl(income.r_amt, 0)) amt
					          from h_lease_rent_income income
							   where income.dept_code = as_dept_code
							     and income.sell_code = as_sell_code
								  and income.cont_date    = as_cont_date
								  and income.cont_seq       = as_cont_seq
								  and income.receipt_date = C_RECEIPT_DATE
								  and income.daily_seq    = C_DAILY_SEQ
							  group by income.degree_code) in_sum

					  where agree.dept_code = as_dept_code
					    and agree.sell_code = as_sell_code
					    and agree.cont_date = as_cont_date
					    and agree.cont_seq  = as_cont_seq
					    and agree.degree_code = in_sum.degree_code
						 and h_lease_rent_agree.degree_code = in_sum.degree_code)
			where h_lease_rent_agree.dept_code = as_dept_code
			  and h_lease_rent_agree.sell_code = as_sell_code
			  and h_lease_rent_agree.cont_date    = as_cont_date
			  and h_lease_rent_agree.cont_seq       = as_cont_seq
			  and h_lease_rent_agree.degree_code in (select income.degree_code
												          from h_lease_rent_income income
														   where income.dept_code = as_dept_code
														     and income.sell_code = as_sell_code
															  and income.cont_date    = as_cont_date
															  and income.cont_seq     = as_cont_seq
															  and income.receipt_date = C_RECEIPT_DATE
								                       and income.daily_seq    = C_DAILY_SEQ);


	     delete from h_lease_rent_income income
		   where income.dept_code = as_dept_code
		     and income.sell_code = as_sell_code
			  and income.cont_date = as_cont_date
			  and income.cont_seq       = as_cont_seq
			  and income.receipt_date = C_RECEIPT_DATE
	        and income.daily_seq    = C_DAILY_SEQ;
		  delete from h_lease_rent_income_daily daily
		   where daily.dept_code = as_dept_code
		     and daily.sell_code = as_sell_code
			  and daily.cont_date = as_cont_date
			  and daily.cont_seq       = as_cont_seq
			  and daily.receipt_date = C_RECEIPT_DATE
	        and daily.daily_seq    = C_DAILY_SEQ;

      END LOOP;
		CLOSE DAILY_CUR;

-----------------------------------------재계산처리
      IF as_recalc_tag = 1 THEN
			LOOP
				FETCH DAILY_RECALC_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ, C_AMT, C_DEPOSIT_NO;
				EXIT WHEN DAILY_RECALC_CUR%NOTFOUND;


			   h_calc_income_rent.y_sp_h_rent_cmpt(as_dept_code, as_sell_code, as_cont_date, as_cont_seq, C_RECEIPT_DATE, C_AMT,
				 					 C_DEPOSIT_NO, '재계산');
			END LOOP;
		END IF;

		CLOSE DAILY_RECALC_CUR;

	 EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '일자별수입금 삭제및 재계산 실패! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	end;
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
END y_sp_h_delete_daily_rent;


PROCEDURE y_sp_h_delay_recalc_rent(as_dept_code    IN   VARCHAR2,
                                                as_sell_code    IN   VARCHAR2,
                                                as_cont_date    IN   DATE,
                                                as_cont_seq     IN   INTEGER,
																as_degree_code  IN   VARCHAR2,
																as_degree_seq   IN   INTEGER,
																as_receipt_date IN   DATE,
																as_daily_seq    IN   INTEGER,
																as_delay_amt    IN   NUMBER,
																as_discount_amt IN   NUMBER) IS



--업데이트하는 차수 이후에 대해서 보관한다.
CURSOR DAILY_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ, AMT, DEPOSIT_NO
  FROM h_lease_rent_income_daily
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND cont_date  = as_cont_date
	AND cont_seq   = as_cont_seq
	AND ((receipt_date > as_receipt_date) or
		  (receipt_date = as_receipt_date and daily_seq > as_daily_seq))
order by receipt_date, daily_seq;
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
C_AGREE_AMT         NUMBER(13);
C_DEGREE_SUM_AMT    NUMBER(13);
C_R_AMT_OVER         NUMBER(13);
R_AMT_CHG_TAG        VARCHAR2(1);
C_RECEIPT_DATE       H_LEASE_rent_INCOME_DAILY.RECEIPT_DATE%TYPE;
C_DAILY_SEQ          H_LEASE_rent_INCOME_DAILY.DAILY_SEQ%TYPE;
C_AMT                H_LEASE_rent_INCOME_DAILY.AMT%TYPE;
C_DEPOSIT_NO         H_LEASE_rent_INCOME_DAILY.DEPOSIT_NO%TYPE;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_CNT                NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	begin

		select r_amt, delay_amt, discount_amt
		  into C_R_AMT, C_ORG_DELAY_AMT, C_ORG_DISCOUNT_AMT
		  from h_lease_rent_income income
		 where income.dept_code = as_dept_code
	      and income.sell_code = as_sell_code
		   and income.cont_date = as_cont_date
		   and income.cont_seq    = as_cont_seq
		   and income.degree_code = as_degree_code
		   and income.degree_seq  = as_degree_seq;

		C_DELAY_OFFSET    := as_delay_amt    - C_ORG_DELAY_AMT;
		C_DISCOUNT_OFFSET := as_discount_amt - C_ORG_DISCOUNT_AMT;
		C_TOTAL_OFFSET    := C_DELAY_OFFSET - C_DISCOUNT_OFFSET;

		IF C_TOTAL_OFFSET = 0 THEN --이게 0 이면 게산할필요가 없다.연체료/할인료만 업데이트하고 끝

		   UPDATE H_LEASE_rent_INCOME
			   SET delay_amt    = as_delay_amt,
					 discount_amt = as_discount_amt
			 WHERE dept_code = as_dept_code
		      and sell_code = as_sell_code
			   and cont_date      = as_cont_date
			   and cont_seq       = as_cont_seq
			   and degree_code = as_degree_code
			   and degree_seq  = as_degree_seq;
			RETURN;
		END IF;

		select nvl(sum(nvl(income.r_amt, 0) + nvl(income.delay_amt, 0) - nvl(income.discount_amt, 0)), 0)
		  into C_WORK_AMT
		  from h_lease_rent_income income
		 where income.dept_code = as_dept_code
	      and income.sell_code = as_sell_code
		   and income.cont_date = as_cont_date
		   and income.cont_seq       = as_cont_seq
		   and income.receipt_date = as_receipt_date
		   and income.daily_seq    = as_daily_seq
			and ((income.degree_code > as_degree_code) or
			     (income.degree_code = as_degree_code and income.degree_seq > as_degree_seq));

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
			   C_R_AMT := C_R_AMT - C_DELAY_OFFSET;
			END IF;
			IF C_DISCOUNT_OFFSET > 0 THEN
				C_R_AMT := C_R_AMT + 0; --C_DISCOUNT_OFFSET;
			ELSE
			   C_R_AMT := C_R_AMT - C_DISCOUNT_OFFSET;
			END IF;
			R_AMT_CHG_TAG := 'Y';

		END IF;

		IF R_AMT_CHG_TAG = 'Y' THEN
		
			SELECT SUM(NVL(R_AMT+DELAY_AMT-DISCOUNT_AMT,0))
			  INTO C_DEGREE_SUM_AMT
			  from H_LEASE_RENT_INCOME
			 WHERE dept_code = as_dept_code
		      and sell_code = as_sell_code
			   and cont_date = as_cont_date
			   and cont_seq    = as_cont_seq
			   and degree_code = as_degree_code
				and (degree_seq  < as_degree_seq or degree_seq = as_degree_seq) ;
			 
			SELECT rent_amt
			  INTO C_AGREE_AMT
			  FROM H_LEASE_RENT_AGREE
			 WHERE dept_code = as_dept_code
		      and sell_code = as_sell_code
			   and cont_date = as_cont_date
			   and cont_seq    = as_cont_seq
			   and degree_code = as_degree_code;
			
			IF C_DEGREE_SUM_AMT > C_AGREE_AMT THEN
				C_R_AMT := C_R_AMT - (C_DEGREE_SUM_AMT - C_AGREE_AMT);
				C_R_AMT_OVER := C_DEGREE_SUM_AMT - C_AGREE_AMT;
			END IF; 

			UPDATE H_LEASE_rent_INCOME
			   SET r_amt        = C_R_AMT,
				    delay_amt    = as_delay_amt,
					 discount_amt = as_discount_amt,

					 input_id     = '연체',
					 modi_yn      = 'Y'
			 WHERE dept_code = as_dept_code
		      and sell_code = as_sell_code
			   and cont_date = as_cont_date
			   and cont_seq    = as_cont_seq
			   and degree_code = as_degree_code
			   and degree_seq  = as_degree_seq;
				
			 --IF C_R_AMT_OVER > 0 THEN
			 --  h_calc_income_rent.y_sp_h_rent_calc(as_dept_code,as_sell_code,as_cont_date ,as_cont_seq ,as_receipt_date,as_daily_seq,
          --            C_R_AMT_OVER, C_DEPOSIT_NO,'재계산1');
			 --END IF;

		ELSE --원금 안 변했으면 연체료와 할인료 업데이트

		   UPDATE H_LEASE_rent_INCOME
			   SET delay_amt    = as_delay_amt,
					 discount_amt = as_discount_amt,
					 input_id     = '연체',
					 modi_yn      = 'Y'
			 WHERE dept_code = as_dept_code
		      and sell_code = as_sell_code
			   and cont_date = as_cont_date
			   and cont_seq       = as_cont_seq
			   and degree_code = as_degree_code
			   and degree_seq  = as_degree_seq;

		END IF;
      delete h_lease_rent_income income
		 where income.dept_code = as_dept_code
	      and income.sell_code = as_sell_code
		   and income.cont_date = as_cont_date
		   and income.cont_seq  = as_cont_seq
		   --and income.receipt_date = as_receipt_date
		   --and income.daily_seq    = as_daily_seq
			and ((income.degree_code > as_degree_code) or
			     (income.degree_code = as_degree_code and income.degree_seq > as_degree_seq));

		--약정 완납구분 업데이트
		update h_lease_rent_agree
		  set (pay_tot_amt,f_pay_yn)=
			   (select in_sum.amt,
			           case when in_sum.amt = agree.rent_amt
			                then 'Y'
							 	 else 'N'
						  end case
				   from h_lease_rent_agree agree,
				       (select income.degree_code,
				               sum(nvl(income.r_amt, 0)) amt
				          from h_lease_rent_income income
						   where income.dept_code = as_dept_code
						     and income.sell_code = as_sell_code
							  and income.cont_date = as_cont_date
							  and income.cont_seq       = as_cont_seq
							  and income.degree_code = as_degree_code
						  group by income.degree_code) in_sum

				  where agree.dept_code = as_dept_code
				    and agree.sell_code = as_sell_code
				    and agree.cont_date    = as_cont_date
				    and agree.cont_seq       = as_cont_seq
				    and agree.degree_code = in_sum.degree_code(+)
					 and h_lease_rent_agree.degree_code = agree.degree_code)
		where h_lease_rent_agree.dept_code = as_dept_code
		  and h_lease_rent_agree.sell_code = as_sell_code
		  and h_lease_rent_agree.cont_date = as_cont_date
		  and h_lease_rent_agree.cont_seq  = as_cont_seq
		  and h_lease_rent_agree.degree_code = as_degree_code;
		  
		IF C_R_AMT_OVER > 0 THEN
			   h_calc_income_rent.y_sp_h_rent_calc(as_dept_code,as_sell_code,as_cont_date ,as_cont_seq ,as_receipt_date,as_daily_seq,
                      C_R_AMT_OVER, C_DEPOSIT_NO,'재계산1');
	   END IF;

		select amt,  deposit_no
		  into C_DAILY_AMT, C_DEPOSIT_NO

		  from h_lease_rent_income_daily daily
		 where daily.dept_code = as_dept_code
	      and daily.sell_code = as_sell_code
		   and daily.cont_date = as_cont_date
		   and daily.cont_seq       = as_cont_seq
		   and daily.receipt_date = as_receipt_date
		   and daily.daily_seq    = as_daily_seq;

		select nvl(sum(nvl(income.r_amt, 0) + nvl(income.delay_amt, 0) - nvl(income.discount_amt, 0)), 0)
		  into C_INCOME_AMT
		  from h_lease_rent_income income
		 where income.dept_code = as_dept_code
	      and income.sell_code = as_sell_code
		   and income.cont_date = as_cont_date
		   and income.cont_seq       = as_cont_seq
		   and income.receipt_date = as_receipt_date
		   and income.daily_seq    = as_daily_seq;



		IF C_DAILY_AMT > C_INCOME_AMT THEN
			h_calc_income_rent.y_sp_h_rent_calc(as_dept_code,as_sell_code,as_cont_date ,as_cont_seq ,as_receipt_date,as_daily_seq,
                      C_DAILY_AMT - C_INCOME_AMT, C_DEPOSIT_NO,'재계산1');

		END IF;

		--DIALY 에서 이후 입금분에 대해서 재입금 처리

		SELECT min(to_char(RECEIPT_DATE,'yyyymmdd')||to_char(DAILY_SEQ,'0000'))
		  INTO C_TEMP_STR
		  FROM h_lease_rent_income_daily
		 WHERE dept_code  = as_dept_code
			AND sell_code  = as_sell_code
			AND cont_date  = as_cont_date
			AND cont_seq   = as_cont_seq
			AND ((receipt_date > as_receipt_date) or
			     (receipt_date = as_receipt_date and daily_seq > as_daily_seq));
		C_RECEIPT_DATE:= TO_DATE(SUBSTR(C_TEMP_STR,1,8));
		C_DAILY_SEQ   := TO_NUMBER(SUBSTR(C_TEMP_STR,10,4));

		IF C_RECEIPT_DATE > '1900.01.01' AND C_DAILY_SEQ > 0 THEN

		   OPEN DAILY_CUR;  --삭제하기전 저장
		   --------------------------------이후자료삭제


			h_calc_income_rent.y_sp_h_delete_daily_rent(as_dept_code, as_sell_code, as_cont_date, as_cont_seq,
												C_RECEIPT_DATE, C_DAILY_SEQ, 0);
			LOOP
				FETCH DAILY_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ, C_AMT, C_DEPOSIT_NO;

				EXIT WHEN DAILY_CUR%NOTFOUND;

				-----------------------------------이후자료 재입금
				IF C_AMT <> 0 THEN
			   	h_calc_income_rent.y_sp_h_rent_cmpt(as_dept_code, as_sell_code, as_cont_date, as_cont_seq, C_RECEIPT_DATE, C_AMT,
										 C_DEPOSIT_NO, '재계산2');

				END IF;
			END LOOP;
			CLOSE DAILY_CUR;
		END IF;

	 EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := sqlerrm; --'연체료/할인료변경 및 재계산 실패! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	end;
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
END y_sp_h_delay_recalc_rent;



end;
/

