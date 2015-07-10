/* ============================================================================= */
/* 함수명 : sp_y_esmt_projmng_spec_convert                                       */
/* 기  능 : 현장별현장관리비내역을 실행내역으로적용한다 화일로 복사한다.         */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_receive_code (string)                     */
/*        : 번호                   ==> ai_no        (integer)                    */
/*        : 상위집계코드           ==> as_sum_code  (string)                     */
/*        : 사용자                 ==> as_user      (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2001.09.11                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_esmt_projmng_spec_convert(as_receive_code IN   VARCHAR2,
                                                           ai_no           IN   INTEGER,
                                                           ai_seq          IN   INTEGER,
                                                           as_sum_code     IN   VARCHAR2,
                                                           as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR PARENT_CUR IS
SELECT A.receive_code,
       A.WBS_CODE,
       A.NAME,
       A.NOTE
  FROM Y_ESMT_PROJMNG_AMT_WBS A
 WHERE A.receive_code = as_receive_code
ORDER BY A.WBS_CODE ASC;

CURSOR DETAIL_CUR IS
SELECT A.receive_code,
       A.WBS_CODE,
       A.RES_CLASS_CODE,
       A.DETAIL_CODE,
       A.NAME,
       A.SSIZE,
       A.UNIT,
       A.QTY,
       A.PRICE,
       A.AMT,
       A.REMARK
  FROM Y_ESMT_PROJMNG_AMT A
 WHERE A.receive_code    = as_receive_code
   AND ( A.AMT          <> 0
    OR   A.SPEC_UNQ_NUM <> 0 )
ORDER BY A.WBS_CODE ASC,
         A.DETAIL_CODE ASC;

-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   V_receive_code      Y_ESMT_PROJMNG_AMT_WBS.receive_code%TYPE;
   V_WBS_CODE          Y_ESMT_PROJMNG_AMT_WBS.WBS_CODE%TYPE;
   V_NAME              Y_ESMT_PROJMNG_AMT_WBS.NAME%TYPE;
   V_NOTE              Y_ESMT_PROJMNG_AMT_WBS.NOTE%TYPE;
   V_RES_CLASS_CODE    Y_ESMT_PROJMNG_AMT.RES_CLASS_CODE%TYPE;
   V_DETAIL_CODE       Y_ESMT_PROJMNG_AMT.DETAIL_CODE%TYPE;
   V_SSIZE             Y_ESMT_PROJMNG_AMT.SSIZE%TYPE;
   V_UNIT              Y_ESMT_PROJMNG_AMT.UNIT%TYPE;
   V_QTY               Y_ESMT_PROJMNG_AMT.QTY%TYPE;
   V_PRICE             Y_ESMT_PROJMNG_AMT.PRICE%TYPE;
   V_AMT               Y_ESMT_PROJMNG_AMT.AMT%TYPE;
   V_REMARK            Y_ESMT_PROJMNG_AMT.REMARK%TYPE;

   C_CNT               NUMBER(20,5);  -- 
   C_SEQ               NUMBER(20,5);  -- 
   C_NO                NUMBER(18);  -- 
   C_LEVEL             NUMBER(20,5);  -- 
   C_MAX               VARCHAR2(20);
   C_SUM_CODE          VARCHAR2(20);
   C_CHK               VARCHAR2(1);
   C_INVEST            VARCHAR2(1);
   C_DETAIL            VARCHAR2(1);
   
BEGIN

 BEGIN
-- 현장관리비요청의 Setting 및 실행집계구조의 초기화. 
   SELECT process_yn
     INTO C_CHK
     FROM y_esmt_projmng_request
    WHERE receive_code = as_receive_code;

   IF C_CHK <> 'Y' THEN
      UPDATE y_esmt_projmng_request
         SET sum_code = as_sum_code,
             approve_class = '4',
             process_yn   = 'Y'
       WHERE receive_code = as_receive_code;
   END IF;

   EXCEPTION
   WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '현장관리비요청입력실패! [Line No: 159]';
           Wk_errflag := -20020;
         
           GOTO EXIT_ROUTINE;
        END IF;   
 END;
 BEGIN

   SELECT COUNT(*)
     INTO C_CNT
     FROM y_esmt_projmng_amt_wbs
    WHERE receive_code = as_receive_code;

   IF C_CNT > 0 THEN
      BEGIN
      INSERT INTO y_esmt_summary  
           VALUES ( as_receive_code,ai_no,as_sum_code,'2','','Z',
                    ai_seq,1,'00','N','Y','현장관리비','','',
                    0,0,0,0,0,'','','','','','',sysdate,as_user  );
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
--              e_msg      := '집계상위공종입력실패! [Line No: 159]';
--              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
      END;
   ELSE
      GOTO EXIT_ROUTINE;
   END IF;

   C_LEVEL := LENGTH(as_sum_code) / 2 + 1;

	OPEN	PARENT_CUR;
	LOOP
		FETCH PARENT_CUR INTO V_receive_code,V_WBS_CODE,V_NAME,V_NOTE;
		EXIT WHEN PARENT_CUR%NOTFOUND;

      C_SUM_CODE := as_sum_code || SUBSTR(V_WBS_CODE,2,2);
      C_SEQ      := TO_NUMBER(SUBSTR(V_WBS_CODE,2,2));

      SELECT COUNT(*)
        INTO C_CNT
        FROM y_esmt_projmng_amt
       WHERE receive_code = as_receive_code
         AND wbs_code     = V_WBS_CODE
         AND ( amt          <> 0 
          OR   spec_unq_num <> 0);

      IF C_CNT > 0 THEN
         INSERT INTO y_esmt_summary  
  	           VALUES ( as_receive_code,ai_no,C_SUM_CODE,'2','',V_WBS_CODE,
                       C_SEQ,C_LEVEL,as_sum_code,'Y','Y',V_NAME,'','',
                       0,0,0,0,0,V_NOTE,'','','','','',sysdate,as_user  );

         UPDATE y_esmt_projmng_amt_wbs
            SET sum_code = C_SUM_CODE
          WHERE receive_code = as_receive_code
            AND wbs_code     = V_WBS_CODE;
      END IF;

	END LOOP;
	CLOSE PARENT_CUR;

   EXCEPTION
   WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '현장관리비공종입력실패! [Line No: 159]';
           Wk_errflag := -20020;
         
           GOTO EXIT_ROUTINE;
        END IF;   
 END;

 BEGIN

   C_SEQ := 0;

  	OPEN	DETAIL_CUR;
  	LOOP
   	FETCH DETAIL_CUR INTO V_receive_code,V_WBS_CODE,V_RES_CLASS_CODE,V_DETAIL_CODE,
                            V_NAME,V_SSIZE,V_UNIT,V_QTY,V_PRICE,V_AMT,V_REMARK;
 		EXIT WHEN DETAIL_CUR%NOTFOUND;

      C_SUM_CODE := as_sum_code || SUBSTR(V_WBS_CODE,2,2);

      SELECT NVL(MAX(seq),0)
        INTO C_SEQ
        FROM y_esmt_detail
       WHERE receive_code = as_receive_code
         AND no           = ai_no
         AND sum_code     = C_SUM_CODE;

      C_SEQ      := C_SEQ + 1;

      SELECT COUNT(*)
        INTO C_CNT
        FROM y_esmt_projmng_amt_wbs
       WHERE receive_code = as_receive_code
         AND wbs_code     = V_WBS_CODE;
      IF C_CNT > 0 THEN
         SELECT COUNT(*)
           INTO C_CNT
           FROM y_esmt_detail
          WHERE receive_code = as_receive_code
            AND no        = ai_no
            AND sum_code = C_SUM_CODE
            AND detail_code = V_DETAIL_CODE;
         IF C_CNT < 1 THEN
	        	SELECT y_spec_unq_num.nextval
   	    	  INTO C_NO
      	 	  FROM dual;

	         INSERT INTO y_esmt_detail
   	           VALUES ( as_receive_code,ai_no,C_SUM_CODE,C_NO,V_DETAIL_CODE,'Z',
      	                 C_SEQ,'',V_WBS_CODE,'',V_NAME,V_SSIZE,V_UNIT,
         	              V_QTY,V_PRICE,V_AMT,0,0,0,0,V_PRICE,V_AMT,
            	           V_REMARK,'','','','','',sysdate,as_user);
         ELSE
            UPDATE y_esmt_detail
              SET QTY       = V_QTY,
                  price     = V_PRICE,
                  amt       = V_AMT,
                  exp_price = V_PRICE,
                  exp_amt   = V_AMT,
                  note      = V_REMARK
            WHERE receive_code = as_receive_code
              AND no        = ai_no
              AND sum_code = C_SUM_CODE
              AND detail_code = V_DETAIL_CODE;
         END IF;         

         UPDATE y_esmt_projmng_amt
            SET spec_unq_num = C_NO
          WHERE receive_code   = as_receive_code
            AND wbs_code       = V_WBS_CODE
            AND res_class_code = V_RES_CLASS_CODE
            AND detail_code    = V_DETAIL_CODE;

      END IF;
  	END LOOP;
  	CLOSE DETAIL_CUR;

   EXCEPTION
   WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '표준관리비복사 실패! [Line No: 159]';
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
END sp_y_esmt_projmng_spec_convert;

/
