/* ============================================================================= */
/* �Լ��� : y_sp_f_slip_detail4                                                  */
/* ��  �� : �ڵ���ǥ����������(�빫��).                  */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ������                 ==> adt_from_date(date)                       */
/*        : ������                 ==> adt_to_date(date)                         */
/*        : ��ǥ��                 ==> adt_slip_date(date)                       */
/*        : ��񱸺�               ==> arg_res_type(string)                      */
/*        : ��ǥ�����ڵ�           ==> as_class(string)                          */
/*        : ��ǥ��ȣ               ==> arg_seq(integer)                          */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.08.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_slip_detail4(as_dept_code    IN   VARCHAR2, 
                                        		   adt_from_yymm   IN   DATE,
															   adt_to_yymm     IN   DATE,
															   adt_slip_date   IN   DATE,
																arg_res_type    IN   VARCHAR2,
																as_class        IN   VARCHAR2,
															   arg_seq         IN   INTEGER, 
															   arg_slip_name   IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------

-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   v_rqst_detail   f_request.RQST_DETAIL%TYPE;
   v_cust_code     f_request.CUST_CODE%TYPE;
   v_deptdetail_code      erpc.am_code_dept_rela.DEPTDETAIL_CODE%TYPE;
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_DATE			 DATE;
   C_ACNT_CODE     f_request.ACNTCODE%TYPE;
   C_CNT           NUMBER(10,3);
   C_AMT           NUMBER(12,0);
   C_WORK_CNT      INTEGER;
   C_PERS_CNT      INTEGER;
   C_SODUK_AMT     NUMBER(12,0);
   C_TAX_CNT       NUMBER(12,0);
   C_INCOME_TAX    NUMBER(12,0);
   C_CIVIL_TAX     NUMBER(12,0);
   C_WORK_NO       NUMBER(6,0);
	C_KIND_CODE     VARCHAR2(3);
	C_EVIDENCE_KIND VARCHAR2(3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN
		C_SEQ := 1;
		C_AMT := 0;

	   e_msg      := '�빫�� �ڵ���ǥ ���� ! [Line No: 1]';
	   
		SELECT MAX(DEPTDETAIL_CODE) 
        INTO v_deptdetail_code 
 		   FROM ERPC.AM_CODE_DEPT_RELA  
        WHERE dept_code = as_dept_code 
          and DEPTDETAIL_CODE <> '530'
        ;

		-- �빫��� �ŷ�ó�� �����ڵ带 �Է��Ѵ�.
		C_ACNT_CODE := '50120501';    --�빫�� ���(��õ)
		
		--�⿪�ϼ�
	   e_msg      := '�빫�� �ڵ���ǥ ���� ! [Line No: 2]';
		select sum(count(*))
		  into C_WORK_CNT 
        from (select distinct work_date   
                from l_labor_dailywork
               where dept_code = as_dept_code 
                 and work_date between adt_from_yymm and adt_to_yymm
             ) a
        group by a.work_date; 
		if C_WORK_CNT is null  then 
			C_WORK_CNT := 0;        
      end if;        

		--�����޾�
	   e_msg      := '�빫�� �ڵ���ǥ ���� ! [Line No: 3]';
		select sum(pay_amt)  
		  into C_AMT  
		  from l_labor_dailywork
		 where dept_code = as_dept_code 
		   and work_date between adt_from_yymm and adt_to_yymm ;
		if C_AMT is null  then 
			C_AMT := 0;        
      end if;        

		--���ο���
	   e_msg      := '�빫�� �ڵ���ǥ ���� ! [Line No: 4]';
		select sum(count(*))
		  into C_PERS_CNT
        from (select distinct civil_register_number    
                from l_labor_dailywork
               where dept_code = as_dept_code 
                 and work_date between adt_from_yymm and adt_to_yymm
             ) a
        group by a.civil_register_number; 
		if C_PERS_CNT is null  then 
			C_PERS_CNT := 0;        
      end if;        

		--�ҵ�ݾ�
	   e_msg      := '�빫�� �ڵ���ǥ ���� ! [Line No: 5]';
		select sum(pay_amt)  
		  into C_SODUK_AMT  
		  from l_labor_dailywork
		 where income_tax <> 0        
		   and dept_code = as_dept_code 
		   and work_date between adt_from_yymm and adt_to_yymm ; 
		if C_SODUK_AMT is null  then 
			C_SODUK_AMT := 0;        
      end if;        

		--�����ο���
	   e_msg      := '�빫�� �ڵ���ǥ ���� ! [Line No: 6]';
		select sum(count(*))
		  into C_TAX_CNT
        from (select distinct civil_register_number           
                from l_labor_dailywork
               where income_tax <> 0 
                 and dept_code = as_dept_code 
                 and work_date between adt_from_yymm and adt_to_yymm
             ) a
        group by a.civil_register_number;   
		if C_TAX_CNT is null  then 
			C_TAX_CNT := 0;        
      end if;        
        
		--�ҵ漼, �ֹμ�
	   e_msg      := '�빫�� �ڵ���ǥ ���� ! [Line No: 7]';
		select sum(income_tax),   
		       sum(civil_tax) 
		  into C_INCOME_TAX,  
		       C_CIVIL_TAX   
		  from l_labor_dailywork
		 where dept_code = as_dept_code 
		   and work_date between adt_from_yymm and adt_to_yymm ; 
		if C_INCOME_TAX is null  then 
			C_INCOME_TAX := 0;        
      end if;        
		if C_CIVIL_TAX  is null  then 
			C_CIVIL_TAX  := 0;        
      end if;        

	   e_msg      := '�빫�� �ڵ���ǥ ���� ! [Line No: 8]';
		INSERT INTO erpc.AM_WORK_DETAIL  
		VALUES ( adt_slip_date,arg_seq,C_SEQ,C_SEQ,as_dept_code,as_class,'01',as_dept_code,v_deptdetail_code,   
				 C_ACNT_CODE,C_ACNT_CODE,C_AMT,0,C_AMT,0,0,0,to_char(adt_to_yymm,'YYYY.MM') || '�� ����',to_char(adt_to_yymm,'YYYY.MM') || '�� ����',   
				 '01',v_cust_code,null,null,null,null,null,null,null,null,null,null,null,null,null,'015',null,   
				 null,null,C_WORK_CNT,0,C_AMT,0,C_SODUK_AMT,C_INCOME_TAX,C_CIVIL_TAX,C_PERS_CNT,C_TAX_CNT,adt_slip_date,adt_slip_date,NULL,null,null,null,null,null,
				 null,null,null,arg_slip_name,sysdate,arg_slip_name,sysdate,null) ; 

   		C_SEQ := C_SEQ + 1;

--		IF as_class = 'CM5' THEN
--			C_ACNT_CODE := '10117901';    -- ������
--		ELSE
--			C_ACNT_CODE := '20110101';    -- �ܻ���Ա�
--		END IF;
		
		C_ACNT_CODE := '20113504';    -- �����޺��(���)

	   e_msg      := '�빫�� �ڵ���ǥ ���� ! [Line No: 9]';
		INSERT INTO erpc.AM_WORK_DETAIL  
		VALUES ( adt_slip_date,arg_seq,C_SEQ,C_SEQ,as_dept_code,as_class,'01',as_dept_code,v_deptdetail_code,   
				 C_ACNT_CODE,C_ACNT_CODE,0,0,0,C_AMT,0,C_AMT,to_char(adt_to_yymm,'YYYY.MM') || '�� ����',to_char(adt_to_yymm,'YYYY.MM') || '�� ����',   
				 '01',v_cust_code,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,   
				 null,null,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,null,null,null,null,null,
				 null,null,null,arg_slip_name,sysdate,arg_slip_name,sysdate,null) ; 

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
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
END y_sp_f_slip_detail4;

/
