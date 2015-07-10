    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : sp_bank_opening                                        */
    /*  2. 모듈이름  : 개시전문                                              */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : HP-UX + Oracle 9.2.0                                  */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 사업자/은행정보에서 은행을 조회하여서 개시전문을 만든다.       */
    /*                                                                       */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년3월08일                                         */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/  
    Create Or Replace Procedure sp_bank_opening(p_param IN VARCHAR2 DEFAULT NULL ) IS

        v_company_cd               VARCHAR2(2); 
        v_bank_cd                  VARCHAR2(2); 
        	                            
    BEGIN

        FOR rec IN ( SELECT DISTINCT A.BANK_MAIN_CODE   AS bank_cd ,
                                     A.COMP_CODE        AS company_cd
                       FROM T_FB_ORG_BANK A
                    )
        LOOP

        v_company_cd := rec.company_cd;
        v_bank_cd := rec.bank_cd;
        
        -- 전문을 생성
        sp_send_start_document( v_company_cd , v_bank_cd );    
                         
		    END LOOP;
    
    EXCEPTION    
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] 개시전문 오류발생.(회사코드:'||v_company_cd||',은행코드:'||v_bank_cd||')');
             RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(은행코드:'||v_bank_cd||')');
    END ;