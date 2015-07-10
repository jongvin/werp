/* ============================================================================= */
/* �Լ��� : y_sp_c_pre                                                      */
/* ��  �� : �����ϼ��ݾ� ���(�ܰ�/���� ���ϱ�)        .                   */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ����                   ==> ad_date      (date)                       */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �ڵ���                                                               */
/* �ۼ��� : 2005.04.10                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_pre(as_dept_code    IN   VARCHAR2,
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
   C_PERSON        NUMBER(20,1);
   C_SEQ           INTEGER        DEFAULT 0;
   C_UNQ_NUMBER    NUMBER(18,0);
BEGIN

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
               '' 
           from (   
-- ����  ��մܰ� ���ϱ�  
                  SELECT b.dept_code,
                         b.spec_unq_num,
                         0 cost_qty,
                         decode(sum(b.qty),0,0,trunc(sum(b.amt) / sum(b.qty),0)) cost_mat_amt,
                         0 cost_lab_amt,
                         0 cost_equ_amt,
                         0 cost_sub_amt,
                         0 cost_exp_amt
							  from m_input_detail b,
							       y_budget_detail c,
							       C_SPEC_CONST_DETAIL d
							 where b.dept_code = as_dept_code
								and b.yymmdd <  add_months(adt_yymm,1)
								and b.dept_code = c.dept_code
								and b.spec_unq_num = c.spec_unq_num
								and c.chg_no_seq = 0
								and c.unit <> '��'
								and b.dept_code = d.dept_code
								and b.spec_unq_num = d.spec_unq_num
								and d.yymm  = adt_yymm
								and d.mat_unit_fix = 'F' 
								and d.sup_unit_fix = 'F' 
						 group by b.dept_code,
									 b.spec_unq_num
                 union all		
-- ���� ��մܰ� ���ϱ�                  
                 SELECT b.dept_code,
                        b.spec_unq_num,
                        0,
                        0,
                        0,
                        0,
						      decode(sum(b.sub_qty),0,0,trunc(sum(b.sub_amt) / sum(b.sub_qty),0)) sub_price,
						      0
							  from s_cn_detail b,
							       C_SPEC_CONST_DETAIL d
							 where b.dept_code    = as_dept_code 
								and b.unit <> '��'
								and b.dept_code = d.dept_code
								and b.spec_unq_num = d.spec_unq_num
								and d.mat_unit_fix = 'F'
								and d.sup_unit_fix = 'F' 
						 group by b.dept_code,
									 b.spec_unq_num  ) b
          group by b.dept_code,
                   b.spec_unq_num ;								 
 -- ���� �ϼ� �ܰ�  
		UPDATE c_spec_const_detail  a
		  SET (a.sup_unit_amt) = 
            ( SELECT decode(b.cost_mat_amt,0,b.cost_sub_amt,b.cost_mat_amt) 
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num 
                        and b.dept_code = as_dept_code
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER )
		 WHERE a.dept_code = as_dept_code
			AND a.yymm      = adt_yymm
			AND EXISTS (SELECT decode(b.cost_mat_amt,0,b.cost_sub_amt,b.cost_mat_amt) 
							  from c_spec_const_cal_tmp b
							 where a.spec_unq_num = b.spec_unq_num 
                        and b.dept_code = as_dept_code
								and b.yymm         = adt_yymm 
								and b.detail_unq_num = C_UNQ_NUMBER ) ;
								
								
    delete from c_spec_const_cal_tmp where detail_unq_num = C_UNQ_NUMBER;										

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '�����ܰ�(���ֺ�)! [Line No: 2]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
   END;
   BEGIN
-- ���� �ݾ�  ���ϱ�         
		UPDATE c_spec_const_detail  a
		  SET a.pre_result_amt = a.sup_unit_amt * a.sup_qty 
		 WHERE a.dept_code = as_dept_code
			AND a.yymm      = adt_yymm;

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '�����ϼ��ݾ� ! [Line No: 2]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
   END;
   BEGIN                       
   
   
-- ����⼺����
		UPDATE c_spec_const_detail  a
		  SET a.result_qty = decode(a.cost_amt,0,0,decode(a.sup_qty,0,(a.qty - a.ls_result_qty),decode(sign(trunc(a.qty * a.cost_qty / a.sup_qty,3) - a.qty),1,a.qty,trunc(a.qty * a.cost_qty / a.sup_qty,3)))),
		      a.cnt_result_qty = decode(a.sup_qty,0,(a.qty - a.ls_cnt_result_qty),trunc((a.cnt_qty * a.cost_qty / a.sup_qty),3)) 
		 WHERE a.dept_code = as_dept_code
			AND a.yymm      = adt_yymm;

-- ����⼺�ݾ�
		UPDATE c_spec_const_detail  a
		  SET  a.result_amt     = a.price * a.result_qty,
		       a.result_mat_amt = a.mat_price * a.result_qty,
		       a.result_lab_amt = a.lab_price * a.result_qty,
		       a.result_exp_amt = a.exp_price * a.result_qty,
		       a.result_equ_amt = a.equ_price * a.result_qty,
		       a.result_sub_amt = a.sub_price * a.result_qty
		 WHERE a.dept_code = as_dept_code
			AND a.yymm      = adt_yymm;
-- ��������� (y_sp_c_summary_cmpt.sql ���� �������� ����)
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '�����ϼ��ݾ� ! [Line No: 2]';
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
END y_sp_c_pre;

/
