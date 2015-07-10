CREATE OR REPLACE PROCEDURE y_sp_h_cms_conv_find_seq(as_dept_code     IN   VARCHAR2,
                                                     as_sell_code     IN   VARCHAR2) IS

CURSOR DETAIL_CUR IS
select m.dongho dongho,
       nvl(max(m.seq),0) seq
  from h_sale_master m,
       h_sale_bank b
 where m.dept_code = as_dept_code
   and m.sell_code = as_sell_code
	and m.dept_code = b.dept_code
	and m.sell_code = b.sell_code
	and b.process_yn = 'T'
group by m.dongho
order by m.dongho;

-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수

   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error

   C_CNT               NUMBER(10,5);  --
	C_DONGHO            VARCHAR2(8);
	C_SEQ               INTEGER;
	sql_stmt            VARCHAR2(100);
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN

		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO C_DONGHO, C_SEQ;
			EXIT WHEN DETAIL_CUR%NOTFOUND;

			IF C_SEQ <> 0 THEN
				UPDATE H_SALE_BANK
				   SET SEQ = C_SEQ
				 WHERE DEPT_CODE = as_dept_code
				   AND SELL_CODE = as_sell_code
					AND DONGHO    = C_DONGHO
					AND PROCESS_YN = 'T' ;
			ELSE
				UPDATE H_SALE_BANK
				   SET DEPOSIT_NO = '계약자료없음',
					    PROCESS_YN = 'F',
						 CANCEL_YN  = '1',
						 PRGSS_STATUS = 'Y'
				 WHERE DEPT_CODE = as_dept_code
				   AND SELL_CODE = as_sell_code
					AND DONGHO    = C_DONGHO
					AND PROCESS_YN = 'T' ;
			END IF;

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
END y_sp_h_cms_conv_find_seq;
/

