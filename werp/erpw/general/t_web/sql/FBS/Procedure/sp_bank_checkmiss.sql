    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : sp_bank_checkmiss                                     */
    /*  2. 모듈이름  : 전자어음결번요청                                      */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : HP-UX + Oracle 9.2.0                                  */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 자동으로 전자어음결번전문을 만든다.                            */
    /*                                                                       */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년3월10일                                         */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/  
    Create Or Replace Procedure sp_bank_checkmiss(p_param IN VARCHAR2 DEFAULT NULL ) IS

        v_company_cd               VARCHAR2(2); 
        v_bank_cd                  VARCHAR2(2); 
        v_hour                     NUMBER; 
        v_chk                      NUMBER; 
        v_max_docu_numc            NUMBER;
        
		    FB_DOCU_BILL_TRX_B   VARCHAR2(7) := FBS_MAIN_PKG.FB_DOCU_BILL_TRX_B;  /*  어음거래명세     (은행=>업체) */  
		    FB_DOCU_BILL_MISS_T  VARCHAR2(7) := FBS_MAIN_PKG.FB_DOCU_BILL_MISS_T; /*  어음명세결번요청 (업체=>은행) */
		    FB_DOCU_BILL_MISS_B  VARCHAR2(7) := FBS_MAIN_PKG.FB_DOCU_BILL_MISS_B; /*  어음명세결번요청 (은행=>업체) */
        	                            
    BEGIN
        /***************************************************************/         
        /*  전자어음명세 결번을 확인하여, 자동으로 결번요청            */
        /***************************************************************/         
         v_hour := TO_NUMBER( TO_CHAR( SYSDATE , 'HH24' ) );
            
         -- 아침9시부터 오후9시까지 수행토록 한다. 
         IF v_hour >= 9 AND v_hour <= 21 THEN

            -- 은행별/거래처별 LOOP   
            FOR rec_gubun IN ( SELECT DISTINCT TRAN_CODE, ENTE_CODE ,BANK_CODE
                               FROM   T_FB_VAN_RECV 
                               WHERE  SEND_DATE = TO_CHAR(SYSDATE,'YYYYMMDD') 
                               AND    DOCU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,1,4) 
                               AND    UPMU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,5,3) ) LOOP
                                   
                SELECT TO_NUMBER(MAX(DOCU_NUMC)) 
                INTO   v_max_docu_numc
                FROM   T_FB_VAN_RECV 
                WHERE  TRAN_CODE = rec_gubun.TRAN_CODE
                AND    ENTE_CODE = rec_gubun.ENTE_CODE
                AND    BANK_CODE = rec_gubun.BANK_CODE                          
                AND    DOCU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,1,4) 
                AND    UPMU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,5,3) 
                AND    SEND_DATE = TO_CHAR(SYSDATE,'YYYYMMDD') ;
                  
                -- 해당 은행/거래처/전문구분/날짜에 해당하는 전문이 1부터 시작해서 빠진 번호가 있는지 확인합니다.
                FOR index_num IN 1..v_max_docu_numc LOOP 

                    -- 해당번호의 전문이 있는지 확인합니다.  
                    SELECT COUNT(*)
                    INTO   v_chk
                    FROM   T_FB_VAN_RECV
                    WHERE  TRAN_CODE = rec_gubun.TRAN_CODE
                    AND    ENTE_CODE = rec_gubun.ENTE_CODE
                    AND    BANK_CODE = rec_gubun.BANK_CODE
                    AND    DOCU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,1,4) 
                    AND    UPMU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,5,3) 
                    AND    SEND_DATE = TO_CHAR(SYSDATE,'YYYYMMDD')
                    AND    DOCU_NUMC = LPAD( TO_CHAR(index_num) , 6 , '0' );
                        
                    -- 해당 번호의 전문이 없는 경우이므로, 먼저 결번응답이 있는지 확인 한 후, 없으면 결번요청전문 송신  
                    IF v_chk = 0 THEN   

                        SELECT COUNT(*)
                        INTO   v_chk
                        FROM   T_FB_VAN_RECV
                        WHERE  TRAN_CODE = rec_gubun.TRAN_CODE
                        AND    ENTE_CODE = rec_gubun.ENTE_CODE
                        AND    BANK_CODE = rec_gubun.BANK_CODE
                        AND    DOCU_CODE = SUBSTRB(FB_DOCU_BILL_MISS_B,1,4) 
                        AND    UPMU_CODE = SUBSTRB(FB_DOCU_BILL_MISS_B,5,3)
                        AND    SEND_DATE = TO_CHAR(SYSDATE,'YYYYMMDD') 
                        AND    DOCU_NUMC = LPAD( TO_CHAR(index_num) , 6 , '0' );
                            
                        -- 해당 전문번호에 대하여 결번요청응답도 없는 경우는 결번요청 전문 송신    
                        IF v_chk = 0 THEN
                            -- 거래처코드로부터 회사코드를 가져옵니다.
                            SELECT COMP_CODE    ,rec_gubun.BANK_CODE
                            INTO   v_company_cd ,v_bank_cd
                            FROM   T_FB_ORG_BANK
                            WHERE  BANK_MAIN_CODE = rec_gubun.BANK_CODE
                            AND    TRAN_CODE      = rec_gubun.TRAN_CODE
                            AND    ENTE_CODE      = rec_gubun.ENTE_CODE
                            AND    ROWNUM = 1;
                                    
                            -- 결번요청 전문을 송신합니다.
													 sp_check_miss_req( v_company_cd	 ,	                      -- 사업장코드
														                  rec_gubun.BANK_CODE	 ,	                -- 은행코드
																							TO_CHAR(SYSDATE,'YYYYMMDD'),	          -- 거래일자
																							LPAD( TO_CHAR(index_num) , 6 , '0' ));  -- 결번
                                
                        END IF;
                                
                    END IF;    
                       
                END LOOP;  -- 해당은행/거래처/날짜/전문구분별 
                
            END LOOP;  -- 해당은행/거래처
            
         END IF;
    
    EXCEPTION    
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] 결번전문 오류발생.(회사코드:'||v_company_cd||',은행코드:'||v_bank_cd||')');
             RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(은행코드:'||v_bank_cd||')');
    END ;