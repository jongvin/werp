/* ============================================================================= */
/* �Լ��� : y_sp_c_invest_parent                                                 */
/* ��  �� : ��ó�������������迡 ó�����а��� �־��ش�.     				         */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ���                   ==> ad_date      (date)                       */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �ǹ̻�                                                               */
/* �ۼ��� : 2005.05.27                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_invest_parent(as_dept_code  IN   VARCHAR2,
                                                      ad_date    IN   DATE ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT acntcode,
		 nvl(amt,0)
  FROM C_INVEST_PARENT
 WHERE dept_code = as_dept_code
   AND yymm    = ad_date;

-- ���� ���� 
   v_acntcode      	  C_INVEST_PARENT.acntcode%TYPE;
   v_amt          	  C_INVEST_PARENT.amt%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_AMT           NUMBER(15,0);
   C_CNT           NUMBER(10,3);

BEGIN
   BEGIN
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_acntcode,v_amt;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			
			select count(*)
			  into C_CNT
			  from c_invest_detail
			 where dept_code 	= as_dept_code
				and yymm    	= ad_date
				and acntcode   = v_acntcode;

			IF C_CNT > 0 THEN
				select nvl(sum(amt),0)
				  into C_AMT
				  from c_invest_detail
				 where dept_code 	= as_dept_code
					and yymm    	= ad_date
					and acntcode   = v_acntcode;

				IF C_AMT = v_amt THEN
					UPDATE C_INVEST_PARENT
						SET PROCESS_YN = 'Y'
					 WHERE DEPT_CODE = as_dept_code
						AND yymm    = ad_date
						AND acntcode  = v_acntcode;
				END IF;
			END IF;
		END LOOP;
		CLOSE DETAIL_CUR;

		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '����ü�������� �����۾� ����! [Line No: 2]';
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
END y_sp_c_invest_parent;

/
