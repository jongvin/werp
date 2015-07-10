/* ============================================================================= */
/* �Լ��� : y_sp_c_progress_real                                               */
/* ��  �� : ���Ұ��� �������԰��                   */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ��������               ==> ai_chg_no_seq  (number)                         */
/*        : ��������               ==> as_start_date  (string)                         */
/*        : ����������             ==> as_last_date  (string)                         */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �ڵ���                                                              */
/* �ۼ��� : 2005.03.08                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_progress_real(as_dept_code    IN   VARCHAR2,
                                                  ai_chg_no_seq         IN   NUMBER,
                                                  as_start_date         IN   VARCHAR2,
                                                  as_last_date         IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- ��������
-----------------------------------------------+--------------
-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   C_PLAN_AMT          NUMBER(14)     DEFAULT 0;   -- �����հ�
   C_REAL_AMT          NUMBER(14)     DEFAULT 0;   -- �����հ�
   C_CNT          NUMBER(14)     DEFAULT 0;   -- �����հ�

-- User Define Error 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
  		select count(*)
		  into C_CNT
		  from c_progress_detail
		 where dept_code = as_dept_code
			and chg_no_seq = ai_chg_no_seq;


		IF C_CNT < 1 THEN        -- ���Ұ����� ��������������  
         GOTO EXIT_ROUTINE;
		END IF;
   -- copy table ���� 
    	delete from c_progress_detail_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
   -- ���������ڷḦ ������  wbs ������ ������ 
       INSERT INTO c_progress_detail_copy
            select as_dept_code,ai_chg_no_seq,a.wbs_code,a.yymm,0,0,0,a.real_mm_amt
              from y_wbs_code b,
                   (
                         select a.yymm,
                                substr(b.wbs_code,1,1) wbs_code,   -- ���� 1�ڸ��� ���� 
                                sum(a.cost_amt) real_mm_amt
                           from c_spec_const_detail a,y_budget_parent b
                           where a.dept_code = b.dept_code
                             and a.spec_no_seq = b.spec_no_seq
                             and a.yymm >= as_start_date
                             and a.yymm <= as_last_date
                             and a.dept_code = as_dept_code
                           group by a.yymm,substr(b.wbs_code,1,1)
                       union all
                         select a.yymm,
                                substr(b.wbs_code,1,3),   --�����ϰ�쿡�� ���� 3�ڸ��� ����  
                                sum(a.cost_amt) real_mm_amt
                           from c_spec_const_detail a,y_budget_parent b
                           where a.dept_code = b.dept_code
                             and a.spec_no_seq = b.spec_no_seq
                             and a.yymm >= as_start_date
                             and a.yymm <= as_last_date
                             and a.dept_code = as_dept_code
                             AND substr(b.wbs_code,1,1) = 'A'
                           group by a.yymm,substr(b.wbs_code,1,3) ) a
                where a.wbs_code = b.wbs_code;
       -- UPDATE 
       update c_progress_detail a set (a.real_mm_amt) = 
                        (select b.real_mm_amt
                             from c_progress_detail_copy b
						         	  where a.dept_code = b.dept_code 
							             and a.chg_no_seq  = b.chg_no_seq
							             and a.wbs_code   = b.wbs_code
                                  and a.year       = b.year
							             and a.dept_code = as_dept_code
							             and a.chg_no_seq = ai_chg_no_seq
                                   )
          where exists (select b.real_mm_amt
                             from c_progress_detail_copy b
						         	  where a.dept_code = b.dept_code 
							             and a.chg_no_seq  = b.chg_no_seq
							             and a.wbs_code   = b.wbs_code
                                  and a.year       = b.year 
							             and a.dept_code = as_dept_code
							             and a.chg_no_seq = ai_chg_no_seq
                                  );
    -- �����հ�� �����հ� �ݾװ��                                   
		select nvl(sum(a.plan_amt),0)
		  into C_PLAN_AMT
		  from c_progress_parent a
		  where a.dept_code = as_dept_code
			 and a.chg_no_seq  = ai_chg_no_seq
			 and a.wbs_code <> 'A';      -- 'A'�� ���� �հ�ݾ��̹Ƿ� ���ุ�����ϰ� SUM�ϸ� ��ü ����ݾ׹����Աݾױ���
    -- ���� ������ ���			 
      IF C_PLAN_AMT <> 0 THEN 
         update c_progress_detail a set a.real_mm_per = 
                           decode(C_PLAN_AMT,0,0,decode(sign(trunc((nvl(a.real_mm_amt,0) / C_PLAN_AMT ) * 100,2) - 999),
																				1,999,trunc((nvl(a.real_mm_amt,0) / C_PLAN_AMT ) * 100,2)))
		         	  where a.dept_code =  as_dept_code
							             and a.chg_no_seq  = ai_chg_no_seq;
      END IF;  			
                
    	delete from c_progress_detail_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
       EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '���� �������� ����! []';
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
END y_sp_c_progress_real;        