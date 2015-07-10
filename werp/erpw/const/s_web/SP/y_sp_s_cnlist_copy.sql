 /* ============================================================================ */
/* 함수명 : y_sp_s_cnlist_copy                                                   */
/* 기  능 : 계약변경승인시 계약내역화일로 복사한다.                              */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 발주번호               ==> ai_order_number(integer)                  */
/*        : 변경차수               ==> ai_chg_degree(integer)                    */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.04.25                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_cnlist_copy (as_dept_code    IN   VARCHAR2,
                                                ai_order_number IN   INTEGER,
                                                ai_chg_degree   IN   INTEGER ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR SUMMARY_CUR IS
SELECT SUM_CODE,
		 SPEC_NO_SEQ,
       DIRECT_CLASS,
       SEQ,
       LLEVEL,
       PARENT_SUM_CODE,
       INVEST_CLASS,
       DETAIL_YN,
       NAME,
       SSIZE,
       UNIT,
       CNT_QTY,
       CNT_AMT,
       EXE_QTY,
       EXE_AMT,
       SUB_QTY,
       SUB_AMT,
	    MAT_AMT,
	    LAB_AMT,
	    EXP_AMT
  FROM S_CHG_CN_PARENT
 WHERE dept_code    = as_dept_code
   AND ORDER_NUMBER = ai_order_number
   AND CHG_DEGREE   = ai_chg_degree
ORDER BY  SUM_CODE ASC;

CURSOR DETAIL_CUR IS
SELECT SPEC_NO_SEQ,
		 DETAIL_UNQ_NUM,
       SPEC_UNQ_NUM,
       SEQ,
       RES_CLASS,
       NAME,
       SSIZE,
       UNIT,
       WBS_CODE,
       TAXATION_TAG,
       CNT_QTY,
       CNT_PRICE,
       CNT_AMT,
       EXE_QTY,
       EXE_PRICE,
       EXE_AMT,
       SUB_QTY,
       SUB_PRICE,
       SUB_AMT,
		 MAT_PRICE,
		 MAT_AMT,
		 LAB_PRICE,
		 LAB_AMT,
		 EXP_PRICE,
		 EXP_AMT
  FROM S_CHG_CN_DETAIL
 WHERE dept_code    = as_dept_code
   AND ORDER_NUMBER = ai_order_number
   AND CHG_DEGREE   = ai_chg_degree
ORDER BY  SPEC_NO_SEQ ASC,
          DETAIL_UNQ_NUM ASC;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
   V_SPEC_UNQ_NUM     S_CHG_CN_DETAIL.SPEC_UNQ_NUM%TYPE;
   V_SEQ              S_CHG_CN_DETAIL.SEQ%TYPE;
   V_DETAIL_UNQ_NUM   S_CHG_CN_DETAIL.DETAIL_UNQ_NUM%TYPE;
   V_RES_CLASS        S_CHG_CN_DETAIL.RES_CLASS%TYPE;
   V_NAME             S_CHG_CN_DETAIL.NAME%TYPE;
   V_SSIZE            S_CHG_CN_DETAIL.SSIZE%TYPE;
   V_UNIT             S_CHG_CN_DETAIL.UNIT%TYPE;
   V_WBS_CODE         S_CHG_CN_DETAIL.WBS_CODE%TYPE;
   V_TAXATION_TAG     S_CHG_CN_DETAIL.TAXATION_TAG%TYPE;
   V_CNT_QTY          S_CHG_CN_DETAIL.CNT_QTY%TYPE;
   V_CNT_PRICE        S_CHG_CN_DETAIL.CNT_PRICE%TYPE;
   V_CNT_AMT          S_CHG_CN_DETAIL.CNT_AMT%TYPE;
   V_EXE_QTY          S_CHG_CN_DETAIL.EXE_QTY%TYPE;
   V_EXE_PRICE        S_CHG_CN_DETAIL.EXE_PRICE%TYPE;
   V_EXE_AMT          S_CHG_CN_DETAIL.EXE_AMT%TYPE;
   V_SUB_QTY          S_CHG_CN_DETAIL.SUB_QTY%TYPE;
   V_SUB_PRICE        S_CHG_CN_DETAIL.SUB_PRICE%TYPE;
   V_SUB_AMT          S_CHG_CN_DETAIL.SUB_AMT%TYPE;
   V_MAT_PRICE        S_CHG_CN_DETAIL.MAT_PRICE%TYPE;
   V_MAT_AMT          S_CHG_CN_DETAIL.MAT_AMT%TYPE;
   V_LAB_PRICE        S_CHG_CN_DETAIL.LAB_PRICE%TYPE;
   V_LAB_AMT          S_CHG_CN_DETAIL.LAB_AMT%TYPE;
   V_EXP_PRICE        S_CHG_CN_DETAIL.EXP_PRICE%TYPE;
   V_EXP_AMT          S_CHG_CN_DETAIL.EXP_AMT%TYPE;
   V_DIRECT_CLASS     S_CHG_CN_PARENT.DIRECT_CLASS%TYPE;
   V_LLEVEL           S_CHG_CN_PARENT.LLEVEL%TYPE;
   V_SPEC_NO_SEQ      S_CHG_CN_PARENT.SPEC_NO_SEQ%TYPE;
   V_PARENT_SUM_CODE  S_CHG_CN_PARENT.PARENT_SUM_CODE%TYPE;
   V_SUM_CODE			 S_CHG_CN_PARENT.SUM_CODE%TYPE;
   V_INVEST_CLASS     S_CHG_CN_PARENT.INVEST_CLASS%TYPE;
   V_DETAIL_YN        S_CHG_CN_PARENT.DETAIL_YN%TYPE;
   C_CNT               NUMBER(20,5);  --
BEGIN
 BEGIN
-- 계약대장을 CHECK 하여 입력 또는 수정한다.
   SELECT COUNT(*)
     INTO C_CNT
     FROM s_cn_list
    WHERE dept_code    = as_dept_code
      AND order_number = ai_order_number;

   IF C_CNT < 1 THEN
      INSERT INTO s_cn_list
           SELECT a.dept_code,a.order_number,a.sbcr_code,a.close_tag,a.approve_class,
                  a.check_dt,a.request_dt,a.approve_dt,a.order_name,a.sbc_name,a.sbc_dt,
                  a.sbc_section,a.choice_rival,a.choice_kind,a.proj_scale,a.const_place,
                  a.plan_start_dt,a.plan_end_dt,a.start_dt,a.end_dt,a.page_count,a.book_count,
                  a.pay_mat,a.mat_etc,a.cnt_amt,a.exe_amt,a.supply_amt_tax,a.supply_amt_notax,
                  a.misctax_tax,a.misctax_notax,a.purchase_vat,a.sbc_amt,a.vat,a.stamp,
                  a.prgs_ctrl_dt,a.prgs_pay_count,a.prgs_cash_rt,a.prgs_bill_rt,a.bill_cond,
                  a.delay_rt,a.previous_pay_dt,a.previous_amt_rt,a.previous_amt,a.previous_vat,
                  a.previous_pay_tag,a.previous_checker,a.previous_check_dt,
                  a.previous_deduction_rt,a.delay_amt,a.delay_dt,a.delay_pay_dt,a.insurance1_amt1,
                  a.insurance1_amt2,a.insurance2_name,a.insurance2_amt1,a.safety_amt1,
                  a.safety_amt2,a.sbc_guarantee_issueday,a.sbc_guarantee_rt,a.sbc_guarantee_amt,
                  a.sbc_guarantee_start_dt,a.sbc_guarantee_end_dt,a.sbc_guarantee_number,
                  a.sbc_guarantee_kind,a.warrant_guarantee_issueday,a.warrant_guarantee_rt,
                  a.warrant_guarantee_amt,a.warrant_guarantee_start_dt,a.warrant_guarantee_end_dt,
                  a.warrant_guarantee_number,a.warrant_guarantee_kind,a.warrant_term,
                  a.pay_guarantee_issueday,a.pay_guarantee_amt,a.pay_guarantee_start_dt,
                  a.pay_guarantee_end_dt,a.pay_guarantee_number,a.pay_guarantee_kind,
                  a.guarantee_name,a.guarantee_rep_name,a.guarantee_address,a.sbc_guarantee_name,
                  a.sbc_guarantee_rep_name,a.sbc_guarantee_address,a.remark,a.insurance_yn,ta_tag,
						a.previous_pay1,a.cnt_previous_amt,a.guarantee_yn,a.order_class,a.ebid_yn,
						a.const_no,a.req_dt,a.bonsa_dt,a.sbcr_dt,a.charge,a.vatcode,a.buy_rt,
						a.guarantee_tag1,a.guarantee_tag2,a.guarantee_tag3,a.guarantee_tag4,a.guarantee_tag5,a.bill_day,
					   a.nosend1,a.nosend2,a.nosend3,a.nosend4,a.nosend5,a.nosend6,a.nosend7,a.nosend8,a.nosend9,a.comm_tag,a.acc_tag,a.emp_class  
             FROM s_chg_cn_list a
            WHERE ( a.dept_code    = as_dept_code )
              AND ( a.order_number = ai_order_number )
              AND ( a.chg_degree   = ai_chg_degree );

   ELSE
      UPDATE s_cn_list b
         SET ( b.approve_class,b.check_dt,b.request_dt,b.approve_dt,b.sbc_name,b.sbc_dt,
               b.sbc_section,b.choice_rival,b.choice_kind,b.proj_scale,b.const_place,
               b.plan_start_dt,b.plan_end_dt,b.start_dt,b.end_dt,b.page_count,b.book_count,
               b.pay_mat,b.mat_etc,b.cnt_amt,b.exe_amt,b.supply_amt_tax,b.supply_amt_notax,
               b.misctax_tax,b.misctax_notax,b.purchase_vat,b.sbc_amt,b.vat,b.stamp,
               b.prgs_ctrl_dt,b.prgs_pay_count,b.prgs_cash_rt,b.prgs_bill_rt,b.bill_cond,
               b.delay_rt,b.previous_pay_dt,b.previous_amt_rt,b.previous_amt,b.previous_vat,
               b.previous_pay_tag,b.previous_checker,b.previous_check_dt,
               b.previous_deduction_rt,b.delay_amt,b.delay_dt,b.delay_pay_dt,b.insurance1_amt1,
               b.insurance1_amt2,b.insurance2_name,b.insurance2_amt1,b.safety_amt1,
               b.safety_amt2,b.sbc_guarantee_issueday,b.sbc_guarantee_rt,b.sbc_guarantee_amt,
               b.sbc_guarantee_start_dt,b.sbc_guarantee_end_dt,b.sbc_guarantee_number,
               b.sbc_guarantee_kind,b.warrant_guarantee_issueday,b.warrant_guarantee_rt,
               b.warrant_guarantee_amt,b.warrant_guarantee_start_dt,b.warrant_guarantee_end_dt,
               b.warrant_guarantee_number,b.warrant_guarantee_kind,b.warrant_term,
               b.pay_guarantee_issueday,b.pay_guarantee_amt,b.pay_guarantee_start_dt,
               b.pay_guarantee_end_dt,b.pay_guarantee_number,b.pay_guarantee_kind,b.insurance_yn,b.ta_tag,
				   b.previous_pay1,b.cnt_previous_amt,b.guarantee_yn,b.order_class,b.ebid_yn,
					b.const_no,b.req_dt,b.bonsa_dt,b.sbcr_dt,b.charge,b.vatcode,b.buy_rt,
					b.guarantee_tag1,b.guarantee_tag2,b.guarantee_tag3,b.guarantee_tag4,b.guarantee_tag5,b.bill_day,
				   b.nosend1,b.nosend2,b.nosend3,b.nosend4,b.nosend5,b.nosend6,b.nosend7,b.nosend8,b.nosend9,b.comm_tag,b.acc_tag,b.emp_class)  =
      ( SELECT a.approve_class,a.check_dt,a.request_dt,a.approve_dt,a.sbc_name,a.sbc_dt,
               a.sbc_section,a.choice_rival,a.choice_kind,a.proj_scale,a.const_place,
               a.plan_start_dt,a.plan_end_dt,a.start_dt,a.end_dt,a.page_count,a.book_count,
               a.pay_mat,a.mat_etc,a.cnt_amt,a.exe_amt,a.supply_amt_tax,a.supply_amt_notax,
               a.misctax_tax,a.misctax_notax,a.purchase_vat,a.sbc_amt,a.vat,a.stamp,
               a.prgs_ctrl_dt,a.prgs_pay_count,a.prgs_cash_rt,a.prgs_bill_rt,a.bill_cond,
               a.delay_rt,a.previous_pay_dt,a.previous_amt_rt,a.previous_amt,a.previous_vat,
               a.previous_pay_tag,a.previous_checker,a.previous_check_dt,
               a.previous_deduction_rt,a.delay_amt,a.delay_dt,a.delay_pay_dt,a.insurance1_amt1,
               a.insurance1_amt2,a.insurance2_name,a.insurance2_amt1,a.safety_amt1,
               a.safety_amt2,a.sbc_guarantee_issueday,a.sbc_guarantee_rt,a.sbc_guarantee_amt,
               a.sbc_guarantee_start_dt,a.sbc_guarantee_end_dt,a.sbc_guarantee_number,
               a.sbc_guarantee_kind,a.warrant_guarantee_issueday,a.warrant_guarantee_rt,
               a.warrant_guarantee_amt,a.warrant_guarantee_start_dt,a.warrant_guarantee_end_dt,
               a.warrant_guarantee_number,a.warrant_guarantee_kind,a.warrant_term,
               a.pay_guarantee_issueday,a.pay_guarantee_amt,a.pay_guarantee_start_dt,
               a.pay_guarantee_end_dt,a.pay_guarantee_number,a.pay_guarantee_kind,a.insurance_yn,a.ta_tag,
					a.previous_pay1,a.cnt_previous_amt,a.guarantee_yn,a.order_class,a.ebid_yn,
					a.const_no,a.req_dt,a.bonsa_dt,a.sbcr_dt,a.charge,a.vatcode,a.buy_rt,
					a.guarantee_tag1,a.guarantee_tag2,a.guarantee_tag3,a.guarantee_tag4,a.guarantee_tag5,a.bill_day,
				   a.nosend1,a.nosend2,a.nosend3,a.nosend4,a.nosend5,a.nosend6,a.nosend7,a.nosend8,a.nosend9,a.comm_tag,a.acc_tag,a.emp_class
          FROM s_chg_cn_list a
         WHERE b.dept_code    = a.dept_code
           AND b.order_number = a.order_number
           AND a.chg_degree   = ai_chg_degree )
       WHERE b.dept_code    = as_dept_code
         AND b.order_number = ai_order_number;
   END IF;
   EXCEPTION
   WHEN others THEN
        IF SQL%NOTFOUND THEN
           e_msg      := '계약대장입력실패! [Line No: 159]';
           Wk_errflag := -20020;
           GOTO EXIT_ROUTINE;
        END IF;
 END;
 BEGIN
	OPEN	SUMMARY_CUR;
	LOOP
		FETCH SUMMARY_CUR INTO V_SUM_CODE,V_SPEC_NO_SEQ,V_DIRECT_CLASS,V_SEQ,V_LLEVEL,V_PARENT_SUM_CODE,
                             V_INVEST_CLASS,V_DETAIL_YN,V_NAME,V_SSIZE,V_UNIT,V_CNT_QTY,V_CNT_AMT,
                             V_EXE_QTY,V_EXE_AMT,V_SUB_QTY,V_SUB_AMT,V_MAT_AMT,V_LAB_AMT,V_EXP_AMT ;
		EXIT WHEN SUMMARY_CUR%NOTFOUND;
      SELECT COUNT(*)
        INTO C_CNT
        FROM s_cn_parent
       WHERE dept_code    = as_dept_code
         AND order_number = ai_order_number
         AND spec_no_seq  = V_SPEC_NO_SEQ;
      IF C_CNT < 1 THEN
	      INSERT INTO s_cn_parent
   	        VALUES ( as_dept_code,ai_order_number,V_SPEC_NO_SEQ,V_SEQ,V_DIRECT_CLASS,
						     V_LLEVEL,V_SUM_CODE,V_PARENT_SUM_CODE,V_INVEST_CLASS,V_DETAIL_YN,V_NAME,
                       V_SSIZE,V_UNIT,V_CNT_QTY,V_CNT_AMT,V_EXE_QTY,V_EXE_AMT,V_SUB_QTY,
                       V_SUB_AMT,V_MAT_AMT,V_LAB_AMT,V_EXP_AMT  );
      ELSE
         UPDATE s_cn_parent
            SET direct_class = V_DIRECT_CLASS,
                SEQ          = V_SEQ,
                LLEVEL       = V_LLEVEL,
                SUM_CODE     = V_SUM_CODE,
                PARENT_SUM_CODE = V_PARENT_SUM_CODE,
                INVEST_CLASS = V_INVEST_CLASS,
                DETAIL_YN    = V_DETAIL_YN,
                NAME         = V_NAME,
                SSIZE        = V_SSIZE,
                UNIT         = V_UNIT,
                CNT_QTY      = V_CNT_QTY,
                CNT_AMT      = V_CNT_AMT,
                EXE_QTY      = V_EXE_QTY,
                EXE_AMT      = V_EXE_AMT,
                SUB_QTY      = V_SUB_QTY,
                SUB_AMT      = V_SUB_AMT,
					 MAT_AMT      = V_MAT_AMT,
					 LAB_AMT      = V_LAB_AMT,
					 EXP_AMT      = V_EXP_AMT
          WHERE dept_code    = as_dept_code
            AND order_number = ai_order_number
            AND spec_no_seq  = V_SPEC_NO_SEQ;
      END IF;
	END LOOP;
	CLOSE SUMMARY_CUR;
   EXCEPTION
   WHEN others THEN
        IF SQL%NOTFOUND THEN
           e_msg      := '계약집계구조입력실패! [Line No: 159]';
           Wk_errflag := -20020;
           GOTO EXIT_ROUTINE;
        END IF;
 END;
 BEGIN
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_SPEC_NO_SEQ,V_DETAIL_UNQ_NUM,V_SPEC_UNQ_NUM,V_SEQ,V_RES_CLASS,
                            V_NAME,V_SSIZE,V_UNIT,V_WBS_CODE,V_TAXATION_TAG,V_CNT_QTY,
                            V_CNT_PRICE,V_CNT_AMT,V_EXE_QTY,V_EXE_PRICE,V_EXE_AMT,
                            V_SUB_QTY,V_SUB_PRICE,V_SUB_AMT,V_MAT_PRICE,V_MAT_AMT,
									 V_LAB_PRICE,V_LAB_AMT,V_EXP_PRICE,V_EXP_AMT;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
      SELECT COUNT(*)
        INTO C_CNT
        FROM s_cn_detail
       WHERE dept_code      = as_dept_code
         AND order_number   = ai_order_number
         AND spec_no_seq    = V_SPEC_NO_SEQ
         AND detail_unq_num = V_DETAIL_UNQ_NUM;
      IF C_CNT < 1 THEN
         INSERT INTO s_cn_detail
   	        VALUES ( as_dept_code,ai_order_number,V_SPEC_NO_SEQ,V_DETAIL_UNQ_NUM,V_SEQ,
                       V_RES_CLASS,V_SPEC_UNQ_NUM,V_NAME,V_SSIZE,V_UNIT,
                       V_TAXATION_TAG,V_CNT_QTY,V_CNT_PRICE,V_CNT_AMT,V_EXE_QTY,
                       V_EXE_PRICE,V_EXE_AMT,V_SUB_QTY,V_SUB_PRICE,V_SUB_AMT,
							  V_MAT_PRICE,V_MAT_AMT,V_LAB_PRICE,V_LAB_AMT,V_EXP_PRICE,V_EXP_AMT);
      ELSE
         UPDATE s_cn_detail
            SET SEQ            = V_SEQ,
                DETAIL_UNQ_NUM = V_DETAIL_UNQ_NUM,
                RES_CLASS      = V_RES_CLASS,
                NAME           = V_NAME,
                SSIZE          = V_SSIZE,
                UNIT           = V_UNIT,
                TAXATION_TAG   = V_TAXATION_TAG,
                CNT_QTY        = V_CNT_QTY,
                CNT_PRICE      = V_CNT_PRICE,
                CNT_AMT        = V_CNT_AMT,
                EXE_QTY        = V_EXE_QTY,
                EXE_PRICE      = V_EXE_PRICE,
                EXE_AMT        = V_EXE_AMT,
                SUB_QTY        = V_SUB_QTY,
                SUB_PRICE      = V_SUB_PRICE,
                SUB_AMT        = V_SUB_AMT,
                MAT_PRICE      = V_MAT_PRICE,
                MAT_AMT        = V_MAT_AMT,
                LAB_PRICE      = V_LAB_PRICE,
                LAB_AMT        = V_LAB_AMT,
                EXP_PRICE      = V_EXP_PRICE,
                EXP_AMT        = V_EXP_AMT
          WHERE dept_code      = as_dept_code
            AND order_number   = ai_order_number
            AND spec_no_seq    = V_SPEC_NO_SEQ
            AND detail_unq_num = V_DETAIL_UNQ_NUM;
      END IF;
	END LOOP;
	CLOSE DETAIL_CUR;

		UPDATE s_chg_cn_list  
		  SET APPROVE_CLASS = '6',   
				APPROVE_DT  = sysdate
		WHERE ( DEPT_CODE  = as_dept_code ) AND  
				( order_number = ai_order_number ) and
				( chg_degree = ai_chg_degree );

      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '계약내역입력 실패! [Line No: 159]';
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
END y_sp_s_cnlist_copy;
/

