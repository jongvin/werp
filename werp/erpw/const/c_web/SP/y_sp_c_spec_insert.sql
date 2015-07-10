/* ============================================================================= */
/* �Լ��� : y_sp_c_spec_insert                                                   */
/* ��  �� : �������� �ݿ������ڷḦ����.  							                  */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ����                   ==> ad_date      (date)                       */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �ڵ��� ����                                                                */
/* �ۼ��� : 2003.05.26                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_spec_insert(as_dept_code    IN   VARCHAR2,
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

BEGIN
	BEGIN
		INSERT INTO C_SPEC_CONST_PARENT  
		  SELECT DEPT_CODE,adt_yymm,SPEC_NO_SEQ,   
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,WBS_CODE,   
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,
					0,0,0,0  
			 FROM Y_BUDGET_PARENT  
			WHERE ( DEPT_CODE = as_dept_code ) AND  
					( CHG_NO_SEQ = 0 ) AND  
					( SPEC_NO_SEQ not in (  SELECT SPEC_NO_SEQ  
													  FROM C_SPEC_CONST_PARENT  
													 WHERE ( DEPT_CODE = as_dept_code ) AND  
															 ( YYMM = adt_yymm )  ))   ;

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '�������豸������ ����! [Line No: 2]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
   END;
	BEGIN
		INSERT INTO C_SPEC_CONST_DETAIL  
		  SELECT DEPT_CODE,adt_yymm,SPEC_NO_SEQ,SPEC_UNQ_NUM,   
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',   
					qty * price,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,qty,price,'F',qty,price,
					amt,mat_price,mat_amt,lab_price,lab_amt,exp_price,exp_amt,equ_price,equ_amt,sub_price,sub_amt,
					cnt_qty,cnt_price,cnt_amt,cnt_mat_price,cnt_mat_amt,cnt_lab_price,cnt_lab_amt,cnt_exp_price,cnt_exp_amt,
					'F'
			 FROM Y_BUDGET_DETAIL
			WHERE ( DEPT_CODE = as_dept_code ) AND  
					( CHG_NO_SEQ = 0 ) AND  
					( SPEC_UNQ_NUM not in (  SELECT SPEC_UNQ_NUM  
													  FROM C_SPEC_CONST_DETAIL  
													 WHERE ( DEPT_CODE = as_dept_code ) AND  
															 ( YYMM = adt_yymm )  ))   ;		

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '���೻������ ����! [Line No: 2]';
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
END y_sp_c_spec_insert;

/
