/* ============================================================================= */
/* 함수명 : y_sp_c_structure_insert                                                 */
/* 기  능 :   조직도 이전차수 복사                                       */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드                    ==> as_dept_code (string)                     */
/*        : 변경순번(이전)               ==> an_old_chg_no_seq(NUMBER)                    */
/*        : 변경순번(이후)               ==> an_new_chg_no_seq      (NUMBER)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                               */
/* 작성일 : 2004.10.15                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_structure_insert(as_dept_code    IN  VARCHAR2,
                                            an_old_chg_no_seq   IN   NUMBER,
                                            an_new_chg_no_seq   IN   NUMBER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
		INSERT INTO c_structure
          SELECT a.dept_code,
                 an_new_chg_no_seq,
         a.ji_1,   
         a.jikwi_1,   
         a.name_1,   
         a.buim_tag_1,   
         a.input_date_1,   
         a.ji_2,   
         a.jikwi_2,   
         a.name_2,   
         a.buim_tag_2,   
         a.input_date_2,   
         a.ji_3,   
         a.jikwi_3,   
         a.name_3,   
         a.buim_tag_3,   
         a.input_date_3,   
         a.ji_4,   
         a.jikwi_4,   
         a.name_4,   
         a.buim_tag_4,   
         a.input_date_4,   
         a.ji_5,   
         a.jikwi_5,   
         a.name_5,   
         a.buim_tag_5,   
         a.input_date_5,   
         a.ji_6,   
         a.jikwi_6,   
         a.name_6,   
         a.buim_tag_6,   
         a.input_date_6,   
         a.ji_7,   
         a.jikwi_7,   
         a.name_7,   
         a.buim_tag_7,   
         a.input_date_7,   
         a.ji_8,   
         a.jikwi_8,   
         a.name_8,   
         a.buim_tag_8,   
         a.input_date_8,   
         a.ji_9,   
         a.jikwi_9,   
         a.name_9,   
         a.buim_tag_9,   
         a.input_date_9,   
         a.ji_10,   
         a.jikwi_10,   
         a.name_10,   
         a.buim_tag_10,   
         a.input_date_10,   
         a.ji_11,   
         a.jikwi_11,   
         a.name_11,   
         a.buim_tag_11,   
         a.input_date_11,   
         a.ji_12,   
         a.jikwi_12,   
         a.name_12,   
         a.buim_tag_12,   
         a.input_date_12,   
         a.ji_13,   
         a.jikwi_13,   
         a.name_13,   
         a.buim_tag_13,   
         a.input_date_13,   
         a.ji_14,   
         a.jikwi_14,   
         a.name_14,   
         a.buim_tag_14,   
         a.input_date_14,   
         a.ji_15,   
         a.jikwi_15,   
         a.name_15,   
         a.buim_tag_15,   
         a.input_date_15,   
         a.ji_16,   
         a.jikwi_16,   
         a.name_16,   
         a.buim_tag_16,   
         a.input_date_16,   
         a.ji_17,   
         a.jikwi_17,   
         a.name_17,   
         a.buim_tag_17,   
         a.input_date_17,   
         a.ji_18,   
         a.jikwi_18,   
         a.name_18,   
         a.buim_tag_18,   
         a.input_date_18,   
         a.ji_19,   
         a.jikwi_19,   
         a.buim_tag_19,   
         a.name_19,   
         a.input_date_19,   
         a.ji_20,   
         a.jikwi_20,   
         a.name_20,   
         a.buim_tag_20,   
         a.input_date_20,   
         a.ji_21,   
         a.jikwi_21,   
         a.name_21,   
         a.buim_tag_21,   
         a.input_date_21,   
         a.ji_22,   
         a.jikwi_22,   
         a.name_22,   
         a.buim_tag_22,   
         a.input_date_22,   
         a.ji_23,   
         a.jikwi_23,   
         a.name_23,   
         a.buim_tag_23,   
         a.input_date_23,   
         a.ji_24,   
         a.jikwi_24,   
         a.name_24,   
         a.buim_tag_24,   
         a.input_date_24,   
         a.ji_25,   
         a.jikwi_25,   
         a.name_25,   
         a.buim_tag_25,   
         a.input_date_25,   
         a.ji_26,   
         a.jikwi_26,   
         a.name_26,   
         a.buim_tag_26,   
         a.input_date_26,   
         a.ji_27,   
         a.jikwi_27,   
         a.name_27,   
         a.buim_tag_27,   
         a.input_date_27,   
         a.ji_28,   
         a.jikwi_28,   
         a.name_28,   
         a.buim_tag_28,   
         a.input_date_28,   
         a.ji_29,   
         a.jikwi_29,   
         a.name_29,   
         a.buim_tag_29,   
         a.input_date_29,   
         a.ji_30,   
         a.jikwi_30,   
         a.name_30,   
         a.buim_tag_30,   
         a.input_date_30,   
         a.ji_31,   
         a.jikwi_31,   
         a.name_31,   
         a.buim_tag_31,   
         a.input_date_31,   
         a.ji_32,   
         a.jikwi_32,   
         a.name_32,   
         a.buim_tag_32,   
         a.input_date_32,   
         a.ji_33,   
         a.jikwi_33,   
         a.name_33,   
         a.buim_tag_33,   
         a.input_date_33,   
         a.ji_34,   
         a.jikwi_34,   
         a.name_34,   
         a.buim_tag_34,   
         a.input_date_34,   
         a.ji_35,   
         a.jikwi_35,   
         a.name_35,   
         a.buim_tag_35,   
         a.input_date_35,   
         a.ji_36,   
         a.jikwi_36,   
         a.name_36,   
         a.buim_tag_36,   
         a.input_date_36,   
         a.ji_37,   
         a.jikwi_37,   
         a.name_37,   
         a.buim_tag_37,   
         a.input_date_37,   
         a.ji_38,   
         a.jikwi_38,   
         a.name_38,   
         a.buim_tag_38,   
         a.input_date_38,   
         a.ji_39,   
         a.jikwi_39,   
         a.name_39,   
         a.buim_tag_39,   
         a.input_date_39,   
         a.ji_40,   
         a.jikwi_40,   
         a.name_40,   
         a.buim_tag_40,   
         a.input_date_40  
      FROM c_structure  a  
            WHERE a.dept_code = as_dept_code
              and a.chg_no_seq = an_old_chg_no_seq;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'insert c_structure 자료변환 실패! [Line No: 157]';
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
END y_sp_c_structure_insert;

/
