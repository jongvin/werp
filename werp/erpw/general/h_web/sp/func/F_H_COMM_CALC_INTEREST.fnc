CREATE OR REPLACE FUNCTION f_h_comm_calc_interest ( ad_agree_date IN DATE,  --계산시작일 (예:약정일(연체료)/입금일(할인료))  
                                                    ad_receipt_date IN DATE,  --계산종료일 (예:입금일(연체료)/약정일(할인료))
                                                    an_amt     IN NUMBER, --원금
                                                    as_rate_tag  IN VARCHAR2,--('연체료','할인료')
                                                    as_rate_kind IN VARCHAR2,--계산대상 구분('분양','별도','임대료','임대보증금')
                                                    as_dept_code IN VARCHAR2,
                                                    as_sell_code IN VARCHAR2,
                                                    as_dongho    IN VARCHAR2,
                                                    ai_seq       IN INTEGER
                                                    )
                                                          
      RETURN NUMBER --
    AS
    
CURSOR DETAIL_CUR (V_SDATE DATE, V_EDATE DATE, V_DAYS INTEGER, V_RATE_KIND VARCHAR2 )IS
SELECT rate,cutoff_std,cutoff_unit,s_date,e_date
  FROM H_SALE_DELAY_RATE
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = ai_seq
	AND rate_kind  = V_RATE_KIND
	AND e_date >= V_SDATE
	AND s_date <= V_EDATE
	AND MNTH = (SELECT MIN(MNTH)
					  FROM H_SALE_DELAY_RATE
					 WHERE dept_code  = as_dept_code
						AND sell_code  = as_sell_code
						AND dongho     = as_dongho
						AND seq        = ai_seq
						AND rate_kind  = V_RATE_KIND
						AND e_date >= V_SDATE
						AND s_date <= V_EDATE
						AND ADD_MONTHS(V_SDATE, MNTH) > V_EDATE);
CURSOR DETAIL_CUR1 (V_SDATE DATE, V_EDATE DATE, V_RATE_KIND VARCHAR2 )IS
SELECT rate,cutoff_std,cutoff_unit,s_date,e_date
  FROM H_SALE_DISCOUNT_RATE
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = ai_seq
	AND rate_kind  = V_RATE_KIND
	AND e_date >= V_EDATE
	AND s_date <= V_SDATE;
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
    C_DAYS         NUMBER DEFAULT 0;
    C_DELAY_DAY    NUMBER DEFAULT 0;
  	 C_DISCOUNT_DAY NUMBER DEFAULT 0;
  	 C_DELAY_AMT    NUMBER DEFAULT 0;
  	 C_DISCOUNT_AMT NUMBER DEFAULT 0;
    C_RATE_KIND    VARCHAR2(10);
    C_TEMP_RATE    NUMBER DEFAULT 0;
    C_TEMP_CNT     NUMBER DEFAULT 0;
    C_TEMP_AMT     NUMBER DEFAULT 0;
    C_COMP_UNIT    NUMBER DEFAULT 0;
    C_CNT          NUMBER DEFAULT 0;
    
    
    rec_sale_delay H_SALE_DELAY_RATE%ROWTYPE;
    rec_sale_discount H_SALE_DISCOUNT_RATE%ROWTYPE;
    rec_lease_delay H_LEASE_DELAY_RATE%ROWTYPE;
    rec_lease_discount H_LEASE_DISCOUNT_RATE%ROWTYPE;
    
BEGIN             
   IF as_rate_tag NOT IN ('연체료', '할인료') THEN
      RETURN -11;
   END IF;
   
   IF as_rate_kind NOT IN ('분양','별도','임대료','임대보증금') THEN
      RETURN -1;
   ELSIF as_rate_kind = '분양' THEN
      C_RATE_KIND := '01';
   ELSIF as_rate_kind = '별도' THEN
      C_RATE_KIND := '02';
   ELSIF as_rate_kind = '임대료' THEN
      C_RATE_KIND := '03';
   ELSIF as_rate_kind = '임대보증금' THEN
      C_RATE_KIND := '04';
   ELSE
      RETURN -98;   
   END IF;    
   
   C_DAYS := NVL((ad_agree_date - ad_receipt_date),0);
   IF C_DAYS < 0 THEN
      IF as_rate_tag = '할인료' THEN
         RETURN 0;
      END IF; 
      C_DAYS := C_DAYS * -1;
   ELSIF C_DAYS > 0 THEN
      IF as_rate_tag = '연체료' THEN
         RETURN 0;
      END IF;
   ELSIF C_DAYS = 0 THEN
      RETURN 0;
   END IF;
   
   --약정일이 휴일/분양휴일 여부 check
   			SELECT COUNT(*),NVL(MAX(process_days),0)
				  INTO C_CNT,C_TEMP_CNT
				  FROM H_DEPT_HOLIDAY
				 WHERE dept_code = as_dept_code
					AND sell_code = as_sell_code
 					AND delay_discount_div = DECODE(as_rate_tag, '연체율', '1', '할인율', '2')
					AND yymmdd = ad_agree_date;
				IF C_CNT > 0 THEN
					IF C_DAYS <= C_TEMP_CNT THEN
						C_DAYS := 0;
					END IF;
				ELSE
					SELECT COUNT(*),NVL(MAX(process_days),0)
					  INTO C_CNT,C_TEMP_CNT
					  FROM H_COM_HOLIDAY
					 WHERE yymmdd = ad_agree_date;
					IF C_CNT > 0 THEN
						IF C_DAYS <= C_TEMP_CNT THEN
							C_DAYS := 0;
						END IF;
					END IF;
				END IF;
	          
   IF as_rate_tag = '연체료' THEN
   	            
   		C_DELAY_DAY   := C_DAYS;
   		C_TEMP_RATE := 0;
   	-- 납입대상금액계산
   		
   		                  
   			OPEN	DETAIL_CUR(ad_agree_date,   ad_receipt_date,   C_DAYS, C_RATE_KIND);
   			LOOP                      
   				FETCH DETAIL_CUR INTO rec_sale_delay.rate,rec_sale_delay.cutoff_std, rec_sale_delay.cutoff_unit,
                                                         rec_sale_delay.s_date,       rec_sale_delay.e_date;
   				EXIT WHEN DETAIL_CUR%NOTFOUND;
   				C_COMP_UNIT :=
   					CASE rec_sale_delay.cutoff_unit
   						WHEN '01' THEN 1
   						WHEN '02' THEN 10
   						WHEN '03' THEN 100
   						WHEN '04' THEN 1000
   						WHEN '05' THEN 10000
   						WHEN '06' THEN 100000
   						ELSE 1
   					END;
   				IF ad_agree_date >= rec_sale_delay.s_date AND ad_receipt_date <= rec_sale_delay.e_date THEN
   					C_TEMP_RATE := 1 + ( C_DELAY_DAY / 365 ) * ( rec_sale_delay.rate / 100 ) ;
   					C_TEMP_AMT := an_amt / C_TEMP_RATE;
   					IF rec_sale_delay.cutoff_std = '01' THEN
   						C_DELAY_AMT := TRUNC((an_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
   					ELSE
   						IF rec_sale_delay.cutoff_std = '02' THEN
   							C_DELAY_AMT := TRUNC((an_amt - C_TEMP_AMT) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
   						ELSE
   							C_DELAY_AMT := ROUND((an_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
   						END IF;
   					END IF;
   					EXIT;
   				END IF;
   				IF ad_agree_date >= rec_sale_delay.s_date THEN
   					SELECT NVL(rec_sale_delay.e_date - ad_agree_date ,0)
   					  INTO C_TEMP_CNT
   					  FROM dual;
   				ELSE
   					IF ad_receipt_date <= rec_sale_delay.e_date THEN
   						SELECT NVL(ad_receipt_date - rec_sale_delay.s_date + 1,0)
   						  INTO C_TEMP_CNT
   						  FROM dual;
   					ELSE
   						SELECT NVL(rec_sale_delay.e_date - rec_sale_delay.s_date + 1,0)
   						  INTO C_TEMP_CNT
   						  FROM dual;
   					END IF;
   				END IF;
   				C_TEMP_RATE := 1 + (C_TEMP_CNT / 365) * (rec_sale_delay.rate / 100);
   				IF C_TEMP_RATE <> 0 THEN
   					C_TEMP_AMT := an_amt / C_TEMP_RATE;
   				ELSE
   					C_TEMP_AMT := 0;
   				END IF;
   				IF rec_sale_delay.cutoff_std = '01' THEN
   					C_DELAY_AMT := C_DELAY_AMT + TRUNC((an_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
   				ELSE
   					IF rec_sale_delay.cutoff_std = '02' THEN
   						C_DELAY_AMT := C_DELAY_AMT + TRUNC((an_amt - C_TEMP_AMT) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
   					ELSE
   						C_DELAY_AMT := C_DELAY_AMT + ROUND((an_amt - C_TEMP_AMT) / C_COMP_UNIT,0) * C_COMP_UNIT;
   					END IF;
   				END IF;
   			END LOOP;
   			CLOSE DETAIL_CUR;
   			--C_TEMP_AMT   := an_amt - C_DELAY_AMT;
   			--an_amt := 0;
   		   
            RETURN C_DELAY_AMT; 
            
   ELSIF as_rate_tag = '할인료' THEN
   ------------------------------------할인료
            C_DISCOUNT_DAY   := C_DAYS;
   		   C_TEMP_RATE := 0;
   			OPEN	DETAIL_CUR1(ad_agree_date,   ad_receipt_date,   C_RATE_KIND);
   			LOOP                      
   				FETCH DETAIL_CUR1 INTO rec_sale_discount.rate,
                                      rec_sale_discount.cutoff_std,
                                      rec_sale_discount.cutoff_unit,
                                      rec_sale_discount.s_date,
                                      rec_sale_discount.e_date;
   				EXIT WHEN DETAIL_CUR1%NOTFOUND;
   				C_COMP_UNIT :=
   					CASE rec_sale_discount.cutoff_unit
   						WHEN '01' THEN 1
   						WHEN '02' THEN 10
   						WHEN '03' THEN 100
   						WHEN '04' THEN 1000
   						WHEN '05' THEN 10000
   						WHEN '06' THEN 100000
   						ELSE 1
   					END;
   				IF ad_agree_date <= rec_sale_discount.e_date AND ad_receipt_date >= rec_sale_discount.s_date THEN
   					C_TEMP_RATE := 1 - ( C_DISCOUNT_DAY / 365 ) * ( rec_sale_discount.rate / 100 ) ;
   					C_TEMP_AMT := an_amt / C_TEMP_RATE;
   					IF rec_sale_discount.cutoff_std = '01' THEN
   						C_DISCOUNT_AMT := TRUNC((C_TEMP_AMT - an_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
   					ELSE
   						IF rec_sale_discount.cutoff_std = '02' THEN
   							C_DISCOUNT_AMT := TRUNC((C_TEMP_AMT - an_amt) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
   						ELSE
   							C_DISCOUNT_AMT := ROUND((C_TEMP_AMT - an_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
   						END IF;
   					END IF;
   					EXIT;
   				END IF;
   				IF ad_receipt_date >= rec_sale_discount.s_date THEN
   					SELECT NVL(rec_sale_discount.e_date - ad_receipt_date ,0)
   					  INTO C_TEMP_CNT
   					  FROM dual;
   				ELSE
   					IF ad_agree_date <= rec_sale_discount.e_date THEN
   						SELECT NVL(ad_agree_date - rec_sale_discount.s_date + 1,0)
   						  INTO C_TEMP_CNT
   						  FROM dual;
   					ELSE
   						SELECT NVL(rec_sale_discount.e_date - rec_sale_discount.s_date + 1,0)
   						  INTO C_TEMP_CNT
   						  FROM dual;
   					END IF;
   				END IF;
   				C_TEMP_RATE := 1 - (C_TEMP_CNT / 365) * (rec_sale_discount.rate / 100);
   				IF C_TEMP_RATE <> 0 THEN
   					C_TEMP_AMT := an_amt / C_TEMP_RATE;
   				ELSE
   					C_TEMP_AMT := 0;
   				END IF;
   				IF rec_sale_discount.cutoff_std = '01' THEN
   					C_DISCOUNT_AMT := C_DISCOUNT_AMT + TRUNC((C_TEMP_AMT - an_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
   				ELSE
   					IF rec_sale_discount.cutoff_std = '02' THEN
   						C_DISCOUNT_AMT := C_DISCOUNT_AMT + TRUNC((C_TEMP_AMT - an_amt) / C_COMP_UNIT + 0.9,0) * C_COMP_UNIT;
   					ELSE
   						C_DISCOUNT_AMT := C_DISCOUNT_AMT + ROUND((C_TEMP_AMT - an_amt) / C_COMP_UNIT,0) * C_COMP_UNIT;
   					END IF;
   				END IF;
   			END LOOP;
   			CLOSE DETAIL_CUR1;
   			--C_TEMP_AMT   := an_amt + C_DISCOUNT_AMT;
   			--an_amt := 0;
   		   
            RETURN C_DISCOUNT_AMT;
   	
   END IF;
   
   
   RETURN -1;
EXCEPTION
   WHEN OTHERS THEN
      RAISE;
END;
/

