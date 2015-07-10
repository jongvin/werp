CREATE OR REPLACE PROCEDURE Y_Sp_H_Name_Chg_Delete(as_dept_code    IN   VARCHAR2,
                                                   as_sell_code    IN   VARCHAR2,
                                                   as_dongho       IN   VARCHAR2,
                                                   as_seq          IN   INTEGER) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_LEVEL              NUMBER(20,5);  --
   C_CNT                NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
-- ���뺰 ���񽺿ɼ� ����
	BEGIN
		DELETE FROM H_SALE_OPTION
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 ���񽺿ɼ� ���� ����! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 ���Ա� ����
	BEGIN
		DELETE FROM H_SALE_INCOME
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 ���Ա� ���� ����! [Line No: 2]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���ں� ���Ա� ����
	BEGIN
		DELETE FROM H_SALE_INCOME_DAILY
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���ں� ���Ա� ���� ����! [Line No: 2]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 �������ڳ��� ����
	BEGIN
	  DELETE FROM H_SALE_LOAN_INTEREST
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 �������ڳ��� ���� ����! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 �������� ����
	BEGIN
	  DELETE FROM H_SALE_AGREE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 �������� ���� ����! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 �������ñ�� ����
	BEGIN
		DELETE FROM H_SALE_FUND
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 �������ñ�� ���� ����! [Line No: 3]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 �ؾ���� ����
	BEGIN
		DELETE FROM H_SALE_ANNUL
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 �ؾ���� ���� ����! [Line No: 4]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 �������� ����
	BEGIN
		DELETE FROM H_SALE_DOCUMENT
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 �������� ���� ����! [Line No: 5]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 On-Time���� ����
	BEGIN
		DELETE FROM H_SALE_ONTIME_MASTER
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 On-Time���� ���� ����! [Line No: 6]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 �޸���� ����
	BEGIN
		DELETE FROM H_SALE_MEMO
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 �޸���� ���� ����! [Line No: 7]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 Ư�̻��� ����
	BEGIN
		DELETE FROM H_SALE_ETC
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 Ư�̻��� ���� ����! [Line No: 8]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 ���������⳻�� ����
	BEGIN
		DELETE FROM H_SALE_LOAN
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 ���������⳻�� ���� ����! [Line No: 9]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 On-Time���Ա� ����
	BEGIN
		DELETE FROM H_SALE_ONTIME_INCOME
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 On-Time���Ա� ���� ����! [Line No: 11]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���ں� On-Time���Ա� ����
	BEGIN
		DELETE FROM H_SALE_ONTIME_INCOME_DAILY
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���ں� On-Time���Ա� ���� ����! [Line No: 11]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 On-Time�������� ����
	BEGIN
		DELETE FROM H_SALE_ONTIME_AGREE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 On-Time�������� ���� ����! [Line No: 10]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- �Ӵ�ᳳ�Ի��� ����
	/*begin
	  DELETE FROM H_LEAS_LEASE_INCOME
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '�Ӵ�ᳳ�Ի��� ���� ����! [Line No: 14]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	end;
-- ���ں��Ӵ�ᳳ�Ի��� ����
	begin
	  DELETE FROM H_LEAS_LEASE_INCOME_DAILY
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���ں��Ӵ�ᳳ�Ի��� ���� ����! [Line No: 14]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	end;
-- �Ӵ��������� ����
	begin
		DELETE FROM H_LEAS_LEASE_AGREE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '�Ӵ��������� ���� ����! [Line No: 13]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	end;*/
-- ���뺰�������� ����
	BEGIN
		DELETE FROM H_SALE_DELAY_RATE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰��ü�� ���� ����! [Line No: 12]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰������ ����
	BEGIN
		DELETE FROM H_SALE_DISCOUNT_RATE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰������ ���� ����! [Line No: 12]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ������� ��ȣ ������Ʈ��-- �ؾ�Ȱ�� ������¸� ���� ��Ų��...����������̺��� ��ȣ���� ����...
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
				  e_msg      := '���뺰������ ���� ����! [Line No: 12]';
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
END Y_Sp_H_Name_Chg_Delete;
/

