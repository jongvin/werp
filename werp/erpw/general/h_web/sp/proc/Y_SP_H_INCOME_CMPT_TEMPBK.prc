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
		c_input_amt := 90000000000;
-- ������ �������� �� ȸ���� ���Ѵ�.
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
			-- �ش� ���ڱ��� �̳��ݾ��� ���� ���� ��� ������.
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
-- LOOP ����
		LOOP
	-- �ϼ� �� �����ݾ��� ���Ѵ�
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
-- ���α���� ���������� ��ü�� �����(2004.07.02 �̾���)
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
			  FROM H_SALE_INCOME_TEMP
			 WHERE spec_unq_num = as_spec_unq_num
				AND dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = C_LAST_DEGREE;
	-- ����� �����ݾ��� ���Ѵ�(���ݾ�).  ���α���� ���������� ó���ϹǷ� ������(2004.07.02 �̾���)
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
						IF C_R_CONT_YN = 'Y' THEN             -- &&&&&&&&&&&&&&&&&&&&&&&&
							C_DELAY_DAY   := C_DAYS;
							C_TEMP_RATE := 0;
						-- ���Դ��ݾװ��
                     
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
								C_TEMP_AMT := c_input_amt / C_TEMP_RATE; -- ���Դ��ݾ�
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
				ELSE
					C_C_LAND_AMT  := 0;
					C_C_BUILD_AMT := 0;
					C_C_VAT_AMT   := 0;
				END IF;
			END IF;
	-----------------------------------------------------------------------------
	-- ���� ���� �о�_���뺰���Աݿ� �־��ش�.
			IF C_LAST_SEQ < 70 THEN
				INSERT INTO H_SALE_INCOME_TEMP
					VALUES ( as_spec_unq_num,as_dept_code,as_sell_code,as_dongho,as_seq,C_LAST_DEGREE,C_LAST_SEQ,as_input_date,
								as_input_class,as_input_deposit,C_TEMP_AMT,C_C_LAND_AMT,C_C_BUILD_AMT,C_C_VAT_AMT,
								C_DELAY_DAY,C_DELAY_AMT,C_DISCOUNT_DAY,C_DISCOUNT_AMT,as_user,SYSDATE,NULL,0,NULL,0,'Y' )  ;
	       END IF;
	-- �ⳳ�Աݾ״��踦 ���Ѵ�.
			SELECT NVL(SUM(r_amt),0)
			  INTO C_R_AMT
			  FROM H_SALE_INCOME_TEMP
			 WHERE spec_unq_num = as_spec_unq_num
				AND dept_code = as_dept_code
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
-- ���α���� ���������� ó���ϹǷ� ������(2004.07.02 �̾���)
--			if C_FUND_AMT > 0 THEN
--				C_FUND_AMT := C_FUND_AMT + C_R_AMT;
--				if C_SELL_AMT <= C_FUND_AMT THEN
--					C_PAY_YN := 'Y';
--				end if;
--			end if;
	-- �������׿� �ԱݿϷᱸ�а��� �Ա��հ谪�� �־��ش�.
			UPDATE H_SALE_AGREE_TEMP
				SET F_PAY_YN = C_PAY_YN,
					 TOT_AMT = C_R_AMT
			 WHERE spec_unq_num = as_spec_unq_num
				AND dept_code = as_dept_code
				AND sell_code = as_sell_code
				AND dongho    = as_dongho
				AND seq       = as_seq
				AND degree_code = C_LAST_DEGREE;
	-- ���Աݾ��� 0�̸� �����Ѵ�.
         IF c_input_amt = 0 THEN
            EXIT;
         END IF;
	-- ���Աݾ��� 0�� �ƴϸ� ���������� ���Ͽ� �������ݾ�ó���� �Ѵ�.
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
END Y_Sp_H_Income_Cmpt_Tempbk;
/

