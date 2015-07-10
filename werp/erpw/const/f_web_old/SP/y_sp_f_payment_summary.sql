/* ============================================================================= */
/* �Լ��� : y_sp_f_payment_summary                                               */
/* ��  �� : �ڱ�û���������� ������ �ڷḦ �ڱ����೻���� �־��ش�.              */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ����                   ==> ad_date      (date)                       */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.05.26                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_payment_summary(as_dept_code  IN   VARCHAR2,
                                                      ad_date    IN   DATE ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT rqst_date,seq,res_type,rqst_detail,cust_code,cust_name,amt,vat,fund_type
  FROM f_request 
 WHERE dept_code    = as_dept_code AND
       to_char(rqst_date,'YYYY.MM') = to_char(ad_date,'YYYY.MM') AND
       (fund_type = '2' or fund_type = '4');

-- ���� ���� 
   v_rqst_date         f_request.rqst_date%TYPE;
   v_seq               f_request.seq%TYPE;
   v_res_type          f_request.res_type%TYPE;
   v_rqst_detail       f_request.rqst_detail%TYPE;
   v_cust_code         f_request.cust_code%TYPE;
   v_cust_name         f_request.cust_name%TYPE;
   v_amt               f_request.amt%TYPE;
   v_vat               f_request.vat%TYPE;
   v_fund_type         f_request.fund_type%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_CNT           NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_rqst_date,v_seq,v_res_type,v_rqst_detail,v_cust_code,v_cust_name,v_amt,
										 v_vat,v_fund_type;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			
			select nvl(max(seq),0)
 			  into C_SEQ
			  from f_payment
			 where dept_code = as_dept_code
			   and pay_date  = v_rqst_date;

			C_SEQ := C_SEQ + 1;

			INSERT INTO F_PAYMENT  
			VALUES ( as_dept_code,v_rqst_date,C_SEQ,v_res_type,v_rqst_detail,
						v_cust_code,v_cust_name,v_amt,v_vat,v_fund_type )  ;

		END LOOP;
		CLOSE DETAIL_CUR;

		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '�ڱ����೻�� �����۾� ����! [Line No: 2]';
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
END y_sp_f_payment_summary;

/
