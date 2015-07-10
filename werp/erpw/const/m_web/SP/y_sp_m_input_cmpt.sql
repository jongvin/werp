/* ============================================================================= */
/* �Լ��� : y_sp_m_input_cmpt                                                    */
/* ��  �� : �����԰�� �ݾ��� �����Ѵ�.                                        */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ����                   ==> ad_date      (date)                       */
/*        : ����                   ==> ai_seq      (INTEGER)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.05.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_input_cmpt(as_dept_code    IN   VARCHAR2,
																 ad_date         IN   DATE,
                                                 ai_seq          IN   INTEGER ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   V_INPUT_UNQ_NUM     m_input_detail.input_unq_num%TYPE;
   C_QTY               m_input_detail.qty%TYPE;                -- ����
   C_PRICE             m_input_detail.unitprice%TYPE;          -- �ܰ�
   C_AMT               m_input_detail.amt%TYPE;                -- �ݾ�
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
		select nvl(sum(amt),0)
		  into C_AMT
		  from m_input_detail
		  where dept_code     = as_dept_code
			 and yymmdd        = ad_date 
       	 and seq           = ai_seq; 


       UPDATE m_input
          SET total_amt = NVL(C_AMT,0)
		  where dept_code     = as_dept_code
			 and yymmdd        = ad_date 
       	 and seq           = ai_seq ;
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
END y_sp_m_input_cmpt;

/
