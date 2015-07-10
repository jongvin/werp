/* ============================================================================= */
/* 함수명 : y_sp_s_sbcr_insert                                                   */
/* 기  능 : 협력업체신규등록시 협력업체기본사항으로 COPY한다                     */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 신청업체고유번호       ==> ai_unq_num (Integer)                      */
/*        : 협력업체코드           ==> C_SBCR_CODE  (string)                    */
/*        : 등록공종코드           ==> as_wbs_code   (string)                    */
/*        : 등록구분               ==> as_class  (string)                        */
/*        : 업체구분               ==> as_gubun  (string)                        */
/*        : 사용자                 ==> as_user      (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2005.02.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_sbcr_insert(ai_unq_num    IN   INTEGER,
                                               as_sbcr_code  IN   VARCHAR2,
                                               as_wbs_code   IN   VARCHAR2,
                                               as_class      IN   VARCHAR2,
											   as_gubun      IN   VARCHAR2,
															  as_user       IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error 
   C_TOT_AMT 	        S_ESTIMATE_PARENT.CTRL_AMT%TYPE;        -- 실행금액
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
   C_TEMP              VARCHAR2(13);
   C_SBCR_CODE         VARCHAR2(8);
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
    SELECT COUNT(*)
      INTO C_CNT
	   FROM S_SBCR 
     WHERE businessman_number = as_sbcr_code;

	IF C_CNT < 1 THEN
		SELECT  substrb(max(sbcr_code),2,5) + 1
	     INTO C_TEMP
		  FROM S_SBCR;
		IF C_TEMP < 10 THEN
			C_SBCR_CODE := 'S' || '0000' || C_TEMP;
		ELSIF C_TEMP < 100 THEN
			C_SBCR_CODE := 'S' || '000' || C_TEMP;
		ELSIF C_TEMP < 1000 THEN
			C_SBCR_CODE := 'S' || '00' || C_TEMP;
		ELSIF C_TEMP < 10000 THEN
			C_SBCR_CODE := 'S' || '0' || C_TEMP;
		ELSE
			C_SBCR_CODE := 'S' || C_TEMP;
		END IF;

      INSERT INTO S_SBCR  
			(SBCR_CODE,SBCR_NAME,BUSINESSMAN_NUMBER,CORP_NO,ESTABLISH_DATE,KIND_BUSSINESSTYPE,KINDITEM,REGION_CODE,   
	        ZIP_NUMBER1,ADDRESS1,TEL_NUMBER1,ZIP_NUMBER2,ADDRESS2,TEL_NUMBER2,REP_NAME1,REP_NAME2,REP_EMAIL,REP_JUMIN,   
    	    REP_ZIP_NUMBER1,REP_ADDRESS1,REP_ZIP_NUMBER2,REP_ADDRESS2,REP_TEL_NUMBER1,REP_TEL_NUMBER2,REP_TASTE,   
	        REP_RELIGIOUS,REP_BORN_AREA,CHRG_DEPARTMENT,CHRG_GRADE,CHRG_NAME1,CHRG_NAME2,CHRG_HP,CHRG_EMAIL,   
    	    CHRG_JUMIN,CHRG_ZIP_NUMBER1,CHRG_ADDRESS1,CHRG_ZIP_NUMBER2,CHRG_ADDRESS2,CHRG_TEL_NUMBER2,CHRG_BORN_AREA,   
	        FAX_NUMBER,ISO_STATUS,MAIN_BANK,DEPOSITOR,ACC_NUMBER,SPECIALITY,CAPITAL1,PROPERTY1,DEBT1,CAPITAL_TOT1,   
    	    SALE_AMT1,PROFIT1,C_GRADE1,CAPITAL2,PROPERTY2,DEBT2,CAPITAL_TOT2,SALE_AMT2,PROFIT2,C_GRADE2,CAPITAL3,   
	        PROPERTY3,DEBT3,CAPITAL_TOT3,SALE_AMT3,PROFIT3,C_GRADE3,INPUT_DT,INPUT_NAME,mat_sbcr_class,chg_degree,sbcr_class,use_tag )  
		SELECT
			C_SBCR_CODE,SBCR_NAME,BUSINESSMAN_NUMBER,CORP_NO,ESTABLISH_DATE,KIND_BUSSINESSTYPE,KINDITEM,REGION_CODE,   
			ZIP_NUMBER1,ADDRESS1,TEL_NUMBER1,ZIP_NUMBER2,ADDRESS2,TEL_NUMBER2,REP_NAME1,REP_NAME2,REP_EMAIL,REP_JUMIN,   
            REP_ZIP_NUMBER1,REP_ADDRESS1,REP_ZIP_NUMBER2,REP_ADDRESS2,REP_TEL_NUMBER1,REP_TEL_NUMBER2,REP_TASTE,
            REP_RELIGIOUS,REP_BORN_AREA,CHRG_DEPARTMENT,CHRG_GRADE,CHRG_NAME1,CHRG_NAME2,CHRG_HP,CHRG_EMAIL,
            CHRG_JUMIN,CHRG_ZIP_NUMBER1,CHRG_ADDRESS1,CHRG_ZIP_NUMBER2,CHRG_ADDRESS2,CHRG_TEL_NUMBER2,CHRG_BORN_AREA,
            FAX_NUMBER,ISO_STATUS,MAIN_BANK,DEPOSITOR,ACC_NUMBER,SPECIALITY,CAPITAL1,PROPERTY1,DEBT1,CAPITAL_TOT1,
            SALE_AMT1,PROFIT1,C_GRADE1,CAPITAL2,PROPERTY2,DEBT2,CAPITAL_TOT2,SALE_AMT2,PROFIT2,C_GRADE2,CAPITAL3,
            PROPERTY3,DEBT3,CAPITAL_TOT3,SALE_AMT3,PROFIT3,C_GRADE3,sysdate,as_user,mat_sbcr_class,0,'1','Y'
        FROM S_REQ_SBCR
       WHERE SBCR_UNQ_NUM = ai_unq_num;
	ELSE
    SELECT  max(sbcr_code)
      INTO C_SBCR_CODE
	   FROM S_SBCR 
     WHERE businessman_number = as_sbcr_code;

		UPDATE S_SBCR SET
			(ESTABLISH_DATE,KIND_BUSSINESSTYPE,KINDITEM,REGION_CODE,ZIP_NUMBER1,ADDRESS1,TEL_NUMBER1,
			ZIP_NUMBER2,ADDRESS2,TEL_NUMBER2,REP_NAME1,REP_NAME2,REP_EMAIL,REP_JUMIN,REP_ZIP_NUMBER1,   
			REP_ADDRESS1,REP_ZIP_NUMBER2,REP_ADDRESS2,REP_TEL_NUMBER1,REP_TEL_NUMBER2,REP_TASTE,   
			REP_RELIGIOUS,REP_BORN_AREA,CHRG_DEPARTMENT,CHRG_GRADE,CHRG_NAME1,CHRG_NAME2,CHRG_HP,   
			CHRG_EMAIL,CHRG_JUMIN,CHRG_ZIP_NUMBER1,CHRG_ADDRESS1,CHRG_ZIP_NUMBER2,CHRG_ADDRESS2,   
			CHRG_TEL_NUMBER2,CHRG_BORN_AREA,FAX_NUMBER,ISO_STATUS,MAIN_BANK,DEPOSITOR,ACC_NUMBER,   
			SPECIALITY,CAPITAL1,PROPERTY1,DEBT1,CAPITAL_TOT1,SALE_AMT1,PROFIT1,C_GRADE1,CAPITAL2,   
			PROPERTY2,DEBT2,CAPITAL_TOT2,SALE_AMT2,PROFIT2,C_GRADE2,CAPITAL3,PROPERTY3,DEBT3,CAPITAL_TOT3,   
			SALE_AMT3,PROFIT3,C_GRADE3,INPUT_DT,INPUT_NAME) =
			(SELECT
				ESTABLISH_DATE,KIND_BUSSINESSTYPE,KINDITEM,REGION_CODE,ZIP_NUMBER1,ADDRESS1,TEL_NUMBER1,  
				ZIP_NUMBER2,ADDRESS2,TEL_NUMBER2,REP_NAME1,REP_NAME2,REP_EMAIL,REP_JUMIN,REP_ZIP_NUMBER1,
				REP_ADDRESS1,REP_ZIP_NUMBER2,REP_ADDRESS2,REP_TEL_NUMBER1,REP_TEL_NUMBER2,REP_TASTE,
				REP_RELIGIOUS,REP_BORN_AREA,CHRG_DEPARTMENT,CHRG_GRADE,CHRG_NAME1,CHRG_NAME2,CHRG_HP,
				CHRG_EMAIL,CHRG_JUMIN,CHRG_ZIP_NUMBER1,CHRG_ADDRESS1,CHRG_ZIP_NUMBER2,CHRG_ADDRESS2,
				CHRG_TEL_NUMBER2,CHRG_BORN_AREA,FAX_NUMBER,ISO_STATUS,MAIN_BANK,DEPOSITOR,ACC_NUMBER,
				SPECIALITY,CAPITAL1,PROPERTY1,DEBT1,CAPITAL_TOT1,SALE_AMT1,PROFIT1,C_GRADE1,CAPITAL2,
				PROPERTY2,DEBT2,CAPITAL_TOT2,SALE_AMT2,PROFIT2,C_GRADE2,CAPITAL3,PROPERTY3,DEBT3,CAPITAL_TOT3,
				SALE_AMT3,PROFIT3,C_GRADE3,INPUT_DT,INPUT_NAME
			FROM	S_REQ_SBCR
			WHERE	SBCR_UNQ_NUM = ai_unq_num)
		WHERE SBCR_CODE = C_SBCR_CODE;
	END IF;

	update s_req_sbcr
		set sbcr_code = C_SBCR_CODE
	 where sbcr_unq_num = ai_unq_num;

--	SELECT businessman_number into C_TEMP FROM S_REQ_SBCR WHERE SBCR_UNQ_NUM = ai_unq_num;
-- 	UPDATE z_webuser_code SET SBCR_CODE = C_SBCR_CODE, GUBUN = as_gubun where businessman_number = C_TEMP;
--	UPDATE S_REQ_SBCR SET SBCR_CODE = C_SBCR_CODE WHERE SBCR_UNQ_NUM = ai_unq_num;

	DELETE FROM S_COMPANY_HISTORY WHERE sbcr_code = C_SBCR_CODE;
	INSERT INTO S_COMPANY_HISTORY  
	  SELECT C_SBCR_CODE,a.SEQ,a.E_DATE,a.DETAIL,a.REMARK
		 FROM S_REQ_COMPANY_HISTORY a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num
		  AND a.seq not in (select seq from s_company_history where sbcr_code = C_SBCR_CODE );

	DELETE FROM s_scholarship WHERE sbcr_code = C_SBCR_CODE;
	insert into s_scholarship
	  select C_SBCR_CODE,a.class,a.spec_seq,a.scholarship_class,a.sch_date,a.name,a.subject_name,a.graduation_class,a.remark
		 from s_req_scholarship a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num   
		  AND a.class || a.spec_seq not in (select class || spec_seq from s_scholarship where sbcr_code = C_SBCR_CODE);

	DELETE FROM s_award WHERE sbcr_code = C_SBCR_CODE;
	insert into s_award
	  select C_SBCR_CODE,a.seq,a.e_date,a.owner,a.name,a.reson
		 from s_req_award a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num
		  AND a.seq not in (select seq from s_award where sbcr_code = C_SBCR_CODE );

	DELETE FROM s_const WHERE sbcr_code = C_SBCR_CODE;
	insert into s_const
	  select C_SBCR_CODE,a.othercompany_seq,a.owner,a.profession_wbs_name,a.othercompany_construction,
				a.othercompany_start_date,a.othercompany_end_date,a.othercompany_amt,a.sale_amt,a.bigo,a.year_class
		 from s_req_const a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num
		  AND a.othercompany_seq not in (select othercompany_seq from s_const where sbcr_code = C_SBCR_CODE);

	DELETE FROM s_master WHERE sbcr_code = C_SBCR_CODE;
	insert into s_master
	  select C_SBCR_CODE,a.seq,a.grade,a.name,a.age,
				a.imp_process,a.our_career_year,a.career_year,a.representative_rel,a.last_scholarship,a.imp_career
		 from s_req_master a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num
		  AND a.seq not in (select seq from s_master where sbcr_code = C_SBCR_CODE );

	DELETE FROM s_license_status WHERE sbcr_code = C_SBCR_CODE;
	insert into s_license_status
	  select C_SBCR_CODE,a.PROFESSION_WBS_CODE,a.seq,a.TREATKIND_CODE,a.SELECTION_TAG,a.PROFESSION_WBS_NAME,
				a.TREATKIND_LICENSE_NUMBER,a.LICENSE_ISSUE_DATE,a.REGION_CODE,a.CN_GRADE1,
				a.CN_GRADE_TOTAL1,a.CN_LIMIT_AMT1,a.CN_GRADE2,a.CN_GRADE_TOTAL2,a.CN_LIMIT_AMT2,
				a.CN_GRADE3,a.CN_GRADE_TOTAL3,a.CN_LIMIT_AMT3 
		 from s_req_license_status a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num
		  AND a.PROFESSION_WBS_CODE not in (select PROFESSION_WBS_CODE from s_license_status where sbcr_code = C_SBCR_CODE );

	DELETE FROM s_sale WHERE sbcr_code = C_SBCR_CODE;
	insert into s_sale
	  select C_SBCR_CODE,YEAR_CLASS,SEQ,SBCR_NAME,SALE_AMT,SALE_RT,REMARK
		 from s_req_sale
		WHERE SBCR_UNQ_NUM = ai_unq_num
		  AND year_class || seq not in (select year_class || seq from s_sale where sbcr_code = C_SBCR_CODE );


	insert into s_wbs_request
	  select C_SBCR_CODE,a.profession_wbs_code,as_class,a.register_req_date,sysdate,a.profession_wbs_name,a.treatkind_code,
				a.rep_year,a.chrg_year,a.recommender_department,a.recommender_grade,a.recommender_name,a.recommender_rel,
				a.recommender_reson,a.our_const_proj,a.our_const_amt,'',a.inout_name,a.inout_tel,10,'','','','Y'
		 from s_req_wbs_request a
		WHERE a.SBCR_UNQ_NUM = ai_unq_num
		  and a.profession_wbs_code = as_wbs_code
		  and a.profession_wbs_code not in (select profession_wbs_code from s_wbs_request where sbcr_code = C_SBCR_CODE);

    UPDATE S_WBS_REQUEST 
      SET ( register_chk, treatkind_code, rep_year, chrg_year,
    	      recommender_department, recommender_grade, recommender_name, recommender_rel, recommender_reson, our_const_proj,
    	      our_const_amt, inout_name, inout_tel) = 
         (SELECT as_class, a.treatkind_code, a.rep_year, a.chrg_year,
        		   a.recommender_department,a.recommender_grade,a.recommender_name,a.recommender_rel, a.recommender_reson,a.our_const_proj,
        			a.our_const_amt, a.inout_name, a.inout_tel
        FROM  	s_req_wbs_request a
        WHERE 	a.SBCR_UNQ_NUM = ai_unq_num
        AND a.profession_wbs_code = as_wbs_code)
    WHERE
    	SBCR_CODE = C_SBCR_CODE
    AND profession_wbs_code = as_wbs_code;

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
END y_sp_s_sbcr_insert;
/