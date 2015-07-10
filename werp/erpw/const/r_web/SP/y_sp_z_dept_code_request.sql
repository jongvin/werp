 /* ============================================================================ */
/* �Լ��� : y_sp_z_dept_code_request                                             */
/* ��  �� : ���ֿ������� �����ڵ������û�� �Ѵ�.                                */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_receive_code(string)                   */
/*          ���ֱ���               ==> as_class(string)                          */
/*          �⵵                   ==> as_year(string)                           */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2005.01.17                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_z_dept_code_request(  as_receive_code  IN   VARCHAR2,
                                                       as_class IN VARCHAR2,
                                                       as_year IN VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------

-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Codeai_unq_num
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_RECEIVE_CODE      Z_DEPT_APPROVE.RECEIVE_CODE%TYPE;
   C_DEPT_CODE         Z_DEPT_APPROVE.DEPT_CODE%TYPE;
   C_TEMP_CODE         Z_DEPT_APPROVE.DEPT_CODE%TYPE;
   C_CNT               NUMBER(20,5);  --
BEGIN
 BEGIN
	select max(dept_code),count(*)
	  into C_DEPT_CODE,C_CNT
	  from z_dept_approve
	 where substrb(dept_code,1,3) = as_class || as_year;

	IF C_CNT = 0 THEN
		C_TEMP_CODE := as_class || as_year || '001';
	ELSE
		select to_number(substrb(C_DEPT_CODE,3,3)) 
		  into C_CNT
		  from dual;
		C_CNT := C_CNT + 1;
		IF C_CNT < 10 THEN
			C_TEMP_CODE := as_class || as_year || '00' || C_CNT;
		ELSE
			IF C_CNT < 100 THEN
				C_TEMP_CODE := as_class || as_year || '0' || C_CNT;
			ELSE
				C_TEMP_CODE := as_class || as_year || C_CNT;
			END IF;
		END IF;
	END IF;

	INSERT INTO z_dept_approve
					( spec_unq_num,approve_class,dept_code,long_name,short_name,dept_proj_tag,receive_code,request_dt,create_dt,comp_code)
		  SELECT y_spec_unq_no.nextval,'1',C_TEMP_CODE,name,const_shortname,'P',receive_code,sysdate,'','10'
			 FROM r_receive_code
			WHERE receive_code = as_receive_code;

	UPDATE r_receive_code  
	  SET approve_class = '2'   
   WHERE receive_code = as_receive_code;

      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '�����ڵ������û ����! [Line No: 159]';
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
END y_sp_z_dept_code_request;
/

