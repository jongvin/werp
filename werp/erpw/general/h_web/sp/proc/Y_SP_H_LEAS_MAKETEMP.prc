CREATE OR REPLACE PROCEDURE Y_Sp_H_Leas_Maketemp(as_spec_unq_num IN NUMBER,
															    as_dept_code     IN   VARCHAR2,
															    as_sell_code     IN   VARCHAR2,
																 as_from_pyong    IN   VARCHAR2,
																 as_to_pyong      IN   VARCHAR2,
																 as_from_dongho   IN   VARCHAR2,
																 as_to_dongho     IN   VARCHAR2,
																 as_date          IN   DATE,
																 as_from_date     IN   DATE,
																 as_to_date       IN   DATE) IS
CURSOR DETAIL_CUR (as_dept_code   VARCHAR2,
                   as_sell_code   VARCHAR2,
						 as_from_pyong  VARCHAR2,
						 as_to_pyong    VARCHAR2,
						 as_from_dongho VARCHAR2,
						 as_to_dongho   VARCHAR2)IS
SELECT UNIQUE b.dongho
  FROM H_SALE_MASTER b
 WHERE b.DEPT_CODE = as_dept_code
   AND b.sell_code = as_sell_code
   AND b.pyong     BETWEEN as_from_pyong   AND as_to_pyong
   AND b.dongho    BETWEEN as_from_dongho  AND as_to_dongho;

CURSOR DETAIL_CUR2 (as_dept_code   VARCHAR2,
                   as_sell_code   VARCHAR2,
						 as_from_pyong  VARCHAR2,
						 as_to_pyong    VARCHAR2,
						 as_from_dongho VARCHAR2,
						 as_to_dongho   VARCHAR2,
						 as_date        DATE,
						 as_from_date       DATE,
						 as_to_date         DATE)IS
SELECT MASTER.dongho ,
       MASTER.seq ,
		 agree.degree_code
  FROM H_SALE_MASTER MASTER,
       (SELECT a.dept_code,
		         a.sell_code,
					a.dongho,
					a.seq,
					MAX(a.degree_code) degree_code
			 FROM h_leas_lease_agree a
         WHERE a.dept_code = as_dept_code
			  AND a.sell_code = as_sell_code
			  AND a.agree_date BETWEEN as_from_date AND as_to_date
        GROUP BY a.dept_code, a.sell_code, a.dongho, a.seq  ) agree
 WHERE MASTER.dept_code = as_dept_code
   AND MASTER.sell_code = as_sell_code
	AND MASTER.pyong  BETWEEN as_from_pyong  AND as_to_pyong
   AND MASTER.dongho BETWEEN as_from_dongho AND as_to_dongho
   AND MASTER.last_contract_date <= as_date
	AND MASTER.chg_date > as_date
   AND MASTER.chg_div <> '00'
	AND MASTER.contract_code = '02'
	AND MASTER.dept_code = agree.dept_code
   AND MASTER.sell_code = agree.sell_code
	AND MASTER.dongho = agree.dongho
	AND MASTER.seq = agree.seq
ORDER BY MASTER.dongho, MASTER.seq,  agree.degree_code;

-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   C_DONGHO            H_SALE_MASTER.DONGHO%TYPE;
	C_SEQ               H_SALE_MASTER.SEQ%TYPE;
	C_DEGREE_CODE       H_SALE_AGREE.DEGREE_CODE%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN

	   OPEN	DETAIL_CUR(as_dept_code, as_sell_code, as_from_pyong, as_to_pyong, as_from_dongho, as_to_dongho);
		LOOP
			FETCH DETAIL_CUR INTO C_DONGHO;
			EXIT WHEN DETAIL_CUR%NOTFOUND;

			INSERT INTO h_leas_lease_agree_temp
	              SELECT  as_spec_unq_num ,dept_code,sell_code,dongho,seq,degree_code,
	                     agree_date,s_date,e_date,days,lease_amt,vat_yn,lease_supply,lease_vat,
	                     f_pay_yn,pay_tot_amt,lease_amt,lease_supply,lease_vat,f_pay_yn,pay_tot_amt
	                FROM h_leas_lease_agree
	   	         WHERE DEPT_CODE = as_dept_code
	   			     AND sell_code = as_sell_code
	   			     AND dongho = C_DONGHO;

	      INSERT INTO h_leas_lease_income_temp
	              SELECT  as_spec_unq_num ,dept_code,sell_code,dongho,seq,degree_code,degree_seq,
	                     receipt_date,deposit_no,r_amt,lease_supply,lease_vat,delay_days,delay_amt,discount_days,discount_amt,
	                     work_date,work_no,input_id,input_date,'N'
	                FROM h_leas_lease_income
	   	         WHERE DEPT_CODE = as_dept_code
	   			     AND sell_code = as_sell_code
	   			     AND dongho = C_DONGHO ;

		END LOOP;
		CLOSE DETAIL_CUR;
		OPEN	DETAIL_CUR2(as_dept_code, as_sell_code, as_from_pyong, as_to_pyong, as_from_dongho, as_to_dongho,
		                  as_date,as_from_date,as_to_date  );

		LOOP
			FETCH DETAIL_CUR2 INTO C_DONGHO, C_SEQ, C_DEGREE_CODE;
			EXIT WHEN DETAIL_CUR2%NOTFOUND;

		   UPDATE h_leas_lease_agree_temp
			   SET lease_amt_tmp = 0
			 WHERE spec_unq_num = as_spec_unq_num
			   AND dept_code =    as_dept_code
			   AND sell_code =    as_sell_code
			   AND dongho =       C_DONGHO
			   AND seq  =         C_SEQ
			   AND degree_code >   C_DEGREE_CODE;


			Y_Sp_H_Leas_Lease_Cmpt_Tempbk(as_spec_unq_num ,as_dept_code,as_sell_code,C_DONGHO,C_SEQ,
			                              as_date, '01','01','납부안내장');

			 UPDATE h_leas_lease_agree_temp
			    SET f_pay_yn = f_pay_yn_tmp,
			        pay_tot_amt  = pay_tot_amt_tmp,
			        lease_amt_tmp = lease_amt
			  WHERE spec_unq_num =   as_spec_unq_num
			    AND dept_code = as_dept_code
			    AND sell_code = as_sell_code
			    AND dongho = C_DONGHO
			    AND seq  =   C_SEQ;

		END LOOP;
		CLOSE DETAIL_CUR2;

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
END Y_Sp_H_Leas_Maketemp;
/

