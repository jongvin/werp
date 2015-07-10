/* ============================================================================= */
/* �Լ��� : sp_y_budget_emsconvert_tmp                                           */
/* ��  �� : EMS�ڷ� ��ȯ��(����) �������а� �ڿ��ڵ� Match Check��.              */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_proj_code (string)                     */
/*        : �κ�                   ==> as_part      (string)                     */
/*        : ��ȣ                   ==> ai_degree    (string)                     */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2001.08.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_budget_emsconvert_tmp(as_proj_code    IN   VARCHAR2,
                                                       as_part         IN   VARCHAR2,
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
-- ǥ���ڿ��� ����ȵǸ� 'N'�� Setting�Ѵ�. 
   UPDATE y_tmp_detail a
      SET a.res_connect_yn = 'Y'
    WHERE (a.proj_code = as_proj_code) AND 
          (a.part_class = as_part) AND
         EXISTS (SELECT b.detail_code
	                FROM y_stand_spec b
                  WHERE  a.name_key = b.name_key);

   UPDATE y_tmp_detail a
      SET (a.detail_code) = 
          ( SELECT min(b.detail_code)
              FROM y_stand_spec b
             WHERE a.name_key = b.name_key )
    WHERE (a.proj_code = as_proj_code) AND 
          (a.part_class = as_part) AND
          (a.res_connect_yn = 'Y') ;

-- ���豸�������� �������п� 'Y'�� Setting �Ѵ�. 
   update y_tmp_summary a
      set a.detail_yn = 'Y'
   WHERE (a.proj_code      = as_proj_code) AND 
         (a.part_class     = as_part) and
         (a.sum_code  in (select b.parent_sum_code
                            from y_tmp_summary b
                           where a.proj_code = b.proj_code
                             and a.part_class = b.part_class));


   update y_tmp_summary a
      set a.invest_class = 'Y',
          a.detail_yn = 'Y'
    where (a.proj_code  = as_proj_code)
      and (a.part_class = as_part)
      and (a.sum_code  in ( select sum_code
                              from y_tmp_detail
                             where proj_code  = as_proj_code
                               and part_class = as_part
                          group by proj_code,
                                   part_class,
                                   sum_code));

-- �ش������� ���೻���� ����Ǹ� 'Y'�� Setting�Ѵ�. 
--   UPDATE y_tmp_detail a
--      SET a.connect_yn = 'Y'
--    WHERE (a.proj_code = as_proj_code) AND 
--          (a.part_class = as_part) AND
--         EXISTS (SELECT b.detail_code
--	                FROM y_chg_budget_detail b
--                  WHERE a.sum_code    = b.sum_code
--                    AND a.detail_code = b.detail_code
--                    AND b.proj_code = as_proj_code
--                    AND b.no        = ai_no);

-- �ش������� �������豸���� ����Ǹ� 'Y'�� Setting�Ѵ�. 
--   UPDATE y_tmp_summary a
--      SET a.connect_yn  = 'Y'
--    WHERE (a.proj_code  = as_proj_code) AND 
--          (a.part_class = as_part) AND
--         EXISTS (SELECT b.sum_code
--	                FROM y_chg_budget_summary b
--                  WHERE a.sum_code    = b.sum_code
--                    AND b.proj_code = as_proj_code
--                    AND b.no        = ai_no);

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'EMS �ڷắȯ ����! [Line No: 159]';
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
END sp_y_budget_emsconvert_tmp;

/
