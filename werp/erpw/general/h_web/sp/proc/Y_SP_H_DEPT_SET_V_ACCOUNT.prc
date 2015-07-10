CREATE OR REPLACE PROCEDURE Y_Sp_H_dept_set_v_account(as_dept_code IN   VARCHAR2,
                                                  as_sell_code IN   VARCHAR2) IS
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
 
 CURSOR get_cont_dongho(in_dept_code IN VARCHAR2, in_sell_code VARCHAR2)IS
 SELECT M.DONGHO,
       m.seq
  FROM H_SALE_MASTER M
 WHERE M.DEPT_CODE = in_dept_code
   AND M.SELL_CODE = in_sell_code
   AND M.CONTRACT_YN = 'Y'
   AND m.v_account_no IS NULL
ORDER BY M.DONGHO;
 

-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   v_dongho              H_SALE_MASTER.dongho%TYPE;
   v_seq              H_SALE_MASTER.seq%TYPE;
   V_DEPOSIT_NO        H_SALE_MASTER.DEPOSIT_NO%TYPE;
   V_V_ACCOUNT_NO      H_SALE_MASTER.V_ACCOUNT_NO%TYPE;    
	UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
    OPEN get_cont_dongho(as_dept_code, as_sell_code);
    LOOP
      FETCH get_cont_dongho INTO v_dongho, v_seq;
      EXIT WHEN get_cont_dongho%NOTFOUND;
       
      OPEN	GET_V_ACCOUNT_NO(as_dept_code, as_sell_code);
      FETCH GET_V_ACCOUNT_NO INTO V_V_ACCOUNT_NO, V_DEPOSIT_NO;
      CLOSE GET_V_ACCOUNT_NO;
             
      
      Y_Sp_H_Set_V_Account_No(as_dept_code,as_sell_code,v_dongho,v_seq, V_DEPOSIT_NO, V_V_ACCOUNT_NO);
      
                  
		
      /*EXCEPTION
      WHEN OTHERS THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '공급세대 일괄생성 실패! [Line No: 2]';
              Wk_errflag := -20001;
              GOTO EXIT_ROUTINE;
           END IF;*/
    END LOOP;
    CLOSE get_cont_dongho;
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
END Y_Sp_H_dept_set_v_account;
/

