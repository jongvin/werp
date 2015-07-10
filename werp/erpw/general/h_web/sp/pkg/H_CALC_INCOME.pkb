CREATE OR REPLACE PACKAGE BODY H_Calc_Income IS

PROCEDURE Y_Sp_H_Income_Calc(as_dept_code              IN   VARCHAR2,
															  as_sell_code              IN   VARCHAR2,
															  as_dongho                 IN   VARCHAR2,
															  as_seq                    IN   INTEGER,
                                               as_input_date             IN   DATE,
															  as_daily_seq              IN   INTEGER,
                                               as_input_amt              IN   NUMBER,
															  as_input_class            IN   VARCHAR2,
															  as_input_deposit          IN   VARCHAR2,
															  as_user                   IN   VARCHAR2,
															  as_receipt_class_code     IN   VARCHAR2,
															  as_receipt_number         IN   VARCHAR2,
															  as_card_app_num           IN   VARCHAR2,
															  as_card_bank_code         IN   VARCHAR2,
                                               as_v_account_no           IN   VARCHAR2) IS
CURSOR DETAIL_CUR (V_AGREE_DATE DATE, V_DAYS INTEGER )IS
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
-- ��������
-------------------------------------------------------------
-- ���� ����
   C_LAST_DEGREE       H_SALE_AGREE.DEGREE_CODE%TYPE;    -- ��������������
   C_MAX_DEGREE        H_SALE_AGREE.DEGREE_CODE%TYPE;    -- ��������������(�ܱ�,�λ�� ����)
   C_LAST_SEQ          H_SALE_INCOME.DEGREE_SEQ%TYPE;    -- ������ȸ��
   C_AGREE_DATE        H_SALE_AGREE.AGREE_DATE%TYPE;     -- ��������
   C_SELL_AMT          H_SALE_AGREE.SELL_AMT%TYPE;       -- �����ݾ�
   C_LAND_AMT          H_SALE_AGREE.SELL_AMT%TYPE;       -- ���������ݾ�
   C_BUILD_AMT         H_SALE_AGREE.SELL_AMT%TYPE;       -- �����ǹ��ݾ�
   C_VAT_AMT           H_SALE_AGREE.SELL_AMT%TYPE;       -- �����ΰ���
   C_DELAY_AMT         H_SALE_AGREE.SELL_AMT%TYPE;       -- ��ü��
   C_DISCOUNT_AMT      H_SALE_AGREE.SELL_AMT%TYPE;       -- ���η�
   C_DELAY_DAY         H_SALE_INCOME.DISCOUNT_DAYS%TYPE;       -- ��ü����
   C_DISCOUNT_DAY      H_SALE_INCOME.DISCOUNT_DAYS%TYPE;       -- ��������
   C_R_AMT             H_SALE_AGREE.SELL_AMT%TYPE;       -- ���Աݾ�
   C_R_LAND_AMT        H_SALE_AGREE.SELL_AMT%TYPE;       -- ���������ݾ�
   C_R_BUILD_AMT       H_SALE_AGREE.SELL_AMT%TYPE;       -- ���԰ǹ��ݾ�
   C_R_VAT_AMT         H_SALE_AGREE.SELL_AMT%TYPE;       -- ���Ժΰ���
   C_C_LAND_AMT        H_SALE_AGREE.SELL_AMT%TYPE;       -- ���������ݾ�
   C_C_BUILD_AMT       H_SALE_AGREE.SELL_AMT%TYPE;       -- ���԰ǹ��ݾ�
   C_C_VAT_AMT         H_SALE_AGREE.SELL_AMT%TYPE;       -- ���Ժΰ���
   C_WORK_AMT          H_SALE_AGREE.SELL_AMT%TYPE;       -- �������ݾ�
   C_TEMP_AMT          H_SALE_AGREE.SELL_AMT%TYPE;       -- �������ݾ�
   C_S_DATE        	  H_SALE_AGREE.AGREE_DATE%TYPE;     -- ��������
   C_E_DATE        	  H_SALE_AGREE.AGREE_DATE%TYPE;     -- ��������
   C_FR_DATE        	  H_SALE_AGREE.AGREE_DATE%TYPE;     -- ���ְ�����
   C_TO_DATE        	  H_SALE_AGREE.AGREE_DATE%TYPE;     -- ����������
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
   C_TEMP_CNT           NUMBER(10,5);  -- ��������
   C_CNT                NUMBER(10,5);  --
   c_input_amt          NUMBER(30,9);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN

      IF as_input_amt = 0 THEN
		RETURN;
		END IF;
		-- &&&&&&&&&&&&&&
		-- ���� �Ǵ� �ܱ��� ��� ����(����:��ü����,�ܱ�:���ο���)��� ���θ� ���Ѵ�.�о籸�����̺�
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
		c_input_amt := as_input_amt;
-- ������ �������� �� ȸ���� ���Ѵ�.
		SELECT COUNT(*)
		  INTO C_CNT
		  FROM H_SALE_AGREE
		 WHERE dept_code = as_dept_code
			AND sell_code = as_sell_code
			AND dongho    = as_dongho
			AND seq       = as_seq
			AND f_pay_yn  = 'N';
		IF C_CNT > 0 THEN
			SELECT MIN(degree_code)
			  INTO C_LAST_DEGREE
			  FROM H_SALE_AGREE
			 WHERE dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND f_pay_yn  = 'N';
			SELECT NVL(MAX(degree_seq),0)
			  INTO C_LAST_SEQ
			  FROM H_SALE_INCOME
			 WHERE dept_code   = as_dept_code
				AND sell_code   = as_sell_code
				AND dongho      = as_dongho
				AND seq         = as_seq
				AND degree_code = C_LAST_DEGREE;
			C_LAST_SEQ := C_LAST_SEQ + 1;
		ELSE
			SELECT COUNT(*)
			  INTO C_CNT
			  FROM H_SALE_AGREE
			 WHERE dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq ;
-- ������ ������ �ʰ� ���θ� ó���ϱ� ���Ͽ� '50' ���� ���� ����.
--				and degree_code > '49';
 			IF C_CNT < 1 THEN
   			Wk_errflag := '-20001';
		      e_msg  := ' ���������� �����ϴ�. ��ȣ==>' || as_dongho;
 	         GOTO EXIT_ROUTINE;
 			END IF;
			--C_LAST_DEGREE := '50';
			SELECT MAX(degree_code)
			  INTO C_LAST_DEGREE
			  FROM H_SALE_INCOME
			 WHERE dept_code   = as_dept_code
				AND sell_code   = as_sell_code
				AND dongho      = as_dongho
				AND seq         = as_seq ;
			SELECT NVL(MAX(degree_seq),0)
			  INTO C_LAST_SEQ
			  FROM H_SALE_INCOME
			 WHERE dept_code   = as_dept_code
				AND sell_code   = as_sell_code
				AND dongho      = as_dongho
				AND seq         = as_seq
				AND degree_code = C_LAST_DEGREE;
			IF C_LAST_SEQ < 70 THEN
				C_LAST_SEQ := 70;
			ELSE
				C_LAST_SEQ := C_LAST_SEQ + 1;
			END IF;
		END IF;
-- LOOP ����
		LOOP
	-- �ϼ� �� �����ݾ��� ���Ѵ�
			SELECT NVL((agree_date - as_input_date) * -1,0),NVL(sell_amt,0),NVL(land_amt,0),NVL(build_amt,0),NVL(vat_amt,0),agree_date
			  INTO C_DAYS,C_SELL_AMT,C_LAND_AMT,C_BUILD_AMT,C_VAT_AMT,C_AGREE_DATE
			  FROM H_SALE_AGREE
			 WHERE dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = C_LAST_DEGREE;

/* ���䱸���� �ܱ������ΰ�� ���� ���ֽ���/������ �����Ϸ� ����ߴµ� �׳� ������ �������� ����Ѵ�..
--  �������� ����� ���������� ó����
			if C_LAST_DEGREE <> '81' AND C_LAST_DEGREE > '49' and C_LAST_SEQ < 70  then
				select moveinto_fr_date,moveinto_to_date
				  into C_FR_DATE,C_TO_DATE
				  from h_sale_master
				 where dept_code = as_dept_code
					and sell_code = as_sell_code
					and dongho    = as_dongho
					and seq       = as_seq;
				if C_FR_DATE > as_input_date then
					select nvl((moveinto_fr_date - as_input_date) * -1,0)
					  into C_DAYS
					  from h_sale_master
					 where dept_code = as_dept_code
						and sell_code = as_sell_code
						and dongho    = as_dongho
						and seq       = as_seq;
				else
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
			end if;*/
	-- �������뿩�θ� üũ�Ѵ�.
			IF C_DAYS > 0 THEN -- ��ü���� ���
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
			IF C_DAYS < 0 THEN -- ���η��� ���
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
	-- �ⳳ�Աݾ״��踦 ���Ѵ�.
			SELECT NVL(SUM(r_amt),0),NVL(SUM(r_land_amt),0),NVL(SUM(r_build_amt),0),NVL(SUM(r_vat_amt),0)
			  INTO C_R_AMT,C_R_LAND_AMT,C_R_BUILD_AMT,C_R_VAT_AMT
			  FROM H_SALE_INCOME
			 WHERE dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = C_LAST_DEGREE;
	-- ����� �����ݾ��� ���Ѵ�(���ݾ�).    -- ���α������ �߰��� ��� ������(2004.07.02 �̾���)
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
	-- �ϼ��� 0�ϰ�� �ٷ� �Ա�ó��, +�ϰ�� ��ü��, -�ϰ�� ���ηḦ ����Ѵ�.
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
-- ���� ������ �ִ°�쿡 loop ����
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
						-- ���Դ��ݾװ��
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
								C_TEMP_AMT := c_input_amt / C_TEMP_RATE; -- ���Դ��ݾ�
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
						IF C_R_REMAIND_YN = 'Y' THEN  -- ���η���
							C_DISCOUNT_DAY   := C_DAYS * -1;
							C_TEMP_RATE := 0;
							-- ���Դ��ݾװ��
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
								C_TEMP_AMT := c_input_amt / C_TEMP_RATE; -- ���Դ��ݾ�
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
	-- ���Աݾ��� ������ ����,�ǹ�,�ΰ����� ���Ѵ�.
			IF C_WORK_AMT = C_TEMP_AMT THEN
				C_C_LAND_AMT  := C_LAND_AMT - C_R_LAND_AMT;
				C_C_BUILD_AMT := C_BUILD_AMT - C_R_BUILD_AMT;
				C_C_VAT_AMT   := C_VAT_AMT - C_R_VAT_AMT;
			ELSE
				IF C_SELL_AMT <> 0 THEN
					C_C_LAND_AMT  := TRUNC(C_LAND_AMT / C_SELL_AMT * C_TEMP_AMT,0);
					C_C_BUILD_AMT := TRUNC(C_BUILD_AMT / C_SELL_AMT * C_TEMP_AMT,0);
					C_C_VAT_AMT   := TRUNC(C_VAT_AMT / C_SELL_AMT * C_TEMP_AMT,0);
					IF C_C_LAND_AMT + C_C_BUILD_AMT + C_C_VAT_AMT > 0 THEN
						IF C_C_LAND_AMT + C_C_BUILD_AMT + C_C_VAT_AMT <> C_SELL_AMT THEN
					      C_C_LAND_AMT  := C_TEMP_AMT - (C_C_BUILD_AMT + C_C_VAT_AMT); --��Ǻ� �հ�� ������ ���߱� ���ؼ�
                  END IF;
					END IF;

				ELSE
					C_C_LAND_AMT  := 0;
					C_C_BUILD_AMT := 0;
					C_C_VAT_AMT   := 0;
				END IF;
			END IF;
	-----------------------------------------------------------------------------
	-- ���� ���� �о�_���뺰���Աݿ� �־��ش�.
			INSERT INTO H_SALE_INCOME
				VALUES ( as_dept_code,as_sell_code,as_dongho,as_seq,C_LAST_DEGREE,C_LAST_SEQ,as_input_date,
							as_input_class,as_input_deposit,C_TEMP_AMT,C_C_LAND_AMT,C_C_BUILD_AMT,C_C_VAT_AMT,
							C_DELAY_DAY,C_DELAY_AMT,C_DISCOUNT_DAY,C_DISCOUNT_AMT,as_user,SYSDATE,NULL,0,NULL,0,'N',
							as_receipt_class_code, as_receipt_number, as_card_app_num, as_card_bank_code ,as_daily_seq,
							C_DELAY_AMT,C_DISCOUNT_AMT, NULL, as_v_account_no )  ;
	-- �ⳳ�Աݾ״��踦 ���Ѵ�.
			SELECT NVL(SUM(r_amt),0)
			  INTO C_R_AMT
			  FROM H_SALE_INCOME
			 WHERE dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = C_LAST_DEGREE;
	-- �ԱݿϷᱸ�а��� ���Ѵ�.
			IF C_SELL_AMT <= C_R_AMT THEN
				C_PAY_YN := 'Y';
			ELSE
				C_PAY_YN := 'N';
			END IF;
-- ���α���� ������ ó�� �ϹǷ� ��� ����(2004.07.02 �̾���)
--			if C_FUND_AMT > 0 THEN
--				C_FUND_AMT := C_FUND_AMT + C_R_AMT;
--				if C_SELL_AMT <= C_FUND_AMT THEN
--					C_PAY_YN := 'Y';
--				end if;
--			end if;
	-- �������׿� �ԱݿϷᱸ�а��� �Ա��հ谪�� �־��ش�.
			UPDATE H_SALE_AGREE
				SET F_PAY_YN = C_PAY_YN,
					 TOT_AMT = C_R_AMT
			 WHERE dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = C_LAST_DEGREE;
	-- ���Աݾ��� 0�̸� �����Ѵ�.
         IF c_input_amt = 0 THEN
            EXIT;
         END IF;
	-- ���Աݾ��� 0�� �ƴϸ� ���������� ���Ͽ� �������ݾ�ó���� �Ѵ�.  &&&&
			IF C_LAST_DEGREE >= C_MAX_DEGREE THEN
				C_LAST_DEGREE := C_MAX_DEGREE;
				SELECT NVL(MAX(degree_seq),0)
				  INTO C_LAST_SEQ
				  FROM H_SALE_INCOME
				 WHERE dept_code   = as_dept_code
					AND sell_code   = as_sell_code
					AND dongho      = as_dongho
					AND seq         = as_seq
					AND degree_code = C_LAST_DEGREE;
				SELECT f_pay_yn
				  INTO C_PAY_YN
				  FROM H_SALE_AGREE
				 WHERE dept_code = as_dept_code
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
				  FROM H_SALE_AGREE
				 WHERE dept_code = as_dept_code
					AND sell_code = as_sell_code
					AND dongho    = as_dongho
					AND seq       = as_seq
					AND degree_code > C_LAST_DEGREE;
				IF C_CNT > 0 THEN
					SELECT MIN(degree_code)
					  INTO C_LAST_DEGREE
					  FROM H_SALE_AGREE
					 WHERE dept_code = as_dept_code
						AND sell_code = as_sell_code
						AND dongho    = as_dongho
						AND seq       = as_seq
						AND degree_code > C_LAST_DEGREE;
					SELECT NVL(MAX(degree_seq),0)
					  INTO C_LAST_SEQ
					  FROM H_SALE_INCOME
					 WHERE dept_code   = as_dept_code
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
   -- ENDING...[0.1] CURSOR CLOSE �� Ȯ�� ó�� !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- ����� ���� Error Message
      Wk_errflag := 0;                         -- ����� ���� Error Code
   ELSE
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;
EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END Y_Sp_H_Income_Calc;

PROCEDURE y_sp_h_income_cmpt(as_dept_code              IN   VARCHAR2,
															  as_sell_code              IN   VARCHAR2,
															  as_dongho                 IN   VARCHAR2,
															  as_seq                    IN   INTEGER,
                                               as_input_date             IN   DATE,
                                               as_input_amt              IN   NUMBER,
															  as_input_class            IN   VARCHAR2,
															  as_input_deposit          IN   VARCHAR2,
															  as_user                   IN   VARCHAR2,
															  as_receipt_class_code     IN   VARCHAR2,
															  as_receipt_number         IN   VARCHAR2,
															  as_card_app_num           IN   VARCHAR2,
															  as_card_bank_code         IN   VARCHAR2,
                                               as_v_account_no           IN   VARCHAR2,
                                               as_fb_seq                 IN   NUMBER) IS
----------------------------�����ڷ�����
CURSOR DAILY_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ, AMT, RECEIPT_CODE, DEPOSIT_NO,
       RECEIPT_CLASS_CODE, CARD_APP_NUM, RECEIPT_NUMBER,CARD_BANK_CODE, 
       V_ACCOUNT_NO, fb_seq, loan_interest_tag, loan_rdm_yn, loan_degree_code
  FROM H_SALE_INCOME_DAILY
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND receipt_date > as_input_date
ORDER BY receipt_date, daily_seq;

-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ����
   C_RECEIPT_DATE      H_SALE_INCOME_DAILY.RECEIPT_DATE%TYPE;
	C_DAILY_SEQ         H_SALE_INCOME_DAILY.DAILY_SEQ%TYPE;
	C_AMT                H_SALE_INCOME_DAILY.AMT%TYPE;
	C_RECEIPT_CODE       H_SALE_INCOME_DAILY.RECEIPT_CODE%TYPE;
	C_DEPOSIT_NO         H_SALE_INCOME_DAILY.DEPOSIT_NO%TYPE;
	C_RECEIPT_CLASS_CODE H_SALE_INCOME_DAILY.RECEIPT_CLASS_CODE%TYPE;
	C_CARD_APP_NUM       H_SALE_INCOME_DAILY.CARD_APP_NUM%TYPE;
	C_RECEIPT_NUMBER     H_SALE_INCOME_DAILY.RECEIPT_NUMBER%TYPE;
	C_CARD_BANK_CODE     H_SALE_INCOME_DAILY.CARD_BANK_CODE%TYPE;
   C_V_ACCOUNT_NO       H_SALE_INCOME_DAILY.V_ACCOUNT_NO%TYPE;
   C_fb_seq             H_SALE_INCOME_DAILY.fb_seq%TYPE;
   C_loan_interest_tag  H_SALE_INCOME_DAILY.loan_interest_tag%TYPE;
   C_loan_rdm_yn        H_SALE_INCOME_DAILY.loan_rdm_yn%TYPE;
   c_loan_degree_code   H_SALE_INCOME_DAILY.loan_degree_code%TYPE;

   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN
	IF as_input_amt = 0 THEN
	   RETURN;
	END IF;
	OPEN DAILY_CUR;

	SELECT MIN(RECEIPT_DATE), MIN(DAILY_SEQ)
	  INTO C_RECEIPT_DATE, C_DAILY_SEQ
	  FROM H_SALE_INCOME_DAILY
	 WHERE dept_code  = as_dept_code
		AND sell_code  = as_sell_code
		AND dongho     = as_dongho
		AND seq        = as_seq
		AND receipt_date > as_input_date;

	IF C_RECEIPT_DATE > '1900.01.01' AND C_DAILY_SEQ > 0 THEN
	   --------------------------------�����ڷ����
		H_Calc_Income.y_sp_h_delete_daily_income(as_dept_code, as_sell_code, as_dongho, as_seq,
										C_RECEIPT_DATE, C_DAILY_SEQ, 0);
	END IF;

	SELECT NVL(MAX(daily_seq), 0) + 1
	  INTO C_DAILY_SEQ
	  FROM H_SALE_INCOME_DAILY
	 WHERE dept_code     = as_dept_code
		AND sell_code     = as_sell_code
		AND dongho        = as_dongho
		AND seq           = as_seq
		AND receipt_date  = as_input_date;
	INSERT INTO H_SALE_INCOME_DAILY   --���ں� ���Ա� ���̺� INSERT�Ѵ�
        VALUES (as_dept_code, as_sell_code, as_dongho, as_seq, as_input_date, C_DAILY_SEQ, as_input_amt,
		        as_input_class,as_input_deposit,as_receipt_class_code, as_receipt_number, as_card_app_num,
				  as_card_bank_code, NULL, as_v_account_no, as_fb_seq, NULL, 'N', NULL );

	-----------------------------------���ڷ��Ա�ó��
	H_Calc_Income.Y_Sp_H_Income_Calc(as_dept_code,as_sell_code,as_dongho ,as_seq ,as_input_date,C_DAILY_SEQ,
                      as_input_amt,as_input_class,as_input_deposit,as_user,as_receipt_class_code,
							 as_receipt_number,as_card_app_num,as_card_bank_code, as_v_account_no);

	LOOP
		FETCH DAILY_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ, C_AMT, C_RECEIPT_CODE,C_DEPOSIT_NO,
	                               C_RECEIPT_CLASS_CODE, C_CARD_APP_NUM, C_RECEIPT_NUMBER,C_CARD_BANK_CODE, 
                                  C_V_ACCOUNT_NO, c_fb_seq, c_loan_interest_tag, c_loan_rdm_yn, c_loan_degree_code;
		EXIT WHEN DAILY_CUR%NOTFOUND;

		-----------------------------------�����ڷ� ���Ա�
	   H_Calc_Income.y_sp_h_income_cmpt(as_dept_code, as_sell_code, as_dongho, as_seq, C_RECEIPT_DATE, C_AMT,C_RECEIPT_CODE,
								 C_DEPOSIT_NO, '����',C_RECEIPT_CLASS_CODE,C_RECEIPT_NUMBER,C_CARD_APP_NUM,C_CARD_BANK_CODE, 
                         C_V_ACCOUNT_NO, as_fb_seq);
	END LOOP;


	CLOSE DAILY_CUR;

	END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   -- ENDING...[0.1] CURSOR CLOSE �� Ȯ�� ó�� !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- ����� ���� Error Message
      Wk_errflag := 0;                         -- ����� ���� Error Code
   ELSE
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;
EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END y_sp_h_income_cmpt;

PROCEDURE y_sp_h_delete_daily_income(as_dept_code    IN   VARCHAR2,
	                                                    as_sell_code    IN   VARCHAR2,
	                                                    as_dongho       IN   VARCHAR2,
	                                                    as_seq          IN   INTEGER,
																		 as_receipt_date IN   DATE,
																		 as_daily_seq    IN   INTEGER,
																		 as_recalc_tag   IN   INTEGER) IS

--as_recalc_tag  1  *�����Ϸ��� ���� ����, *�������� ����, *���������� ���ؼ� ����
--as_recalc_tag  0  *�����Ϸ��� ���� ����, *�������� ����  (���� ����)

--������ ���� �����ؼ� ���Ŀ� ���ؼ� �����Ѵ�. ������
CURSOR DAILY_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ
  FROM H_SALE_INCOME_DAILY
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND (    receipt_date > as_receipt_date
	     OR  (receipt_date = as_receipt_date AND
		       daily_seq    >= as_daily_seq)
		 )
ORDER BY receipt_date, daily_seq;
--������ ���� ���Ŀ� ���ؼ� �����Ѵ�. ���Ա� ó����(����)
CURSOR DAILY_RECALC_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ, AMT, RECEIPT_CODE, DEPOSIT_NO,
       RECEIPT_CLASS_CODE, CARD_APP_NUM, RECEIPT_NUMBER,CARD_BANK_CODE, 
       V_ACCOUNT_NO, fb_seq, loan_interest_tag, loan_rdm_yn, loan_degree_code
  FROM H_SALE_INCOME_DAILY
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
-- ��������
-------------------------------------------------------------
C_RECEIPT_DATE       H_SALE_INCOME_DAILY.RECEIPT_DATE%TYPE;
C_DAILY_SEQ          H_SALE_INCOME_DAILY.DAILY_SEQ%TYPE;
C_AMT                H_SALE_INCOME_DAILY.AMT%TYPE;
C_RECEIPT_CODE       H_SALE_INCOME_DAILY.RECEIPT_CODE%TYPE;
C_DEPOSIT_NO         H_SALE_INCOME_DAILY.DEPOSIT_NO%TYPE;
C_RECEIPT_CLASS_CODE H_SALE_INCOME_DAILY.RECEIPT_CLASS_CODE%TYPE;
C_CARD_APP_NUM       H_SALE_INCOME_DAILY.CARD_APP_NUM%TYPE;
C_RECEIPT_NUMBER     H_SALE_INCOME_DAILY.RECEIPT_NUMBER%TYPE;
C_CARD_BANK_CODE     H_SALE_INCOME_DAILY.CARD_BANK_CODE%TYPE;
C_V_ACCOUNT_NO       H_SALE_INCOME_DAILY.V_ACCOUNT_NO%TYPE;
C_fb_seq             H_SALE_INCOME_DAILY.fb_seq%TYPE;
C_loan_interest_tag  H_SALE_INCOME_DAILY.loan_interest_tag%TYPE;
C_loan_rdm_yn        H_SALE_INCOME_DAILY.loan_rdm_yn%TYPE;
c_loan_degree_code   H_SALE_INCOME_DAILY.loan_degree_code%TYPE;
-- ���� ����
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
		OPEN	DAILY_RECALC_CUR; --�����ϱ� ���ؼ� ���� �ϱ����� �����´�
-----------------------------------------����ó��
		LOOP
			FETCH DAILY_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ ;
			EXIT WHEN DAILY_CUR%NOTFOUND;

			UPDATE H_SALE_AGREE
			  SET (tot_amt,f_pay_yn)=
				   (SELECT agree.tot_amt - in_sum.amt,
				           CASE WHEN agree.tot_amt - in_sum.amt = agree.sell_amt
				                THEN 'Y'
								 	 ELSE 'N'
							  END CASE
					   FROM H_SALE_AGREE agree,
					       (SELECT income.degree_code,
					               SUM(NVL(income.r_amt, 0)) amt
					          FROM H_SALE_INCOME income
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
						 AND H_SALE_AGREE.degree_code = in_sum.degree_code)
			WHERE H_SALE_AGREE.dept_code = as_dept_code
			  AND H_SALE_AGREE.sell_code = as_sell_code
			  AND H_SALE_AGREE.dongho    = as_dongho
			  AND H_SALE_AGREE.seq       = as_seq
			  AND H_SALE_AGREE.degree_code IN (SELECT income.degree_code
												          FROM H_SALE_INCOME income
														   WHERE income.dept_code = as_dept_code
														     AND income.sell_code = as_sell_code
															  AND income.dongho    = as_dongho
															  AND income.seq       = as_seq
															  AND income.receipt_date = C_RECEIPT_DATE
								                       AND income.daily_seq    = C_DAILY_SEQ);


	     DELETE FROM H_SALE_INCOME income
		   WHERE income.dept_code = as_dept_code
		     AND income.sell_code = as_sell_code
			  AND income.dongho    = as_dongho
			  AND income.seq       = as_seq
			  AND income.receipt_date = C_RECEIPT_DATE
	        AND income.daily_seq    = C_DAILY_SEQ;
		  DELETE FROM H_SALE_INCOME_DAILY daily
		   WHERE daily.dept_code = as_dept_code
		     AND daily.sell_code = as_sell_code
			  AND daily.dongho    = as_dongho
			  AND daily.seq       = as_seq
			  AND daily.receipt_date = C_RECEIPT_DATE
	        AND daily.daily_seq    = C_DAILY_SEQ;

      END LOOP;
		CLOSE DAILY_CUR;

-----------------------------------------����ó��
      IF as_recalc_tag = 1 THEN
			LOOP
				FETCH DAILY_RECALC_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ, C_AMT, C_RECEIPT_CODE,C_DEPOSIT_NO,
	                               C_RECEIPT_CLASS_CODE, C_CARD_APP_NUM, C_RECEIPT_NUMBER,C_CARD_BANK_CODE, 
                                  C_V_ACCOUNT_NO, c_fb_seq, c_loan_interest_tag, c_loan_rdm_yn, c_loan_degree_code ;
				EXIT WHEN DAILY_RECALC_CUR%NOTFOUND;



			   H_Calc_Income.y_sp_h_income_cmpt(as_dept_code, as_sell_code, as_dongho, as_seq, C_RECEIPT_DATE, C_AMT,C_RECEIPT_CODE,
				 					 C_DEPOSIT_NO, '����',C_RECEIPT_CLASS_CODE,C_RECEIPT_NUMBER,C_CARD_APP_NUM,C_CARD_BANK_CODE, 
                            C_V_ACCOUNT_NO, c_fb_seq);
			END LOOP;
		END IF;

		CLOSE DAILY_RECALC_CUR;

	 EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���ں����Ա� ������ ���� ����! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
 END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   -- ENDING...[0.1] CURSOR CLOSE �� Ȯ�� ó�� !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- ����� ���� Error Message
      Wk_errflag := 0;                         -- ����� ���� Error Code
   ELSE
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;
EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END y_sp_h_delete_daily_income;

PROCEDURE y_sp_h_delay_recalc(as_dept_code    IN   VARCHAR2,
                                                as_sell_code    IN   VARCHAR2,
                                                as_dongho       IN   VARCHAR2,
                                                as_seq          IN   INTEGER,
																as_degree_code  IN   VARCHAR2,
																as_degree_seq   IN   INTEGER,
																as_receipt_date IN   DATE,
																as_daily_seq    IN   INTEGER,
																as_delay_amt    IN   NUMBER,
																as_discount_amt IN   NUMBER) IS



--������Ʈ�ϴ� ���� ���Ŀ� ���ؼ� �����Ѵ�.
CURSOR DAILY_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ, AMT, RECEIPT_CODE, DEPOSIT_NO,
       RECEIPT_CLASS_CODE, CARD_APP_NUM, RECEIPT_NUMBER,CARD_BANK_CODE, 
       V_ACCOUNT_NO, fb_seq, loan_interest_tag, loan_rdm_yn, loan_degree_code
  FROM H_SALE_INCOME_DAILY
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND ((receipt_date > as_receipt_date) OR
		  (receipt_date = as_receipt_date AND daily_seq > as_daily_seq))
ORDER BY receipt_date, daily_seq;
-------------------------------------------------------------
-- ��������
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
C_AGREE_AMT          NUMBER(13);
C_DEGREE_SUM_AMT     NUMBER(13);
C_R_AMT_OVER         NUMBER(13);
--��Ǻΰ���
C_R_R_AMT            NUMBER(13);
C_SELL_AMT           NUMBER(13);
C_LAND_AMT           NUMBER(13);
C_BUILD_AMT          NUMBER(13);
C_VAT_AMT            NUMBER(13);
C_R_LAND_AMT         NUMBER(13);
C_R_BUILD_AMT        NUMBER(13);
C_R_VAT_AMT          NUMBER(13);
--
C_RECEIPT_DATE       H_SALE_INCOME_DAILY.RECEIPT_DATE%TYPE;
C_DAILY_SEQ          H_SALE_INCOME_DAILY.DAILY_SEQ%TYPE;
C_AMT                H_SALE_INCOME_DAILY.AMT%TYPE;
C_RECEIPT_CODE       H_SALE_INCOME_DAILY.RECEIPT_CODE%TYPE;
C_DEPOSIT_NO         H_SALE_INCOME_DAILY.DEPOSIT_NO%TYPE;
C_RECEIPT_CLASS_CODE H_SALE_INCOME_DAILY.RECEIPT_CLASS_CODE%TYPE;
C_CARD_APP_NUM       H_SALE_INCOME_DAILY.CARD_APP_NUM%TYPE;
C_RECEIPT_NUMBER     H_SALE_INCOME_DAILY.RECEIPT_NUMBER%TYPE;
C_CARD_BANK_CODE     H_SALE_INCOME_DAILY.CARD_BANK_CODE%TYPE;
C_V_ACCOUNT_NO       H_SALE_INCOME_DAILY.V_ACCOUNT_NO%TYPE;
C_fb_seq             H_SALE_INCOME_DAILY.fb_seq%TYPE;
C_loan_interest_tag  H_SALE_INCOME_DAILY.loan_interest_tag%TYPE;
C_loan_rdm_yn        H_SALE_INCOME_DAILY.loan_rdm_yn%TYPE;
c_loan_degree_code   H_SALE_INCOME_DAILY.loan_degree_code%TYPE;
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
	err_num             INTEGER;
   e_msg               VARCHAR2(100);
-- User Define Error
   C_CNT                NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	BEGIN

		SELECT r_amt, delay_amt, discount_amt
		  INTO C_R_AMT, C_ORG_DELAY_AMT, C_ORG_DISCOUNT_AMT
		  FROM H_SALE_INCOME income
		 WHERE income.dept_code = as_dept_code
	      AND income.sell_code = as_sell_code
		   AND income.dongho    = as_dongho
		   AND income.seq       = as_seq
		   AND income.degree_code = as_degree_code
		   AND income.degree_seq  = as_degree_seq;

		C_DELAY_OFFSET    := as_delay_amt    - C_ORG_DELAY_AMT;
		C_DISCOUNT_OFFSET := as_discount_amt - C_ORG_DISCOUNT_AMT;
		C_TOTAL_OFFSET    := C_DELAY_OFFSET - C_DISCOUNT_OFFSET;

		IF C_TOTAL_OFFSET = 0 THEN --�̰� 0 �̸� �Ի����ʿ䰡 ����.��ü��/���ηḸ ������Ʈ�ϰ� ��
		   err_num := 100;
		   UPDATE H_SALE_INCOME
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
		  FROM H_SALE_INCOME income
		 WHERE income.dept_code = as_dept_code
	      AND income.sell_code = as_sell_code
		   AND income.dongho    = as_dongho
		   AND income.seq       = as_seq
		   AND income.receipt_date = as_receipt_date
		   AND income.daily_seq    = as_daily_seq
			AND ((income.degree_code > as_degree_code) OR
			     (income.degree_code = as_degree_code AND income.degree_seq > as_degree_seq));

      IF C_WORK_AMT > 0  THEN
			IF C_WORK_AMT < C_TOTAL_OFFSET THEN --���������Ŀ� �ɰ��� �Աݾ��� ������...���ݼ���..��Ǻμ���
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
				C_R_AMT := C_R_AMT + 0; -- (C_DISCOUNT_OFFSET*2);
			ELSE
			   C_R_AMT := C_R_AMT - C_DISCOUNT_OFFSET;
			END IF;
			R_AMT_CHG_TAG := 'Y';
		END IF;

		IF R_AMT_CHG_TAG = 'Y' THEN
		   SELECT SUM(NVL(R_AMT+DELAY_AMT-DISCOUNT_AMT,0))
			  INTO C_DEGREE_SUM_AMT
			  FROM H_SALE_INCOME
			 WHERE dept_code = as_dept_code
		      AND sell_code = as_sell_code
			   AND dongho    = as_dongho
				AND seq       = as_seq
			   AND degree_code = as_degree_code
				AND (degree_seq  < as_degree_seq OR degree_seq = as_degree_seq) ;
			 
			SELECT sell_amt
			  INTO C_AGREE_AMT
			  FROM H_SALE_AGREE
			 WHERE dept_code = as_dept_code
		      AND sell_code = as_sell_code
			   AND dongho       = as_dongho
			   AND seq    = as_seq
			   AND degree_code = as_degree_code;
			
			IF C_DEGREE_SUM_AMT > C_AGREE_AMT THEN  --�ش� ������ ������ ���Ա��� �����ݾ׺���ū��� 
				C_R_AMT := C_R_AMT - (C_DEGREE_SUM_AMT - C_AGREE_AMT);
				C_R_AMT_OVER := C_DEGREE_SUM_AMT - C_AGREE_AMT; --�ʰ��ݾ׿� ���ؼ� ����ó�� 
			END IF;
			 
			--��Ǻΰ���ƾ
			SELECT NVL(sell_amt,0),NVL(land_amt,0),NVL(build_amt,0),NVL(vat_amt,0)
			  INTO C_SELL_AMT, C_LAND_AMT,C_BUILD_AMT,C_VAT_AMT
			  FROM H_SALE_AGREE
			 WHERE dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = as_degree_code;

			SELECT NVL(SUM(r_amt),0),NVL(SUM(r_land_amt),0),NVL(SUM(r_build_amt),0),NVL(SUM(r_vat_amt),0)
			  INTO C_R_R_AMT,C_R_LAND_AMT,C_R_BUILD_AMT,C_R_VAT_AMT
			  FROM H_SALE_INCOME
			 WHERE dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = as_degree_code
				AND degree_seq < as_degRee_seq;

			IF (C_R_AMT + C_R_R_AMT) = C_SELL_AMT THEN
				C_LAND_AMT  := C_LAND_AMT - C_R_LAND_AMT;
				C_BUILD_AMT := C_BUILD_AMT - C_R_BUILD_AMT;
				C_VAT_AMT   := C_VAT_AMT - C_R_VAT_AMT;
			ELSE
			   IF C_SELL_AMT <> 0 THEN
					C_LAND_AMT  := TRUNC(C_LAND_AMT / C_SELL_AMT * C_R_AMT,0);
					C_BUILD_AMT := TRUNC(C_BUILD_AMT / C_SELL_AMT * C_R_AMT,0);
					C_VAT_AMT   := TRUNC(C_VAT_AMT / C_SELL_AMT * C_R_AMT,0);
					IF C_LAND_AMT + C_BUILD_AMT + C_VAT_AMT > 0 THEN
					   IF C_SELL_AMT <> C_LAND_AMT + C_BUILD_AMT + C_VAT_AMT THEN
					      C_LAND_AMT  := C_R_AMT - (C_BUILD_AMT+C_VAT_AMT);--��Ǻ� �հ�� ������ ���߱� ���ؼ�
						END IF;
					END IF;
				ELSE
					C_LAND_AMT  := 0;
					C_BUILD_AMT := 0;
					C_VAT_AMT   := 0;
				END IF;
			END IF;
			--������ ��Ǻ�
         err_num := 200;
			UPDATE H_SALE_INCOME
			   SET r_amt        = C_R_AMT,
				    delay_amt    = as_delay_amt,
					 discount_amt = as_discount_amt,
					 r_land_amt   = C_LAND_AMT,
					 r_build_amt  = C_BUILD_AMT,
					 r_vat_amt    = C_VAT_AMT,
					 modi_yn      = 'Y'
			 WHERE dept_code = as_dept_code
		      AND sell_code = as_sell_code
			   AND dongho    = as_dongho
			   AND seq       = as_seq
			   AND degree_code = as_degree_code
			   AND degree_seq  = as_degree_seq;
			--IF C_R_AMT_OVER > 0 THEN
			--   h_calc_income.y_sp_h_income_calc(as_dept_code,as_sell_code,as_dongho ,as_seq ,as_receipt_date,as_daily_seq,
         --             C_R_AMT_OVER, C_RECEIPT_CODE,C_DEPOSIT_NO,'����1',C_RECEIPT_CLASS_CODE,
			--				 C_RECEIPT_NUMBER,C_CARD_APP_NUM,C_CARD_BANK_CODE);
			--END IF;

		ELSE --���� �� �������� ��ü��� ���η� ������Ʈ
		   err_num := 300;
		   UPDATE H_SALE_INCOME
			   SET delay_amt    = as_delay_amt,
					 discount_amt = as_discount_amt,
					 modi_yn      = 'Y'
			 WHERE dept_code = as_dept_code
		      AND sell_code = as_sell_code
			   AND dongho    = as_dongho
			   AND seq       = as_seq
			   AND degree_code = as_degree_code
			   AND degree_seq  = as_degree_seq;

		END IF;
      err_num := 400;
		DELETE H_SALE_INCOME income
		 WHERE income.dept_code = as_dept_code
	      AND income.sell_code = as_sell_code
		   AND income.dongho    = as_dongho
		   AND income.seq       = as_seq
		   --and income.receipt_date = as_receipt_date
		   --and income.daily_seq    = as_daily_seq
			AND ((income.degree_code > as_degree_code) OR
			     (income.degree_code = as_degree_code AND income.degree_seq > as_degree_seq));
		err_num := 500;
		--���� �ϳ����� ������Ʈ
		UPDATE H_SALE_AGREE
		  SET (tot_amt,f_pay_yn)=
			   (SELECT in_sum.amt,
			           CASE WHEN in_sum.amt = agree.sell_amt
			                THEN 'Y'
							 	 ELSE 'N'
						  END CASE
				   FROM H_SALE_AGREE agree,
				       (SELECT income.degree_code,
				               SUM(NVL(income.r_amt, 0)) amt
				          FROM H_SALE_INCOME income
						   WHERE income.dept_code = as_dept_code
						     AND income.sell_code = as_sell_code
							  AND income.dongho    = as_dongho
							  AND income.seq       = as_seq
							  --and income.degree_code = as_degree_code
						  GROUP BY income.degree_code) in_sum

				  WHERE agree.dept_code = as_dept_code
				    AND agree.sell_code = as_sell_code
				    AND agree.dongho    = as_dongho
				    AND agree.seq       = as_seq
				    AND agree.degree_code = in_sum.degree_code(+)
					 AND H_SALE_AGREE.degree_code = agree.degree_code)
		WHERE H_SALE_AGREE.dept_code = as_dept_code
		  AND H_SALE_AGREE.sell_code = as_sell_code
		  AND H_SALE_AGREE.dongho    = as_dongho
		  AND H_SALE_AGREE.seq       = as_seq
		  AND H_SALE_AGREE.degree_code >= as_degree_code;
		  
		IF C_R_AMT_OVER > 0 THEN
			   H_Calc_Income.Y_Sp_H_Income_Calc(as_dept_code,as_sell_code,as_dongho ,as_seq ,as_receipt_date,as_daily_seq,
                      C_R_AMT_OVER, C_RECEIPT_CODE,C_DEPOSIT_NO,'����1',C_RECEIPT_CLASS_CODE,
							 C_RECEIPT_NUMBER,C_CARD_APP_NUM,C_CARD_BANK_CODE,C_V_ACCOUNT_NO);
	   END IF;

		SELECT amt, receipt_code, deposit_no, receipt_class_code, card_app_num, receipt_number, card_bank_code, V_ACCOUNT_NO
		  INTO C_DAILY_AMT, C_RECEIPT_CODE, C_DEPOSIT_NO, C_RECEIPT_CLASS_CODE,	 C_CARD_APP_NUM,
				 C_RECEIPT_NUMBER, C_CARD_BANK_CODE, C_V_ACCOUNT_NO
		  FROM H_SALE_INCOME_DAILY daily
		 WHERE daily.dept_code = as_dept_code
	      AND daily.sell_code = as_sell_code
		   AND daily.dongho    = as_dongho
		   AND daily.seq       = as_seq
		   AND daily.receipt_date = as_receipt_date
		   AND daily.daily_seq    = as_daily_seq;

		SELECT NVL(SUM(NVL(income.r_amt, 0) + NVL(income.delay_amt, 0) - NVL(income.discount_amt, 0)), 0)
		  INTO C_INCOME_AMT
		  FROM H_SALE_INCOME income
		 WHERE income.dept_code = as_dept_code
	      AND income.sell_code = as_sell_code
		   AND income.dongho    = as_dongho
		   AND income.seq       = as_seq
		   AND income.receipt_date = as_receipt_date
		   AND income.daily_seq    = as_daily_seq;



		IF C_DAILY_AMT > C_INCOME_AMT  THEN
		   err_num := C_DAILY_AMT - C_INCOME_AMT;
			H_Calc_Income.Y_Sp_H_Income_Calc(as_dept_code,as_sell_code,as_dongho ,as_seq ,as_receipt_date,as_daily_seq,
                      C_DAILY_AMT - C_INCOME_AMT, C_RECEIPT_CODE,C_DEPOSIT_NO,'����1',C_RECEIPT_CLASS_CODE,
							 C_RECEIPT_NUMBER,C_CARD_APP_NUM,C_CARD_BANK_CODE, C_V_ACCOUNT_NO);

		END IF;

		--DIALY ���� ���� �Աݺп� ���ؼ� ���Ա� ó��

		SELECT MIN(TO_CHAR(RECEIPT_DATE,'yyyymmdd')||TO_CHAR(DAILY_SEQ,'0000'))
		  INTO C_TEMP_STR
		  FROM H_SALE_INCOME_DAILY
		 WHERE dept_code  = as_dept_code
			AND sell_code  = as_sell_code
			AND dongho     = as_dongho
			AND seq        = as_seq
			AND ((receipt_date > as_receipt_date) OR
			     (receipt_date = as_receipt_date AND daily_seq > as_daily_seq));
		C_RECEIPT_DATE:= TO_DATE(SUBSTR(C_TEMP_STR,1,8));
		C_DAILY_SEQ   := TO_NUMBER(SUBSTR(C_TEMP_STR,10,4));

		IF C_RECEIPT_DATE > '1900.01.01' AND C_DAILY_SEQ > 0 THEN

		   OPEN DAILY_CUR;  --�����ϱ��� ����
		   --------------------------------�����ڷ����
			err_num := 800;

			H_Calc_Income.y_sp_h_delete_daily_income(as_dept_code, as_sell_code, as_dongho, as_seq,
												C_RECEIPT_DATE, C_DAILY_SEQ, 0);
			LOOP
				FETCH DAILY_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ, C_AMT, C_RECEIPT_CODE,C_DEPOSIT_NO,
			                               C_RECEIPT_CLASS_CODE, C_CARD_APP_NUM, C_RECEIPT_NUMBER,C_CARD_BANK_CODE, 
                                        C_V_ACCOUNT_NO, c_fb_seq, c_loan_interest_tag, c_loan_rdm_yn, c_loan_degree_code ;
				EXIT WHEN DAILY_CUR%NOTFOUND;

				-----------------------------------�����ڷ� ���Ա�
				IF C_AMT <> 0 THEN
				   err_num := 900;
				   H_Calc_Income.y_sp_h_income_cmpt(as_dept_code, as_sell_code, as_dongho, as_seq, C_RECEIPT_DATE, C_AMT,C_RECEIPT_CODE,
										 C_DEPOSIT_NO, '����2',C_RECEIPT_CLASS_CODE,C_RECEIPT_NUMBER,C_CARD_APP_NUM,C_CARD_BANK_CODE, 
                               C_V_ACCOUNT_NO, c_fb_seq);
				END IF;
			END LOOP;
			CLOSE DAILY_CUR;
		END IF;

	 EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '��ü��/���ηắ�� �� ���� ����! [Line No: '||err_num||']';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
 END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   -- ENDING...[0.1] CURSOR CLOSE �� Ȯ�� ó�� !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- ����� ���� Error Message
      Wk_errflag := 0;                         -- ����� ���� Error Code
   ELSE
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;
EXCEPTION
  --WHEN UserErr       THEN
  --     RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
  WHEN OTHERS THEN
  RAISE;
END y_sp_h_delay_recalc;



END;
/

