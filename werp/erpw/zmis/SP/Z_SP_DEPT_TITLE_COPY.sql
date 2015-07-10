/* ============================================================================= */
/* �Լ��� : Z_SP_DEPT_TITLE_COPY                                                 */
/* ��  �� : ������ ����                                        */
/* ----------------------------------------------------------------------------- */
/*        : ����������                 ==> al_old_degree      (NUMBER)                     */
/*        : �����ļ���                 ==> al_new_degree      (NUMBER)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �ڵ���                                                               */
/* �ۼ��� : 2004.10.15                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE "Z_SP_DEPT_TITLE_COPY"  (  al_old_degree           IN   NUMBER,
												                   al_new_degree        IN   NUMBER) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN
		INSERT INTO z_code_chg_dept_title
		       ( SELECT al_new_degree,
			     		dept_seq_key,   
                  no_seq,   
                  level1,   
                  title_name,   
                  level_code,   
                  comp_code,emp_no 
			       FROM z_code_chg_dept_title
				  WHERE degree = al_old_degree);
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '���α׷� ���� ����! [Line No: 2]';
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;   
   END;
	BEGIN
		INSERT INTO z_code_chg_dept_content
		       ( SELECT al_new_degree,
                      dept_seq_key,   
                      dept_code,   
                      no_seq,emp_no,dept_limit_tag,charge_emp_no
			       FROM z_code_chg_dept_content
				  WHERE degree = al_old_degree);
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '���α׷� ���� ����! [Line No: 2]';
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
END Z_SP_DEPT_TITLE_COPY;
/
