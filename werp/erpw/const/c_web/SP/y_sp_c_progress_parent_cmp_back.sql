/* ============================================================================= */
/* �Լ��� : y_sp_c_progress_parent_cmp                                               */
/* ��  �� : ���Ұ��� ��������� �ݾ� ���  (��������)                */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ��������               ==> ai_chg_no_seq  (number)                         */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �ڵ���                                                              */
/* �ۼ��� : 2005.03.08                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_progress_parent_cmp(as_dept_code    IN   VARCHAR2,
                                                  ai_chg_no_seq         IN   NUMBER
                                                   ) IS
-------------------------------------------------------------
-- ��������
-----------------------------------------------+--------------
-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   C_PLAN_AMT          NUMBER(14)     DEFAULT 0;   -- �����հ�
   C_REAL_AMT          NUMBER(14)     DEFAULT 0;   -- �����հ�

-- User Define Error 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      
  -- 'A'  //���� �������� DETAIL����  ��������� �������̺��� ���������� �ϴ� ���� 'A'�� ����    
    	delete from c_progress_detail
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq
              and wbs_code = 'A';
                    
       INSERT INTO c_progress_detail
          select dept_code,
                 chg_no_seq,
                'A',
                year,
                sum(plan_mm_per),
                sum(plan_mm_amt),
                sum(real_mm_per),
                sum(real_mm_amt)
          from c_progress_detail
          where dept_code = as_dept_code
            and chg_no_seq = ai_chg_no_seq
            and substr(wbs_code,2,1) is not null
          group by dept_code,chg_no_seq,year;
--  ������ �����Ͽ� ������ �ݿ� �������� ����ݾ� �� (�����ϰܿ쿡�� ��������)
       update c_progress_parent a set (a.plan_per,a.plan_amt) = 
                    (select sum(b.plan_mm_per),sum(b.plan_mm_amt)
                         from c_progress_detail b
                         where b.dept_code = as_dept_code
                           and b.chg_no_seq = ai_chg_no_seq
                           and b.wbs_code = 'A'
                           and a.dept_code = b.dept_code
                           and a.wbs_code = b.wbs_code
                           and a.chg_no_seq = b.chg_no_seq
                           and a.wbs_code = 'A'
                           group by b.dept_code,b.chg_no_seq,b.wbs_code )
          where exists (select sum(b.plan_mm_per),sum(b.plan_mm_amt)
                         from c_progress_detail b
                         where b.dept_code = as_dept_code
                           and b.chg_no_seq = ai_chg_no_seq
                           and b.wbs_code = 'A'
                           and a.dept_code = b.dept_code
                           and a.wbs_code = b.wbs_code
                           and a.chg_no_seq = b.chg_no_seq
                           and a.wbs_code = 'A'
                           group by b.dept_code,b.chg_no_seq,b.wbs_code );

      				                             
          
  update c_progress_parent aa
  set aa.real_per = (select sum(a.real_mm_per)
                         from c_progress_detail a
                         where a.dept_code = as_dept_code
                           and a.chg_no_seq = ai_chg_no_seq
                           and a.wbs_code = 'A'
                           and aa.dept_code = a.dept_code
                           and aa.wbs_code = a.wbs_code
                           and aa.chg_no_seq = a.chg_no_seq
                           group by a.dept_code,a.chg_no_seq,a.wbs_code ),
     aa.real_amt = (select sum(a.real_mm_amt)
                         from c_progress_detail a
                         where a.dept_code = as_dept_code
                           and a.chg_no_seq = ai_chg_no_seq
                           and a.wbs_code = 'A'
                           and aa.dept_code = a.dept_code
                           and aa.wbs_code = a.wbs_code
                           and aa.chg_no_seq = a.chg_no_seq
                           group by a.dept_code,a.chg_no_seq,a.wbs_code );       				                             
     				                             
			                                  
       EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '���� �ڷ�������� ����! []';
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
END y_sp_c_progress_parent_cmp;        