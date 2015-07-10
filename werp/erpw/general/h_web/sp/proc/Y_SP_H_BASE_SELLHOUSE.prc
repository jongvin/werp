CREATE OR REPLACE PROCEDURE Y_Sp_H_Base_Sellhouse(as_dept_code IN   VARCHAR2,
                                                  as_sell_code IN   VARCHAR2,
																  ai_seq       IN NUMBER,
                                                  ai_v_tag     IN NUMBER ) IS
CURSOR GET_V_ACCOUNT_NO (in_dept_code IN VARCHAR2, in_sell_code VARCHAR2)IS
SELECT AA.V_ACCOUNT_NO, AA.DEPOSIT_NO
  FROM (SELECT A.V_ACCOUNT_NO, A.DEPOSIT_NO, ROWNUM RN
          FROM (SELECT A.V_ACCOUNT_NO, A.CANCEL_DATE, A.DEPOSIT_NO
                  FROM H_CODE_V_ACCOUNT A,
                       H_CODE_DEPOSIT B
                 WHERE B.DEPT_CODE = A.DEPT_CODE
                   AND B.SELL_CODE = A.SELL_CODE
                   AND b.dept_code = in_dept_code
                   AND b.sell_code = in_sell_code
                   AND B.DEPOSIT_NO = A.DEPOSIT_NO
                   AND B.FI_ATTRIBUTE11 = 'Y'
                   AND B.FI_ATTRIBUTE12 = 'Y'
                   AND A.USE_TAG = 0 
                ORDER BY CANCEL_DATE DESC, V_ACCOUNT_NO ASC
               ) A
       )AA
 WHERE AA.RN = 1;

-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   V_DONG              H_BASE_SELLHOUSE.S_DONG%TYPE;    --
   V_S_HO              H_BASE_SELLHOUSE.S_HO%TYPE;    --
   V_E_HO              H_BASE_SELLHOUSE.E_HO%TYPE;    --
   V_PYONG             H_BASE_SELLHOUSE.PYONG%TYPE;    --
   V_STYLE             H_BASE_SELLHOUSE.STYLE%TYPE;    --
   V_CLASS             H_BASE_SELLHOUSE.CLASS%TYPE;    --
   V_OPTION_CODE       H_BASE_SELLHOUSE.OPTION_CODE%TYPE;    --
   V_CONTRACT_CODE     H_BASE_SELLHOUSE.CONTRACT_CODE%TYPE;    --
   V_UNION_YN          H_BASE_SELLHOUSE.UNION_YN%TYPE;    --
   V_MOVEINTO_FR_DATE  H_CODE_HOUSE.MOVEINTO_FR_DATE%TYPE;    --
   V_MOVEINTO_TO_DATE  H_CODE_HOUSE.MOVEINTO_TO_DATE%TYPE;    --
	V_LEASE_S_DATE      DATE;
	V_LEASE_E_DATE      DATE;
	V_LEASE_SUPPLY      H_BASE_PYONG_MASTER.lease_supply%TYPE;
   V_DEPOSIT_NO        H_SALE_MASTER.DEPOSIT_NO%TYPE;
   V_V_ACCOUNT_NO      H_SALE_MASTER.V_ACCOUNT_NO%TYPE;
   C_S_HO1             INTEGER DEFAULT 0;
   C_S_HO2             INTEGER DEFAULT 0;
   C_E_HO1             INTEGER DEFAULT 0;
   C_E_HO2             INTEGER DEFAULT 0;
	C_CHK               VARCHAR2(2);
	C_DONGHO            VARCHAR2(8);
	C_HO1               VARCHAR2(8);
	C_HO2               VARCHAR2(8);
   C_CNT               NUMBER(20,5);  --
   C_CNT1              NUMBER(20,5);  --
   C_CNT2              NUMBER(20,5);  --
   C_TOT_CNT           NUMBER(20,5);  --
   sql_stmt2           VARCHAR2(50);
	UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      --RAISE_APPLICATION_ERROR(-20001, 'aa'); 
		SELECT pyong,style,CLASS,s_dong,TO_NUMBER(SUBSTR(s_ho,1,2)),TO_NUMBER(SUBSTR(s_ho,3,2)),
				 TO_NUMBER(SUBSTR(e_ho,1,2)),TO_NUMBER(SUBSTR(e_ho,3,2)),option_code,union_yn,contract_code
		  INTO V_PYONG,V_STYLE,V_CLASS,V_DONG,C_S_HO1,C_S_HO2,C_E_HO1,C_E_HO2,V_OPTION_CODE,V_UNION_YN,V_CONTRACT_CODE
		  FROM H_BASE_SELLHOUSE
		 WHERE dept_code = as_dept_code
			AND sell_code = as_sell_code
			AND seq       = ai_seq;
      
      SELECT lease_supply
		  INTO V_LEASE_SUPPLY
		  FROM H_BASE_PYONG_MASTER
		 WHERE dept_code = as_dept_code
			AND sell_code = as_sell_code
			AND pyong     = V_PYONG
			AND style     = V_STYLE
			AND CLASS     = V_CLASS
			AND option_code = V_OPTION_CODE;

		SELECT moveinto_fr_date,moveinto_to_date, lease_s_date, lease_e_date
		  INTO V_MOVEINTO_FR_DATE,V_MOVEINTO_TO_DATE, V_LEASE_S_DATE, V_LEASE_E_DATE
		  FROM H_CODE_HOUSE
		 WHERE dept_code = as_dept_code
			AND sell_code = as_sell_code;
		IF V_UNION_YN = 'Y' THEN
			C_CHK := '03';
		ELSE
			C_CHK := '01';
		END IF;
		IF C_S_HO1 <= C_E_HO1 AND C_S_HO2 <= C_E_HO2 THEN
			C_CNT1 := C_S_HO1;
			C_TOT_CNT := 0;
			LOOP
				C_CNT2 := C_S_HO2;
				LOOP
					IF C_CNT1 < 10 THEN
						C_HO1 := '0' || TO_CHAR(C_CNT1);
					ELSE
						C_HO1 := TO_CHAR(C_CNT1);
					END IF;
					IF C_CNT2 < 10 THEN
						C_HO2 := '0' || TO_CHAR(C_CNT2);
					ELSE
						C_HO2 := TO_CHAR(C_CNT2);
					END IF;
					C_DONGHO := V_DONG || C_HO1 || C_HO2;
					SELECT COUNT(*)
					  INTO C_CNT
					  FROM H_SALE_MASTER
					 WHERE dept_code = as_dept_code
						AND sell_code = as_sell_code
						AND dongho    = C_DONGHO;
					IF C_CNT < 1 THEN
                  IF ai_v_tag = 1 THEN --가상계좌 부여태그가 1이면 ..
                     OPEN	GET_V_ACCOUNT_NO(as_dept_code, as_sell_code);
    		            FETCH GET_V_ACCOUNT_NO INTO V_V_ACCOUNT_NO, V_DEPOSIT_NO;
                     CLOSE GET_V_ACCOUNT_NO;
                  END IF;
                     
						INSERT INTO H_SALE_MASTER
                            (DEPT_CODE, SELL_CODE, DONGHO, SEQ, PYONG, STYLE, CLASS, OPTION_CODE,
       							  CONTRACT_CODE,CONTRACT_YN,CONTRACT_DATE, CHG_DIV, CHG_DATE, LAST_CONTRACT_DATE, 
       							  MOVEINTO_FR_DATE, MOVEINTO_TO_DATE,DEPOSIT_NO, V_ACCOUNT_NO )    
							VALUES ( as_dept_code,as_sell_code,C_DONGHO,1,V_PYONG,V_STYLE,V_CLASS,V_OPTION_CODE,
										V_CONTRACT_CODE,'N',TO_DATE('1000.01.01'),'00',TO_DATE('2999.12.31'),TO_DATE('1000.01.01'),
										V_MOVEINTO_FR_DATE,V_MOVEINTO_TO_DATE,V_DEPOSIT_NO, V_V_ACCOUNT_NO)  ;
                  IF ai_v_tag = 1 AND LENGTH(trim(v_v_account_no)) IS NOT NULL THEN --가상계좌 부여태그가 1이면 ..
                     Y_Sp_H_Set_V_Account_No(as_dept_code,as_sell_code,C_DONGHO,1, V_DEPOSIT_NO, V_V_ACCOUNT_NO);
                     V_DEPOSIT_NO := NULL;
                     V_V_ACCOUNT_NO := NULL;
                  END IF;
                  
						INSERT INTO H_SALE_AGREE
						  SELECT b.DEPT_CODE,b.SELL_CODE,C_DONGHO,1,b.DEGREE_CODE,b.AGREE_DATE,b.LAND_AMT,b.BUILD_AMT,
									b.VAT_AMT,b.SELL_AMT,'N',0,NULL,0, NULL, NULL, NULL, NULL, NULL, NULL
							 FROM H_BASE_PYONG_MASTER a,
									( SELECT *
										 FROM	H_BASE_PYONG_DETAIL ) b
							WHERE a.dept_code = b.dept_code (+)
							  AND a.sell_code = b.sell_code (+)
							  AND a.spec_unq_num = b.spec_unq_num (+)
							  AND a.dept_code = as_dept_code
							  AND a.sell_code = as_sell_code
							  AND a.pyong = V_PYONG
							  AND a.style = V_STYLE
							  AND a.CLASS = V_CLASS
							  AND a.option_code = V_OPTION_CODE;
						INSERT INTO H_SALE_DELAY_RATE
							SELECT dept_code,sell_code,C_DONGHO,1,rate_kind,MNTH,s_date,e_date,rate,
									 cutoff_std,cutoff_unit
							  FROM H_BASE_DELAY_RATE
							 WHERE dept_code = as_dept_code
								AND sell_code = as_sell_code;
						INSERT INTO H_SALE_DISCOUNT_RATE
							SELECT dept_code,sell_code,C_DONGHO,1,rate_kind,s_date,e_date,rate,cutoff_std,cutoff_unit
							  FROM H_BASE_DISCOUNT_RATE
							 WHERE dept_code = as_dept_code
								AND sell_code = as_sell_code;
					END IF;
					C_CNT2 := C_CNT2 + 1;
					C_TOT_CNT := C_TOT_CNT + 1;
					IF C_CNT2 > C_E_HO2 THEN
						EXIT;
					END IF;
				END LOOP;
				C_CNT1 := C_CNT1 + 1;
				IF C_CNT1 > C_E_HO1 THEN
					EXIT;
				END IF;
			END LOOP;
			UPDATE H_BASE_SELLHOUSE
			   SET HOUSE_CNT = C_TOT_CNT
			 WHERE DEPT_CODE = as_dept_code
				AND sell_code = as_sell_code
				AND seq       = ai_seq;
		END IF;
      /*EXCEPTION
      WHEN OTHERS THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '공급세대 일괄생성 실패! [Line No: 2]';
              Wk_errflag := -20001;
              GOTO EXIT_ROUTINE;
           END IF;*/
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
END Y_Sp_H_Base_Sellhouse;
/

