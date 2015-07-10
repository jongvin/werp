/* ============================================================================= */
/* 함수명 : y_sp_m_input_delivery                                                */
/* 기  능 : 자재입고시 즉출자료를 출고에 넣어준다.                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 일자                   ==> ad_date      (date)                       */
/*        : 순번                   ==> ai_seq      (INTEGER)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.05.15                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_input_delivery(as_dept_code    IN   VARCHAR2,
																  ad_date         IN   DATE,
                                                  ai_seq          IN   INTEGER ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT A.input_unq_num
  FROM m_input_detail A
 WHERE A.dept_code    = as_dept_code AND
       A.yymmdd = ad_date AND
       A.seq  = ai_seq  AND
		 A.deliverytag = 1
order by a.detailseq;
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   V_INPUT_UNQ_NUM     m_input_detail.input_unq_num%TYPE;
   C_AMT               m_input_detail.amt%TYPE;                -- 금액
   C_CNT               NUMBER(20,5);  -- 
   C_SEQ               NUMBER(20,5);  -- 
   C_KSEQ              NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
		SELECT count(*)
		  INTO C_CNT
		  FROM m_input_detail 
		 WHERE dept_code    = as_dept_code AND
				 yymmdd = ad_date AND
				 seq  = ai_seq  AND
				 deliverytag = 1;

		IF C_CNT > 0 THEN
			select NVL(MAX(seq),0)
			  into C_KSEQ
			  from m_output
			  where dept_code     = as_dept_code
				 and yymmdd        = ad_date 
				 and inouttypecode = '2'; 
	
			IF C_KSEQ < 1 THEN
				select NVL(MAX(seq),0)
				  into C_KSEQ
				  from m_output
				 where dept_code     = as_dept_code
				   and yymmdd        = ad_date ;

				C_KSEQ := C_KSEQ + 1;

				insert into m_output
					 select dept_code,yymmdd,C_KSEQ,inputtitle,'',null,0,'2',paymethod,0,'',memo
						from m_input
					  where dept_code     = as_dept_code
						 and yymmdd        = ad_date 
						 and seq           = ai_seq; 
			END IF;

			OPEN	DETAIL_CUR;
			LOOP
				FETCH DETAIL_CUR INTO V_INPUT_UNQ_NUM;
				EXIT WHEN DETAIL_CUR%NOTFOUND;
				
				select count(*)
				  into C_CNT
				  from m_output_detail
				 where dept_code     = as_dept_code
				   and yymmdd        = ad_date 
					and input_unq_num = V_INPUT_UNQ_NUM; 
				IF C_CNT < 1 THEN
					select nvl(max(detailseq),0)
					  into C_SEQ
					  from m_output_detail
					 where dept_code     = as_dept_code
						and yymmdd        = ad_date 
						and seq           = C_KSEQ;

					C_SEQ := C_SEQ + 1;

					insert into m_output_detail
						select dept_code,yymmdd,C_KSEQ,m_spec_unq_no.nextval,C_SEQ,mtrcode,name,ssize,unitcode,
								 ditag,qty,unitprice,amt,deliverytag,'2',spec_no_seq,spec_unq_num,
								 request_unq_num,est_unq_num,input_unq_num,approval_unq_num,tmat_unq_num,0,0,''
						  from m_input_detail
						 where dept_code     = as_dept_code
							and yymmdd        = ad_date 
							and seq           = ai_seq
							and input_unq_num = V_INPUT_UNQ_NUM; 
				END IF;
			END LOOP;
			CLOSE DETAIL_CUR;

			select nvl(sum(amt),0)
			  into C_AMT
			  from m_output_detail
			  where dept_code     = as_dept_code
				 and yymmdd        = ad_date 
				 and seq           = C_KSEQ; 
	
	
			 UPDATE m_output
				 SET total_amt = NVL(C_AMT,0)
			  where dept_code     = as_dept_code
				 and yymmdd        = ad_date 
				 and seq           = C_KSEQ ;

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
END y_sp_m_input_delivery;

/
