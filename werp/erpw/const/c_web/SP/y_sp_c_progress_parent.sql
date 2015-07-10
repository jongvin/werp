/* ============================================================================= */
/* �Լ��� : y_sp_c_progress_parent                                               */
/* ��  �� : ���Ұ��� ��������� �ݾ� ���                  */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ��������               ==> ai_chg_no_seq  (number)                         */
/*        : ��������               ==> as_start_date  (string)                         */
/*        : ����������             ==> as_last_date  (string)                         */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �ڵ���                                                              */
/* �ۼ��� : 2005.03.08                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_progress_parent(as_dept_code    IN   VARCHAR2,
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

-- User Define Error 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
   -- copy table ���� 
    	delete from c_progress_detail_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
    	delete from c_progress_parent_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
  -- ���� ����Ÿ �������Ϸ� ����
      insert into c_progress_parent_copy
                  select * from c_progress_parent
                       where dept_code = as_dept_code
                         and chg_no_seq = ai_chg_no_seq;
      insert into c_progress_detail_copy
                  select * from c_progress_detail
                       where dept_code = as_dept_code
                         and chg_no_seq = ai_chg_no_seq;
 -- �����ڷ� ���� 
    	delete from c_progress_detail
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
    	delete from c_progress_parent
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
   -- �����ڷḦ wbs ������ ������ (����ݾױ����� �����ͼ� PARENT�� ����)
       INSERT INTO c_progress_parent
            select as_dept_code,ai_chg_no_seq,a.wbs_code,b.no_seq,a.invest_class,0, a.amt,0,0
              from y_wbs_code b,
                   (
                         select substr(a.wbs_code,1,1) wbs_code,   -- ���� 1�ڸ��� ���� 
                                DECODE(substr(a.wbs_code,1,1),'A','N','Y') invest_class,
                                sum(a.amt) amt
                           from y_budget_parent a
                           where a.dept_code = as_dept_code
                             AND a.invest_class = 'Y'
                           group by substr(a.wbs_code,1,1)
                       union all
                         select substr(a.wbs_code,1,3),   --�����ϰ�쿡�� ���� 3�ڸ��� ����  
                                'Y',
                                sum(a.amt)
                           from y_budget_parent a
                           where a.dept_code = as_dept_code
                             AND a.invest_class = 'Y'
                             AND substr(a.wbs_code,1,1) = 'A'
                           group by substr(a.wbs_code,1,3) ) a
                where a.wbs_code = b.wbs_code;
                
   -- �����ڷḦ wbs ���� �������  ������(wbs������ c_progress_detail ���̺� �⵵ �߰� ) 
       INSERT INTO c_progress_detail
            select a.dept_code,
                   a.chg_no_seq,
                   a.wbs_code,
                   b.c_yymm,0,0,0,0
              from c_progress_parent a,
                   c_calendar_yymm b
              where a.dept_code = as_dept_code
                and a.chg_no_seq = ai_chg_no_seq
                and b.c_yymm >= as_start_date 
                and b.c_yymm <= as_last_date;  
                
   -- ������ ������ �����ڷᰡ �ִٸ� detail�ڷ� ���� 

       update c_progress_detail a set (a.plan_mm_per,a.plan_mm_amt,a.real_mm_per,a.real_mm_amt) = 
                        (select b.plan_mm_per,b.plan_mm_amt,b.real_mm_per,b.real_mm_amt
                             from c_progress_detail_copy b
						         	  where a.dept_code = b.dept_code 
							             and a.chg_no_seq  = b.chg_no_seq
							             and a.wbs_code   = b.wbs_code
                                  and a.year       = b.year
							             and a.dept_code = as_dept_code
							             and a.chg_no_seq = ai_chg_no_seq
                                   )
          where exists (select b.plan_mm_per,b.plan_mm_amt,b.real_mm_per,b.real_mm_amt
                             from c_progress_detail_copy b
						         	  where a.dept_code = b.dept_code 
							             and a.chg_no_seq  = b.chg_no_seq
							             and a.wbs_code   = b.wbs_code
                                  and a.year       = b.year 
							             and a.dept_code = as_dept_code
							             and a.chg_no_seq = ai_chg_no_seq
                                  );
    -- �����հ�� �����հ� �ݾװ��                                   
		select nvl(sum(a.plan_amt),0),nvl(sum(a.real_amt),0)
		  into C_PLAN_AMT,C_REAL_AMT
		  from c_progress_parent a
		  where a.dept_code = as_dept_code
			 and a.chg_no_seq  = ai_chg_no_seq
			 and a.wbs_code <> 'A';      -- 'A'�� ���� �հ�ݾ��̹Ƿ� ���ุ�����ϰ� SUM�ϸ� ��ü ����ݾ׹����Աݾױ���
    -- ���� ������ ���			 
      IF C_PLAN_AMT <> 0 THEN 
         update c_progress_parent a set a.plan_per = 
                                  decode(C_PLAN_AMT,0,0,decode(sign(ROUND((nvl(a.plan_amt,0) / C_PLAN_AMT ) * 100,2) - 999),
																				1,999,ROUND((nvl(a.plan_amt,0) / C_PLAN_AMT ) * 100,2)))
						         	  where a.dept_code =  as_dept_code
							             and a.chg_no_seq  = ai_chg_no_seq;
         update c_progress_detail a set a.plan_mm_amt = TRUNC(a.plan_mm_per *  C_PLAN_AMT / 100,0)
						         	  where a.dept_code =  as_dept_code
							             and a.chg_no_seq  = ai_chg_no_seq;
         update c_progress_detail a set a.real_mm_per = 
                                  decode(C_PLAN_AMT,0,0,decode(sign(ROUND((nvl(a.real_mm_amt,0) / C_PLAN_AMT ) * 100,2) - 999),
																				1,999,ROUND((nvl(a.real_mm_amt,0) / C_PLAN_AMT ) * 100,2)))
						         	  where a.dept_code =  as_dept_code
							             and a.chg_no_seq  = ai_chg_no_seq;
      END IF;  			
   -- detail���� �������� �������� ����      
      
  -- 'A'  //���� �������� DETAIL����       ������ �������̺����� 'A' ��������ݾ��� �����ϹǷ� ������ �ٽ� ������.
    	delete from c_progress_detail
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq
              and wbs_code = 'A';

          
       INSERT INTO c_progress_detail    -- �������������� �����Ͽ� 'A'�� ���� 
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
            and substr(wbs_code,2,1) is not null    -- ������ �ǹ���(�ٸ���Ʈ�� 2��°�� NULL��)
          group by dept_code,chg_no_seq,year;
      				                             
--  ������ �����Ͽ� ������ �ݿ� �������� ����ݾ� �� (�����ϰ�쿡�� ��������)
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


--  ������ �����Ͽ� ������ �ݿ� ���Աݾװ� �������� �����Ѵ�.
 update c_progress_parent aa
  set aa.real_per = (select sum(a.real_mm_per)
                         from c_progress_detail a
                         where a.dept_code = as_dept_code
                           and a.chg_no_seq = ai_chg_no_seq
                           and aa.dept_code = a.dept_code
                           and aa.wbs_code = a.wbs_code
                           and aa.chg_no_seq = a.chg_no_seq
                           group by a.dept_code,a.chg_no_seq,a.wbs_code ),
     aa.real_amt = (select sum(a.real_mm_amt)
                         from c_progress_detail a
                         where a.dept_code = as_dept_code
                           and a.chg_no_seq = ai_chg_no_seq
                           and aa.dept_code = a.dept_code
                           and aa.wbs_code = a.wbs_code
                           and aa.chg_no_seq = a.chg_no_seq
                           group by a.dept_code,a.chg_no_seq,a.wbs_code );    

   -- copy table ���� 
    	delete from c_progress_detail_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
    	delete from c_progress_parent_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
                              				                             
      				                                  
       EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '���� �ڷ����� ����! []';
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
END y_sp_c_progress_parent;        