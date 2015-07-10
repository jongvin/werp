/* ============================================================================= */
/* 함수명 : y_sp_y_projmng_convert                                               */
/* 기  능 : 현장별현장관리비내역을 실행내역으로적용한다.                         */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 변경순번               ==> ai_no        (integer)                    */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.09.22                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_y_projmng_convert(as_dept_code    IN   VARCHAR2,
                                                   ai_no           IN   INTEGER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DELETE_CUR IS
SELECT dept_code,
		 wbs_code,
		 detail_code,
		 spec_unq_num
  FROM y_projmng_amt
 WHERE dept_code = as_dept_code
	AND spec_unq_num <> 0
	AND amt = 0;

CURSOR DELETE_WBS_CUR IS
SELECT dept_code,
		 wbs_code,
		 spec_no_seq
  FROM y_projmng_amt_wbs
 WHERE dept_code = as_dept_code
	AND spec_no_seq <> 0
	AND amt = 0;

CURSOR PARENT_CUR IS
SELECT DEPT_CODE,
       WBS_CODE,
       NAME,
       NOTE
  FROM Y_PROJMNG_AMT_WBS 
 WHERE DEPT_CODE = as_dept_code
   AND AMT <> 0
ORDER BY WBS_CODE ASC;

CURSOR DETAIL1_CUR IS
SELECT DEPT_CODE,
       DETAIL_CODE,
		 SPEC_UNQ_NUM,
       NAME,
       SSIZE,
       UNIT,
       QTY,
       PRICE,
       AMT,
       UPPER(replace(name || ssize || unit,' ','')) name_key,
       REMARK
  FROM Y_PROJMNG_AMT 
 WHERE DEPT_CODE    = as_dept_code
   AND AMT          <> 0
   AND SPEC_UNQ_NUM <> 0 
ORDER BY WBS_CODE ASC,
         DETAIL_CODE ASC;

CURSOR DETAIL_CUR IS
SELECT DEPT_CODE,
		 WBS_CODE,
       DETAIL_CODE,
       NAME,
       SSIZE,
       UNIT,
       QTY,
       PRICE,
       AMT,
       UPPER(replace(name || ssize || unit,' ','')) name_key,
       REMARK
  FROM Y_PROJMNG_AMT 
 WHERE DEPT_CODE    = as_dept_code
   AND AMT          <> 0
   AND SPEC_UNQ_NUM = 0 
ORDER BY WBS_CODE ASC,
         DETAIL_CODE ASC;
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   V_DEPT_CODE         Y_PROJMNG_AMT_WBS.DEPT_CODE%TYPE;
   V_WBS_CODE          Y_PROJMNG_AMT_WBS.WBS_CODE%TYPE;
   V_NAME              Y_PROJMNG_AMT_WBS.NAME%TYPE;
   V_SPEC_NO_SEQ       Y_PROJMNG_AMT_WBS.SPEC_NO_SEQ%TYPE;
   V_SPEC_UNQ_NUM      Y_PROJMNG_AMT.SPEC_UNQ_NUM%TYPE;
   V_NOTE              Y_PROJMNG_AMT_WBS.NOTE%TYPE;
   V_DETAIL_CODE       Y_PROJMNG_AMT.DETAIL_CODE%TYPE;
   V_SSIZE             Y_PROJMNG_AMT.SSIZE%TYPE;
   V_UNIT              Y_PROJMNG_AMT.UNIT%TYPE;
   V_QTY               Y_PROJMNG_AMT.QTY%TYPE;
   V_PRICE             Y_PROJMNG_AMT.PRICE%TYPE;
   V_AMT               Y_PROJMNG_AMT.AMT%TYPE;
   V_NAME_KEY          Y_CHG_BUDGET_DETAIL.NAME_KEY%TYPE;
   V_REMARK            Y_PROJMNG_AMT.REMARK%TYPE;
   C_CNT               NUMBER(20,5);   
   C_SEQ               NUMBER(20,5);   
   C_TMP_SEQ           NUMBER(20,5);   
   C_TMP_SEQ1          NUMBER(20,5);   
   C_NO                NUMBER(18);   
   C_SPEC_NO           NUMBER(18);   
   C_SUM_CODE          VARCHAR2(20);
   C_SUM_CODE1         VARCHAR2(20);
   C_CHK               VARCHAR2(1);
BEGIN
 BEGIN
-- 실행내역에서 삭제 및 금액을 0로 변경한다. 
	OPEN	DELETE_CUR;
	LOOP
		FETCH DELETE_CUR INTO V_DEPT_CODE,V_WBS_CODE,V_DETAIL_CODE,V_SPEC_UNQ_NUM;
		EXIT WHEN DELETE_CUR%NOTFOUND;

      SELECT COUNT(*)
        INTO C_CNT
        FROM y_chg_budget_detail
       WHERE dept_code = V_DEPT_CODE
			AND chg_no_seq = ai_no
         AND spec_unq_num  = V_SPEC_UNQ_NUM;

      IF C_CNT > 0 THEN
         SELECT approve_yn
           INTO C_CHK
			  FROM y_chg_budget_detail
			 WHERE dept_code = as_dept_code
				AND chg_no_seq = ai_no
				AND spec_unq_num  = V_SPEC_UNQ_NUM;
         IF C_CHK = 'N' THEN   
				DELETE FROM y_chg_budget_detail
						WHERE dept_code = V_DEPT_CODE
						  AND chg_no_seq = ai_no
						  AND spec_unq_num  = V_SPEC_UNQ_NUM;
			ELSE
				UPDATE y_chg_budget_detail
					SET qty = 0,
				       exp_amt = 0,
						 amt = 0
 				 WHERE dept_code = as_dept_code
					AND chg_no_seq = ai_no
					AND spec_unq_num  = V_SPEC_UNQ_NUM;
         END IF;

         UPDATE y_projmng_amt
            SET spec_unq_num = 0
          WHERE DEPT_CODE   = V_DEPT_CODE
            AND wbs_code    = V_WBS_CODE
				AND detail_code = V_DETAIL_CODE;
      END IF;
	END LOOP;
	CLOSE DELETE_CUR;
	
	OPEN	DELETE_WBS_CUR;
	LOOP
		FETCH DELETE_WBS_CUR INTO V_DEPT_CODE,V_WBS_CODE,V_SPEC_NO_SEQ;
		EXIT WHEN DELETE_WBS_CUR%NOTFOUND;

      SELECT COUNT(*)
        INTO C_CNT
        FROM y_chg_budget_parent
       WHERE dept_code = V_DEPT_CODE
			AND chg_no_seq = ai_no
         AND spec_no_seq  = V_SPEC_NO_SEQ;

      IF C_CNT > 0 THEN
         SELECT COUNT(*)
           INTO C_CNT
			  FROM y_chg_budget_detail
			 WHERE dept_code = as_dept_code
				AND chg_no_seq = ai_no
				AND spec_no_seq  = V_SPEC_NO_SEQ;

         IF C_CNT < 1 THEN   
				DELETE FROM y_chg_budget_parent
						WHERE dept_code = V_DEPT_CODE
						  AND chg_no_seq = ai_no
			           AND spec_no_seq  = V_SPEC_NO_SEQ;

				UPDATE y_projmng_amt_wbs
					SET spec_no_seq = 0
				 WHERE DEPT_CODE   = V_DEPT_CODE
					AND wbs_code    = V_WBS_CODE;
         END IF;
      END IF;
	END LOOP;
	CLOSE DELETE_WBS_CUR;

   EXCEPTION
   WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '현장관리비삭제실패! [Line No: 159]';
           Wk_errflag := -20020;
           GOTO EXIT_ROUTINE;
        END IF;   
 END;
 BEGIN
-- 실행내역에서 기존의 적용된 금액 및 수량을 변경한다.
	OPEN	DETAIL1_CUR;
	LOOP
		FETCH DETAIL1_CUR INTO V_DEPT_CODE,V_DETAIL_CODE,V_SPEC_UNQ_NUM,
									  V_NAME,V_SSIZE,V_UNIT,V_QTY,V_PRICE,V_AMT,V_NAME_KEY,V_REMARK;
		EXIT WHEN DETAIL1_CUR%NOTFOUND;

      SELECT COUNT(*)
        INTO C_CNT
        FROM y_chg_budget_detail
       WHERE dept_code = V_DEPT_CODE
			AND chg_no_seq = ai_no
         AND spec_unq_num  = V_SPEC_UNQ_NUM;

      IF C_CNT > 0 THEN
			UPDATE y_chg_budget_detail
				SET qty = V_QTY,
					 price = V_PRICE,
					 exp_price = V_PRICE,
					 exp_amt  = V_AMT,
					 amt = V_AMT,
		   		 name = V_NAME,
					 detail_code = V_DETAIL_CODE,
					 res_class = 'Z',
					 ssize = V_SSIZE,
					 unit = V_UNIT,
					 name_key = V_NAME_KEY,
					 remark = V_REMARK
			 WHERE dept_code = as_dept_code
				AND chg_no_seq = ai_no
				AND spec_unq_num  = V_SPEC_UNQ_NUM;
      END IF;
	END LOOP;
	CLOSE DETAIL1_CUR;

   EXCEPTION
   WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '현장관리비변경실패! [Line No: 159]';
           Wk_errflag := -20020;
           GOTO EXIT_ROUTINE;
        END IF;   
 END;
 BEGIN
-- 최상위 집계구조를 생성한다.
	SELECT COUNT(*)
	  INTO C_CNT
	  FROM y_chg_budget_parent
	 WHERE DEPT_CODE  = as_dept_code
		AND chg_no_seq = ai_no
		AND wbs_code   = 'Z';

	IF C_CNT < 1 THEN
		select max(sum_code) + 1, max(no_seq)
		  into C_SUM_CODE,C_SEQ
		  from y_chg_budget_parent
		 where dept_code = as_dept_code
			and chg_no_seq = ai_no
			and llevel = 2;
		IF length(C_SUM_CODE) < 4 THEN
		   C_SUM_CODE := '0' || C_SUM_CODE;
		END IF;
		select max(no_seq)
		  into C_SEQ
		  from y_chg_budget_parent
		 where dept_code = as_dept_code
			and chg_no_seq = ai_no;

		C_SEQ := C_SEQ + 100;

		INSERT INTO y_chg_budget_parent  
			  VALUES ( as_dept_code,ai_no,y_spec_unq_no.nextval,C_SEQ,C_SUM_CODE,substrb(C_SUM_CODE,1,2),'2','Z',
						  2,'N','현장관리비','','',
						  0,0,0,0,0,0,0,0,0,0,'',sysdate,'',''  );
	ELSE
		select sum_code,no_seq
		  into C_SUM_CODE,C_SEQ
		  from y_chg_budget_parent
		 where dept_code = as_dept_code
			and chg_no_seq = ai_no
			and wbs_code = 'Z';

		select count(*)
		  into C_CNT
		  from y_chg_budget_parent
		 where dept_code = as_dept_code
			and chg_no_seq = ai_no
			and (substrb(wbs_code,1,1) <> 'Z'
          or wbs_code is null )
			and no_seq > C_SEQ;

		IF C_CNT > 0 THEN
			select min(no_seq)
			  into C_TMP_SEQ
			  from y_chg_budget_parent
			 where dept_code = as_dept_code
				and chg_no_seq = ai_no
				and (substrb(wbs_code,1,1) <> 'Z'
   	       or wbs_code is null )
				and no_seq > C_SEQ;

			C_TMP_SEQ1 := C_SEQ + 200 - C_TMP_SEQ;

			IF C_TMP_SEQ1 > 0 THEN
				update y_chg_budget_parent
				   set no_seq = no_seq + C_TMP_SEQ1
				 where dept_code = as_dept_code
					and chg_no_seq = ai_no
					and (substrb(wbs_code,1,1) <> 'Z'
      		    or wbs_code is null )
					and no_seq > C_SEQ;
			END IF;
		END IF;
	END IF;
	EXCEPTION
	WHEN others THEN 
		  IF SQL%NOTFOUND THEN
			  e_msg      := '최상위집계공종입력실패! [Line No: 159]';
			  Wk_errflag := -20020;
			  GOTO EXIT_ROUTINE;
		  END IF;   
 END;
 BEGIN
-- 집계구조를 생성한다.
	OPEN	PARENT_CUR;
	LOOP
		FETCH PARENT_CUR INTO V_DEPT_CODE,V_WBS_CODE,V_NAME,V_NOTE;
		EXIT WHEN PARENT_CUR%NOTFOUND;

      C_SUM_CODE1 := C_SUM_CODE || SUBSTRB(V_WBS_CODE,2,2);
      C_NO        := C_SEQ + TO_NUMBER(SUBSTR(V_WBS_CODE,2,2));
		select count(*)
		  into C_CNT
		  from y_chg_budget_parent
		 where dept_code = V_DEPT_CODE
			and chg_no_seq = ai_no
			and wbs_code = V_WBS_CODE;

		IF C_CNT < 1 THEN
			select y_spec_unq_no.nextval
			  into C_SPEC_NO
			  from dual;
			INSERT INTO y_chg_budget_parent  
				  VALUES ( V_DEPT_CODE,ai_no,C_SPEC_NO,C_NO,C_SUM_CODE1,C_SUM_CODE,'2',V_WBS_CODE,
							  3,'Y',V_NAME,'','',
							  0,0,0,0,0,0,0,0,0,0,V_NOTE,sysdate,'',''  );

         UPDATE y_projmng_amt_wbs
            SET spec_no_seq = C_SPEC_NO,
					 work_dt     = sysdate
          WHERE DEPT_CODE = V_DEPT_CODE
            AND wbs_code  = V_WBS_CODE;
		ELSE
         UPDATE y_projmng_amt_wbs
            SET work_dt     = sysdate
          WHERE DEPT_CODE = V_DEPT_CODE
            AND wbs_code  = V_WBS_CODE;
		END IF;
	END LOOP;
	CLOSE PARENT_CUR;
   EXCEPTION
   WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '집계구조입력실패! [Line No: 159]';
           Wk_errflag := -20020;
           GOTO EXIT_ROUTINE;
        END IF;   
 END;
 BEGIN
-- 실행내역을 생성한다...
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_DEPT_CODE,V_WBS_CODE,V_DETAIL_CODE,V_NAME,V_SSIZE,V_UNIT,
									 V_QTY,V_PRICE,V_AMT,V_NAME_KEY,V_REMARK;
		EXIT WHEN DETAIL_CUR%NOTFOUND;


      SELECT COUNT(*)
        INTO C_CNT
        FROM y_chg_budget_parent
       WHERE dept_code = V_DEPT_CODE
			AND chg_no_seq = ai_no
         AND wbs_code  = V_WBS_CODE
			AND parent_sum_code = C_SUM_CODE;

      IF C_CNT > 0 THEN
			SELECT SPEC_NO_SEQ
			  INTO C_NO
			  FROM y_chg_budget_parent
			 WHERE dept_code = V_DEPT_CODE
				AND chg_no_seq = ai_no
				AND wbs_code  = V_WBS_CODE
				AND parent_sum_code = C_SUM_CODE;

			select nvl(max(no_seq),0) + 1
			  into C_SEQ
			  from y_chg_budget_detail
			 where dept_code = V_DEPT_CODE
				and chg_no_seq = ai_no
				and spec_no_seq = C_NO;

			select y_spec_unq_no.nextval
			  into C_SPEC_NO
			  from dual;

			insert into y_chg_budget_detail  
				  values ( V_DEPT_CODE,ai_no,C_NO,C_SPEC_NO,C_SEQ,V_DETAIL_CODE,'Z','',V_NAME,V_SSIZE,V_UNIT,'N',
							  0,0,0,0,0,0,0,0,0,V_QTY,V_PRICE,V_AMT,0,0,0,0,V_PRICE,V_AMT,0,0,0,0,V_REMARK,V_NAME_KEY,
							  sysdate,''  );

			UPDATE y_projmng_amt
				SET spec_unq_num = C_SPEC_NO
			 WHERE dept_code   = V_DEPT_CODE
				AND wbs_code    = V_WBS_CODE
				AND detail_code = V_DETAIL_CODE;
      END IF;
	END LOOP;
	CLOSE DETAIL_CUR;
   EXCEPTION
   WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '표준관리비복사 실패! [Line No: 159]' || c_no || '=' || c_spec_no || '=' || c_seq;
           Wk_errflag := -20020;
           GOTO EXIT_ROUTINE;
        END IF;   
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
END y_sp_y_projmng_convert;
