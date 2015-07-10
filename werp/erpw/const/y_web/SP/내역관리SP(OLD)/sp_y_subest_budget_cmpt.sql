/* ============================================================================= */
/* �Լ��� : sp_y_subest_budget_cmpt                                              */
/* ��  �� : ���ְ����ݾ������� �Է½� ������ �����Ѵ�.                         */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_proj_code (string)                     */
/*        : ��ȣ                   ==> ai_no        (Integer)                    */
/*        : ������ȣ               ==> ai_estimate_no(Integer)                   */
/*        : ����ڹ�ȣ             ==> as_custcode  (string)                     */
/*        : �����ڵ�               ==> as_sum_code  (string)                     */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2001.08.22                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_subest_budget_cmpt(as_proj_code    IN   VARCHAR2,
                                                    ai_no           IN   INTEGER,
                                                    ai_estimate_no  IN   INTEGER,
                                                    as_custcode     IN   VARCHAR2,
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
   C_PARENT_SUM_CODE   Y_SUB_BUDGET_SUMMARY.PARENT_SUM_CODE%TYPE;    -- �����ڵ�
   C_QTY               Y_SUBEST_BUDGET_DETAIL.QTY%TYPE;                -- ����
   C_AMT               Y_SUBEST_BUDGET_DETAIL.AMT%TYPE;                -- �ݾ�
   C_MAT_AMT           Y_SUBEST_BUDGET_DETAIL.MAT_AMT%TYPE;            -- �����
   C_LAB_AMT           Y_SUBEST_BUDGET_DETAIL.LAB_AMT%TYPE;            -- �빫��
   C_EXP_AMT           Y_SUBEST_BUDGET_DETAIL.EXP_AMT%TYPE;            -- ���
   C_EQU_AMT           Y_SUBEST_BUDGET_DETAIL.EQU_AMT%TYPE;            -- �߱��
   C_SUB_AMT           Y_SUBEST_BUDGET_DETAIL.SUB_AMT%TYPE;            -- ���ֺ�
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      SELECT NVL(SUM(CTRL_AMT),0),NVL(SUM(CTRL_MAT_AMT),0),NVL(SUM(CTRL_LAB_AMT),0),
             NVL(SUM(CTRL_EXP_AMT),0),NVL(SUM(CTRL_EQU_AMT),0),NVL(SUM(CTRL_SUB_AMT),0)
        INTO C_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT,C_EQU_AMT,C_SUB_AMT
        FROM Y_SUBEST_BUDGET_DETAIL
       WHERE proj_code   = as_proj_code   AND
             no          = ai_no          AND
             estimate_no = ai_estimate_no AND
             custcode    = as_custcode    AND
             sum_code  = as_sum_code;

      UPDATE Y_SUBEST_BUDGET_SUMMARY
         SET CTRL_AMT     = NVL(C_AMT,0),
             CTRL_MAT_AMT = NVL(C_MAT_AMT,0),
             CTRL_LAB_AMT = NVL(C_LAB_AMT,0),
             CTRL_EXP_AMT = NVL(C_EXP_AMT,0),
             CTRL_EQU_AMT = NVL(C_EQU_AMT,0),
             CTRL_SUB_AMT = NVL(C_SUB_AMT,0)
       WHERE proj_code   = as_proj_code   AND
             no          = ai_no          AND
             estimate_no = ai_estimate_no AND
             custcode    = as_custcode    AND
             sum_code    = as_sum_code;
 
   C_PARENT_SUM_CODE := as_sum_code;	
   SELECT LLEVEL,PARENT_SUM_CODE
     INTO C_LEVEL,C_PARENT_SUM_CODE
     FROM Y_SUB_BUDGET_SUMMARY
    WHERE proj_code   = as_proj_code  AND
          no          = ai_no         AND
          estimate_no = ai_estimate_no AND
          sum_code    = C_PARENT_SUM_CODE;
   IF C_LEVEL <> 1 THEN
   	LOOP
         SELECT NVL(SUM(a.CTRL_AMT),0),NVL(SUM(a.CTRL_MAT_AMT),0),NVL(SUM(a.CTRL_LAB_AMT),0),
                NVL(SUM(a.CTRL_EXP_AMT),0),NVL(SUM(a.CTRL_EQU_AMT),0),NVL(SUM(a.CTRL_SUB_AMT),0)
           INTO C_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT,C_EQU_AMT,C_SUB_AMT
           FROM Y_SUBEST_BUDGET_SUMMARY a,
                Y_SUB_BUDGET_SUMMARY b
          WHERE b.proj_code       = a.proj_code    AND
                b.no              = a.no           AND
                b.estimate_no     = a.estimate_no  AND
                b.sum_code        = a.sum_code     AND
                a.custcode        = as_custcode    AND
                b.proj_code       = as_proj_code   AND
                b.no              = ai_no          AND
                b.estimate_no     = ai_estimate_no AND
                b.parent_sum_code = C_PARENT_SUM_CODE;


         UPDATE Y_SUBEST_BUDGET_SUMMARY
            SET CTRL_AMT     = NVL(C_AMT,0),
                CTRL_MAT_AMT = NVL(C_MAT_AMT,0),
                CTRL_LAB_AMT = NVL(C_LAB_AMT,0),
                CTRL_EXP_AMT = NVL(C_EXP_AMT,0),
                CTRL_EQU_AMT = NVL(C_EQU_AMT,0),
                CTRL_SUB_AMT = NVL(C_SUB_AMT,0)
          WHERE proj_code       = as_proj_code   AND
                no              = ai_no          AND
                estimate_no     = ai_estimate_no AND
                custcode        = as_custcode    AND
                sum_code = C_PARENT_SUM_CODE;


         SELECT LLEVEL,PARENT_SUM_CODE
           INTO C_LEVEL,C_PARENT_SUM_CODE
           FROM Y_SUB_BUDGET_SUMMARY
          WHERE proj_code       = as_proj_code   AND
                no              = ai_no          AND
                estimate_no     = ai_estimate_no AND
                sum_code = C_PARENT_SUM_CODE;
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
END sp_y_subest_budget_cmpt;

/
