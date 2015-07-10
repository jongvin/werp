CREATE OR REPLACE PROCEDURE Y_SP_S_RE_ESTIMATE ( 
/* ============================================================================ */ 
/* 함수명 : y_sp_s_re_estimate                                                   */ 
/* 기  능 : 재견적요청시 발주내역 복사                                           */ 
/* ----------------------------------------------------------------------------- */ 
/* 인  수 : 현장코드               ==> p_dept_code    (string)                   */ 
/*        : 발주번호               ==> p_order_number (integer)                  */ 
/*        : 업체코드               ==> p_sbcr_code    (string)                   */ 
/* ===========================[ 변   경   이   력 ]============================= */ 
/* 작성자 : 이경일                                                               */ 
/* 작성일 : 2005.09.01                                                           */ 
/* ============================================================================= */ 
 p_dept_code    IN VARCHAR2, 
 p_order_number IN INTEGER, 
 p_sbcr_code_0  IN VARCHAR2, 
 p_sbcr_code_1  IN VARCHAR2, 
 p_sbcr_code_2  IN VARCHAR2, 
 p_sbcr_code_3  IN VARCHAR2, 
 p_sbcr_code_4  IN VARCHAR2, 
 p_sbcr_code_5  IN VARCHAR2, 
 p_sbcr_code_6  IN VARCHAR2, 
 p_sbcr_code_7  IN VARCHAR2, 
 p_sbcr_code_8  IN VARCHAR2, 
 p_sbcr_code_9  IN VARCHAR2 
) IS 
 
------------------------------------------------------------- 
-- 변수선언 
------------------------------------------------------------- 
-- 공통 변수 
 Wk_errmsg           VARCHAR2(500);              -- Error Message Edit 
 Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code 
 e_msg               VARCHAR2(100); 
-- User Define Error 
 UserErr         EXCEPTION;                  -- Select Data Not Found 
 
 v_new_order_number  INTEGER; 
 v_sbcr_code VARCHAR2(8); 
 v_bef_order_number INTEGER; 
 v_re_est_cnt INTEGER; 
 v_cancel_yn VARCHAR2(1); 
 i INTEGER DEFAULT 1; 
BEGIN 
 BEGIN 
 
 SELECT nvl(MAX(ORDER_NUMBER),0) + 1 INTO v_new_order_number FROM s_order_list WHERE dept_code = p_dept_code; --신규발주번호생성 
 SELECT bef_order_number INTO v_bef_order_number FROM s_order_list WHERE dept_code = p_dept_code AND order_number =  p_order_number; --최초발주번호 
 SELECT nvl(MAX(re_est_cnt),0) + 1 INTO v_re_est_cnt FROM s_order_list WHERE dept_code = p_dept_code AND  
 bef_order_number =  ( 
 select bef_order_number from s_order_list WHERE dept_code = p_dept_code AND order_number = p_order_number); --최초발주번호  
 
 UPDATE s_order_list SET cancel_yn = 'Y' WHERE dept_code = p_dept_code AND order_number =  p_order_number; --기존발주서 유찰표시 
 
 --S_ORDER_LIST 추가 
 insert into s_order_list 
  (dept_code, order_number, profession_wbs_code, order_class, ebid_yn, approve_class, check_date, request_dt, approve_dt, order_name, sbcr_code, sbc_degree, br_date, br_place, br_jik, br_name, opt_jik, opt_name, br_remark, start_dt, end_dt, cnt_amt, exe_amt, choice_kind, pr_dt, pr_place, previous_pay1, previous_pay2, prgs_pay1, prgs_pay2, warrant_rt1, warrant_rt2, delay_rt1, delay_rt2, directamt_rt, bill_pay, const_range, pay_mat, mat_etc, tmp_note, sbc_guarantee_rt, warrant_guarantee_rt, warrant_start_dt, warrant_end_dt, warrant_term, adjust_note, estimate_dt, note, cnt_previous_amt, vat_rt, buy_rt, buy_mat_rt, open_yn, open_dt, open_per, vat_class, bef_order_number, re_est_cnt, cancel_yn) 
 select 
  dept_code, v_new_order_number, profession_wbs_code, order_class, ebid_yn, approve_class, check_date, request_dt, approve_dt, order_name, sbcr_code, sbc_degree, br_date, br_place, br_jik, br_name, opt_jik, opt_name, br_remark, start_dt, end_dt, cnt_amt, exe_amt, choice_kind, pr_dt, pr_place, previous_pay1, previous_pay2, prgs_pay1, prgs_pay2, warrant_rt1, warrant_rt2, delay_rt1, delay_rt2, directamt_rt, bill_pay, const_range, pay_mat, mat_etc, tmp_note, sbc_guarantee_rt, warrant_guarantee_rt, warrant_start_dt, warrant_end_dt, warrant_term, adjust_note, estimate_dt, note, cnt_previous_amt, vat_rt, buy_rt, buy_mat_rt, 'N', null, null, vat_class, v_bef_order_number, v_re_est_cnt, 'N' 
 from 
  s_order_list 
 where 
  dept_code    = p_dept_code 
 and order_number = p_order_number; 
 
 --S_ORDER_PARENT 추가 
 insert into s_order_parent 
  (dept_code, order_number, spec_no_seq, seq, direct_class, llevel, sum_code, parent_sum_code, invest_class, detail_yn, name, ssize, unit, cnt_qty, cnt_amt, exe_qty, exe_amt, sub_qty, sub_amt, mat_amt, lab_amt, exp_amt) 
 select 
  dept_code, v_new_order_number, spec_no_seq, seq, direct_class, llevel, sum_code, parent_sum_code, invest_class, detail_yn, name, ssize, unit, cnt_qty, cnt_amt, exe_qty, exe_amt, sub_qty, sub_amt, mat_amt, lab_amt, exp_amt 
 from 
  s_order_parent 
 where 
  dept_code    = p_dept_code 
 and order_number = p_order_number; 
 
 --S_ORDER_DETAIL 추가 
 insert into s_order_detail 
  (dept_code, order_number, spec_no_seq, detail_unq_num, seq, res_class, spec_unq_num, name, ssize, unit, cnt_qty, cnt_price, cnt_amt, exe_qty, exe_price, exe_amt, sub_qty, sub_price, sub_amt, note, lab_class, mat_price, mat_amt, lab_price, lab_amt, exp_price, exp_amt) 
 select 
  dept_code, v_new_order_number, spec_no_seq, detail_unq_num, seq, res_class, spec_unq_num, name, ssize, unit, cnt_qty, cnt_price, cnt_amt, exe_qty, exe_price, exe_amt, sub_qty, sub_price, sub_amt, note, lab_class, mat_price, mat_amt, lab_price, lab_amt, exp_price, exp_amt 
 from 
  s_order_detail 
 where 
  dept_code    = p_dept_code 
 and order_number = p_order_number; 
 
 for i in 1..10 loop 
  if (i = 1) Then 
   v_sbcr_code := p_sbcr_code_0; 
  End if; 
  if (i = 2) Then 
   v_sbcr_code := p_sbcr_code_1; 
  End if; 
  if (i = 3) Then 
   v_sbcr_code := p_sbcr_code_2; 
  End if; 
  if (i = 4) Then 
   v_sbcr_code := p_sbcr_code_3; 
  End if; 
  if (i = 5) Then 
   v_sbcr_code := p_sbcr_code_4; 
  End if; 
  if (i = 6) Then 
   v_sbcr_code := p_sbcr_code_5; 
  End if; 
  if (i = 7) Then 
   v_sbcr_code := p_sbcr_code_6; 
  End if; 
  if (i = 8) Then 
   v_sbcr_code := p_sbcr_code_7; 
  End if; 
  if (i = 9) Then 
   v_sbcr_code := p_sbcr_code_8; 
  End if; 
  if (i = 10) Then 
   v_sbcr_code := p_sbcr_code_9; 
  End if; 
 
  if (rtrim(v_sbcr_code) Is Not Null) Then 
   --S_ESTIMATE_LIST 추가 
   insert into s_estimate_list 
    (dept_code, order_number, sbcr_code, recommender_department, recommender_grade, recommender_name, pr_yn, est_yn, register_chk, noentry_chk, noentry_recommen, noentry_merit, noentry_defect, noentry_recommender_note, noentry_note, noentry_yn_note, est_amt, ctrl_amt, select_yn, charge_name, profession_wbs_code, cn_limit_amt, note, re_est_yn, est_dt, re_est_dt,injung_yn) 
   select 
    dept_code, v_new_order_number, sbcr_code, recommender_department, recommender_grade, recommender_name, pr_yn, 'N', register_chk, null, noentry_recommen, noentry_merit, noentry_defect, noentry_recommender_note, noentry_note, noentry_yn_note, 0, 0, 'N', charge_name, profession_wbs_code, cn_limit_amt, note, 1, null, null,injung_yn 
   from 
    s_estimate_list 
   where 
    dept_code    = p_dept_code 
   and order_number = p_order_number 
   and sbcr_code    = v_sbcr_code; 
   
   --S_ESTIMATE_PARENT 추가 
   insert into s_estimate_parent 
    (dept_code, order_number, sbcr_code, spec_no_seq, est_qty, est_amt, ctrl_qty, ctrl_amt, emat_amt, elab_amt, eexp_amt, cmat_amt, clab_amt, cexp_amt) 
   select 
    dept_code, v_new_order_number, sbcr_code, spec_no_seq, est_qty, 0, ctrl_qty, 0, 0, 0, 0, 0, 0, 0 
   from 
    s_estimate_parent 
   where 
    dept_code    = p_dept_code 
   and order_number = p_order_number 
   and sbcr_code    = v_sbcr_code; 
   --S_ESTIMATE_DETAIL 추가 
   insert into s_estimate_detail 
    (dept_code, order_number, sbcr_code, spec_no_seq, detail_unq_num, est_qty, est_price, est_amt, ctrl_qty, ctrl_price, ctrl_amt, emat_price, emat_amt, elab_price, elab_amt, eexp_price, eexp_amt, cmat_price, cmat_amt, clab_price, clab_amt, cexp_price, cexp_amt) 
   select 
    dept_code, v_new_order_number, sbcr_code, spec_no_seq, detail_unq_num, est_qty, 0, 0, ctrl_qty, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
   from 
    s_estimate_detail 
   where 
    dept_code    = p_dept_code 
   and order_number = p_order_number 
   and sbcr_code    = v_sbcr_code; 
   
   --S_ESTIMATE_PARENT_WEB 추가 
   insert into s_estimate_parent_web 
    (dept_code, order_number, sbcr_code, spec_no_seq, est_amt, emat_amt, elab_amt, eexp_amt, ctrl_amt, cmat_amt, clab_amt, cexp_amt) 
   select 
    dept_code, v_new_order_number, sbcr_code, spec_no_seq, 0, 0, 0, 0, '0', '0', '0', '0' 
   from 
    s_estimate_parent_web 
   where 
    dept_code    = p_dept_code 
   and order_number = p_order_number 
   and sbcr_code    = v_sbcr_code; 
   
   --S_ESTIMATE_DETAIL_WEB 추가 
   insert into s_estimate_detail_web 
    (dept_code, order_number, sbcr_code, spec_no_seq, detail_unq_num, est_price, est_amt, emat_price, emat_amt, elab_price, elab_amt, eexp_price, eexp_amt, ctrl_price, ctrl_amt, cmat_price, cmat_amt, clab_price, clab_amt, cexp_price, cexp_amt) 
   select 
    dept_code, v_new_order_number, sbcr_code, spec_no_seq, detail_unq_num, 0, 0, 0, 0, 0, 0, 0, 0, '0', '0', '0', '0', '0', '0', '0', '0' 
   from 
    s_estimate_detail_web 
   where 
    dept_code    = p_dept_code 
   and order_number = p_order_number 
   and sbcr_code    = v_sbcr_code; 
  End if; 
 end loop; 
 
  
 EXCEPTION 
  WHEN others THEN 
  IF SQL%NOTFOUND THEN 
   e_msg      := '재견적요청 에러 발생'; 
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
END y_sp_s_re_estimate; 
