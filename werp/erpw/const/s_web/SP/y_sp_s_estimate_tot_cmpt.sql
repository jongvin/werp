/* ============================================================================= */
/* �Լ��� : y_sp_s_estimate_tot_cmpt                                             */
/* ��  �� : ���ְ������� �Է½� ������ �����Ѵ�.(TOTAL)                        */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ���ֹ�ȣ               ==> ai_order_number(Integer)                  */
/*        : ���¾�ü�ڵ�           ==> as_sbcr_code  (string)                    */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.04.23                                                           */
/* ============================================================================= */
 CREATE OR REPLACE PROCEDURE y_sp_s_estimate_tot_cmpt(as_dept_code    IN   VARCHAR2,
                                                   ai_order_number IN   INTEGER,
                                                   as_sbcr_code    IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT A.SUM_CODE,A.SPEC_NO_SEQ
  FROM S_ORDER_PARENT A,
       S_ESTIMATE_PARENT B
 WHERE A.dept_code    = B.dept_code     AND
       A.ORDER_NUMBER = B.ORDER_NUMBER  AND
       A.SPEC_NO_SEQ  = B.SPEC_NO_SEQ   AND
       B.SBCR_CODE    = as_sbcr_code    AND
       A.dept_code    = as_dept_code    AND
       A.ORDER_NUMBER = ai_order_number AND
       A.INVEST_CLASS = 'Y' ;
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   V_SPEC_NO_SEQ       S_ORDER_PARENT.SPEC_NO_SEQ%TYPE;
   V_SUM_CODE          S_ORDER_PARENT.SUM_CODE%TYPE;
   C_SPEC_NO_SEQ       S_ORDER_PARENT.SPEC_NO_SEQ%TYPE;    -- �����ڵ�
   C_PARENT_SUM_CODE   S_ORDER_PARENT.PARENT_SUM_CODE%TYPE;    -- �����ڵ�
   C_EST_AMT           S_ESTIMATE_PARENT.EST_AMT%TYPE;            -- ���ޱݾ�
   C_CTRL_AMT          S_ESTIMATE_PARENT.CTRL_AMT%TYPE;            -- ����ݾ�
   C_EMAT_AMT          S_ESTIMATE_PARENT.EMAT_AMT%TYPE;            -- �����(����)
   C_ELAB_AMT          S_ESTIMATE_PARENT.ELAB_AMT%TYPE;            -- �빫��(����)
   C_EEXP_AMT          S_ESTIMATE_PARENT.EEXP_AMT%TYPE;            -- ���(����)
   C_CMAT_AMT          S_ESTIMATE_PARENT.CMAT_AMT%TYPE;            -- �����(����)
   C_CLAB_AMT          S_ESTIMATE_PARENT.CLAB_AMT%TYPE;            -- �빫��(����)
   C_CEXP_AMT          S_ESTIMATE_PARENT.CEXP_AMT%TYPE;            -- ���(����)
   C_LEVEL             NUMBER(20,5);  --
   C_CNT               NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_SUM_CODE,V_SPEC_NO_SEQ;
		EXIT WHEN DETAIL_CUR%NOTFOUND;

      SELECT NVL(SUM(EST_AMT),0),NVL(SUM(CTRL_AMT),0),NVL(SUM(EMAT_AMT),0),NVL(SUM(ELAB_AMT),0),NVL(SUM(EEXP_AMT),0),
	                                                  NVL(SUM(CMAT_AMT),0),NVL(SUM(CLAB_AMT),0),NVL(SUM(CEXP_AMT),0)
        INTO C_EST_AMT,C_CTRL_AMT,C_EMAT_AMT,C_ELAB_AMT,C_EEXP_AMT,C_CMAT_AMT,C_CLAB_AMT,C_CEXP_AMT
        FROM S_ESTIMATE_DETAIL
       WHERE dept_code    = as_dept_code  AND
             order_number = ai_order_number AND
             sbcr_code    = as_sbcr_code AND
             spec_no_seq  = V_SPEC_NO_SEQ;

      UPDATE S_ESTIMATE_PARENT
         SET EST_AMT  = NVL(C_EST_AMT,0),
             CTRL_AMT = NVL(C_CTRL_AMT,0),
				 EMAT_AMT = NVL(C_EMAT_AMT,0),
				 ELAB_AMT = NVL(C_ELAB_AMT,0),
				 EEXP_AMT = NVL(C_EEXP_AMT,0),
				 CMAT_AMT = NVL(C_CMAT_AMT,0),
				 CLAB_AMT = NVL(C_CLAB_AMT,0),
				 CEXP_AMT = NVL(C_CEXP_AMT,0)
       WHERE dept_code    = as_dept_code  AND
             order_number = ai_order_number AND
             sbcr_code    = as_sbcr_code AND
             spec_no_seq  = V_SPEC_NO_SEQ;

		C_PARENT_SUM_CODE := V_SUM_CODE;

		SELECT LLEVEL,PARENT_SUM_CODE
		  INTO C_LEVEL,C_PARENT_SUM_CODE
		  FROM S_ORDER_PARENT
		 WHERE dept_code    = as_dept_code  AND
				 order_number = ai_order_number AND
				 sum_code     = C_PARENT_SUM_CODE;

		IF C_LEVEL <> 1 THEN
			LOOP
				SELECT NVL(SUM(a.EST_AMT),0),NVL(SUM(a.CTRL_AMT),0),NVL(SUM(a.EMAT_AMT),0),NVL(SUM(a.ELAB_AMT),0),NVL(SUM(a.EEXP_AMT),0),
																				  NVL(SUM(a.CMAT_AMT),0),NVL(SUM(a.CLAB_AMT),0),NVL(SUM(a.CEXP_AMT),0)
				  INTO C_EST_AMT,C_CTRL_AMT,C_EMAT_AMT,C_ELAB_AMT,C_EEXP_AMT,C_CMAT_AMT,C_CLAB_AMT,C_CEXP_AMT
				  FROM S_ESTIMATE_PARENT a,
						 S_ORDER_PARENT b
				 WHERE a.dept_code       = b.dept_code
					AND a.order_number    = b.order_number
					AND a.spec_no_seq     = b.spec_no_seq
					AND a.dept_code       = as_dept_code
					AND a.order_number    = ai_order_number
					AND a.sbcr_code       = as_sbcr_code
					AND b.parent_sum_code = C_PARENT_SUM_CODE;

				SELECT spec_no_seq
              INTO C_SPEC_NO_SEQ
              FROM S_ORDER_PARENT
             WHERE dept_code    = as_dept_code
					AND order_number = ai_order_number
					AND sum_code     = C_PARENT_SUM_CODE;

				UPDATE S_ESTIMATE_PARENT
					SET EST_AMT  = NVL(C_EST_AMT,0),
						 CTRL_AMT = NVL(C_CTRL_AMT,0),
						 EMAT_AMT = NVL(C_EMAT_AMT,0),
						 ELAB_AMT = NVL(C_ELAB_AMT,0),
						 EEXP_AMT = NVL(C_EEXP_AMT,0),
						 CMAT_AMT = NVL(C_CMAT_AMT,0),
						 CLAB_AMT = NVL(C_CLAB_AMT,0),
						 CEXP_AMT = NVL(C_CEXP_AMT,0)
				 WHERE dept_code    = as_dept_code  AND
						 order_number = ai_order_number AND
						 sbcr_code    = as_sbcr_code AND
						 spec_no_seq  = C_SPEC_NO_SEQ;

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
		END LOOP;
		CLOSE DETAIL_CUR;

		SELECT NVL(SUM(a.EST_AMT),0),NVL(SUM(a.CTRL_AMT),0)
		  INTO C_EST_AMT,C_CTRL_AMT
		  FROM S_ESTIMATE_PARENT a,
				 S_ORDER_PARENT b
		 WHERE b.dept_code    = a.dept_code AND
				 b.order_number = a.order_number AND
				 b.spec_no_seq  = a.spec_no_seq AND
				 a.sbcr_code    = as_sbcr_code AND
				 b.dept_code    = as_dept_code   AND
				 b.order_number = ai_order_number AND
				 b.llevel = 1;

		 UPDATE S_ESTIMATE_LIST
			 SET est_amt  = C_EST_AMT,
				  ctrl_amt = C_CTRL_AMT
		  WHERE dept_code    = as_dept_code   AND
				  order_number = ai_order_number AND
				  sbcr_code    = as_sbcr_code;
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
END y_sp_s_estimate_tot_cmpt;
