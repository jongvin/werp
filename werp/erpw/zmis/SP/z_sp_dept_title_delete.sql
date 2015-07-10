/* ============================================================================= */
/* �Լ��� : z_sp_dept_title_delete                                                 */
/* ��  �� : ������ ����                                       */
/* ----------------------------------------------------------------------------- */
/*        : �������                 ==> an_degree      (NUMBER)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �ڵ���                                                               */
/* �ۼ��� : 2004.10.15                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE z_sp_dept_title_delete(   an_degree   IN   NUMBER) IS
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
		delete from z_code_chg_dept_content
          WHERE degree = an_degree;
		delete from z_code_chg_dept_title
          WHERE degree = an_degree;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '���� �ڷắȯ ����! [Line No: 157]';
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
END z_sp_dept_title_delete;

/
