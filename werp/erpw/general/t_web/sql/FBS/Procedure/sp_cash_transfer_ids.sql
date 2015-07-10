CREATE OR REPLACE Procedure SP_CASH_TRANSFER_IDS
(
	p_job_gubun        IN VARCHAR2 ,        -- 작업구분(INSERT, UPDATE, DELETE)
	p_TRANSFER_SEQ     IN NUMBER   ,        -- 지급이체일련번호
	p_REQUEST_YMD      IN VARCHAR2 ,        -- 이체예정일자
	p_OUTACCOUNT_CODE  IN VARCHAR2 ,        -- 출금계좌번호
	p_OUTBANK_CODE     IN VARCHAR2 ,        -- 출금은행
	p_INACCOUNT_CODE   IN VARCHAR2 ,        -- 입금계좌번호
	p_INBANK_CODE      IN VARCHAR2 ,        -- 입금은행
	p_TRANSFER_AMT     IN NUMBER   ,        -- 이체금액
	p_COMP_CODE        IN VARCHAR2 ,        -- 사업장코드
	p_DESCRIPTION      IN VARCHAR2 ,        -- 적요
	p_emp_no           IN VARCHAR2          -- 사번 
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : SP_CASH_TRANSFER_IDS                                  */
    /*  2. 모듈이름  : 현금지급이체데이타 생성 및 수정 ,삭제                 */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년02월15일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
-- 변수선언
-- 공통 변수
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				e_msg            VARCHAR2(100);
				i  		           INTEGER        DEFAULT 0;
-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	
Begin

 	IF p_job_gubun = 'INSERT' THEN 

--현금지급이체데이타 INSERT	
    INSERT INTO T_FB_CASH_TRANSFER_DATA	
    ( TRANSFER_SEQ ,
      FUND_TRANSFER_STATUS,
      REQUEST_YMD,
      TRANSFER_AMT,
      OUT_BANK_CODE,
      OUT_ACCOUNT_NO,
      IN_BANK_CODE,
      IN_ACCOUNT_NO,
      DESCRIPTION,
      COMP_CODE,
      CREATION_DATE,
      CREATION_EMP_NO,
      PAY_SEQ )
    VALUES  
    ( T_FB_CASH_TRANSFER_DATA_SEQ.NEXTVAL ,
      'I' ,
			p_REQUEST_YMD ,
			p_TRANSFER_AMT ,
			p_OUTBANK_CODE ,
			p_OUTACCOUNT_CODE,
			p_INBANK_CODE ,
			p_INACCOUNT_CODE ,
			p_DESCRIPTION ,
			p_COMP_CODE ,
			SYSDATE,
			p_emp_no ,
			0 ) ;

	ELSIF p_job_gubun = 'UPDATE' THEN 

		UPDATE T_FB_CASH_TRANSFER_DATA
		SET    REQUEST_YMD    = p_REQUEST_YMD,
		       TRANSFER_AMT   = p_TRANSFER_AMT,
		       OUT_BANK_CODE  = p_OUTBANK_CODE,
		       OUT_ACCOUNT_NO = p_OUTACCOUNT_CODE,
		       IN_BANK_CODE   = p_INBANK_CODE,
		       IN_ACCOUNT_NO  = p_INACCOUNT_CODE,
		       DESCRIPTION    = p_DESCRIPTION,
		       LAST_MODIFY_DATE   = SYSDATE,
		       LAST_MODIFY_EMP_NO = p_emp_no
		WHERE  TRANSFER_SEQ = p_transfer_seq	;		

	ELSIF p_job_gubun = 'DELETE' THEN 

		DELETE FROM T_FB_CASH_TRANSFER_DATA
		WHERE  TRANSFER_SEQ = p_transfer_seq	;		

	END IF;	  

EXCEPTION
	WHEN OTHERS THEN
		fbs_util_pkg.write_log('FBS', sqlerrm||'('||p_job_gubun||')');
		RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'('||p_job_gubun||')');
End;
/
