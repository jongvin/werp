 /* ============================================================================ */
/* �Լ��� : y_sp_slip_delete(CJ����)                                             */
/* ��  �� : ��ǥ�� �����Ѵ�                                                      */
/* ----------------------------------------------------------------------------- */
/* ��  �� : ��ǥ��ȣ               ==> ai_seq (number)                           */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2006.04.12                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_slip_delete (ai_seq   IN   NUMBER) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------

-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   Wk_Chk              NUMBER(10,0) DEFAULT 0 ;
   WK_Chk_msg          VARCHAR2(100);

-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
 BEGIN
-- ��ǥ�� �����Ѵ�
  		PKG_T_Check_Slip.DeleteMaster(ai_seq);

		update f_request
			set invoice_num = '',work_date = ''
		 where invoice_num = ai_seq;

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '��ǥ���� ����! [Line No: 1]';
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
END y_sp_slip_delete;
