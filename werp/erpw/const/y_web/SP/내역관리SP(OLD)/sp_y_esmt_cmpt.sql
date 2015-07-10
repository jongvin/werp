/* ============================================================================= */
/* �Լ��� : sp_y_esmt_cmpt                                                       */
/* ��  �� : �������� �Է½� ������ �����Ѵ�.                                   */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_receive_code (string)                  */
/*        : ����                   ==> ai_no           (integer)                 */
/*        : �����ڵ�               ==> as_sum_code     (string)                  */
/*        : �����                 ==> as_user         (string)                  */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2001.08.22                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_esmt_cmpt(as_receive_code IN   VARCHAR2,
                                           ai_no           IN   INTEGER,
                                           as_sum_code     IN   VARCHAR2,
                                           as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   C_PARENT_SUM_CODE   Y_ESMT_SUMMARY.PARENT_SUM_CODE%TYPE;    -- �����ڵ�
   C_QTY               Y_ESMT_SUMMARY.QTY%TYPE;                -- ����
   C_AMT               Y_ESMT_SUMMARY.AMT%TYPE;                -- �ݾ�
   C_MAT_AMT           Y_ESMT_SUMMARY.MAT_AMT%TYPE;            -- �����
   C_LAB_AMT           Y_ESMT_SUMMARY.LAB_AMT%TYPE;            -- �빫��
   C_EXP_AMT           Y_ESMT_SUMMARY.EXP_AMT%TYPE;            -- ���
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      SELECT NVL(SUM(AMT),0),NVL(SUM(MAT_AMT),0),NVL(SUM(LAB_AMT),0),NVL(SUM(EXP_AMT),0)
        INTO C_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT
        FROM Y_ESMT_DETAIL
       WHERE receive_code = as_receive_code  AND
             no           = ai_no AND
             sum_code     = as_sum_code;

      UPDATE Y_ESMT_SUMMARY
         SET AMT         = NVL(C_AMT,0),
             MAT_AMT     = NVL(C_MAT_AMT,0),
             LAB_AMT     = NVL(C_LAB_AMT,0),
             EXP_AMT     = NVL(C_EXP_AMT,0)
       WHERE receive_code = as_receive_code  AND
             no           = ai_no AND
             sum_code     = as_sum_code;
 
   C_PARENT_SUM_CODE := as_sum_code;	
   SELECT LLEVEL,PARENT_SUM_CODE
     INTO C_LEVEL,C_PARENT_SUM_CODE
     FROM Y_ESMT_SUMMARY
    WHERE receive_code = as_receive_code  AND
          no           = ai_no AND
          sum_code     = C_PARENT_SUM_CODE;
   IF C_LEVEL <> 1 THEN
   	LOOP
         SELECT NVL(SUM(AMT),0),NVL(SUM(MAT_AMT),0),NVL(SUM(LAB_AMT),0),NVL(SUM(EXP_AMT),0)
           INTO C_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT
           FROM Y_ESMT_SUMMARY
          WHERE receive_code    = as_receive_code  AND
                no              = ai_no AND
                parent_sum_code = C_PARENT_SUM_CODE;


         UPDATE Y_ESMT_SUMMARY
            SET AMT         = NVL(C_AMT,0),
                MAT_AMT     = NVL(C_MAT_AMT,0),
                LAB_AMT     = NVL(C_LAB_AMT,0),
                EXP_AMT     = NVL(C_EXP_AMT,0)
          WHERE receive_code = as_receive_code  AND
                no           = ai_no AND
                sum_code     = C_PARENT_SUM_CODE;


         SELECT LLEVEL,PARENT_SUM_CODE
           INTO C_LEVEL,C_PARENT_SUM_CODE
           FROM Y_ESMT_SUMMARY
          WHERE receive_code = as_receive_code  AND
                no           = ai_no AND
                sum_code     = C_PARENT_SUM_CODE;
         IF C_LEVEL = 1 THEN
            EXIT;
         END IF;

  	   END LOOP;
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
END sp_y_esmt_cmpt;

/
