/* ============================================================================= */
/* 함수명 : y_sp_s_order_approve                                                 */
/* 기  능 : 현설품의승인프로세스.                                                */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 발주번호               ==> ai_order_number(Integer)                  */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.06.16           수정일 : 2005.01.20                             */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_order_approve(as_dept_code    IN   VARCHAR2,
                                           ai_order_number   IN   INTEGER) IS
CURSOR DETAIL_CUR IS
SELECT sbcr_code
  FROM s_estimate_list 
 WHERE dept_code    = as_dept_code AND
       order_number = ai_order_number;
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error 
   V_SBCR_CODE         s_estimate_list.SBCR_CODE%TYPE;    -- 
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
		delete from s_estimate_detail a
		where a.dept_code = as_dept_code 
		  and a.order_number = ai_order_number
		  and a.detail_unq_num not in (select b.detail_unq_num
													from s_order_detail b
												  where b.dept_code = as_dept_code
													 and b.order_number = ai_order_number);
		delete from s_estimate_parent a
		where a.dept_code = as_dept_code 
		  and a.order_number = ai_order_number
		  and a.spec_no_seq not in (select b.spec_no_seq
												from s_order_parent b
											  where b.dept_code = as_dept_code
												 and b.order_number = ai_order_number);
		delete from s_estimate_detail_web a
		where a.dept_code = as_dept_code 
		  and a.order_number = ai_order_number
		  and a.detail_unq_num not in (select b.detail_unq_num
													from s_order_detail b
												  where b.dept_code = as_dept_code
													 and b.order_number = ai_order_number);
		delete from s_estimate_parent_web a
		where a.dept_code = as_dept_code 
		  and a.order_number = ai_order_number
		  and a.spec_no_seq not in (select b.spec_no_seq
												from s_order_parent b
											  where b.dept_code = as_dept_code
												 and b.order_number = ai_order_number);
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '자료삭제 실패! [Line No: 157]';
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;   
	END;
	BEGIN
		update s_estimate_detail a
		set a.est_qty = ( select sub_qty
 							     from s_order_detail b
		 					    where a.dept_code = b.dept_code
							      and a.order_number = b.order_number
 									and a.spec_no_seq  = b.spec_no_seq
								   and a.detail_unq_num = b.detail_unq_num ) 
		where a.dept_code = as_dept_code
		  and a.order_number = ai_order_number
		  and exists ( select sub_qty
 							     from s_order_detail b
		 					    where a.dept_code = b.dept_code
							      and a.order_number = b.order_number
 									and a.spec_no_seq  = b.spec_no_seq
								   and a.detail_unq_num = b.detail_unq_num );
		update s_estimate_detail 
  			set ctrl_qty = nvl(est_qty,0),
				 est_amt  = trunc(nvl(est_qty,0) * nvl(est_price,0),0),
				 ctrl_amt = trunc(nvl(est_qty,0) * nvl(ctrl_price,0),0),
				 emat_amt = trunc(nvl(est_qty,0) * nvl(emat_price,0),0),
				 elab_amt = trunc(nvl(est_qty,0) * nvl(elab_price,0),0),
				 eexp_amt = trunc(nvl(est_qty,0) * nvl(eexp_price,0),0),
				 cmat_amt = trunc(nvl(est_qty,0) * nvl(cmat_price,0),0),
				 clab_amt = trunc(nvl(est_qty,0) * nvl(clab_price,0),0),
				 cexp_amt = trunc(nvl(est_qty,0) * nvl(cexp_price,0),0)
		 where dept_code = as_dept_code
		   and order_number = ai_order_number;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '자료변환 실패! [Line No: 157]';
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;   
	END;
	BEGIN
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_SBCR_CODE;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
			insert into s_estimate_parent 
				SELECT a.dept_code,a.order_number,V_SBCR_CODE,a.spec_no_seq,
						 a.sub_qty,0,a.sub_qty,0,0,0,0,0,0,0
				  FROM s_order_parent a  
				 WHERE ( a.DEPT_CODE    = as_dept_code ) AND  
						 ( a.ORDER_NUMBER = ai_order_number ) AND  
						 ( a.SPEC_NO_SEQ not in (  SELECT b.SPEC_NO_SEQ  
															 FROM s_estimate_parent  b
															WHERE ( b.DEPT_CODE = as_dept_code ) AND  
																	( b.ORDER_NUMBER = ai_order_number ) AND  
																	( b.SBCR_CODE = V_SBCR_CODE  )))    ;
			insert into s_estimate_detail 
				SELECT a.dept_code,a.order_number,V_SBCR_CODE,a.spec_no_seq,a.DETAIL_UNQ_NUM,
						 a.sub_qty,0,0,a.sub_qty,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				  FROM s_order_detail a  
				 WHERE ( a.DEPT_CODE = as_dept_code ) AND  
						 ( a.ORDER_NUMBER = ai_order_number ) AND  
						 ( a.DETAIL_UNQ_NUM not in (  SELECT b.DETAIL_UNQ_NUM  
															 FROM s_estimate_detail  b
															WHERE ( b.DEPT_CODE = as_dept_code ) AND  
																	( b.ORDER_NUMBER = ai_order_number ) AND  
																	( b.SBCR_CODE = V_SBCR_CODE  )))    ;
			insert into s_estimate_parent_web
				SELECT a.dept_code,a.order_number,V_SBCR_CODE,a.spec_no_seq,
						 0,0,0,0,0,0,0,0
				  FROM s_order_parent a  
				 WHERE ( a.DEPT_CODE    = as_dept_code ) AND  
						 ( a.ORDER_NUMBER = ai_order_number ) AND  
						 ( a.SPEC_NO_SEQ not in (  SELECT b.SPEC_NO_SEQ  
															 FROM s_estimate_parent_web  b
															WHERE ( b.DEPT_CODE = as_dept_code ) AND  
																	( b.ORDER_NUMBER = ai_order_number ) AND  
																	( b.SBCR_CODE = V_SBCR_CODE  )))    ;
			insert into s_estimate_detail_web 
				SELECT a.dept_code,a.order_number,V_SBCR_CODE,a.spec_no_seq,a.DETAIL_UNQ_NUM,
						 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				  FROM s_order_detail a  
				 WHERE ( a.DEPT_CODE = as_dept_code ) AND  
						 ( a.ORDER_NUMBER = ai_order_number ) AND  
						 ( a.DETAIL_UNQ_NUM not in (  SELECT b.DETAIL_UNQ_NUM  
															 FROM s_estimate_detail_web  b
															WHERE ( b.DEPT_CODE = as_dept_code ) AND  
																	( b.ORDER_NUMBER = ai_order_number ) AND  
																	( b.SBCR_CODE = V_SBCR_CODE  )))    ;
		y_sp_s_estimate_tot_cmpt_web(as_dept_code,ai_order_number,V_SBCR_CODE);
		y_sp_s_estimate_tot_cmpt(as_dept_code,ai_order_number,V_SBCR_CODE);
		END LOOP;
		CLOSE DETAIL_CUR;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '자료삽입 실패! [Line No: 157]';
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;   
	END;
	BEGIN
		UPDATE s_order_list  
		  SET APPROVE_CLASS = '3',   
				APPROVE_DT  = to_date(to_char(sysdate,'yyyy.mm.dd'))
		WHERE ( DEPT_CODE    = as_dept_code ) AND  
				( order_number = ai_order_number );
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '자료승인 실패! [Line No: 157]';
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
END y_sp_s_order_approve;

/
