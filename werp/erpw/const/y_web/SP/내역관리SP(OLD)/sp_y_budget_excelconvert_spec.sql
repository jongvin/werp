/* ============================================================================= */
/* 함수명 : sp_y_budget_excelconvert_spec                                        */
/* 기  능 : EXCEL자료 변환(EXCEL -> 실행내역) .                                  */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_proj_code (string)                     */
/*        : 부분                   ==> as_part      (string)                     */
/*        : 번호                   ==> ai_degree    (string)                     */
/*        : 사용자                 ==> as_user      (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2002.11.21                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_budget_excelconvert_spec(as_proj_code    IN   VARCHAR2,
                                                          as_part         IN   VARCHAR2,
                                                          ai_no           IN   INTEGER,
                                                          as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
  CURSOR DETAIL_CUR IS
  SELECT sum_code
    FROM y_tmp_detail  
   WHERE proj_code  = as_proj_code AND  
         part_class = as_part AND  
         connect_yn = 'Y' AND
         spec_unq_num = 0  
group by proj_code,
         part_class,
         sum_code 
order by proj_code asc,
         part_class asc,
         sum_code asc;


-- 공통 변수 
   V_SUM_CODE          Y_CHG_BUDGET_SUMMARY.SUM_CODE%TYPE;
   C_MNG_CODE          Y_CHG_BUDGET_SUMMARY.MNG_CODE%TYPE;
   C_WBS_CODE          Y_CHG_BUDGET_SUMMARY.WBS_CODE%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_CNT           NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN

 BEGIN
-- 표준자원과 자원구분,자재코드 및 단가를 적용한다. 
   UPDATE y_tmp_detail a
      SET (a.res_class,a.mat_code) =
           ( SELECT b.res_class,b.mat_code
               FROM y_stand_spec b
              WHERE a.detail_code = b.detail_code)
    WHERE (a.proj_code      = as_proj_code) AND 
          (a.part_class     = as_part) AND
          (a.res_connect_yn = 'Y') AND
          (a.spec_unq_num   = 0 ) AND
          (a.connect_yn     = 'Y');


	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_SUM_CODE;
		EXIT WHEN DETAIL_CUR%NOTFOUND;

-- 집계구조수정. 
begin
   UPDATE Y_CHG_BUDGET_SUMMARY  
      SET INVEST_CLASS = 'Y',   
          DETAIL_YN = 'Y'  
    WHERE proj_code = as_proj_code
      AND no        = ai_no
      AND sum_code  = V_SUM_CODE;

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '실행으로 자료변환 실패! [Line No: 157]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
end;
   SELECT max(seq)
     INTO C_SEQ
     FROM Y_CHG_BUDGET_DETAIL
    WHERE proj_code = as_proj_code
      AND no        = ai_no
      AND sum_code  = V_SUM_CODE;

   SELECT mng_code,wbs_code
     INTO C_MNG_CODE,C_WBS_CODE
     FROM y_chg_budget_summary
    WHERE proj_code = as_proj_code
      AND no        = ai_no
      AND sum_code  = V_SUM_CODE;

-- 실행내역으로 변환.
begin
   INSERT INTO y_chg_budget_detail
        SELECT proj_code,ai_no,sum_code,y_spec_unq_num.nextval,
	            detail_code,res_class,NVL(C_SEQ,0) + NVL(seq,0),C_MNG_CODE,C_WBS_CODE,mat_code,'N','N',
			   	name,ssize,unit,1,cnt_price,cnt_price,cnt_mat_price,cnt_mat_price,
               cnt_lab_price,cnt_lab_price,cnt_exp_price,cnt_exp_price,
				   qty,0,price,amt,mat_price,mat_amt,lab_price,lab_amt,exp_price,
   				exp_amt,equ_price,equ_amt,sub_price,sub_amt,0,0,'',
	   			'','','','','',sysdate,as_user
          FROM y_tmp_detail  
         WHERE ( proj_code  = as_proj_code ) AND  
               ( part_class = as_part ) AND  
               ( connect_yn = 'Y' ) AND
               ( spec_unq_num   = 0 ) AND
               ( sum_code   = V_SUM_CODE)  ;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '실행으로 자료변환 실패! [Line No: 158]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
end;
	END LOOP;
	CLOSE DETAIL_CUR;

        
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '실행으로 자료변환 실패! [Line No: 159]';
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
END sp_y_budget_excelconvert_spec;

/
