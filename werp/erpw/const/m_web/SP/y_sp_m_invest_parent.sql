/* ============================================================================= */
/* �Լ��� : y_sp_m_invest_parent                                                 */
/* ��  �� : �����������迡 ó�����а��� �־��ش�.     						         */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ���                   ==> ad_date      (date)                       */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.12.16                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_invest_parent(as_dept_code  IN   VARCHAR2,
                                                      ad_date    IN   DATE ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT mtrcode,
		 ditag,
		 nvl(qty,0),
		 nvl(amt,0)
  FROM M_INVEST_PARENT
 WHERE dept_code = as_dept_code
   AND yymmdd    = ad_date;

-- ���� ���� 
   v_mtrcode      	  M_INVEST_PARENT.mtrcode%TYPE;
   v_ditag         	  M_INVEST_PARENT.ditag%TYPE;
   v_qty          	  M_INVEST_PARENT.qty%TYPE;
   v_amt          	  M_INVEST_PARENT.amt%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_QTY           NUMBER(15,3);
   C_AMT           NUMBER(15,0);
   C_CNT           NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN
   BEGIN
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_mtrcode,v_ditag,v_qty,v_amt;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			
			select count(*)
			  into C_CNT
			  from m_invest_detail
			 where dept_code = as_dept_code
				and yymmdd    = ad_date
				and mtrcode   = v_mtrcode
				and ditag     = v_ditag;

			IF C_CNT > 0 THEN
				select nvl(sum(qty),0),nvl(sum(amt),0)
				  into C_QTY,C_AMT
				  from m_invest_detail
				 where dept_code = as_dept_code
					and yymmdd    = ad_date
					and mtrcode   = v_mtrcode
					and ditag     = v_ditag;

				IF C_QTY = v_qty AND C_AMT = v_amt THEN
					UPDATE M_INVEST_PARENT
						SET PROCESS_YN = 'Y'
					 WHERE DEPT_CODE = as_dept_code
						AND yymmdd    = ad_date
						AND mtrcode   = v_mtrcode
						AND ditag     = v_ditag;
				END IF;
			END IF;
		END LOOP;
		CLOSE DETAIL_CUR;

		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '��������� �����۾� ����! [Line No: 1]';
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
END y_sp_m_invest_parent;

/
