    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : f_opening_result                                      */
    /*  2. 모듈이름  : 개시전문결과                                          */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : HP-UX + Oracle 9.2.0                                  */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 회사코드/은행코드 입력받아서 개시전문결과를 반환               */
    /*                                                                       */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년3월08일                                         */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/  
    Create Or Replace Function f_opening_result(  
                                 company_cd  VARCHAR2 ,                      -- 회사코드
                                 bank_cd     VARCHAR2 ) RETURN VARCHAR2 IS   -- 은행코드


        v_tran_code                VARCHAR2(9); 
        v_ente_code                VARCHAR2(8); 
        v_result_code              VARCHAR2(10); 
        
		    FB_DOCU_OPEN_T    VARCHAR2(7) := '0800100'; /*  개시전문        (업체=>은행)  */
		    FB_DOCU_OPEN_B    VARCHAR2(7) := '0810100'; /*  개시전문        (은행=>업체)  */
        	                            
    BEGIN
    	  --사업장/은행정보 검색
    	  SELECT TRAN_CODE,
    	         ENTE_CODE
    	  INTO   v_tran_code ,
    	         v_ente_code
        FROM   T_FB_ORG_BANK
        WHERE  COMP_CODE = company_cd
        AND    BANK_MAIN_CODE = bank_cd ;
            	         
        -- 결과검색.
				SELECT RESP_CODE
				INTO   v_result_code
				FROM   T_FB_VAN_RECV
				WHERE  TRAN_CODE = v_tran_code
				AND    ENTE_CODE = v_ente_code
				AND    BANK_CODE = bank_cd
				AND    DOCU_CODE = SUBSTRB(FB_DOCU_OPEN_B,1,4)
				AND    UPMU_CODE = SUBSTRB(FB_DOCU_OPEN_B,5,3)
				AND    SEND_DATE = TO_CHAR(SYSDATE ,'yyyymmdd') ;

        RETURN( v_result_code );
    
    EXCEPTION
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] 파일명 생성을 위한 SUBJECT NAME이 등록되어 있지 않습니다. (회사코드:'||company_cd||',은행코드:'||bank_cd||')');
             RETURN('ERROR');             
    END ;