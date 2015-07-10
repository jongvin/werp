CREATE OR REPLACE PROCEDURE Y_Sp_H_Name_Chg_Delete(as_dept_code    IN   VARCHAR2,
                                                   as_sell_code    IN   VARCHAR2,
                                                   as_dongho       IN   VARCHAR2,
                                                   as_seq          IN   INTEGER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_LEVEL              NUMBER(20,5);  --
   C_CNT                NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
-- 세대별 서비스옵션 삭제
	BEGIN
		DELETE FROM H_SALE_OPTION
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 서비스옵션 삭제 실패! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 수입금 삭제
	BEGIN
		DELETE FROM H_SALE_INCOME
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 수입금 삭제 실패! [Line No: 2]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 일자별 수입금 삭제
	BEGIN
		DELETE FROM H_SALE_INCOME_DAILY
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '일자별 수입금 삭제 실패! [Line No: 2]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 대출이자내역 삭제
	BEGIN
	  DELETE FROM H_SALE_LOAN_INTEREST
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 대출이자내역 삭제 실패! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 약정사항 삭제
	BEGIN
	  DELETE FROM H_SALE_AGREE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 약정사항 삭제 실패! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 국민주택기금 삭제
	BEGIN
		DELETE FROM H_SALE_FUND
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 국민주택기금 삭제 실패! [Line No: 3]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 해약대장 삭제
	BEGIN
		DELETE FROM H_SALE_ANNUL
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 해약대장 삭제 실패! [Line No: 4]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 서류발행 삭제
	BEGIN
		DELETE FROM H_SALE_DOCUMENT
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 서류발행 삭제 실패! [Line No: 5]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 On-Time대장 삭제
	BEGIN
		DELETE FROM H_SALE_ONTIME_MASTER
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 On-Time대장 삭제 실패! [Line No: 6]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 메모사항 삭제
	BEGIN
		DELETE FROM H_SALE_MEMO
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 메모사항 삭제 실패! [Line No: 7]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 특이사항 삭제
	BEGIN
		DELETE FROM H_SALE_ETC
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 특이사항 삭제 실패! [Line No: 8]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 보증서대출내역 삭제
	BEGIN
		DELETE FROM H_SALE_LOAN
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 보증서대출내역 삭제 실패! [Line No: 9]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 On-Time수입금 삭제
	BEGIN
		DELETE FROM H_SALE_ONTIME_INCOME
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 On-Time수입금 삭제 실패! [Line No: 11]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 일자별 On-Time수입금 삭제
	BEGIN
		DELETE FROM H_SALE_ONTIME_INCOME_DAILY
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '일자별 On-Time수입금 삭제 실패! [Line No: 11]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별 On-Time약정사항 삭제
	BEGIN
		DELETE FROM H_SALE_ONTIME_AGREE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별 On-Time약정사항 삭제 실패! [Line No: 10]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 임대료납입사항 삭제
	/*begin
	  DELETE FROM H_LEAS_LEASE_INCOME
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '임대료납입사항 삭제 실패! [Line No: 14]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	end;
-- 일자별임대료납입사항 삭제
	begin
	  DELETE FROM H_LEAS_LEASE_INCOME_DAILY
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '일자별임대료납입사항 삭제 실패! [Line No: 14]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	end;
-- 임대료약정사항 삭제
	begin
		DELETE FROM H_LEAS_LEASE_AGREE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '임대료약정사항 삭제 실패! [Line No: 13]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	end;*/
-- 세대별약정이율 삭제
	BEGIN
		DELETE FROM H_SALE_DELAY_RATE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별연체율 삭제 실패! [Line No: 12]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 세대별할인율 삭제
	BEGIN
		DELETE FROM H_SALE_DISCOUNT_RATE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별할인율 삭제 실패! [Line No: 12]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- 가상계좌 동호 업데이트？-- 해약된경우 가상계좌를 해지 시킨다...가상계좌테이블으 동호정보 삭제...
	BEGIN
      UPDATE H_CODE_V_ACCOUNT
         SET DONGHO = NULL,
             SEQ    = NULL,
             APPLY_DATE = NULL,
             CANCEL_DATE = (SELECT SYSDATE FROM DUAL), 
             USE_TAG = 0
       WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '세대별할인율 삭제 실패! [Line No: 12]';
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
END Y_Sp_H_Name_Chg_Delete;
/

