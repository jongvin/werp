/* ============================================================================= */
/* �Լ��� : y_sp_m_output_trans_cancel                                           */
/* ��  �� : �����������ó���� �Ѵ�. 			                                    */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ����                   ==> ad_date      (date)                       */
/*        : ����                   ==> ai_seq      (INTEGER)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2005.07.21                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_output_trans_cancel(as_dept_code    IN   VARCHAR2,
																 as_to_dept      IN   VARCHAR2,
																 as_date         IN   DATE,
																 as_to_date      IN   DATE,
																 ai_seq          IN   INTEGER,
                                                 ai_to_seq       IN   INTEGER ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
select input_unq_num
from m_input_detail 
where dept_code = as_to_dept
  and yymmdd    = as_to_date
  and seq       = ai_to_seq
  and ditag     = '2';

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
   C_SEQ               INTEGER;  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
		UPDATE m_output  
		   set trans_tag = '1' 
       WHERE dept_code = as_dept_code
         AND yymmdd = as_date
         AND seq   = ai_seq;

		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_INPUT_UNQ_NUM;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			
			delete from m_tmat_stock
			where dept_code = as_to_dept
			  and yymmdd = as_to_date
			  and seq    = ai_to_seq
			  and input_unq_num = V_INPUT_UNQ_NUM;
		
		END LOOP;
		CLOSE DETAIL_CUR;

		delete from m_input_detail
			where dept_code = as_to_dept
			  and yymmdd = as_to_date
			  and seq    = ai_to_seq;
	
		delete from m_input
			where dept_code = as_to_dept
			  and yymmdd = as_to_date
			  and seq    = ai_to_seq;

      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '�������ó�� ����! [Line No: 159]';
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
END y_sp_m_output_trans_cancel;

/
