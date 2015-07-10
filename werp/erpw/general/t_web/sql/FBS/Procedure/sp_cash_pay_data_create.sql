CREATE OR REPLACE Procedure SP_CASH_PAY_DATA_CREATE
(
	p_TRANSFER_SEQ     IN NUMBER   ,        -- 지급이체일련번호
	p_emp_no           IN VARCHAR2          -- 사번 
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : SP_CASH_PAY_DATA_CREATE                               */
    /*  2. 모듈이름  : 현금지급이체데이타 생성                               */
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
        v_pay_seq        NUMBER         DEFAULT 0;   -- 지급일련번호
-- 공통 변수
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				e_msg            VARCHAR2(100);
				i  		           INTEGER        DEFAULT 0;
-- User Define Error
				Err         			EXCEPTION;                 -- Select Data Not Found        	
Begin

--지급일련번호 검색
    SELECT T_FB_CASH_PAY_DATA_SEQ.NEXTVAL 
    INTO v_pay_seq
    FROM DUAL ;

--현금지급데이타 INSERT	
    INSERT INTO T_FB_CASH_PAY_DATA	
    ( PAY_SEQ ,
      PAY_KIND_GUBUN,
      COMP_CODE,
      PAY_AMT,
      PAY_DUE_YMD,
      IN_BANK_CODE,
      IN_ACCOUNT_NO,
      ACCT_HOLDER_NAME,
      OUT_BANK_CODE,
      OUT_ACCOUNT_NO,
      DESCRIPTION ,
      PAY_STATUS,
      EDI_CREATE_REQ_YN,
      SLIP_ID ,
      CREATION_DATE,
      CREATION_EMP_NO )
    SELECT v_pay_seq ,
           'TR',
           A.COMP_CODE,
           A.TRANSFER_AMT,
           A.REQUEST_YMD,
           A.IN_BANK_CODE,
           A.IN_ACCOUNT_NO,
           B.ACCT_NAME,
           A.OUT_BANK_CODE,
           A.OUT_ACCOUNT_NO,
           A.DESCRIPTION ,
           '0',
           'N',
           11 ,
           SYSDATE,
           p_emp_no
    FROM T_FB_CASH_TRANSFER_DATA A,
         T_ACCNO_CODE B 
    WHERE A.IN_ACCOUNT_NO = B.ACCNO
    AND A.TRANSFER_SEQ = p_TRANSFER_SEQ ;
    
--현금이체데이타 UPDATE
		UPDATE T_FB_CASH_TRANSFER_DATA
		SET    PAY_SEQ            = v_pay_seq,
		       TRANSFER_YMD       = TO_CHAR(SYSDATE,'YYYYMMDD'),
		       SLIP_ID            = 11 ,
		       FUND_TRANSFER_STATUS = 'S',
		       LAST_MODIFY_DATE   = SYSDATE,
		       LAST_MODIFY_EMP_NO = p_emp_no
		WHERE  TRANSFER_SEQ = p_TRANSFER_SEQ	;		

EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		fbs_util_pkg.write_log('FBS', sqlerrm);
--현금이체데이타 UPDATE
		UPDATE T_FB_CASH_TRANSFER_DATA
		SET    FUND_TRANSFER_STATUS = 'C',
		       LAST_MODIFY_DATE   = SYSDATE,
		       LAST_MODIFY_EMP_NO = p_emp_no
		WHERE  TRANSFER_SEQ = p_TRANSFER_SEQ	;				
		COMMIT;
		RAISE_APPLICATION_ERROR(-20010 ,sqlerrm);
End;
/
