/* ============================================================================= */
/* �Լ��� : y_sp_m_invest_process                                                */
/* ��  �� : ����������� ������������� �������Գ����� �־��ش�.               */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ���                   ==> ad_date      (date)                       */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.12.16                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_invest_process(as_dept_code  IN   VARCHAR2,
                                                      ad_date    IN   DATE ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT max(mtrcode),
		 max(ditag),
		 max(spec_no_seq),
		 max(spec_unq_num),
		 nvl(sum(qty),0),
		 nvl(sum(amt),0)
  FROM M_OUTPUT_DETAIL 
 WHERE dept_code    = as_dept_code
   AND trunc(yymmdd,'MM') = trunc(ad_date,'MM')
   AND inouttypecode IN ('M','N','P','S','R')
	AND spec_unq_num <> 0
group by mtrcode,ditag,spec_unq_num;

-- ���� ���� 
   v_mtrcode      	  M_OUTPUT_DETAIL.mtrcode%TYPE;
   v_ditag         	  M_OUTPUT_DETAIL.ditag%TYPE;
   v_spec_no_seq  	  M_OUTPUT_DETAIL.spec_no_seq%TYPE;
   v_spec_unq_num 	  M_OUTPUT_DETAIL.spec_unq_num%TYPE;
   v_qty          	  M_OUTPUT_DETAIL.qty%TYPE;
   v_amt          	  M_OUTPUT_DETAIL.amt%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_QTY           NUMBER(15,3);
   C_PRICE         NUMBER(15,0);
   C_AMT           NUMBER(15,0);
   C_CNT           NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN
		DELETE FROM M_INVEST_DETAIL  
		  	   WHERE DEPT_CODE = as_dept_code
				  AND yymmdd    = ad_date  ;

		DELETE FROM M_INVEST_PARENT  
		  	   WHERE DEPT_CODE = as_dept_code
				  AND yymmdd    = ad_date  ;

		INSERT INTO M_INVEST_PARENT  
		  SELECT as_dept_code,ad_date,max(MTRCODE),max(DITAG),max(name),max(ssize),max(unitcode),
					nvl(sum(QTY),0),0,nvl(sum(AMT),0),'N'  
			 FROM M_OUTPUT_DETAIL  
		   WHERE dept_code    = as_dept_code
			  AND trunc(yymmdd,'MM') = trunc(ad_date,'MM')
			  AND inouttypecode IN ('M','N','P')
		group by mtrcode,ditag;

		UPDATE M_INVEST_PARENT
		   SET UNITPRICE = ROUND(amt / qty,0) 
		 WHERE DEPT_CODE = as_dept_code
			AND yymmdd = ad_date
			AND qty > 0 ;
		
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_mtrcode,v_ditag,v_spec_no_seq,v_spec_unq_num,v_qty,v_amt;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			
			select count(*)
			  into C_CNT
			  from m_invest_parent
			 where dept_code = as_dept_code
				and yymmdd    = ad_date
				and mtrcode   = v_mtrcode
				and ditag     = v_ditag;

			IF C_CNT > 0 THEN
				select nvl(max(seq),0)
				  into C_SEQ
				  from m_invest_detail
				 where dept_code = as_dept_code
					and yymmdd    = ad_date
					and mtrcode   = v_mtrcode
					and ditag     = v_ditag;
	
				C_SEQ := C_SEQ + 1;
				IF v_qty > 0 THEN
					C_PRICE := round(v_amt / v_qty,0);
				ELSE
					C_PRICE := 0;
				END IF;
	
				INSERT INTO m_invest_detail  
				VALUES ( as_dept_code,ad_date,v_mtrcode,v_ditag,C_SEQ,v_qty,C_PRICE,v_amt,v_spec_no_seq,v_spec_unq_num )  ;
			END IF;
		END LOOP;
		CLOSE DETAIL_CUR;

		y_sp_m_invest_parent(as_dept_code,ad_date);

		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '��������� �����۾� ����! [Line No: 2]';
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
END y_sp_m_invest_process;

/
