/* ============================================================================= */
/* �Լ��� : sp_y_bom_process                                                     */
/* ��  �� : EMS�ڷ� ��ȯ(EMS -> ���೻��) .                                      */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_proj_code (string)                     */
/*        : �κ�                   ==> as_part      (string)                     */
/*        : ��ȣ                   ==> ai_degree    (string)                     */
/*        : EMS�ܰ�����            ==> as_class     (string)                     */
/*        : ���޴ܰ�����           ==> as_cnt       (string)                     */
/*        : ����ܰ�����           ==> as_exe       (string)                     */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2001.08.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_bom_process(as_proj_code    IN   VARCHAR2,
                                             as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
  CURSOR DETAIL_CUR IS
  SELECT max(mat_code),sum(nvl(qty,0)),sum(nvl(mat_amt,0))
    FROM y_budget_detail
   WHERE proj_code = as_proj_code
     AND mat_code IS NOT NULL
     AND mat_amt <> 0
GROUP BY mat_code
ORDER BY mat_code asc;

-- ���� ���� 
   V_MAT_CODE          Y_BUDGET_DETAIL.MAT_CODE%TYPE;
   V_QTY               Y_BUDGET_DETAIL.QTY%TYPE;
   V_AMT               Y_BUDGET_DETAIL.MAT_AMT%TYPE;
   C_DITAG             M_CODE_MATERIAL.DITAG%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_CNT           NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN

 BEGIN
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_MAT_CODE,V_QTY,V_AMT;
		EXIT WHEN DETAIL_CUR%NOTFOUND;

      SELECT COUNT(*)
        INTO C_SEQ
        FROM M_CODE_MATERIAL
       WHERE MTRCODE = V_MAT_CODE;

      IF C_SEQ > 0 THEN
         SELECT DITAG
           INTO C_DITAG
           FROM M_CODE_MATERIAL
          WHERE MTRCODE = V_MAT_CODE;

         SELECT COUNT(*)
           INTO C_CNT
           FROM M_PLAN
          WHERE PROJ_CODE = as_proj_code
            AND MTRCODE   = V_MAT_CODE;

         IF C_CNT > 0 THEN
            UPDATE M_PLAN
               SET BD_QTY = V_QTY,
                   BD_AMT = V_AMT
             WHERE PROJ_CODE = as_proj_code
               AND MTRCODE   = V_MAT_CODE
               AND DITAG     = C_DITAG;
         ELSE
            INSERT INTO M_PLAN  
                 VALUES ( as_proj_code,V_MAT_CODE,C_DITAG,V_QTY,V_AMT ) ;   
         END IF;
      END IF;
	END LOOP;
	CLOSE DETAIL_CUR;

        
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'BOM �ڷ����� ����! [Line No: 159]';
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
END sp_y_bom_process;

/
