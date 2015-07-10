CREATE OR REPLACE Procedure SP_CASH_PAY_WINDOW_CHECK
(
	p_pay_seq     IN NUMBER ,          -- 지급일련번호
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
    /*      - 현금이체시 담당자 확인/확인취소에 대하여 각각의 처리루틴       */
    /*        확인인지, 확인취소처리인지는 GUBUN코드로 구분한다.             */
    /*                                                                       */
    /*        (1) 확인처리 시                                                */
    /*          : T_FB_CASH_PAY_DATA에 담긴 해당 지급RECORD에 대하여 타행    */
    /*            이체여부를 확인하여, T_FB_LOOKUP_VALUES테이블의 은행별     */
    /*            이체한도금액을 확인하여, T_FB_CASH_PAY_DIVIDED_DATA에      */
    /*            분할지급건에 대하여 RECORD를 생성시킨다.                   */
    /*            이체한도에 안걸리면 보통 1개의 분할지급RECORD생성됨        */
    /*            생성시킨 후, PAY_STATUS를 담당자 확인상태로 UPDATE한다.    */
    /*                                                                       */
    /*        (2) 확인취소 처리 시                                           */ 
    /*          : 기 확인 된 건이었으므로, 분할지급테이블에 생성된 RECORD를  */
    /*            DELETE하고, PAY_STATUS를 담당자 미확인 상태로 변경시킨다.  */
    /*                                                                       */
    /*      - 담당자확인/확인취소처리는 팀장승인/지급완료/실패/전표취소 시를 */
    /*         제외한 상태에서만 처리가 가능함                               */
    /*                                                                       */
    /*      - 지급데이타의 출처가 "예금이체"인 경우는 확인/확인취소에 따라서 */
    /*        STATUS를 변경시켜준다. T_FB_CASH_TRANSFER_DATA의               */
    /*        FUND_TRANSFER_STATUS를 확인시는 '1'로 변경하며, 취소시는 '0'으 */
    /*        으로 UPDATE한다.                                               */
    /*                                                                       */    
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
-- 변수선언
				C_PAY_SEQ					t_fb_cash_pay_data.PAY_SEQ%TYPE;
				C_PAY_AMT					t_fb_cash_pay_data.PAY_AMT%TYPE;
				C_OUT_BANK_CODE		t_fb_cash_pay_data.OUT_BANK_CODE%TYPE;
				C_IN_BANK_CODE		t_fb_cash_pay_data.IN_BANK_CODE%TYPE;
				C_LIMIT_AMT		    NUMBER(20,5);
				C_DIVIDED_AMT		  NUMBER(20,5);
				C_CNT		          INTEGER        DEFAULT 0;
-- 공통 변수
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				e_msg            VARCHAR2(100);
				i  		           INTEGER        DEFAULT 0;
-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	
Begin
	SELECT PAY_SEQ,				--지급일련번호
	       PAY_AMT,       --지급금액
	       OUT_BANK_CODE, --출금은행
	       IN_BANK_CODE   --입금은행
	INTO 	 C_PAY_SEQ,
				 C_PAY_AMT,
				 C_OUT_BANK_CODE,
				 C_IN_BANK_CODE
	FROM   T_FB_CASH_PAY_DATA
	WHERE  PAY_SEQ = p_pay_seq ;
	
  IF SQL%NOTFOUND THEN
     errmsg  := '현금지급데이타 생성 실패!';
     errflag := -20020;
     RAISE Err;
  END IF;   	

 	IF p_job_gubun = 'CHECK' THEN --담당자 확인처리시
 				 	
		IF C_OUT_BANK_CODE <> C_IN_BANK_CODE THEN  --타행이체시
			
		 	  SELECT TRUNC( (C_PAY_AMT/ TO_NUMBER(LOOKUP_VALUE)) ,0)+
		 	         DECODE(GREATEST(MOD(C_PAY_AMT, TO_NUMBER(LOOKUP_VALUE)),0),0,0,1), --이체건수
		 	         TO_NUMBER(LOOKUP_VALUE)                                            --이체한도
		 	  INTO   C_CNT ,
		 	  			 C_LIMIT_AMT	
		 	  FROM   T_FB_LOOKUP_VALUES
		 	  WHERE  LOOKUP_TYPE = 'TA_TRAN_LIMIT'
		 	  AND    LOOKUP_CODE = C_OUT_BANK_CODE
		 	  AND    USE_YN      = 'Y' ;
		 	  
			  IF SQL%NOTFOUND THEN
			     errmsg  := '기초데이타 생성 실패!';
			     errflag := -20021;
			     RAISE Err;
			  END IF;   			 	  
					 	  
		ELSE
				C_CNT := 1;
		END IF	;	  
  				
		For i In 1..C_CNT Loop -- 분할지급금액
			 	
			IF C_CNT = 1 THEN
				 C_DIVIDED_AMT := C_PAY_AMT;
			ELSE
				 IF i < C_CNT THEN
				 		C_DIVIDED_AMT := C_LIMIT_AMT;
				 ELSE
				 		C_DIVIDED_AMT := C_PAY_AMT - (C_LIMIT_AMT*(i-1));		
				 END IF;
			END IF	; 		
			 		 		
			BEGIN
--현금지급분할데이타 생성
			INSERT INTO T_FB_CASH_PAY_DIVIDED_DATA
			(
				PAY_SEQ,
				DIV_SEQ,
				PAY_AMT
			)
			VALUES
			(
				C_PAY_SEQ,
				i,
				C_DIVIDED_AMT
			) ;

			EXCEPTION
			WHEN OTHERS THEN
				  errmsg := 'INSERT 처리 실패!' ;
				  errflag := -20022 ;
				  RAISE Err;
					EXIT;
			END;				    		  
 	
		End Loop;
--현금지급데이타 UPDATE			
		UPDATE T_FB_CASH_PAY_DATA
		SET    PAY_STATUS ='1',
		       CASHIER_CONFIRM_DATE = SYSDATE
		WHERE  PAY_SEQ = C_PAY_SEQ		    ;		
		
	  IF SQL%NOTFOUND THEN
	     errmsg  := '지급데이타 수정 실패!';
	     errflag := -20023;
	     RAISE Err;
	  END IF;

	ELSIF p_job_gubun = 'CANCEL' THEN --담당자 확인취소시
--현금지급분할데이타삭제		
		DELETE FROM T_FB_CASH_PAY_DIVIDED_DATA
		WHERE PAY_SEQ = C_PAY_SEQ		    ;

	  IF SQL%NOTFOUND THEN
	     errmsg  := '분할데이타 삭제 실패!';
	     errflag := -20024;
	     RAISE Err;
	  END IF;

		
--현금지급데이타 UPDATE			
		UPDATE T_FB_CASH_PAY_DATA
		SET    PAY_STATUS ='0',
		       CASHIER_CONFIRM_DATE = NULL
		WHERE  PAY_SEQ = C_PAY_SEQ		    ;
		
	  IF SQL%NOTFOUND THEN
	     errmsg  := '지급데이타 수정 실패!';
	     errflag := -20025;
	     RAISE Err;
	  END IF;
	END IF;

EXCEPTION
	WHEN Err THEN
		RAISE_APPLICATION_ERROR(errflag ,errmsg);
End;
/
