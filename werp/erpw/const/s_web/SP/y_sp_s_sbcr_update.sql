/* ============================================================================= */
/* 함수명 : y_sp_s_sbcr_update                                                   */
/* 기  능 : 외주업체정보변경시 협력업체기본사항으로 반영한다.                    */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 협력업체고유번호       ==> ai_unq_num(Integer)                       */
/*        : 협력업체코드           ==> as_sbcr_code  (string)                    */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.04.23                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_sbcr_update(ai_unq_num      IN   INTEGER,
                                               as_sbcr_code    IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error 
   C_CNT               NUMBER(20,5);  -- 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	  UPDATE S_SBCR  
		  SET (ESTABLISH_DATE,KIND_BUSSINESSTYPE,KINDITEM,REGION_CODE,ZIP_NUMBER1,ADDRESS1,TEL_NUMBER1,
				 ZIP_NUMBER2,ADDRESS2,TEL_NUMBER2,REP_NAME1,REP_NAME2,REP_EMAIL,REP_JUMIN,REP_ZIP_NUMBER1,   
				 REP_ADDRESS1,REP_ZIP_NUMBER2,REP_ADDRESS2,REP_TEL_NUMBER1,REP_TEL_NUMBER2,REP_TASTE,   
				 REP_RELIGIOUS,REP_BORN_AREA,CHRG_DEPARTMENT,CHRG_GRADE,CHRG_NAME1,CHRG_NAME2,CHRG_HP,   
				 CHRG_EMAIL,CHRG_JUMIN,CHRG_ZIP_NUMBER1,CHRG_ADDRESS1,CHRG_ZIP_NUMBER2,CHRG_ADDRESS2,   
				 CHRG_TEL_NUMBER2,CHRG_BORN_AREA,FAX_NUMBER,ISO_STATUS,MAIN_BANK,DEPOSITOR,ACC_NUMBER,   
				 SPECIALITY,CAPITAL1,PROPERTY1,DEBT1,CAPITAL_TOT1,SALE_AMT1,PROFIT1,C_GRADE1,CAPITAL2,   
				 PROPERTY2,DEBT2,CAPITAL_TOT2,SALE_AMT2,PROFIT2,C_GRADE2,CAPITAL3,PROPERTY3,DEBT3,CAPITAL_TOT3,   
				 SALE_AMT3,PROFIT3,C_GRADE3,INPUT_DT,INPUT_NAME) =
				(SELECT ESTABLISH_DATE,KIND_BUSSINESSTYPE,KINDITEM,REGION_CODE,ZIP_NUMBER1,ADDRESS1,TEL_NUMBER1,   
						 ZIP_NUMBER2,ADDRESS2,TEL_NUMBER2,REP_NAME1,REP_NAME2,REP_EMAIL,REP_JUMIN,REP_ZIP_NUMBER1,   
						 REP_ADDRESS1,REP_ZIP_NUMBER2,REP_ADDRESS2,REP_TEL_NUMBER1,REP_TEL_NUMBER2,REP_TASTE,   
						 REP_RELIGIOUS,REP_BORN_AREA,CHRG_DEPARTMENT,CHRG_GRADE,CHRG_NAME1,CHRG_NAME2,CHRG_HP,   
						 CHRG_EMAIL,CHRG_JUMIN,CHRG_ZIP_NUMBER1,CHRG_ADDRESS1,CHRG_ZIP_NUMBER2,CHRG_ADDRESS2,   
						 CHRG_TEL_NUMBER2,CHRG_BORN_AREA,FAX_NUMBER,ISO_STATUS,MAIN_BANK,DEPOSITOR,ACC_NUMBER,   
						 SPECIALITY,CAPITAL1,PROPERTY1,DEBT1,CAPITAL_TOT1,SALE_AMT1,PROFIT1,C_GRADE1,CAPITAL2,   
						 PROPERTY2,DEBT2,CAPITAL_TOT2,SALE_AMT2,PROFIT2,C_GRADE2,CAPITAL3,PROPERTY3,DEBT3,CAPITAL_TOT3,   
						 SALE_AMT3,PROFIT3,C_GRADE3,INPUT_DT,INPUT_NAME
				  FROM S_REQ_SBCR  
				 where SBCR_UNQ_NUM = ai_unq_num )
		  where sbcr_code = as_sbcr_code ;
	delete from s_company_history
		   where sbcr_code = as_sbcr_code;
	INSERT INTO S_COMPANY_HISTORY  
	  SELECT as_sbcr_code,a.SEQ,a.E_DATE,a.DETAIL,a.REMARK  
		 FROM S_REQ_COMPANY_HISTORY  a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num ;  
	delete from s_scholarship
		   where sbcr_code = as_sbcr_code;
	insert into s_scholarship
	  select as_sbcr_code,a.class,a.spec_seq,a.scholarship_class,a.sch_date,a.name,a.subject_name,a.graduation_class,a.remark
		 from s_req_scholarship a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num   ;
	delete from s_award
		   where sbcr_code = as_sbcr_code;
	insert into s_award
	  select as_sbcr_code,a.seq,a.e_date,a.owner,a.name,a.reson
		 from s_req_award a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num ;  
	delete from s_const
		   where sbcr_code = as_sbcr_code;
	insert into s_const
	  select as_sbcr_code,a.othercompany_seq,a.owner,a.profession_wbs_name,a.othercompany_construction,
				a.othercompany_start_date,a.othercompany_end_date,a.othercompany_amt,a.sale_amt,a.bigo,a.year_class
		 from s_req_const a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num ;  
	delete from s_master
		   where sbcr_code = as_sbcr_code;
	insert into s_master
	  select as_sbcr_code,a.seq,a.grade,a.name,a.age,
				a.imp_process,a.our_career_year,a.career_year,a.representative_rel,a.last_scholarship,a.imp_career
		 from s_req_master a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num   ;
	delete from s_license_status
		   where sbcr_code = as_sbcr_code;
	insert into s_license_status
	  select as_sbcr_code,a.PROFESSION_WBS_CODE,a.TREATKIND_CODE,a.SELECTION_TAG,a.PROFESSION_WBS_NAME,
				a.TREATKIND_LICENSE_NUMBER,a.LICENSE_ISSUE_DATE,a.REGION_CODE,a.CN_GRADE1,
				a.CN_GRADE_TOTAL1,a.CN_LIMIT_AMT1,a.CN_GRADE2,a.CN_GRADE_TOTAL2,a.CN_LIMIT_AMT2,
				a.CN_GRADE3,a.CN_GRADE_TOTAL3,a.CN_LIMIT_AMT3  ,a.seq
		 from s_req_license_status a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num  ; 
	delete from s_sale
		   where sbcr_code = as_sbcr_code;
	insert into s_sale
	  select as_sbcr_code,YEAR_CLASS,SEQ,SBCR_NAME,SALE_AMT,SALE_RT,REMARK  
		 from s_req_sale
		WHERE SBCR_UNQ_NUM = ai_unq_num   ;
	update s_req_sbcr
	   set chg_class = '1'
	 where sbcr_unq_num = ai_unq_num;


	UPDATE S_WBS_REQUEST B SET (
    	B.treatkind_code, B.rep_year, B.chrg_year, B.our_const_proj, B.our_const_amt, B.inout_name, B.inout_tel
    	) = (
        SELECT
        	a.treatkind_code, a.rep_year, a.chrg_year, a.our_const_proj, a.our_const_amt, a.inout_name, a.inout_tel
        FROM
        	s_req_wbs_request a,
			s_req_sbcr d
        WHERE
			a.sbcr_unq_num = d.sbcr_unq_num
		AND a.SBCR_UNQ_NUM = ai_unq_num
		AND a.profession_wbs_code = b.profession_wbs_code
		AND d.sbcr_code = b.sbcr_code
		AND a.register_chk not in ('1','2','3')
        )
    WHERE
    	B.SBCR_CODE = as_sbcr_code
    AND EXISTS (
    	SELECT
        	a.sbcr_unq_num
        FROM
        	s_req_wbs_request a,
			s_req_sbcr d
        WHERE
			a.sbcr_unq_num = d.sbcr_unq_num
		AND a.SBCR_UNQ_NUM = ai_unq_num
		AND a.profession_wbs_code = b.profession_wbs_code
		AND d.sbcr_code = b.sbcr_code
		AND a.register_chk not in ('1','2','3')
    	);

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
END y_sp_s_sbcr_update;
