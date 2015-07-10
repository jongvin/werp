/* ============================================================================= */
/* �Լ��� : y_sp_q_prevdata_copy                                                 */
/* ��  �� : ������Գ����Է½� �����ڷẹ��.                                     */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : �⿪����               ==> as_date  (string)                         */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.04.21                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_q_prevdata_copy(as_dept_code    IN   VARCHAR2,
                                                 as_date         IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   C_DATE              Q_DAILY_RUN.RUN_DATE%TYPE;    -- ����
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      SELECT MAX(run_date),count(*)
        INTO C_DATE,C_CNT
        FROM q_daily_run
       WHERE dept_code  = as_dept_code
         AND run_date < to_date(as_date,'yyyy.mm.dd');

		IF C_CNT > 0 THEN
			INSERT INTO q_daily_run  
			  SELECT DEPT_CODE,   
						to_date(as_date,'yyyy.mm.dd'),   
                  equp_code,
						seq,
						SPEC_NO_SEQ,   
						SPEC_UNQ_NUM,   
						run_time,   
						suspension_time,   
						extra_time,   
						settle_time,   
						unitcost,   
						settle_amt,   
						inv_tag,   
						fuel_qty,   
						fuel_amt,   
						oil_qty,   
						oil_amt,
      				repair_remark,
						repair_amt,
						move_remark,
						move_amt,
						run_remark  
				 FROM q_daily_run  
				WHERE DEPT_CODE = as_dept_code
              AND run_date = C_DATE;
    END IF;
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
END y_sp_q_prevdata_copy;

/
