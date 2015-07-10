 /* ============================================================================ */
/* 함수명 : y_sp_s_yymm_create                                                   */
/* 기  능 : 기성 년월차수 등록시 년월차수 파일 creation                          */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 기성년월               ==> ad_yymm(date)                             */
/*        : 기성차수               ==> ai_seq(integer)                           */
/*        : 발주번호               ==> ai_order_number(integer)                  */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.04.25                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_yymm_create (as_dept_code    IN   VARCHAR2,
																ad_yymm         IN   DATE,
																ai_seq          IN   INTEGER,
                                                ai_order_number IN   INTEGER ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	C_YYMM              DATE;
	C_SEQ               NUMBER(20,5);
	C_PRGS_DEGREE       NUMBER(20,5);
   C_CNT               NUMBER(20,5);  --
BEGIN
 BEGIN

		select COUNT(*)
		  into C_CNT
		  from s_pay
		 where dept_code    = as_dept_code
			and order_number = ai_order_number;


		IF C_CNT > 0 THEN
			select max(prgs_degree)
			  into C_PRGS_DEGREE
			  from s_pay
			 where dept_code    = as_dept_code
				and order_number = ai_order_number;

			select yymm,seq
			  into C_YYMM,C_SEQ
			  from s_pay
			 where dept_code    = as_dept_code
				and order_number = ai_order_number
				and prgs_degree  = C_PRGS_DEGREE;

			C_PRGS_DEGREE := C_PRGS_DEGREE + 1;
		ELSE
			C_PRGS_DEGREE := 1;
		END IF;

		IF C_PRGS_DEGREE = 1 THEN
			INSERT INTO s_pay  
				  SELECT as_dept_code,ad_yymm,ai_seq,ai_order_number,1,
							null,null,null,null,last_day(ad_yymm),a.bill_cond,
							0,0,0,0,0,0,'',0,0,0,0,0,0,0,0,   
							0,0,0,0,0,0,'',0,0,0,0,0,0,0,0,null,'',0,null,0,'',null,'','',0,'1','',0,0,0,0,0,0
					 FROM s_cn_list  a
					WHERE a.dept_code = as_dept_code
					  AND a.order_number = ai_order_number;
	
			INSERT INTO s_prgs_parent
				  SELECT as_dept_code,ad_yymm,ai_seq,ai_order_number,a.spec_no_seq,
							0,0,0,0,0,0,0,0,0
					 FROM s_cn_parent a
					WHERE a.dept_code    = as_dept_code 
					  AND a.order_number = ai_order_number;
	
			INSERT INTO s_prgs_detail
				  SELECT as_dept_code,ad_yymm,ai_seq,ai_order_number,a.spec_no_seq,a.detail_unq_num,
							0,0,0,0,0,0,0,0,0
					 FROM s_cn_detail a
					WHERE a.dept_code    = as_dept_code 
					  AND a.order_number = ai_order_number;
					  
			INSERT INTO s_prgs_parent_web
				  SELECT as_dept_code,ad_yymm,ai_seq,ai_order_number,a.spec_no_seq,
							0,0,0,0,0,0,0,0,0
					 FROM s_cn_parent a
					WHERE a.dept_code    = as_dept_code 
					  AND a.order_number = ai_order_number;
	
			INSERT INTO s_prgs_detail_web
				  SELECT as_dept_code,ad_yymm,ai_seq,ai_order_number,a.spec_no_seq,a.detail_unq_num,
							0,0,0,0,0,0,0,0,0
					 FROM s_cn_detail a
					WHERE a.dept_code    = as_dept_code 
					  AND a.order_number = ai_order_number;
		ELSE
			INSERT INTO s_pay  
				  SELECT as_dept_code,ad_yymm,ai_seq,ai_order_number,C_PRGS_DEGREE,
							null,null,null,null,last_day(ad_yymm),a.bill_cond,
							0,0,0,0,0,0,'',0,0,0,0,0,0,0,0,   
							0,0,0,0,0,0,'',0,0,0,0,0,0,0,0,null,'',0,null,0,'',null,'','',0,'1','',0,0,0,0,0,0
					 FROM s_cn_list  a
					WHERE a.dept_code = as_dept_code
					  AND a.order_number = ai_order_number;
	
			INSERT INTO s_prgs_parent
				  SELECT as_dept_code,ad_yymm,ai_seq,ai_order_number,a.spec_no_seq,
							0,0,0,0,0,0,0,0,0
					 FROM s_cn_parent a
					WHERE a.dept_code    = as_dept_code 
					  AND a.order_number = ai_order_number;
	
			INSERT INTO s_prgs_detail
				  SELECT as_dept_code,ad_yymm,ai_seq,ai_order_number,a.spec_no_seq,a.detail_unq_num,
							0,0,0,0,0,0,0,0,0
					 FROM s_cn_detail a
					WHERE a.dept_code    = as_dept_code 
					  AND a.order_number = ai_order_number;

			INSERT INTO s_prgs_parent_web
				  SELECT as_dept_code,ad_yymm,ai_seq,ai_order_number,a.spec_no_seq,
							0,0,0,0,0,0,0,0,0
					 FROM s_cn_parent a
					WHERE a.dept_code    = as_dept_code 
					  AND a.order_number = ai_order_number;
	
			INSERT INTO s_prgs_detail_web
				  SELECT as_dept_code,ad_yymm,ai_seq,ai_order_number,a.spec_no_seq,a.detail_unq_num,
							0,0,0,0,0,0,0,0,0
					 FROM s_cn_detail a
					WHERE a.dept_code    = as_dept_code 
					  AND a.order_number = ai_order_number;
					  
				UPDATE s_pay a
					SET (a.pre_prgs,a.pre_prgs_notax,a.pre_sbc_deduction,
						  a.pre_advance_deduction,a.pre_employ_amt,a.pre_etc_amt,a.pre_deduction_detail,
						  a.pre_purchase_vat,a.pre_misctax,a.pre_misctax_notax,a.pre_vat,
						  a.pre_netpay_amt,a.pre_pay,a.pre_cash,a.pre_bill,
						  a.pre_pre_tax,a.pre_pre_notax,a.pre_pre_vat) = 
						 ( SELECT NVL(b.pre_prgs,0)              + NVL(b.tm_prgs,0),
									 NVL(b.pre_prgs_notax,0)        + NVL(b.tm_prgs_notax,0),   
									 NVL(b.pre_sbc_deduction,0)     + NVL(b.tm_sbc_deduction,0),   
									 NVL(b.pre_advance_deduction,0) + NVL(b.tm_advance_deduction,0),   
									 NVL(b.pre_employ_amt,0)        + NVL(b.tm_employ_amt,0),   
									 NVL(b.pre_etc_amt,0)           + NVL(b.tm_etc_amt,0),   
									 b.tm_deduction_detail,   
									 NVL(b.pre_purchase_vat,0)      + NVL(b.tm_purchase_vat,0),   
									 NVL(b.pre_misctax,0)           + NVL(b.tm_misctax,0),   
									 NVL(b.pre_misctax_notax,0)     + NVL(b.tm_misctax_notax,0),   
									 NVL(b.pre_vat,0)               + NVL(b.tm_vat,0),   
									 NVL(b.pre_netpay_amt,0)        + NVL(b.tm_netpay_amt,0),   
									 NVL(b.pre_pay,0)               + NVL(b.tm_pay,0),   
									 NVL(b.pre_cash,0)              + NVL(b.tm_cash,0),   
									 NVL(b.pre_bill,0)              + NVL(b.tm_bill,0),
									 NVL(b.pre_pre_tax,0)           + NVL(b.tm_pre_tax,0),
									 NVL(b.pre_pre_notax,0)         + NVL(b.tm_pre_notax,0),
									 NVL(b.pre_pre_vat,0)           + NVL(b.tm_pre_vat,0)
							  FROM s_pay  b
							 WHERE a.dept_code    = b.dept_code (+)
								AND a.order_number = b.order_number (+)
								AND b.yymm         = C_YYMM 
								AND b.seq          = C_SEQ  ) 
				 WHERE a.dept_code    = as_dept_code
					AND a.order_number = ai_order_number
					AND a.yymm         = ad_yymm
					AND a.seq          = ai_seq
					AND EXISTS (SELECT b.prgs_degree
									  FROM s_pay  b
									 WHERE a.dept_code    = b.dept_code (+)
										AND a.order_number = b.order_number (+)
										AND b.yymm         = C_YYMM 
										AND b.seq          = C_SEQ  ) ;
			
				UPDATE s_prgs_parent a
					SET (a.pre_prgs_qty,a.pre_prgs_amt,a.pre_prgs_rt,
						  a.tot_prgs_qty,a.tot_prgs_amt,a.tot_prgs_rt ) = 
						 ( SELECT NVL(b.pre_prgs_qty,0) + NVL(b.tm_prgs_qty,0),
									 NVL(b.pre_prgs_amt,0) + NVL(b.tm_prgs_amt,0),
									 decode(sign(999 - (NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0))),1,NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0),999),
									 NVL(b.pre_prgs_qty,0) + NVL(b.tm_prgs_qty,0),
									 NVL(b.pre_prgs_amt,0) + NVL(b.tm_prgs_amt,0),
									 decode(sign(999 - (NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0))),1,NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0),999)
							  FROM s_prgs_parent b
							 WHERE a.dept_code    = b.dept_code
								AND a.order_number = b.order_number
								AND a.spec_no_seq  = b.spec_no_seq
								AND b.yymm         = C_YYMM
								AND b.seq          = C_SEQ )
				 WHERE a.dept_code    = as_dept_code
					AND a.order_number = ai_order_number
					AND a.yymm         = ad_yymm 
					AND a.seq          = ai_seq 
					AND EXISTS (SELECT b.pre_prgs_qty
									  FROM s_prgs_parent b
									 WHERE a.dept_code    = b.dept_code
										AND a.order_number = b.order_number
										AND a.spec_no_seq  = b.spec_no_seq
										AND b.yymm         = C_YYMM
										AND b.seq          = C_SEQ );

				UPDATE s_prgs_detail a
					SET (a.pre_prgs_qty,a.pre_prgs_amt,a.pre_prgs_rt,
						  a.tot_prgs_qty,a.tot_prgs_amt,a.tot_prgs_rt ) = 
						 ( SELECT NVL(b.pre_prgs_qty,0) + NVL(b.tm_prgs_qty,0),
									 NVL(b.pre_prgs_amt,0) + NVL(b.tm_prgs_amt,0),
									 decode(sign(999 - (NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0))),1,NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0),999),
									 NVL(b.pre_prgs_qty,0) + NVL(b.tm_prgs_qty,0),
									 NVL(b.pre_prgs_amt,0) + NVL(b.tm_prgs_amt,0),
									 decode(sign(999 - (NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0))),1,NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0),999)
							  FROM s_prgs_detail b
							 WHERE a.dept_code      = b.dept_code
								AND a.order_number   = b.order_number
								AND a.spec_no_seq    = b.spec_no_seq
								AND a.detail_unq_num = b.detail_unq_num
								AND b.yymm         = C_YYMM
								AND b.seq          = C_SEQ )
				 WHERE a.dept_code    = as_dept_code
					AND a.order_number = ai_order_number
					AND a.yymm         = ad_yymm 
					AND a.seq          = ai_seq 
					AND EXISTS (SELECT b.pre_prgs_qty
									  FROM s_prgs_detail b
									 WHERE a.dept_code      = b.dept_code
										AND a.order_number   = b.order_number
										AND a.spec_no_seq    = b.spec_no_seq
										AND a.detail_unq_num = b.detail_unq_num
										AND b.yymm         = C_YYMM
										AND b.seq          = C_SEQ );

				UPDATE s_prgs_parent_web a
					SET (a.pre_prgs_qty,a.pre_prgs_amt,a.pre_prgs_rt,
						  a.tot_prgs_qty,a.tot_prgs_amt,a.tot_prgs_rt ) = 
						 ( SELECT NVL(b.pre_prgs_qty,0) + NVL(b.tm_prgs_qty,0),
									 NVL(b.pre_prgs_amt,0) + NVL(b.tm_prgs_amt,0),
									 decode(sign(999 - (NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0))),1,NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0),999),
									 NVL(b.pre_prgs_qty,0) + NVL(b.tm_prgs_qty,0),
									 NVL(b.pre_prgs_amt,0) + NVL(b.tm_prgs_amt,0),
									 decode(sign(999 - (NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0))),1,NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0),999)
							  FROM s_prgs_parent b
							 WHERE a.dept_code    = b.dept_code
								AND a.order_number = b.order_number
								AND a.spec_no_seq  = b.spec_no_seq
								AND b.yymm         = C_YYMM
								AND b.seq          = C_SEQ )
				 WHERE a.dept_code    = as_dept_code
					AND a.order_number = ai_order_number
					AND a.yymm         = ad_yymm 
					AND a.seq          = ai_seq 
					AND EXISTS (SELECT b.pre_prgs_qty
									  FROM s_prgs_parent b
									 WHERE a.dept_code    = b.dept_code
										AND a.order_number = b.order_number
										AND a.spec_no_seq  = b.spec_no_seq
										AND b.yymm         = C_YYMM
										AND b.seq          = C_SEQ );

				UPDATE s_prgs_detail_web a
					SET (a.pre_prgs_qty,a.pre_prgs_amt,a.pre_prgs_rt,
						  a.tot_prgs_qty,a.tot_prgs_amt,a.tot_prgs_rt ) = 
						 ( SELECT NVL(b.pre_prgs_qty,0) + NVL(b.tm_prgs_qty,0),
									 NVL(b.pre_prgs_amt,0) + NVL(b.tm_prgs_amt,0),
									 decode(sign(999 - (NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0))),1,NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0),999),
									 NVL(b.pre_prgs_qty,0) + NVL(b.tm_prgs_qty,0),
									 NVL(b.pre_prgs_amt,0) + NVL(b.tm_prgs_amt,0),
									 decode(sign(999 - (NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0))),1,NVL(b.pre_prgs_rt,0) + NVL(b.tm_prgs_rt,0),999)
							  FROM s_prgs_detail b
							 WHERE a.dept_code      = b.dept_code
								AND a.order_number   = b.order_number
								AND a.spec_no_seq    = b.spec_no_seq
								AND a.detail_unq_num = b.detail_unq_num
								AND b.yymm         = C_YYMM
								AND b.seq          = C_SEQ )
				 WHERE a.dept_code    = as_dept_code
					AND a.order_number = ai_order_number
					AND a.yymm         = ad_yymm 
					AND a.seq          = ai_seq 
					AND EXISTS (SELECT b.pre_prgs_qty
									  FROM s_prgs_detail b
									 WHERE a.dept_code      = b.dept_code
										AND a.order_number   = b.order_number
										AND a.spec_no_seq    = b.spec_no_seq
										AND a.detail_unq_num = b.detail_unq_num
										AND b.yymm         = C_YYMM
										AND b.seq          = C_SEQ );
		END IF;

--      EXCEPTION
--      WHEN others THEN
--           IF SQL%NOTFOUND THEN
--              e_msg      := '전회이월 실패! [Line No: 159]';
--              Wk_errflag := -20020;
--              GOTO EXIT_ROUTINE;
--           END IF;
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
END y_sp_s_yymm_create;
/

