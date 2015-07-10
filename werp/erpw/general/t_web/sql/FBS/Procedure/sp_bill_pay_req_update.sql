CREATE OR REPLACE Procedure SP_BILL_PAY_REQ_UPDATE
(
	p_job_gubun   IN VARCHAR2 ,        -- 작업구분(CREATE:이체파일생성시작 FINISH:파일작성완료)
	p_pay_seq     IN NUMBER ,          -- 지급일련번호
	p_emp_no      IN VARCHAR2          -- 사번                                       
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : SP_BILL_PAY_REQ_UPDATE                                */
    /*  2. 모듈이름  : 전자어음지급데이타의 EDI생성요청여부 수정             */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - EDI 배치 파일을 만드기전 잠금 장치로 FLAG UPDATE               */
    /*        ('Y' :파일 작성중 'N': )                                       */
    /*                                                                       */
    /*                                                                       */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년02월7일                                         */
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

 	IF p_job_gubun = 'CREATE' THEN --파일생성시작시

--현금지급데이타 UPDATE			
		UPDATE T_FB_BILL_PAY_DATA
		SET    PAY_METHOD_GUBUN   = 'B',
		       EDI_CREATE_REQ_YN  = 'Y',
		       LAST_MODIFY_DATE   = SYSDATE,
		       LAST_MODIFY_EMP_NO = p_emp_no
		WHERE  PAY_SEQ = p_pay_seq	;		
		
	  IF SQL%NOTFOUND THEN
	  	 ROLLBACK;	
	     errmsg  := '지급데이타 수정 실패!';
	     errflag := -20020;
	     RAISE Err;
	  END IF;

	ELSIF p_job_gubun = 'FINISH' THEN --파일완료시
--현금지급데이타 UPDATE	
		UPDATE T_FB_BILL_PAY_DATA
		SET    PAY_STATUS  = '3',
		       EDI_CREATE_REQ_YN  = 'N',
		       LAST_MODIFY_DATE   = SYSDATE,
		       LAST_MODIFY_EMP_NO = p_emp_no
		WHERE  PAY_SEQ = p_pay_seq	;		

	  IF SQL%NOTFOUND THEN
	  	 ROLLBACK;
	     errmsg  := '지급데이타 수정 실패!';
	     errflag := -20021;
	     RAISE Err;
	  END IF;

	END IF;	  

EXCEPTION
	WHEN Err THEN
		RAISE_APPLICATION_ERROR(errflag ,errmsg);
End;
/
