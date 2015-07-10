/* ============================================================================= */
/* �Լ��� : y_sp_l_prevdata_copy                                                 */
/* ��  �� : �����⿪�Ϻ��Է½� �����ڷẹ��.                                     */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : �⿪����               ==> as_date  (string)                         */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.04.16                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_l_prevdata_copy(as_dept_code    IN   VARCHAR2,
                                                 as_date         IN   VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   C_DATE              L_LABOR_DAILYWORK.WORK_DATE%TYPE;    -- ����
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      SELECT MAX(work_date),count(*)
        INTO C_DATE,C_CNT
        FROM l_labor_dailywork
       WHERE dept_code  = as_dept_code
         AND work_date < to_date(as_date,'yyyy.mm.dd');

		IF C_CNT > 0 THEN
			INSERT INTO L_LABOR_DAILYWORK  
			  SELECT DEPT_CODE,   
						CIVIL_REGISTER_NUMBER,   
						to_date(as_date,'yyyy.mm.dd'),   
						SPEC_NO_SEQ,   
						SPEC_UNQ_NUM,   
						DAILYWORK,   
						UNITCOST,   
						INV_SECTION,   
						PAY_AMT,   
						NETPAY_AMT,   
						INCOME_TAX,   
						CIVIL_TAX,   
						PEOPLE_PENSION,   
						INSURANCE_TAX,   
						JIBUL_TAG,   
						JIBUL_DATE  
				 FROM L_LABOR_DAILYWORK  
				WHERE DEPT_CODE = as_dept_code
              AND work_date = C_DATE;
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
END y_sp_l_prevdata_copy;

/
