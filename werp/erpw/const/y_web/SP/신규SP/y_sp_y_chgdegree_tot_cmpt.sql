/* ============================================================================= */
/* �Լ��� : y_sp_y_chgdegree_tot_cmpt                                            */
/* ��  �� : ������೻�� �Է½� ������ �����Ѵ�.                               */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ��ȣ(TO  )             ==> ai_chg_no_seq(Integer)                    */
/*        : �����ڵ�               ==> as_sum_code  (string)                     */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.10.09                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_y_chgdegree_tot_cmpt(as_dept_code    IN   VARCHAR2,
                                                  ai_chg_no_seq   IN   INTEGER) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT SPEC_NO_SEQ
  FROM Y_CHG_BUDGET_PARENT
 WHERE dept_code  = as_dept_code    AND
       chg_no_seq = ai_chg_no_seq AND
       INVEST_CLASS = 'Y' ;

-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   V_SPEC_NO_SEQ       Y_CHG_BUDGET_PARENT.SPEC_NO_SEQ%TYPE;        -- �����з�������ȣ
   C_PARENT_SUM_CODE   Y_CHG_BUDGET_PARENT.PARENT_SUM_CODE%TYPE;    -- �����ڵ�
   C_CNT_AMT           Y_CHG_BUDGET_PARENT.CNT_AMT%TYPE;            -- ���ޱݾ�
   C_CNT_MAT_AMT       Y_CHG_BUDGET_PARENT.CNT_MAT_AMT%TYPE;        -- ���������
   C_CNT_LAB_AMT       Y_CHG_BUDGET_PARENT.CNT_LAB_AMT%TYPE;        -- ���޳빫��
   C_CNT_EXP_AMT       Y_CHG_BUDGET_PARENT.CNT_EXP_AMT%TYPE;        -- ���ް��
   C_AMT               Y_CHG_BUDGET_PARENT.AMT%TYPE;                -- �ݾ�
   C_MAT_AMT           Y_CHG_BUDGET_PARENT.MAT_AMT%TYPE;            -- �����
   C_LAB_AMT           Y_CHG_BUDGET_PARENT.LAB_AMT%TYPE;            -- �빫��
   C_EXP_AMT           Y_CHG_BUDGET_PARENT.EXP_AMT%TYPE;            -- ���
   C_EQU_AMT           Y_CHG_BUDGET_PARENT.EQU_AMT%TYPE;            -- �߱��
   C_SUB_AMT           Y_CHG_BUDGET_PARENT.SUB_AMT%TYPE;            -- ���ֺ�
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_SPEC_NO_SEQ;
		EXIT WHEN DETAIL_CUR%NOTFOUND;

			SELECT NVL(SUM(CNT_AMT),0),NVL(SUM(CNT_MAT_AMT),0),NVL(SUM(CNT_LAB_AMT),0),
					 NVL(SUM(CNT_EXP_AMT),0),NVL(SUM(AMT),0),NVL(SUM(MAT_AMT),0),NVL(SUM(LAB_AMT),0),
					 NVL(SUM(EXP_AMT),0),NVL(SUM(EQU_AMT),0),NVL(SUM(SUB_AMT),0)
			  INTO C_CNT_AMT,C_CNT_MAT_AMT,C_CNT_LAB_AMT,C_CNT_EXP_AMT,C_AMT,C_MAT_AMT,
					 C_LAB_AMT,C_EXP_AMT,C_EQU_AMT,C_SUB_AMT
			  FROM Y_CHG_BUDGET_DETAIL
			 WHERE dept_code  = as_dept_code  AND
					 chg_no_seq = ai_chg_no_seq AND
					 spec_no_seq   = V_SPEC_NO_SEQ;
	
			UPDATE Y_CHG_BUDGET_PARENT
				SET CNT_AMT     = NVL(C_CNT_AMT,0),
					 CNT_MAT_AMT = NVL(C_CNT_MAT_AMT,0),
					 CNT_LAB_AMT = NVL(C_CNT_LAB_AMT,0),
					 CNT_EXP_AMT = NVL(C_CNT_EXP_AMT,0),
					 AMT         = NVL(C_AMT,0),
					 MAT_AMT     = NVL(C_MAT_AMT,0),
					 LAB_AMT     = NVL(C_LAB_AMT,0),
					 EXP_AMT     = NVL(C_EXP_AMT,0),
					 EQU_AMT     = NVL(C_EQU_AMT,0),
					 SUB_AMT     = NVL(C_SUB_AMT,0)
			 WHERE dept_code  = as_dept_code  AND
					 chg_no_seq = ai_chg_no_seq AND
					 spec_no_seq   = V_SPEC_NO_SEQ;
	
			SELECT SUM_CODE
			  INTO C_PARENT_SUM_CODE
			  FROM Y_CHG_BUDGET_PARENT
			 WHERE dept_code  = as_dept_code  AND
					 chg_no_seq = ai_chg_no_seq AND
					 spec_no_seq   = V_SPEC_NO_SEQ;
	 
		SELECT LLEVEL,PARENT_SUM_CODE
		  INTO C_LEVEL,C_PARENT_SUM_CODE
		  FROM Y_CHG_BUDGET_PARENT
		 WHERE dept_code       = as_dept_code  AND
				 chg_no_seq      = ai_chg_no_seq AND
				 sum_code = C_PARENT_SUM_CODE;
		IF C_LEVEL <> 1 THEN
			LOOP
				SELECT NVL(SUM(CNT_AMT),0),NVL(SUM(CNT_MAT_AMT),0),NVL(SUM(CNT_LAB_AMT),0),
						 NVL(SUM(CNT_EXP_AMT),0),NVL(SUM(AMT),0),NVL(SUM(MAT_AMT),0),NVL(SUM(LAB_AMT),0),
						 NVL(SUM(EXP_AMT),0),NVL(SUM(EQU_AMT),0),NVL(SUM(SUB_AMT),0)
				  INTO C_CNT_AMT,C_CNT_MAT_AMT,C_CNT_LAB_AMT,C_CNT_EXP_AMT,C_AMT,C_MAT_AMT,
						 C_LAB_AMT,C_EXP_AMT,C_EQU_AMT,C_SUB_AMT
				  FROM Y_CHG_BUDGET_PARENT
				 WHERE dept_code       = as_dept_code  AND
						 chg_no_seq      = ai_chg_no_seq AND
						 parent_sum_code = C_PARENT_SUM_CODE;
	
	
				UPDATE Y_CHG_BUDGET_PARENT
					SET CNT_AMT     = NVL(C_CNT_AMT,0),
						 CNT_MAT_AMT = NVL(C_CNT_MAT_AMT,0),
						 CNT_LAB_AMT = NVL(C_CNT_LAB_AMT,0),
						 CNT_EXP_AMT = NVL(C_CNT_EXP_AMT,0),
						 AMT         = NVL(C_AMT,0),
						 MAT_AMT     = NVL(C_MAT_AMT,0),
						 LAB_AMT     = NVL(C_LAB_AMT,0),
						 EXP_AMT     = NVL(C_EXP_AMT,0),
						 EQU_AMT     = NVL(C_EQU_AMT,0),
						 SUB_AMT     = NVL(C_SUB_AMT,0)
				 WHERE dept_code       = as_dept_code  AND
						 chg_no_seq      = ai_chg_no_seq AND
						 sum_code = C_PARENT_SUM_CODE;
	
	
				SELECT LLEVEL,PARENT_SUM_CODE
				  INTO C_LEVEL,C_PARENT_SUM_CODE
				  FROM Y_CHG_BUDGET_PARENT
				 WHERE dept_code       = as_dept_code  AND
						 chg_no_seq      = ai_chg_no_seq AND
						 sum_code = C_PARENT_SUM_CODE;
				IF C_LEVEL = 1 THEN
					EXIT;
				END IF;
	
			END LOOP;
		 END IF;
	END LOOP;
	CLOSE DETAIL_CUR;

	 select nvl(cnt_amt,0),nvl(amt,0)
		into C_CNT_AMT,C_AMT
		from y_chg_budget_parent
	  where dept_code  = as_dept_code
		 and chg_no_seq = ai_chg_no_seq
		 and llevel = 1;

	update y_chg_degree
		set cnt_amt = nvl(C_CNT_AMT,0),
			 amt     = nvl(C_AMT,0)
    where dept_code  = as_dept_code
		and chg_no_seq = ai_chg_no_seq;

	update z_code_dept
		set  exe_amt1     = nvl(C_AMT,0),
		     exe_rate1    = decode(NVL(C_CNT_AMT,0),0,0,decode(sign(trunc((nvl(C_AMT,0) / C_CNT_AMT ) * 100,2) - 999),
																			1,999,trunc((nvl(C_AMT,0) / C_CNT_AMT ) * 100,2))) 
    where dept_code  = as_dept_code;

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
END y_sp_y_chgdegree_tot_cmpt;

/
