/* ============================================================================= */
/* 함수명 : y_sp_m_output_trans_cancel                                           */
/* 기  능 : 자재전출취소처리를 한다. 			                                    */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 일자                   ==> ad_date      (date)                       */
/*        : 순번                   ==> ai_seq      (INTEGER)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2005.07.21                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_output_trans_cancel(as_dept_code    IN   VARCHAR2,
																 as_to_dept      IN   VARCHAR2,
																 as_date         IN   DATE,
																 as_to_date      IN   DATE,
																 ai_seq          IN   INTEGER,
                                                 ai_to_seq       IN   INTEGER ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
select input_unq_num
from m_input_detail 
where dept_code = as_to_dept
  and yymmdd    = as_to_date
  and seq       = ai_to_seq
  and ditag     = '2';

-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   V_INPUT_UNQ_NUM     m_input_detail.input_unq_num%TYPE;
   C_QTY               m_input_detail.qty%TYPE;                -- 수량
   C_PRICE             m_input_detail.unitprice%TYPE;          -- 단가
   C_AMT               m_input_detail.amt%TYPE;                -- 금액
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
              e_msg      := '전출취소처리 실패! [Line No: 159]';
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
END y_sp_m_output_trans_cancel;

/
