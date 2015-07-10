/* ============================================================================= */
/* �Լ��� : sp_y_esmt_emsconvert_tmp                                             */
/* ��  �� : EMS�ڷ� ��ȯ��(����) �������а� �ڿ��ڵ� Match Check��.              */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_receive_code (string)                     */
/*        : �κ�                   ==> as_part      (string)                     */
/*        : ��ȣ                   ==> ai_degree    (string)                     */
/*        : �����                 ==> as_user      (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2001.08.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_esmt_emsconvert_tmp(as_receive_code    IN   VARCHAR2,
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
   UPDATE y_esmt_tmp_detail a
      SET a.res_connect_yn = 'Y'
    WHERE (a.receive_code = as_receive_code) AND 
          (a.part_class   = as_part) AND
         EXISTS (SELECT b.detail_code
	                FROM y_stand_spec b
                  WHERE  a.detail_code = b.detail_code);


-- ���豸�������� �������п� 'Y'�� Setting �Ѵ�. 
   update y_esmt_tmp_summary a
      set a.detail_yn = 'Y'
   WHERE (a.receive_code = as_receive_code) AND 
         (a.part_class   = as_part) and
         (a.sum_code  in (select b.parent_sum_code
                            from y_esmt_tmp_summary b
                           where a.receive_code = b.receive_code
                             and a.part_class   = b.part_class));


   update y_esmt_tmp_summary a
      set a.invest_class = 'Y',
          a.detail_yn = 'Y'
    where (a.receive_code  = as_receive_code)
      and (a.part_class = as_part)
      and (a.sum_code  in ( select sum_code
                              from y_esmt_tmp_detail
                             where receive_code  = as_receive_code
                               and part_class = as_part
                          group by receive_code,
                                   part_class,
                                   sum_code));

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
END sp_y_esmt_emsconvert_tmp;

/
