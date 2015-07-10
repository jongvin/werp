CREATE OR REPLACE Procedure SP_FBS_ORDER_SAVE
(
	p_ACCOUNT_NO       IN VARCHAR2 ,        -- 계좌번호
	p_FBS_ORDER        IN NUMBER   ,        -- 순서
	p_emp_no           IN VARCHAR2          -- 사번 
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : SP_FBS_ORDER_SAVE                                     */
    /*  2. 모듈이름  : 계좌번호 조회순서저장                                 */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년02월20일                                        */
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

		UPDATE T_ACCNO_CODE
		SET    FBS_DISPLAY_ORDER  = p_FBS_ORDER ,
		       MODDATE   = SYSDATE,
		       MODUSERNO = p_emp_no
		WHERE  ACCNO = p_ACCOUNT_NO	;		

EXCEPTION
	WHEN OTHERS THEN		fbs_util_pkg.write_log('FBS', sqlerrm||'(계좌번호:'||p_ACCOUNT_NO||')');
		RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(계좌번호:'||p_ACCOUNT_NO||')');

End;
/
