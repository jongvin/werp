/* ============================================================================= */
/* �Լ��� : y_sp_s_orderspec_cmpt                                                */
/* ��  �� : ���ֹ��ֳ��� �Է½� ������ �����Ѵ�.                               */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ���ֹ�ȣ               ==> ai_order_number(Integer)                  */
/*        : �з��ڵ�               ==> ai_spec_no_seq  (Integer)                 */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.04.23                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_orderspec_cmpt(as_dept_code    IN   VARCHAR2,
                                                ai_order_number IN   INTEGER,
                                                ai_spec_no_seq     IN   INTEGER,
                                                as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_PARENT_SUM_CODE   S_ORDER_PARENT.PARENT_SUM_CODE%TYPE;    -- �����ڵ�
   C_CNT_QTY           S_ORDER_PARENT.CNT_QTY%TYPE;            -- ���޼���
   C_CNT_AMT           S_ORDER_PARENT.CNT_AMT%TYPE;            -- ���ޱݾ�
   C_EXE_QTY           S_ORDER_PARENT.EXE_QTY%TYPE;            -- �������
   C_EXE_AMT           S_ORDER_PARENT.EXE_AMT%TYPE;            -- ����ݾ�
   C_SUB_QTY           S_ORDER_PARENT.SUB_QTY%TYPE;            -- ���ּ���
   C_SUB_AMT           S_ORDER_PARENT.SUB_AMT%TYPE;            -- ���ֺ�
   C_MAT_AMT           S_ORDER_PARENT.MAT_AMT%TYPE;            -- �����
   C_LAB_AMT           S_ORDER_PARENT.LAB_AMT%TYPE;            -- �빫��
   C_EXP_AMT           S_ORDER_PARENT.EXP_AMT%TYPE;            -- ���
   C_LEVEL             NUMBER(20,5);  --
   C_CNT               NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      SELECT NVL(SUM(CNT_AMT),0),NVL(SUM(EXE_AMT),0),NVL(SUM(SUB_AMT),0),NVL(SUM(MAT_AMT),0),NVL(SUM(LAB_AMT),0),NVL(SUM(EXP_AMT),0)
        INTO C_CNT_AMT,C_EXE_AMT,C_SUB_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT
        FROM S_ORDER_DETAIL
       WHERE dept_code    = as_dept_code  AND
             order_number = ai_order_number AND
             spec_no_seq  = ai_spec_no_seq;

      UPDATE S_ORDER_PARENT
         SET CNT_AMT = NVL(C_CNT_AMT,0),
             EXE_AMT = NVL(C_EXE_AMT,0),
             SUB_AMT = NVL(C_SUB_AMT,0),
				 MAT_AMT = NVL(C_MAT_AMT,0),
				 LAB_AMT = NVL(C_LAB_AMT,0),
				 EXP_AMT = NVL(C_EXP_AMT,0)
       WHERE dept_code    = as_dept_code  AND
             order_number = ai_order_number AND
             spec_no_seq  = ai_spec_no_seq;

		SELECT LLEVEL,PARENT_SUM_CODE
        INTO C_LEVEL,C_PARENT_SUM_CODE
        FROM S_ORDER_PARENT
       WHERE dept_code    = as_dept_code  AND
             order_number = ai_order_number AND
             spec_no_seq  = ai_spec_no_seq;

		IF C_LEVEL <> 1 THEN
			LOOP
				SELECT NVL(SUM(CNT_AMT),0),NVL(SUM(EXE_AMT),0),NVL(SUM(SUB_AMT),0),NVL(SUM(MAT_AMT),0),NVL(SUM(LAB_AMT),0),NVL(SUM(EXP_AMT),0)
				  INTO C_CNT_AMT,C_EXE_AMT,C_SUB_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT
				  FROM S_ORDER_PARENT
				 WHERE dept_code       = as_dept_code  AND
						 order_number    = ai_order_number AND
						 parent_sum_code = C_PARENT_SUM_CODE;
				UPDATE S_ORDER_PARENT
					SET CNT_AMT = NVL(C_CNT_AMT,0),
						 EXE_AMT = NVL(C_EXE_AMT,0),
						 SUB_AMT = NVL(C_SUB_AMT,0),
					MAT_AMT = NVL(C_MAT_AMT,0),
					LAB_AMT = NVL(C_LAB_AMT,0),
					EXP_AMT = NVL(C_EXP_AMT,0)
				 WHERE dept_code    = as_dept_code  AND
						 order_number = ai_order_number AND
						 sum_code     = C_PARENT_SUM_CODE;
				SELECT LLEVEL,PARENT_SUM_CODE
				  INTO C_LEVEL,C_PARENT_SUM_CODE
				  FROM S_ORDER_PARENT
				 WHERE dept_code    = as_dept_code  AND
						 order_number = ai_order_number AND
						 sum_code     = C_PARENT_SUM_CODE;
				IF C_LEVEL = 1 THEN
					EXIT;
				END IF;
			END LOOP;
		 END IF;

		select nvl(sum(cnt_amt),0),nvl(sum(exe_amt),0)
    	  into C_CNT_AMT,C_EXE_AMT
        from s_order_parent
     	 where dept_code  = as_dept_code
         and order_number = ai_order_number
   		and llevel = 1;

		update s_order_list
			set cnt_amt = nvl(C_CNT_AMT,0),
				 exe_amt = nvl(C_EXE_AMT,0)
		 where dept_code = as_dept_code
			and order_number = ai_order_number;
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
END y_sp_s_orderspec_cmpt;
