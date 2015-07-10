/* ============================================================================= */
/* �Լ��� : sp_y_esmt_tot_cmpt                                                   */
/* ��  �� : ���ְ����ݾ�Ȯ���� ���������� ������ �����Ѵ�.(��ü�ϰ�)           */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_receive_code (string)                  */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2001.09.04                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_esmt_tot_cmpt(as_receive_code    IN   VARCHAR2,
                                               ai_no              IN   INTEGER,
                                               as_user            IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT A.SUM_CODE
  FROM Y_ESMT_SUMMARY A
 WHERE A.RECEIVE_CODE = as_receive_code AND
       A.NO           = ai_no AND
       A.INVEST_CLASS = 'Y' ;

-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   V_SUM_CODE          Y_ESMT_SUMMARY.SUM_CODE%TYPE;
   C_PARENT_SUM_CODE   Y_ESMT_SUMMARY.PARENT_SUM_CODE%TYPE;    -- �����ڵ�
   C_QTY               Y_ESMT_DETAIL.QTY%TYPE;                -- ����
   C_AMT               Y_ESMT_DETAIL.AMT%TYPE;                -- �ݾ�
   C_MAT_AMT           Y_ESMT_DETAIL.MAT_AMT%TYPE;            -- �����
   C_LAB_AMT           Y_ESMT_DETAIL.LAB_AMT%TYPE;            -- �빫��
   C_EXP_AMT           Y_ESMT_DETAIL.EXP_AMT%TYPE;            -- ���
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_SUM_CODE;
		EXIT WHEN DETAIL_CUR%NOTFOUND;

      SELECT NVL(SUM(AMT),0),NVL(SUM(MAT_AMT),0),NVL(SUM(LAB_AMT),0),
             NVL(SUM(EXP_AMT),0)
        INTO C_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT
        FROM Y_ESMT_DETAIL
       WHERE receive_code = as_receive_code   AND
             no           = ai_no AND
             sum_code     = V_SUM_CODE;

      UPDATE Y_ESMT_SUMMARY
         SET AMT          = NVL(C_AMT,0),
             MAT_AMT      = NVL(C_MAT_AMT,0),
             LAB_AMT      = NVL(C_LAB_AMT,0),
             EXP_AMT      = NVL(C_EXP_AMT,0)
       WHERE receive_code = as_receive_code   AND
             no           = ai_no AND
             sum_code     = V_SUM_CODE;
 
   C_PARENT_SUM_CODE := V_SUM_CODE;	

   SELECT LLEVEL,PARENT_SUM_CODE
     INTO C_LEVEL,C_PARENT_SUM_CODE
     FROM Y_ESMT_SUMMARY
    WHERE receive_code = as_receive_code  AND
          no           = ai_no AND
          sum_code     = C_PARENT_SUM_CODE;

   IF C_LEVEL <> 1 THEN
   	LOOP
         SELECT NVL(SUM(a.AMT),0),NVL(SUM(a.MAT_AMT),0),NVL(SUM(a.LAB_AMT),0),
                NVL(SUM(a.EXP_AMT),0)
           INTO C_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT
           FROM Y_ESMT_SUMMARY a
          WHERE a.receive_code    = as_receive_code   AND
                a.no              = ai_no AND
                a.parent_sum_code = C_PARENT_SUM_CODE;


         UPDATE Y_ESMT_SUMMARY
            SET AMT          = NVL(C_AMT,0),
                MAT_AMT      = NVL(C_MAT_AMT,0),
                LAB_AMT      = NVL(C_LAB_AMT,0),
                EXP_AMT      = NVL(C_EXP_AMT,0)
          WHERE receive_code = as_receive_code   AND
                no           = ai_no AND
                sum_code = C_PARENT_SUM_CODE;

         SELECT LLEVEL,PARENT_SUM_CODE
           INTO C_LEVEL,C_PARENT_SUM_CODE
           FROM Y_ESMT_SUMMARY
          WHERE receive_code = as_receive_code   AND
                no           = ai_no AND
                sum_code = C_PARENT_SUM_CODE;
         IF C_LEVEL = 1 THEN
            EXIT;
         END IF;

  	   END LOOP;
    END IF;
	END LOOP;
	CLOSE DETAIL_CUR;

   SELECT NVL(SUM(a.AMT),0),NVL(SUM(a.MAT_AMT),0),NVL(SUM(a.LAB_AMT),0),
          NVL(SUM(a.EXP_AMT),0)
     INTO C_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT
     FROM Y_ESMT_SUMMARY a
    WHERE a.receive_code    = as_receive_code   AND
          a.no              = ai_no AND
          a.llevel = 1;

    UPDATE Y_ESMT_DEGREE
       SET amt     = C_AMT,
           mat_amt = C_MAT_AMT,
           lab_amt = C_LAB_AMT,
           exp_amt = C_EXP_AMT
     WHERE receive_code = as_receive_code   AND
           no           = ai_no;
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
END sp_y_esmt_tot_cmpt;

/
