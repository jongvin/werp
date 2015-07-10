/* ============================================================================= */
/* �Լ��� : y_sp_q_payment_summary                                               */
/* ��  �� : �ŷ�ó�� ���� ����                                                 */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ���                   ==> as_date  (string)                         */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.04.21                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_q_payment_summary(as_dept_code    IN   VARCHAR2,
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
      delete from q_monthly_payment
            where dept_code = as_dept_code
              and to_char(yymm,'yyyy.mm') = as_date;

		INSERT INTO q_monthly_payment  
		  	 select max(c.dept_code),to_date(as_date || '.01','yyyy.mm.dd'),
                 a.regist_no,nvl(sum(c.settle_amt),0),trunc(nvl(sum(c.settle_amt),0) * 0.1,0),nvl(sum(c.settle_amt),0) + trunc(nvl(sum(c.settle_amt),0) * 0.1,0),0,'',''
				from q_code_eqp_vender a,
				     q_code_equipment b,
				     q_daily_run c
				where b.regist_no = a.regist_no
				  and c.dept_code = b.dept_code
				  and c.equp_code = b.equp_code
				  and c.dept_code = as_dept_code
				  and to_char(c.run_date,'yyyy.mm') = as_date
				group by a.regist_no;

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
END y_sp_q_payment_summary;

/
