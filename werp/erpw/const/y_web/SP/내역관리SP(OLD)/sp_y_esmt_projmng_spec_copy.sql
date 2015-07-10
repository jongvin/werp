/* ============================================================================= */
/* �Լ��� : sp_y_esmt_projmng_spec_copy                                          */
/* ��  �� : ����������������� ���庰���������ȭ�Ϸ� �����Ѵ�.                */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_receive_code (string)                     */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2001.09.11                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_esmt_projmng_spec_copy(as_receive_code IN   VARCHAR2,
                                                        as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR PARENT_CUR IS
SELECT A.WBS_CODE,
       A.NAME,
       A.NOTE,
       A.ACNTCODE
  FROM Y_PROJMNG_BASIC_WBS A
ORDER BY A.WBS_CODE ASC;

CURSOR DETAIL_CUR IS
SELECT A.WBS_CODE,
       A.RES_CLASS_CODE,
       A.DETAIL_CODE,
       A.NAME,
       A.SSIZE,
       A.UNIT,
       A.PRICE,
       A.REMARK,
       A.ACNTCODE
  FROM Y_PROJMNG_BASIC A
ORDER BY A.WBS_CODE ASC,
         A.DETAIL_CODE ASC;



-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   V_WBS_CODE          Y_PROJMNG_BASIC_WBS.WBS_CODE%TYPE;
   V_NAME              Y_PROJMNG_BASIC_WBS.NAME%TYPE;
   V_NOTE              Y_PROJMNG_BASIC_WBS.NOTE%TYPE;
   V_RES_CLASS_CODE    Y_PROJMNG_BASIC.RES_CLASS_CODE%TYPE;
   V_DETAIL_CODE       Y_PROJMNG_BASIC.DETAIL_CODE%TYPE;
   V_SSIZE             Y_PROJMNG_BASIC.SSIZE%TYPE;
   V_UNIT              Y_PROJMNG_BASIC.UNIT%TYPE;
   V_PRICE             Y_PROJMNG_BASIC.PRICE%TYPE;
   V_REMARK            Y_PROJMNG_BASIC.REMARK%TYPE;
   V_ACNTCODE          Y_PROJMNG_BASIC.ACNTCODE%TYPE;

   C_CNT               NUMBER(20,5);  -- 

BEGIN

 BEGIN
-- ����������������� ���庰 ���������� �����Ѵ�. 
   SELECT COUNT(*)
     INTO C_CNT
     FROM y_esmt_projmng_request
    WHERE receive_code = as_receive_code;

   IF C_CNT < 1 THEN
      INSERT INTO y_esmt_projmng_request  
           VALUES ( as_receive_code,sysdate,'1',null,'N',null,sysdate,as_user )  ;
   END IF;

   EXCEPTION
   WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '����������û�Է½���! [Line No: 159]';
           Wk_errflag := -20020;
         
           GOTO EXIT_ROUTINE;
        END IF;   
 END;
 BEGIN
	OPEN	PARENT_CUR;
	LOOP
		FETCH PARENT_CUR INTO V_WBS_CODE,V_NAME,V_NOTE,V_ACNTCODE;
		EXIT WHEN PARENT_CUR%NOTFOUND;

      SELECT COUNT(*)
        INTO C_CNT
        FROM y_esmt_projmng_amt_wbs
       WHERE receive_code = as_receive_code
         AND wbs_code     = V_WBS_CODE;

      IF C_CNT < 1 THEN
	      INSERT INTO y_esmt_projmng_amt_wbs  
   	        VALUES ( as_receive_code,V_WBS_CODE,'',V_NAME,V_NOTE,
                       V_ACNTCODE,sysdate,as_user  );
      END IF;

	END LOOP;
	CLOSE PARENT_CUR;

   EXCEPTION
   WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '�������������Է½���! [Line No: 159]';
           Wk_errflag := -20020;
         
           GOTO EXIT_ROUTINE;
        END IF;   
 END;
 BEGIN
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_WBS_CODE,V_RES_CLASS_CODE,V_DETAIL_CODE,V_NAME,
                            V_SSIZE,V_UNIT,V_PRICE,V_REMARK,V_ACNTCODE;
		EXIT WHEN DETAIL_CUR%NOTFOUND;

      SELECT COUNT(*)
        INTO C_CNT
        FROM y_esmt_projmng_amt
       WHERE receive_code   = as_receive_code
         AND wbs_code       = V_WBS_CODE
         AND res_class_code = V_RES_CLASS_CODE
         AND detail_code    = V_DETAIL_CODE;

      IF C_CNT < 1 THEN
         INSERT INTO y_esmt_projmng_amt  
              VALUES ( as_receive_code,V_WBS_CODE,V_RES_CLASS_CODE,V_DETAIL_CODE,0,
                       V_NAME,V_SSIZE,V_UNIT,1,1,1,1,V_PRICE,V_PRICE,V_ACNTCODE,
                       V_REMARK,sysdate,as_user );
      END IF;

	END LOOP;
	CLOSE DETAIL_CUR;

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'ǥ�ذ����񺹻� ����! [Line No: 159]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
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
END sp_y_esmt_projmng_spec_copy;

/
