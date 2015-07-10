/* ============================================================================= */
/* 함수명 : y_sp_m_loss_process                                                  */
/* 기  능 : 자재 손료계산.                                                       */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 년월(시작)             ==> ad_s_date    (date)                       */
/*        : 년월(종료)             ==> ad_e_date    (date)                       */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.12.17                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_loss_process(as_dept_code  IN   VARCHAR2,
                                                ad_s_date     IN   DATE,
															   ad_e_date     IN   DATE ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
select ad_e_date - a.yymmdd,
		 ad_e_date - ad_s_date + 1,
		 a.mtrcode,
		 a.name,
		 a.ssize,
		 a.unitcode,
		 a.qty,
		 a.amt,
		 b.rentrate
  from m_input_detail a,
	    m_code_material b
 where a.mtrcode = b.mtrcode
   and a.dept_code = as_dept_code
   and trunc(a.yymmdd,'MM') = ad_s_date
   and a.ditag = '2';

CURSOR DETAIL_CUR1 IS
select ad_e_date - a.yymmdd,
		 ad_e_date - ad_s_date + 1,
		 a.mtrcode,
		 a.name,
		 a.ssize,
		 a.unitcode,
		 decode(b.inouttypecode,'N',0,decode(b.inouttypecode,'O',decode(b.trans_tag,'4',a.qty,0),a.qty)) qty,
		 decode(b.inouttypecode,'O',decode(b.trans_tag,'4',a.amt,0),a.amt) amt,
		 c.rentrate
  from m_output_detail a,
		 m_output b,
		 m_code_material c
 where a.mtrcode   = c.mtrcode
	and a.dept_code = b.dept_code
	and a.yymmdd    = b.yymmdd
	and a.seq       = b.seq
	and a.dept_code = as_dept_code
	and trunc(a.yymmdd,'MM') = ad_s_date
	and a.ditag = '2';

-- 공통 변수 
   V_USE_DAY           INTEGER        DEFAULT 0;
   V_MON_DAY           INTEGER        DEFAULT 0;
   V_MTRCODE       	  M_OUTPUT_DETAIL.MTRCODE%TYPE;
   V_NAME       	     M_OUTPUT_DETAIL.NAME%TYPE;
   V_SSIZE       	     M_OUTPUT_DETAIL.SSIZE%TYPE;
   V_UNITCODE       	  M_OUTPUT_DETAIL.UNITCODE%TYPE;
   V_QTY       	     M_OUTPUT_DETAIL.QTY%TYPE;
   V_AMT       	     M_OUTPUT_DETAIL.AMT%TYPE;
   V_RENTRATE       	  M_CODE_MATERIAL.RENTRATE%TYPE;
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
		BEGIN
		DELETE FROM M_OUTPUT_DETAIL  
		  	   WHERE DEPT_CODE = as_dept_code
				  AND yymmdd    = ad_e_date  
				  AND seq       = 999;

		DELETE FROM M_OUTPUT  
		  	   WHERE DEPT_CODE = as_dept_code
				  AND yymmdd    = ad_e_date  
				  AND seq       = 999;

		INSERT INTO M_OUTPUT  
		VALUES ( as_dept_code,ad_e_date,999,substrb(to_char(ad_e_date,'YYYY.MM.DD'),1,7) || ' 손료',
					null,null,0,'N',null,0,null,null )  ;

		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '자재손료계산 작업 실패! [Line No: 1]';
				  Wk_errflag := -20020;
			
				  GOTO EXIT_ROUTINE;
			  END IF;   
		END;
		begin
-- 전월재고의 손료
		INSERT INTO M_OUTPUT_DETAIL
		select a.dept_code,ad_e_date,999,m_spec_unq_no.nextval,1,a.mtrcode,a.name,a.ssize,a.unitcode,'2',
				 nvl(a.qty - nvl(b.out_qty,0),0),nvl(round(((a.amt - nvl(b.out_amt,0)) * c.rentrate / 100) / (a.qty - nvl(b.out_qty,0)),0),0),
				 nvl((a.amt - nvl(b.out_amt,0)) * c.rentrate / 100,0),0,'N',0,0,0,0,0,0
		from m_input_detail a,
			  (select max(a.dept_code) dept_code ,max(a.mtrcode) mtrcode,
						 nvl(sum(decode(b.inouttypecode,'N',0,decode(b.inouttypecode,'O',decode(b.trans_tag,'4',a.qty,0),a.qty))),0) out_qty,
						 nvl(sum(decode(b.inouttypecode,'O',decode(b.trans_tag,'4',a.amt,0),a.amt)),0) out_amt
				  from m_output_detail a,
						 m_output b
				 where a.dept_code = b.dept_code
					and a.yymmdd    = b.yymmdd
					and a.seq       = b.seq
					and a.dept_code = as_dept_code
					and a.yymmdd < ad_s_date
					and a.ditag = '2'
				group by a.dept_code,a.mtrcode) b,
				m_code_material c
		where a.mtrcode = c.mtrcode
		and a.dept_code = b.dept_code (+)
		and a.mtrcode = b.mtrcode (+)
		and a.dept_code = as_dept_code
		and a.yymmdd < ad_s_date
		and a.ditag = '2';

		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '자재손료계산 작업 실패! [Line No: 4]';
				  Wk_errflag := -20020;
			
				  GOTO EXIT_ROUTINE;
			  END IF;   
		END;
		begin
-- 당월에 입고된 가설재 손료
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_USE_DAY,V_MON_DAY,V_MTRCODE,V_NAME,V_SSIZE,V_UNITCODE,V_QTY,V_AMT,V_RENTRATE;
			EXIT WHEN DETAIL_CUR%NOTFOUND;

			select count(*)
			  into C_CNT
			  from m_output_detail
			 where dept_code = as_dept_code
				and yymmdd    = ad_e_date
				and seq       = 999
				and mtrcode   = V_MTRCODE;

			IF C_CNT > 0 THEN
				select nvl(qty,0),nvl(amt,0)
				  into C_QTY,C_AMT
				  from m_output_detail
				 where dept_code = as_dept_code
					and yymmdd    = ad_e_date
					and seq       = 999
					and mtrcode   = V_MTRCODE;
	
				C_QTY := C_QTY + V_QTY;
				C_AMT := C_AMT + trunc((V_AMT * V_RENTRATE / 100) * (V_USE_DAY / V_MON_DAY),0);

				IF C_QTY > 0 THEN
					C_PRICE := ROUND(C_AMT / C_QTY,0);
				ELSE
					C_PRICE := 0;
				END IF;

				UPDATE m_output_detail
					SET qty = C_QTY,
						 unitprice = C_PRICE,
						 amt = C_AMT
				 where dept_code = as_dept_code
					and yymmdd    = ad_e_date
					and seq       = 999
					and mtrcode   = V_MTRCODE;
			ELSE
				C_QTY := V_QTY;
				C_AMT := trunc((V_AMT * V_RENTRATE / 100) * (V_USE_DAY / V_MON_DAY),0);
				IF C_QTY > 0 THEN
					C_PRICE := ROUND(C_AMT / C_QTY,0);
				ELSE
					C_PRICE := 0;
				END IF;

				INSERT INTO m_output_detail  
				VALUES ( as_dept_code,ad_e_date,999,m_spec_unq_no.nextval,1,V_MTRCODE,V_NAME,V_SSIZE,V_UNITCODE,
							'2',C_QTY,C_PRICE,C_AMT,0,'N',0,0,0,0,0,0)  ;
			END IF;
		END LOOP;
		CLOSE DETAIL_CUR;
		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '자재손료계산 작업 실패! [Line No: 2]';
				  Wk_errflag := -20020;
			
				  GOTO EXIT_ROUTINE;
			  END IF;   
		END;
		begin
-- 당월에 출고된 가설재 손료
		OPEN	DETAIL_CUR1;
		LOOP
			FETCH DETAIL_CUR1 INTO V_USE_DAY,V_MON_DAY,V_MTRCODE,V_NAME,V_SSIZE,V_UNITCODE,V_QTY,V_AMT,V_RENTRATE;
			EXIT WHEN DETAIL_CUR1%NOTFOUND;
			IF V_QTY <> 0 AND V_AMT <> 0 THEN
				select count(*)
				  into C_CNT
				  from m_output_detail
				 where dept_code = as_dept_code
					and yymmdd    = ad_e_date
					and seq       = 999
					and mtrcode   = V_MTRCODE;
	
				IF C_CNT > 0 THEN
					select nvl(qty,0),nvl(amt,0)
					  into C_QTY,C_AMT
					  from m_output_detail
					 where dept_code = as_dept_code
						and yymmdd    = ad_e_date
						and seq       = 999
						and mtrcode   = V_MTRCODE;
		
					C_QTY := C_QTY - V_QTY;
					C_AMT := C_AMT - trunc((V_AMT * V_RENTRATE / 100) * (V_USE_DAY / V_MON_DAY),0);
	
					IF C_QTY > 0 THEN
						C_PRICE := ROUND(C_AMT / C_QTY,0);
					ELSE
						C_PRICE := 0;
					END IF;
	
					UPDATE m_output_detail
						SET qty = C_QTY,
							 unitprice = C_PRICE,
							 amt = C_AMT
					 where dept_code = as_dept_code
						and yymmdd    = ad_e_date
						and seq       = 999
						and mtrcode   = V_MTRCODE;
				END IF;
			END IF;
		END LOOP;
		CLOSE DETAIL_CUR1;

		UPDATE m_output a
		  SET (a.total_amt ) = 
						 ( SELECT nvl(sum(b.amt),0)
							  from m_output_detail b
							 where a.dept_code = b.dept_code (+)
								and a.yymmdd    = b.yymmdd (+)
								and a.seq       = b.seq (+))
		 WHERE a.dept_code = as_dept_code
			and yymmdd      = ad_e_date
			and seq         = 999
			AND EXISTS (SELECT nvl(sum(b.amt),0)
							  from m_output_detail b
							 where a.dept_code = b.dept_code (+)
								and a.yymmdd    = b.yymmdd (+)
								and a.seq       = b.seq (+));
		

		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := '자재손료계산 작업 실패! [Line No: 3]';
				  Wk_errflag := -20020;
			
				  GOTO EXIT_ROUTINE;
			  END IF;   
		end;
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
END y_sp_m_loss_process;

/
