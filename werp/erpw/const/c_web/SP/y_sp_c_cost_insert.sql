/* ============================================================================= */
/* �Լ��� : y_sp_c_cost_insert                                                 */
/* ��  �� :   ������ȹ  �������� ����                                       */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�                    ==> as_dept_code (string)                     */
/*        : �������(����)               ==> an_old_chg_no_seq(NUMBER)                    */
/*        : �������(����)               ==> an_new_chg_no_seq      (NUMBER)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �ڵ���                                                               */
/* �ۼ��� : 2004.10.15                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_cost_insert(as_dept_code    IN  VARCHAR2,
                                            an_old_chg_no_seq   IN   NUMBER,
                                            an_new_chg_no_seq   IN   NUMBER) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
		INSERT INTO c_cost_plan
          SELECT a.dept_code,
                 an_new_chg_no_seq,
         a.yymm,
         a.amt,
         a.cost_amt,
         a.cnt_amt,
         a.main_process_bigo  
      FROM c_cost_plan  a  
            WHERE a.dept_code = as_dept_code
              and a.chg_no_seq = an_old_chg_no_seq;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'insert c_cost �ڷắȯ ����! [Line No: 157]';
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
END y_sp_c_cost_insert;

/
