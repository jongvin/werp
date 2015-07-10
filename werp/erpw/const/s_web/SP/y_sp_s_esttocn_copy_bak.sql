/* ============================================================================= */
/* 함수명 : y_sp_s_esttocn_copy                                                  */
/* 기  능 : 외주견적내역 입력시 상위로 재계산한다.                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 발주번호               ==> ai_order_number(Integer)                  */
/*        : 협력업체코드           ==> as_sbcr_code  (string)                    */
/*        : 분류코드               ==> ai_spec_no_seq  (Integer)                 */
/*        : 사용자                 ==> as_user      (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.04.23                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_esttocn_copy(as_dept_code    IN   VARCHAR2,
                                               ai_order_number IN   INTEGER,
                                               as_sbcr_code    IN   VARCHAR2,
															  as_vat_class    IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error 
   C_AMT 		        S_ESTIMATE_PARENT.CTRL_AMT%TYPE;        -- 실행금액
   C_VAT 		        S_ESTIMATE_PARENT.CTRL_AMT%TYPE;        -- 실행금액
   C_TOT_AMT 	        S_ESTIMATE_PARENT.CTRL_AMT%TYPE;        -- 실행금액
   C_BUY_AMT	        S_ESTIMATE_PARENT.CTRL_AMT%TYPE;        -- 실행금액
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	select nvl(ctrl_amt,0)
	  into C_AMT
	  from s_estimate_list
	 where dept_code    = as_dept_code
		and order_number = ai_order_number
		and sbcr_code    = as_sbcr_code;


	C_VAT := Trunc(C_AMT * 0.1,0);
	C_TOT_AMT := C_AMT + C_VAT;

	INSERT INTO s_chg_cn_list  
         ( dept_code,order_number,chg_degree,sbcr_code,chg_resign,   
           close_tag,approve_class,check_dt,request_dt,approve_dt,   
           order_name,sbc_name,sbc_dt,sbc_section,choice_rival,choice_kind,   
           proj_scale,const_place,plan_start_dt,plan_end_dt,start_dt,end_dt,
			  page_count,book_count,pay_mat,mat_etc,cnt_amt,exe_amt,   
           supply_amt_tax,supply_amt_notax,misctax_tax,misctax_notax,purchase_vat,   
           sbc_amt,vat,stamp,prgs_ctrl_dt,prgs_pay_count,prgs_cash_rt,prgs_bill_rt,   
           bill_cond,delay_rt,previous_pay_dt,previous_amt_rt,previous_amt,previous_vat,   
           previous_pay_tag,previous_checker,previous_check_dt,previous_deduction_rt,   
           delay_amt,delay_dt,delay_pay_dt,insurance1_amt1,insurance1_amt2,   
           insurance2_name,insurance2_amt1,safety_amt1,safety_amt2,
			  sbc_guarantee_issueday,sbc_guarantee_rt,sbc_guarantee_amt,sbc_guarantee_start_dt,   
           sbc_guarantee_end_dt,sbc_guarantee_number,sbc_guarantee_kind,
			  warrant_guarantee_issueday,warrant_guarantee_rt,warrant_guarantee_amt,   
           warrant_guarantee_start_dt,warrant_guarantee_end_dt,warrant_guarantee_number,   
           warrant_guarantee_kind,warrant_term,pay_guarantee_issueday,   
           pay_guarantee_amt,pay_guarantee_start_dt,pay_guarantee_end_dt,
			  pay_guarantee_number,pay_guarantee_kind,guarantee_name,guarantee_rep_name,   
           guarantee_address,sbc_guarantee_name,sbc_guarantee_rep_name,
			  sbc_guarantee_address,remark,insurance_yn,ta_tag,
			  previous_pay1,cnt_previous_amt,guarantee_yn,order_class,ebid_yn,const_no,req_dt,bonsa_dt,sbcr_dt,charge,vatcode,buy_rt )  
    SELECT a.dept_code,a.order_number,1,a.sbcr_code,'',
           'N','1',null,null,null,
           a.order_name,a.order_name,null,'1',0,'',
           a.const_range,'',a.start_dt,a.end_dt,a.start_dt,a.end_dt,
           0,0,a.pay_mat,a.mat_etc,a.cnt_amt,a.exe_amt,
           C_AMT,0,0,0,0,
           C_AMT,C_VAT,0,null,1,a.directamt_rt,100 - a.directamt_rt,
           a.bill_pay,a.delay_rt2,15,a.previous_pay2,0,0,
           'N','',null,0,
           0,null,null,0,0,
           '',0,0,0,
           null,a.sbc_guarantee_rt,
			  decode(sign(Trunc(C_TOT_AMT * a.sbc_guarantee_rt / 100,0) - 999),1,999,Trunc(C_TOT_AMT * a.sbc_guarantee_rt / 100,0)),
			  decode(a.sbc_guarantee_rt,0,null,a.start_dt),
           decode(a.sbc_guarantee_rt,0,null,a.end_dt),'','',
           null,a.warrant_guarantee_rt,
			  decode(sign(Trunc(C_TOT_AMT * a.warrant_guarantee_rt / 100,0) - 999),1,999,Trunc(C_TOT_AMT * a.warrant_guarantee_rt / 100,0)),
           a.warrant_start_dt,a.warrant_end_dt,'',
           '',a.warrant_term,null,
			  decode(sign(Trunc(C_TOT_AMT * a.previous_pay2 / 100,0) - 999),1,999,Trunc(C_TOT_AMT * a.previous_pay2 / 100,0)),
			  decode(a.previous_pay2,0,null,a.start_dt),decode(a.previous_pay2,0,null,a.end_dt),
           '','','','',
           '','','',
			  '','','Y','N',
			  a.previous_pay1,a.cnt_previous_amt,'N',a.order_class,a.ebid_yn,'','','','','',as_vat_class,a.buy_rt
		FROM s_order_list a
     WHERE a.dept_code = as_dept_code
		 AND a.order_number = ai_order_number ;

	INSERT INTO s_chg_cn_parent  
	 SELECT a.dept_code,a.order_number,1,a.spec_no_seq,a.seq,a.direct_class,a.llevel,a.sum_code,
			  a.parent_sum_code,a.invest_class,a.detail_yn,'N',a.name,a.ssize,a.unit,
			  a.cnt_qty,a.cnt_amt,a.exe_qty,a.exe_amt,b.ctrl_qty,b.ctrl_amt,b.cmat_amt,b.clab_amt,b.cexp_amt
		FROM s_order_parent  a,
           s_estimate_parent b
	  WHERE a.dept_code = b.dept_code
		 and a.order_number = b.order_number
		 and a.spec_no_seq  = b.spec_no_seq
		 and b.sbcr_code    = as_sbcr_code
		 and a.dept_code    = as_dept_code
		 and a.order_number = ai_order_number;

	insert into s_chg_cn_detail
		select a.dept_code,a.order_number,1,a.spec_no_seq,a.detail_unq_num,a.seq,a.res_class,a.spec_unq_num,
				 a.name,a.ssize,a.unit,'N','','1',a.cnt_qty,a.cnt_price,a.cnt_amt,a.exe_qty,a.exe_price,a.exe_amt,
  				 b.ctrl_qty,b.ctrl_price,b.ctrl_amt,b.cmat_price,b.cmat_amt,b.clab_price,b.clab_amt,b.cexp_price,b.cexp_amt
		  from s_order_detail a,
				 s_estimate_detail b
		 where a.dept_code = b.dept_code
			and a.order_number = b.order_number
			and a.spec_no_seq  = b.spec_no_seq
			and a.detail_unq_num = b.detail_unq_num
			and b.sbcr_code      = as_sbcr_code
			and a.dept_code      = as_dept_code
			and a.order_number   = ai_order_number;

	select nvl(sum(sub_amt),0)
	  into C_TOT_AMT
	  from s_chg_cn_parent
    where dept_code = as_dept_code
		and order_number = ai_order_number
		and chg_degree = 1
		and llevel = 1;

	select nvl(sum(sub_amt),0)
	  into C_BUY_AMT
	  from s_chg_cn_parent
    where dept_code = as_dept_code
		and order_number = ai_order_number
		and chg_degree = 1
		and llevel = 2
		and direct_class = '3';

	if as_vat_class = '1' then
		update s_chg_cn_list
		   set supply_amt_tax   = C_TOT_AMT,
				 vat              = TRUNC(C_TOT_AMT * 0.1,0),
				 supply_amt_notax = 0,
				 purchase_vat     = 0,
				 sbc_amt          = TRUNC(C_TOT_AMT * 1.1,0),
				 previous_amt     = TRUNC(C_TOT_AMT * 1.1 * previous_amt_rt * 0.01,0),
				 previous_vat     = TRUNC(C_TOT_AMT * 0.1 * previous_amt_rt * 0.01,0)
		 where dept_code    = as_dept_code
			and order_number = ai_order_number
			and chg_degree   = 1;
	end if;
	if as_vat_class = '2' then
		update s_chg_cn_list
		   set supply_amt_tax   = 0,
				 vat              = 0,
				 supply_amt_notax = C_TOT_AMT,
				 purchase_vat     = 0,
				 sbc_amt          = C_TOT_AMT,
				 previous_amt     = TRUNC(C_TOT_AMT * previous_amt_rt * 0.01,0),
				 previous_vat     = 0
		 where dept_code    = as_dept_code
			and order_number = ai_order_number
			and chg_degree   = 1;
	end if;
	if as_vat_class = '3' then
		update s_chg_cn_list
		   set supply_amt_tax   = C_TOT_AMT,
				 vat              = TRUNC(C_TOT_AMT * 0.1,0),
				 supply_amt_notax = 0,
				 purchase_vat     = 0,
				 sbc_amt          = TRUNC(C_TOT_AMT * 1.1,0),
				 previous_amt     = TRUNC(C_TOT_AMT * 1.1 * previous_amt_rt * 0.01,0),
				 previous_vat     = TRUNC(C_TOT_AMT * 0.1 * previous_amt_rt * 0.01,0)
		 where dept_code    = as_dept_code
			and order_number = ai_order_number
			and chg_degree   = 1;
	end if;
	if as_vat_class = '4' then
		C_AMT := C_TOT_AMT - C_BUY_AMT;
		update s_chg_cn_list
		   set supply_amt_tax   = TRUNC(C_AMT * (100 - buy_rt) * 0.01,0),
				 vat              = TRUNC(C_AMT * (100 - buy_rt) * 0.001,0),
				 supply_amt_notax = C_AMT - TRUNC(C_AMT * (100 - buy_rt) * 0.01,0),
				 purchase_vat     = C_BUY_AMT,
				 sbc_amt          = C_TOT_AMT + TRUNC(C_AMT * (100 - buy_rt) * 0.001,0) ,
				 previous_amt     = TRUNC((C_TOT_AMT + TRUNC(C_AMT * (100 - buy_rt) * 0.001,0)) * previous_amt_rt * 0.01,0),
				 previous_vat     = TRUNC(C_AMT * (100 - buy_rt) * previous_amt_rt * 0.00001,0)
		 where dept_code    = as_dept_code
			and order_number = ai_order_number
			and chg_degree   = 1;
	end if;
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
END y_sp_s_esttocn_copy;
/

