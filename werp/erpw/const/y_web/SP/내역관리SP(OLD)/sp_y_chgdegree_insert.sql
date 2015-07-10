/* ============================================================================= */
/* �Լ��� : sp_y_chgdegree_insert                                                */
/* ��  �� : ����������� �Է½� �������豸��,���೻���� �ڷḦ �����Ѵ�.         */
/*          (����������豸��,������೻��)                                      */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_proj_code (string)                     */
/*        : ��ȣ(TO  )             ==> ai_no        (Integer)                    */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2001.08.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_chgdegree_insert(as_proj_code    IN   VARCHAR2,
                                                  ai_no           IN   INTEGER,
                                                  as_user         IN   VARCHAR2) IS
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
-- �ش������� ������೻���� ����������豸���� �ڷḦ �����Ѵ�. 
   DELETE FROM Y_CHG_BUDGET_DETAIL
         WHERE ( proj_code  = as_proj_code ) AND  
               ( no         = ai_no )   ;
   DELETE FROM Y_CHG_BUDGET_SUMMARY
         WHERE ( proj_code  = as_proj_code ) AND  
               ( no         = ai_no )   ;

-- �����������豸���� �ش������� ����������豸���� �����Ѵ�. 
   INSERT INTO Y_CHG_BUDGET_SUMMARY  
        SELECT a.proj_code,ai_no,a.sum_code,a.direct_class,
               a.mng_code,a.wbs_code,a.seq,a.llevel,a.parent_sum_code,
               a.invest_class,a.detail_yn,'Y',a.name,a.ssize,a.unit,
               NVL(a.cnt_qty,0),   
               NVL(a.cnt_amt,0),   
               NVL(a.cnt_mat_amt,0),   
               NVL(a.cnt_lab_amt,0),   
               NVL(a.cnt_exp_amt,0),   
               NVL(a.qty,0),   
               NVL(a.amt,0),   
               NVL(a.mat_amt,0),
               NVL(a.lab_amt,0),
               NVL(a.exp_amt,0),
               NVL(a.equ_amt,0),
               NVL(a.sub_amt,0),
               NVL(a.cost_amt,0),
               a.note,a.temp1,a.temp2,a.temp3,a.temp4,a.temp5,sysdate,as_user
          FROM y_budget_summary a 
         WHERE ( a.proj_code = as_proj_code );

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '�������豸������ ����! [Line No: 159]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
 END;
 BEGIN
-- �������೻���� �ش������� ������೻������ �����Ѵ�. 
   INSERT INTO Y_CHG_BUDGET_DETAIL  
        SELECT a.proj_code,ai_no,a.sum_code,a.spec_unq_num,a.detail_code,a.res_class,
               a.seq,a.mng_code,a.wbs_code,a.mat_code,'Y',a.add_yn,
               a.name,a.ssize,a.unit,
               NVL(a.cnt_qty,0),   
               NVL(a.cnt_price,0),   
               NVL(a.cnt_amt,0),   
               NVL(a.cnt_mat_price,0),   
               NVL(a.cnt_mat_amt,0),   
               NVL(a.cnt_lab_price,0),   
               NVL(a.cnt_lab_amt,0),   
               NVL(a.cnt_exp_price,0),   
               NVL(a.cnt_exp_amt,0),   
               NVL(a.qty,0),   
               NVL(a.sub_qty,0),
               NVL(a.price,0),   
               NVL(a.amt,0),   
               NVL(a.mat_price,0),
               NVL(a.mat_amt,0),
               NVL(a.lab_price,0),
               NVL(a.lab_amt,0),
               NVL(a.exp_price,0),
               NVL(a.exp_amt,0),
               NVL(a.equ_price,0),
               NVL(a.equ_amt,0),
               NVL(a.sub_price,0),
               NVL(a.sub_amt,0),
               NVL(a.cost_price,0),
               NVL(a.cost_amt,0),
               a.note,a.temp1,a.temp2,a.temp3,a.temp4,a.temp5,sysdate,as_user
          FROM y_budget_detail a 
         WHERE ( a.proj_code = as_proj_code );

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '���೻������ ����! [Line No: 159]';
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
END sp_y_chgdegree_insert;

/
