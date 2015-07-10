/* ============================================================================= */
/* 함수명 : y_sp_m_tmat_master                                                   */
/* 기  능 : 자재입고전표 확정시 가설재재고에 자료를 넣어준다.                    */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code   (string)                   */
/*        : 년월                   ==> ad_date        (date)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2005.03.17                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_tmat_master(as_dept_code  IN   VARCHAR2,
                                                  ad_date    IN   DATE ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------

CURSOR DETAIL_CUR IS
select a.yymmdd,a.seq,a.input_unq_num,a.detailseq,a.mtrcode,a.name,a.ssize,a.unitcode,a.qty,c.years,a.amt
  from m_input_detail a,
		 m_vat b,
		 m_code_material c
 where a.mtrcode = c.mtrcode
   and b.dept_code = a.dept_code
	and b.vat_unq_num = a.vat_unq_num
   and a.ditag = '2'
   and a.inouttypecode in ('1','8')
	and b.dept_code = as_dept_code
   and trunc(b.work_dt,'MM') = trunc(ad_date,'MM')
   and a.input_unq_num not in ( select input_unq_num from m_tmat_stock where dept_code = as_dept_code );


-- 공통 변수 
   v_yymmdd      	     m_input_detail.yymmdd%TYPE;
   v_seq       	     m_input_detail.seq%TYPE;
   v_input_unq_num  	  m_input_detail.input_unq_num%TYPE;
   v_detailseq  	     m_input_detail.detailseq%TYPE;
   v_mtrcode        	  m_input_detail.mtrcode%TYPE;
   v_name         	  m_input_detail.name%TYPE;
   v_ssize         	  m_input_detail.ssize%TYPE;
   v_unitcode       	  m_input_detail.unitcode%TYPE;
   v_qty 			 	  m_input_detail.qty%TYPE;
   v_years         	  m_code_material.years%TYPE;
   v_amt 			 	  m_input_detail.amt%TYPE;

   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found

BEGIN  
   BEGIN

		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO v_yymmdd,v_seq,v_input_unq_num,v_detailseq,v_mtrcode,v_name,v_ssize,v_unitcode,v_qty,v_years,v_amt;
			EXIT WHEN DETAIL_CUR%NOTFOUND;

			INSERT INTO M_TMAT_STOCK  
			VALUES ( as_dept_code,v_yymmdd,v_seq,v_input_unq_num,v_detailseq,v_mtrcode,v_name,v_ssize,v_unitcode,v_qty,v_years,'Y',v_amt)  ;

		END LOOP;
		CLOSE DETAIL_CUR;

		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '가설재마스터등록 작업 실패! [Line No: 1]';
				  Wk_errflag := -20020;
			
				  GOTO EXIT_ROUTINE;
			  END IF;   
	END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   
   -- ENDING...[0.1] CURSOR CLOSE 재 확인 처리 !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- 사용자 정의 Error Message
      Wk_errflag := 0;                         -- 사용자 정의 Error Code
   ELSE 
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;

EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END y_sp_m_tmat_master;

/
