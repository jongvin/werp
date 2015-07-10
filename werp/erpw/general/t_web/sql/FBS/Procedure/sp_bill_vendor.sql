    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : sp_bill_vendor                                        */
    /*  2. 모듈이름  : 전자어음업체정보                                      */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : HP-UX + Oracle 9.2.0                                  */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 자동으로 전자어음업체 정보를 만든다.                           */
    /*                                                                       */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년3월08일                                         */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/  
    Create Or Replace Procedure sp_bill_vendor(p_param IN VARCHAR2 DEFAULT NULL ) IS

        v_company_cd               VARCHAR2(2); 
        v_bank_cd                  VARCHAR2(2); 
        	                            
    BEGIN
        /***************************************************************/         
        /*  자동으로 전자어음정보 요청                                 */
        /***************************************************************/         
        -- 사업장/은행별 LOOP   
        FOR rec_gubun IN ( SELECT DISTINCT COMP_CODE, BANK_MAIN_CODE
                           FROM   T_FB_ORG_BANK 
                           WHERE  VENDOR_SUBJECT_NAME IS NOT NULL  ) LOOP
                                    
	           -- 전자어음정보요청 전문을 송신합니다.
	           v_company_cd := rec_gubun.comp_code;
	           v_bank_cd := rec_gubun.bank_main_code;
	           
		    		 sp_read_bill_vendor_info( v_company_cd ,     -- 시압징코드
		    		                           v_bank_cd    ,     -- 은행코드
		    		                           'SYSTEM'   ) ;     -- 사원번호
             
        END LOOP;  -- 사업장/은행별
    
    EXCEPTION    
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] 전자어음정보전문 오류발생.(회사코드:'||v_company_cd||',은행코드:'||v_bank_cd||')');
             RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(은행코드:'||v_bank_cd||')');
    END ;