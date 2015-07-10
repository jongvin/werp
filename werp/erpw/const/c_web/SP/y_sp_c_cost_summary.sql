/* ============================================================================= */
/* �Լ��� : y_sp_c_cost_summary                                                  */
/* ��  �� : �������� �ݿ������ڷḦ����.  							                  */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ����                   ==> ad_date      (date)                       */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �ڵ���                                                               */
/* �ۼ��� : 2005.05.26                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_cost_summary(as_dept_code    IN   VARCHAR2,
                                                adt_yymm        IN   DATE ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
	C_DATE			 DATE;
   C_CHK           VARCHAR2(1);
   C_CNT           NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;
   C_UNQ_NUMBER    NUMBER(18,0);
BEGIN
   BEGIN
		update c_spec_const_detail         --���� �÷� zero set
			set cost_qty = 0,
				 cost_amt = 0,
				 cost_mat_amt = 0,
				 cost_sub_amt = 0,
				 cost_lab_amt = 0,
				 cost_equ_amt = 0,
				 cost_exp_amt = 0,
				 cost_rate = 0
		 where dept_code = as_dept_code
			and yymm = adt_yymm;

		update c_spec_const_parent
			set cost_qty = 0,
				 cost_amt = 0,
				 cost_mat_amt = 0,
				 cost_sub_amt = 0,
				 cost_lab_amt = 0,
				 cost_equ_amt = 0,
				 cost_exp_amt = 0,
				 cost_rate = 0
		 where dept_code = as_dept_code
			and yymm = adt_yymm;

      EXCEPTION
      WHEN others THEN 
        IF SQL%NOTFOUND THEN
           e_msg      := '�ش�� �ڷ��ʱ�ȭ ����! [Line No: 1]';
           Wk_errflag := -20020;
        
           GOTO EXIT_ROUTINE;
        END IF;   
   END;
   BEGIN
   
		select C_UNQ_NUM.nextval
		  into C_UNQ_NUMBER
		  from dual;

			INSERT INTO C_SPEC_CONST_CAL_TMP     -- update�� ���ϰ��ϱ����ؼ� �������� ���̺� ��� 
		     select
               C_UNQ_NUMBER,
               b.dept_code,
               adt_yymm,
               b.spec_unq_num,
               sum(b.cost_qty) cost_qty,
               sum(b.cost_mat_amt) cost_mat_amt,
               sum(b.cost_lab_amt) cost_lab_amt,
               0  cost_equ_amt,
               sum(b.cost_sub_amt) cost_sub_amt,
               sum(b.cost_exp_amt) cost_exp_amt,
               '',
               '',
               '',
               sum(b.result_qty) result_qty,
					sum(b.result_amt) result_amt 
           from (                 
-- �빫�� �ڷ� ����        
						  SELECT a.dept_code,
						         a.spec_unq_num,
						         0 cost_qty,
						         0 cost_mat_amt,
						         nvl(sum(a.pay_amt),0) cost_lab_amt,
						         0 cost_equ_amt,
						         0 cost_sub_amt,
						         0 cost_exp_amt,
									0 result_qty,
									0 result_amt
							  from l_labor_dailywork a
							 where a.dept_code    = as_dept_code 
							   and a.work_date >= adt_yymm
							   and a.work_date < add_months(adt_yymm,1)
						 group by a.dept_code,
									 a.spec_unq_num  
                union all
-- �������������  �ڷ� ����        
						  SELECT a.dept_code,
						         a.spec_unq_num,
						         0,
						         0,
						         0,
						         0,
						         0,
						         nvl(sum(a.amt),0) cost_exp_amt,
									0 result_qty,
									0 result_amt
							  from f_request a
							 where a.dept_code    = as_dept_code 
							   and a.rqst_date >= adt_yymm
							   and a.rqst_date < add_months(adt_yymm,1)
								and a.spec_unq_num <> 0
							   and a.cost_type = '1'
								and a.res_class = 'X'
						 group by a.dept_code,
									 a.spec_unq_num 
					union all				 
-- ����� �ڷ� ���� (�������)       
						  SELECT b.dept_code,
						         b.spec_unq_num,
						         nvl(sum(decode(c.unit,'��',0,b.qty)),0),
						         NVL(SUM(b.amt),0),
						         0,
						         0,
						         0,
						         0,
									0 result_qty,
									0 result_amt
							  from m_output_detail b,
							       y_budget_detail c
							 where b.dept_code    = as_dept_code
							   and b.yymmdd >= adt_yymm
							   and b.yymmdd < add_months(adt_yymm,1)
								and b.dept_code = c.dept_code
								and c.chg_no_seq = 0
								and b.spec_unq_num = c.spec_unq_num 
								and b.INOUTTYPECODE = '2'    -- ���
								and b.ditag <> '2'            -- �����簡 �ƴѰ� 
						 group by b.dept_code,
									 b.spec_unq_num 
					union all				 
-- ����� �շ�  ����        
						  SELECT b.dept_code,
						         b.spec_unq_num,
						         0,
						         nvl(sum(b.amt),0),
						         0,
						         0,
						         0,
						         0,
									0 result_qty,
									0 result_amt
							  from m_tmat_proj_rent b
							 where b.dept_code    = as_dept_code
							   and b.month= adt_yymm
								and b.spec_unq_num <> 0
						 group by b.dept_code,
									 b.spec_unq_num 
					union all				 
-- ���ֺ� �ڷ� ����        
						  SELECT c.dept_code,
						         c.spec_unq_num, 
						         nvl(sum(decode(c.unit,'��',0,b.tm_prgs_qty)),0),
						         nvl(sum(decode(e.order_class,'2',b.tm_prgs_amt,0)),0),
						         0,
						         0,
						         nvl(sum(decode(e.order_class,'1',b.tm_prgs_amt,0)),0),
                           0,
									nvl(sum(decode(c.unit,'��',0,b.tm_prgs_qty)),0) result_qty,
									nvl(sum(decode(e.order_class,'2',b.tm_prgs_amt,0)),0) result_amt
							  from s_prgs_detail b,
									 s_cn_detail c,
							       C_SPEC_CONST_DETAIL d,
									 s_cn_list e
							 where b.dept_code      = e.dept_code
							   and b.order_number   = e.order_number
                        and b.dept_code      = c.dept_code
								and b.order_number   = c.order_number 
								and b.spec_no_seq    = c.spec_no_seq 
								and b.detail_unq_num = c.detail_unq_num
								and c.dept_code      = d.dept_code
								and c.spec_unq_num   = d.spec_unq_num
								and b.yymm           = d.yymm
								and b.dept_code      = as_dept_code
								and b.yymm = adt_yymm
						 group by c.dept_code,
									 c.spec_unq_num ) b
          group by b.dept_code,
                   b.spec_unq_num ;		
-- ���Աݾ� ���ϱ�                    							 
		UPDATE c_spec_const_detail  a
		  SET (a.cost_qty,a.cost_mat_amt,a.cost_lab_amt,a.cost_equ_amt,a.cost_sub_amt,a.cost_exp_amt,a.cost_amt,a.result_qty,a.result_amt ) =
            ( SELECT b.cost_qty,b.cost_mat_amt,b.cost_lab_amt,b.cost_equ_amt,b.cost_sub_amt,b.cost_exp_amt,
                        b.cost_mat_amt+b.cost_lab_amt+b.cost_equ_amt+b.cost_sub_amt+b.cost_exp_amt,b.result_qty,b.result_amt
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num
								and b.dept_code = as_dept_code
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER)
		 WHERE a.dept_code = as_dept_code
			AND a.yymm      = adt_yymm
			AND EXISTS (SELECT b.cost_qty
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num 
								and b.dept_code = as_dept_code 
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER );

    delete from c_spec_const_cal_tmp where detail_unq_num = C_UNQ_NUMBER;	

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '�������������۾� ����! [Line No: 2]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
   END;
   BEGIN
     -- ���� ���� ���ϱ�    
		UPDATE c_spec_const_detail     -- cost_qty�� ������ ���ֳ� �����ϰ��� �̸� �������Ƿ� 0 �ϰ�쿡�� �ݾ����� qty���
		  SET cost_qty  = decode(amt,0,decode(amt,0,0,trunc(nvl(qty,0) * ( nvl(cost_amt,0) / amt ),3)),cost_qty)
		 WHERE dept_code = as_dept_code
		   AND yymm      = adt_yymm;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '�������� �����۾� ����! [Line No: 2]';
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
END y_sp_c_cost_summary;

/
