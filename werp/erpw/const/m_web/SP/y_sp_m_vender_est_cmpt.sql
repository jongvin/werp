/* ============================================================================= */
/* 함수명 : y_sp_m_vender_est_cmpt                                               */
/* 기  능 : 자재 업체별견적시 견적금액과 조정금액을 재계산한다.                  */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 일자                   ==> ad_date      (date)                       */
/*        : 순번                   ==> ai_seq      (INTEGER)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.05.08                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_vender_est_cmpt(as_dept_code    IN   VARCHAR2,
																 ad_date         IN   DATE,
                                                 ai_seq          IN   INTEGER ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT A.sbcr_code
  FROM m_vender_est A
 WHERE A.estimateyymm = ad_date AND
       A.estimateseq  = ai_seq ;

-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   V_sbcr_code       m_vender_est.sbcr_code%TYPE;
   C_QTY               m_est_detail.qty%TYPE;                -- 수량
   C_AMT               m_vender_est.amt%TYPE;                -- 금액
   C_CHG_AMT           m_vender_est.chg_amt%TYPE;                -- 금액
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_sbcr_code;
		EXIT WHEN DETAIL_CUR%NOTFOUND;

		select sum(nvl(TRUNC(b.qty * a.unitprice,0),0)) amt,
				 sum(nvl(Trunc(b.qty * a.chgprice,0),0)) chg_amt
		  into C_AMT,C_CHG_AMT
		  from m_vender_est_detail a,
				 m_est_detail b
		  where a.estimateyymm = b.estimateyymm
			 and a.estimateseq  = b.estimateseq
			 and a.est_unq_num  = b.est_unq_num
			 and a.estimateyymm = ad_date 
       	 and a.estimateseq  = ai_seq 
			 and a.sbcr_code  = V_sbcr_code;


       UPDATE m_vender_est
          SET AMT          = NVL(C_AMT,0),
              CHG_AMT      = NVL(C_CHG_AMT,0)
        WHERE estimateyymm = ad_date 
       	 and estimateseq  = ai_seq 
			 and sbcr_code  = V_sbcr_code;
 
	END LOOP;
	CLOSE DETAIL_CUR;
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
END y_sp_m_vender_est_cmpt;

/
