CREATE OR REPLACE Procedure SP_BILL_PAY_WINDOW_CHECK
(
	p_pay_seq     IN NUMBER ,          -- 지급일련번호
	p_level_gubun IN VARCHAR2 ,        -- 지급구분 [ CASHIER:출납 , MANAGER:팀장]
	p_job_gubun   IN VARCHAR2 ,        -- 처리구분 [ CHECK:확인 , CANCEL:확인취소 ]
	p_emp_no      IN VARCHAR2          -- 사번                                       
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : cash_pay_window_check                                 */
    /*  2. 모듈이름  : 현금이체 담당자 획인 및 취소처리 로직                 */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
-- 변수선언
				C_PAY_SEQ					t_fb_cash_pay_data.PAY_SEQ%TYPE;
-- 공통 변수
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				e_msg            VARCHAR2(100);
				i  		           INTEGER        DEFAULT 0;
-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	
Begin

	C_PAY_SEQ := p_pay_seq ;

 	IF p_level_gubun = 'CASHIER' THEN --담당자 처리시
	 	IF p_job_gubun = 'CHECK' THEN --확인처리시
	
	--전자어음지급데이타 UPDATE			
			UPDATE T_FB_BILL_PAY_DATA
			SET    PAY_STATUS ='1',
			       CASHIER_CONFIRM_DATE = SYSDATE
			WHERE  PAY_SEQ = C_PAY_SEQ		    ;		
			
		  IF SQL%NOTFOUND THEN
		     errmsg  := '지급데이타 수정 실패!';
		     errflag := -20023;
		     RAISE Err;
		  END IF;
	
		ELSIF p_job_gubun = 'CANCEL' THEN --담당자 확인취소시
			
	--전자어음지급데이타 UPDATE			
			UPDATE T_FB_BILL_PAY_DATA
			SET    PAY_STATUS ='0',
			       CASHIER_CONFIRM_DATE = NULL
			WHERE  PAY_SEQ = C_PAY_SEQ		    ;
			
		  IF SQL%NOTFOUND THEN
		     errmsg  := '지급데이타 수정 실패!';
		     errflag := -20025;
		     RAISE Err;
		  END IF;
		END IF;
	ELSIF	p_level_gubun = 'MANAGER' THEN --팀장 처리시
		
	 	IF p_job_gubun = 'CHECK' THEN --확인처리시
	
	--전자어음지급데이타 UPDATE			
			UPDATE T_FB_BILL_PAY_DATA
			SET    PAY_STATUS ='2',
			       MANAGER_CONFIRM_DATE = SYSDATE
			WHERE  PAY_SEQ = C_PAY_SEQ		    ;		
			
		  IF SQL%NOTFOUND THEN
		     errmsg  := '지급데이타 수정 실패!';
		     errflag := -20023;
		     RAISE Err;
		  END IF;
	
		ELSIF p_job_gubun = 'CANCEL' THEN --확인취소시
			
	--전자어음지급데이타 UPDATE			
			UPDATE T_FB_BILL_PAY_DATA
			SET    PAY_STATUS ='1',
			       MANAGER_CONFIRM_DATE = NULL
			WHERE  PAY_SEQ = C_PAY_SEQ		    ;
			
		  IF SQL%NOTFOUND THEN
		     errmsg  := '지급데이타 수정 실패!';
		     errflag := -20025;
		     RAISE Err;
		  END IF;
		END IF;		
	END IF;		

EXCEPTION
	WHEN Err THEN
		RAISE_APPLICATION_ERROR(errflag ,errmsg);
End;
/
