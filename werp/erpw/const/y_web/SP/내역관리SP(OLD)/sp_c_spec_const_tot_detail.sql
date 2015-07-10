/* ============================================================================= */
/* �Լ��� : sp_c_spec_const_tot_detaiil                                             */
/* ��  �� : ���豸��_������������� ����(���豸��_��������)�� �����Ѵ�.(��ü�ϰ�)       */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_proj_code (string)                     */
/*        : ����                   ==> adt_yymm        (date)                    */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : ���翵																					*/
/* �ۼ��� : 2001.12.04                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_c_spec_const_tot_detaiil
(as_proj_code    IN   VARCHAR2,
 adt_yymm        IN   DATE ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT A.SUM_CODE
  FROM 
	(	
	SELECT B.PROJ_CODE, B.SUM_CODE, A.INVEST_CLASS, B.YYMM 
		FROM Y_BUDGET_SUMMARY A,
			C_SPEC_CONST_TOT B
		WHERE A.PROJ_CODE = B.PROJ_CODE
			AND A.SUM_CODE = B.SUM_CODE
			AND B.YYMM = adt_yymm 
	) A
 WHERE A.PROJ_CODE    = as_proj_code AND
		 A.YYMM          = adt_yymm         AND
       A.INVEST_CLASS = 'Y' ;

-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   V_SUM_CODE          Y_BUDGET_SUMMARY.SUM_CODE%TYPE;
   C_PARENT_SUM_CODE   Y_BUDGET_SUMMARY.PARENT_SUM_CODE%TYPE;    -- �����ڵ�
   C_QTY               Y_BUDGET_DETAIL.QTY%TYPE;                -- ����
   C_AMT               Y_BUDGET_DETAIL.AMT%TYPE;                -- �ݾ�
   C_CNT_AMT           Y_BUDGET_DETAIL.CNT_AMT%TYPE;            -- �ݾ�
   C_CNT_MAT_AMT       Y_BUDGET_DETAIL.CNT_MAT_AMT%TYPE;        -- ���������
   C_CNT_LAB_AMT       Y_BUDGET_DETAIL.CNT_LAB_AMT%TYPE;        -- ���޳빫��
   C_CNT_SUB_AMT       Y_BUDGET_DETAIL.SUB_AMT%TYPE;            -- ���޿��ֺ�
   C_CNT_EXP_AMT       Y_BUDGET_DETAIL.CNT_EXP_AMT%TYPE;        -- ���ް��
   C_CNT_EQU_AMT       Y_BUDGET_DETAIL.CNT_EXP_AMT%TYPE;        -- �������
   C_MAT_AMT           Y_BUDGET_DETAIL.MAT_AMT%TYPE;            -- �����
   C_LAB_AMT           Y_BUDGET_DETAIL.LAB_AMT%TYPE;            -- �빫��
   C_EXP_AMT           Y_BUDGET_DETAIL.EXP_AMT%TYPE;            -- ���
   C_EQU_AMT           Y_BUDGET_DETAIL.EQU_AMT%TYPE;            -- �߱��
   C_SUB_AMT           Y_BUDGET_DETAIL.SUB_AMT%TYPE;            -- ���ֺ�
   C_COST_AMT           C_SPEC_CONST_TOT.COST_AMT%TYPE;            -- �����ݾ�
   C_COST_MAT_AMT       C_SPEC_CONST_TOT.COST_MAT_AMT%TYPE;        -- ���������
   C_COST_LAB_AMT       C_SPEC_CONST_TOT.COST_LAB_AMT%TYPE;        -- �����빫��
   C_COST_SUB_AMT       C_SPEC_CONST_TOT.COST_SUB_AMT%TYPE;            -- �������ֺ�
   C_COST_EXP_AMT       C_SPEC_CONST_TOT.COST_EXP_AMT%TYPE;        -- �������
   C_COST_EQU_AMT       C_SPEC_CONST_TOT.COST_EQU_AMT%TYPE;        -- �������
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_SUM_CODE;
		EXIT WHEN DETAIL_CUR%NOTFOUND;

      SELECT NVL(SUM(RESULT_AMT),0),NVL(SUM(RESULT_MAT_AMT),0),NVL(SUM(RESULT_LAB_AMT),0),
             NVL(SUM(RESULT_EXP_AMT),0),NVL(SUM(RESULT_EQU_AMT),0),NVL(SUM(RESULT_SUB_AMT),0),
			 NVL(SUM(CNT_RESULT_AMT),0),NVL(SUM(CNT_RESULT_MAT_AMT),0),NVL(SUM(CNT_RESULT_LAB_AMT),0),
			 NVL(SUM(CNT_RESULT_EXP_AMT),0),NVL(SUM(CNT_RESULT_SUB_AMT),0),NVL(SUM(CNT_RESULT_EQU_AMT),0), 
			 NVL(SUM(COST_AMT),0),NVL(SUM(COST_MAT_AMT),0),NVL(SUM(COST_LAB_AMT),0),
			 NVL(SUM(COST_EXP_AMT),0),NVL(SUM(COST_EQU_AMT),0), NVL(SUM(COST_SUB_AMT),0)
        INTO C_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT,C_EQU_AMT,C_SUB_AMT,
             C_CNT_AMT,C_CNT_MAT_AMT,C_CNT_LAB_AMT,C_CNT_EXP_AMT,C_CNT_SUB_AMT,C_CNT_EQU_AMT,
			 C_COST_AMT,C_COST_MAT_AMT,C_COST_LAB_AMT,C_COST_EXP_AMT,C_COST_EQU_AMT,C_COST_SUB_AMT
        FROM C_SPEC_CONST_DETAIL
       WHERE proj_code   = as_proj_code   AND
             yymm          = TO_DATE(adt_yymm)          AND
             sum_code  = V_SUM_CODE;

      UPDATE C_SPEC_CONST_TOT
         SET RESULT_AMT          = NVL(C_AMT,0),
             CNT_RESULT_AMT      = NVL(C_CNT_AMT,0),
             CNT_RESULT_MAT_AMT  = NVL(C_CNT_MAT_AMT,0),
             CNT_RESULT_LAB_AMT  = NVL(C_CNT_LAB_AMT,0),
             CNT_RESULT_EXP_AMT  = NVL(C_CNT_EXP_AMT,0),
             CNT_RESULT_SUB_AMT  = NVL(C_CNT_SUB_AMT,0),
             CNT_RESULT_EQU_AMT  = NVL(C_CNT_EQU_AMT,0),
             RESULT_MAT_AMT      = NVL(C_MAT_AMT,0),
             RESULT_LAB_AMT      = NVL(C_LAB_AMT,0),
             RESULT_EXP_AMT      = NVL(C_EXP_AMT,0),
             RESULT_EQU_AMT      = NVL(C_EQU_AMT,0),
             RESULT_SUB_AMT      = NVL(C_SUB_AMT,0),
             COST_AMT      = NVL(C_COST_AMT,0),
			 COST_MAT_AMT      = NVL(C_COST_MAT_AMT,0),
             COST_LAB_AMT      = NVL(C_COST_LAB_AMT,0),
             COST_EXP_AMT      = NVL(C_COST_EXP_AMT,0),
             COST_EQU_AMT      = NVL(C_COST_EQU_AMT,0),
             COST_SUB_AMT      = NVL(C_COST_SUB_AMT,0)
       WHERE proj_code   = as_proj_code   AND
             yymm          = TO_DATE(adt_yymm)     AND
             sum_code    = V_SUM_CODE;
 
   C_PARENT_SUM_CODE := V_SUM_CODE;	
   SELECT A.LLEVEL,A.PARENT_SUM_CODE
     INTO C_LEVEL,C_PARENT_SUM_CODE
     FROM 	
			(	
			SELECT B.PROJ_CODE, B.SUM_CODE, A.PARENT_SUM_CODE, A.LLEVEL, B.YYMM
				FROM Y_BUDGET_SUMMARY A,
					C_SPEC_CONST_TOT B
				WHERE A.PROJ_CODE = B.PROJ_CODE
					AND A.SUM_CODE = B.SUM_CODE
					AND B.YYMM = TO_DATE(adt_yymm) 
			) A
    WHERE A.proj_code   = as_proj_code  AND
          A.YYMM          = TO_DATE(adt_yymm)         AND
          A.sum_code    = C_PARENT_SUM_CODE;
   IF C_LEVEL <> 1 THEN
   	LOOP
         SELECT NVL(SUM(a.RESULT_AMT),0),NVL(SUM(a.RESULT_MAT_AMT),0),NVL(SUM(a.RESULT_LAB_AMT),0),
                NVL(SUM(a.RESULT_EXP_AMT),0),NVL(SUM(a.RESULT_EQU_AMT),0),NVL(SUM(a.RESULT_SUB_AMT),0),
					 NVL(SUM(a.CNT_RESULT_AMT),0),NVL(SUM(a.CNT_RESULT_MAT_AMT),0),NVL(SUM(a.CNT_RESULT_LAB_AMT),0),
					 NVL(SUM(a.CNT_RESULT_EXP_AMT),0),NVL(SUM(a.CNT_RESULT_EQU_AMT),0),NVL(SUM(a.CNT_RESULT_SUB_AMT),0),
					 NVL(SUM(a.COST_AMT),0),NVL(SUM(a.COST_MAT_AMT),0),NVL(SUM(a.COST_LAB_AMT),0),
					 NVL(SUM(a.COST_EXP_AMT),0),NVL(SUM(a.COST_EQU_AMT),0),NVL(SUM(a.COST_SUB_AMT),0)	
           INTO C_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT,C_EQU_AMT,C_SUB_AMT,
                C_CNT_AMT,C_CNT_MAT_AMT,C_CNT_LAB_AMT,C_CNT_EXP_AMT,C_CNT_EQU_AMT,C_CNT_SUB_AMT,
					 C_COST_AMT,C_COST_MAT_AMT,C_COST_LAB_AMT,C_COST_EXP_AMT,C_COST_EQU_AMT,C_COST_SUB_AMT
           FROM 	
				(
				SELECT B.PROJ_CODE, B.SUM_CODE, A.PARENT_SUM_CODE, A.LLEVEL, B.YYMM,
						B.RESULT_AMT,B.RESULT_MAT_AMT,B.RESULT_LAB_AMT,B.RESULT_EXP_AMT,B.RESULT_EQU_AMT,B.RESULT_SUB_AMT,
						B.CNT_RESULT_AMT,B.CNT_RESULT_MAT_AMT,B.CNT_RESULT_LAB_AMT,
						B.CNT_RESULT_EXP_AMT,B.CNT_RESULT_EQU_AMT,B.CNT_RESULT_SUB_AMT,
						B.COST_AMT,B.COST_MAT_AMT,B.COST_LAB_AMT,
						B.COST_EXP_AMT,B.COST_EQU_AMT,B.COST_SUB_AMT
						FROM Y_BUDGET_SUMMARY A,
							C_SPEC_CONST_TOT B
						WHERE A.PROJ_CODE = B.PROJ_CODE
							AND A.SUM_CODE = B.SUM_CODE
							AND B.YYMM = TO_DATE(adt_yymm) 
				) A
          WHERE a.proj_code       = as_proj_code   AND
                a.YYMM              = TO_DATE(adt_yymm)          AND
                a.parent_sum_code = C_PARENT_SUM_CODE;


         UPDATE C_SPEC_CONST_TOT
         SET RESULT_AMT          = NVL(C_AMT,0),
             CNT_RESULT_AMT      = NVL(C_CNT_AMT,0),
             CNT_RESULT_MAT_AMT  = NVL(C_CNT_MAT_AMT,0),
             CNT_RESULT_LAB_AMT  = NVL(C_CNT_LAB_AMT,0),
             CNT_RESULT_EXP_AMT  = NVL(C_CNT_EXP_AMT,0),
             CNT_RESULT_SUB_AMT  = NVL(C_CNT_SUB_AMT,0),
             CNT_RESULT_EQU_AMT  = NVL(C_CNT_EQU_AMT,0),
             RESULT_MAT_AMT      = NVL(C_MAT_AMT,0),
             RESULT_LAB_AMT      = NVL(C_LAB_AMT,0),
             RESULT_EXP_AMT      = NVL(C_EXP_AMT,0),
             RESULT_EQU_AMT      = NVL(C_EQU_AMT,0),
             RESULT_SUB_AMT      = NVL(C_SUB_AMT,0),
             COST_AMT  		   = NVL(C_COST_AMT,0),
			 COST_MAT_AMT      = NVL(C_COST_MAT_AMT,0),
             COST_LAB_AMT      = NVL(C_COST_LAB_AMT,0),
             COST_EXP_AMT      = NVL(C_COST_EXP_AMT,0),
             COST_EQU_AMT      = NVL(C_COST_EQU_AMT,0),
             COST_SUB_AMT      = NVL(C_COST_SUB_AMT,0)
          WHERE proj_code       = as_proj_code   AND
                YYMM              = TO_DATE(adt_yymm)          AND
                sum_code = C_PARENT_SUM_CODE;

			SELECT A.LLEVEL,A.PARENT_SUM_CODE
			  INTO C_LEVEL,C_PARENT_SUM_CODE
			  FROM 	
					(	
					SELECT B.PROJ_CODE, B.SUM_CODE, A.PARENT_SUM_CODE, A.LLEVEL, B.YYMM
						FROM Y_BUDGET_SUMMARY A,
							C_SPEC_CONST_TOT B
						WHERE A.PROJ_CODE = B.PROJ_CODE
							AND A.SUM_CODE = B.SUM_CODE
							AND B.YYMM = TO_DATE(adt_yymm) 
					) A
			 WHERE A.proj_code   = as_proj_code  AND
					 A.YYMM          = TO_DATE(adt_yymm)         AND
					 A.sum_code    = C_PARENT_SUM_CODE;
         IF C_LEVEL = 1 THEN
            EXIT;
         END IF;

  	   END LOOP;
    END IF;
	END LOOP;
	CLOSE DETAIL_CUR;
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
END sp_c_spec_const_tot_detaiil;

/
