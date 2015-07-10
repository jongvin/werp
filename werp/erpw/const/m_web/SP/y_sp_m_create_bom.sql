/* ============================================================================= */
/* �Լ��� : y_sp_m_create_bom                                     		         */
/* ��  �� : ���೻������ ����BOM�� ���Ͽ� ������ȹ���� �����´�.                 */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2003.09.15                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_create_bom(as_dept_code    IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT max(a.mat_code),sum(nvl(a.qty,0)),sum(nvl(a.amt,0)),max(b.ditag)
  FROM y_budget_detail a,
       m_code_material b
 WHERE a.mat_code = b.mtrcode and
		 a.mat_code is not null and
       a.dept_code = as_dept_code 
GROUP BY a.mat_code;

-- ���� ���� 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   V_MAT_CODE          y_budget_detail.mat_code%TYPE;
   V_QTY               y_budget_detail.qty%TYPE;
   V_AMT               y_budget_detail.amt%TYPE;
   V_DITAG             m_code_material.ditag%TYPE;
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN

	delete from m_month_plan
			where dept_code = as_dept_code;

	delete from m_plan
			where dept_code = as_dept_code;

	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_MAT_CODE,V_QTY,V_AMT,V_DITAG;
		EXIT WHEN DETAIL_CUR%NOTFOUND;

--		IF SUBSTRB(V_MAT_CODE,1,8) <> '00100510' and substrb(V_MAT_CODE,1,8) <> '00100110' THEN
			insert into m_plan
				values ( as_dept_code,V_MAT_CODE,V_DITAG,V_QTY,V_AMT);
--		END IF;
 
	END LOOP;
	CLOSE DETAIL_CUR;

--	SELECT nvl(sum(a.qty),0),nvl(sum(a.amt),0),max(b.ditag)
--	  INTO V_QTY,V_AMT,V_DITAG
--	  FROM y_budget_detail a,
--			 m_code_material b
--	 WHERE a.mat_code = b.mtrcode(+) and
--			 a.dept_code = as_dept_code and
--		    a.mat_code is not null and
--			 substrb(a.mat_code,1,6) = '001003';
--	
--	insert into m_plan
--		values ( as_dept_code,'001003',V_DITAG,V_QTY,V_AMT);
--
--	SELECT nvl(sum(a.qty),0),nvl(sum(a.amt),0),max(b.ditag)
--	  INTO V_QTY,V_AMT,V_DITAG
--	  FROM y_budget_detail a,
--			 m_code_material b
--	 WHERE a.mat_code = b.mtrcode(+) and
--			 a.dept_code = as_dept_code and
--		    a.mat_code is not null and
--			 substrb(a.mat_code,1,8) = '00100110';
--	
--	insert into m_plan
--		values ( as_dept_code,'00100110',V_DITAG,V_QTY,V_AMT);
 
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
END y_sp_m_create_bom;

/
