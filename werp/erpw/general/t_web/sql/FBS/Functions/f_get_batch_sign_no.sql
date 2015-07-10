    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : get_batch_sign_no                                     */
    /*  2. 모듈이름  : batch파일처리시  복기부호를 반환한다.                 */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - EDI파일생성시 이력key로서 가지고 있는 edi_history_seq를 넘겨받 */
    /*        아서, 해당 자료를 SELECT하여, 은행별 복기부호 생성규칙에 따라  */
    /*        복기부호를 생성한 후, 반환한다. (MAX값: VARCHAR2 8자리)        */
    /*                                                                       */
    /*      - 대상은행                                                       */
    /*         (1) 기업은행 [03]                                             */
    /*         (2) 국민은행 [04]                                             */
    /*         (3) 우리은행 [20]                                             */
    /*         (4) 하나은행 [81]                                             */
    /*                                                                       */
    /*      - 복기부호 만드는 동시성 체크를 위해서 EDI_HISTORY_SEQ를 받아    */
    /*        대상자료를 SELECT하여 복기부호를 생성하며, OUT PARAMETER로     */
    /*        총건수, 총금액을 반환하므로, 본 함수를 호출하는 함수내에서     */
    /*        그 건수 및 금액을 재확인하여 처리합니다                        */    
    /*                                                                       */
    /*      - 현금BATCH(하나은행)의 경우, 표제부에 들어가는 지급예정일       */
    /*        (YYYYMMDD)의 경우, T_FB_EDI_HISTORY의 기준일(STD_YMD)를 사용   */
    /*                                                                       */
    /*      - 현금인 경우, 기업은행 / 어음인 경우, 2개은행(하나,기업) 모두   */
    /*        복기부호를 검증하지 않으므로, 생성치 않습니다.                 */        
    /*                                                                       */
    /*      - 반환값 : 정상적인 경우, 만들어진 복기부호가 반환되며,          */
    /*                 오류가 난 경우는 NULL값이 반환됩니다.                 */    
    /*                                                                       */        
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월26일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
    create or replace     
    FUNCTION  get_batch_sign_no(  edi_history_seq IN NUMBER ,                 -- EDI이력일련번호   
                                  total_cnt       OUT NUMBER ,                -- 복기부호를 생성한 대상자료의 총 건수 
                                  total_sum       OUT NUMBER ,                -- 복기부호를 생성한 대상자료의 총 금액 
                                  etc_field1      IN VARCHAR2 DEFAULT NULL,   -- 자유필드1   
                                  etc_field2      IN VARCHAR2 DEFAULT NULL)   -- 자유필드2  
        RETURN VARCHAR2 IS
        
        v_sign_no          VARCHAR2(8) := NULL;      -- 반환할 복기부호
        v_cash_bill_gubun  VARCHAR2(1);              -- 현금인지, 전자어음인지 구분.
        v_comp_code        VARCHAR2(10);             -- 업체코드 
        v_comp_password    VARCHAR2(50);             -- 업체암호 
        n_total_cnt        NUMBER      := 0;         -- 실제 복기부호산정에 사용된 총 갯수  ==> 확인용 
        n_total_sum        NUMBER      := 0;         -- 실제 복기부호산정에 사용된 총 금액  ==> 확인용 
        out_bank_cd        VARCHAR2(2);              -- 출금은행코드 
        
        v_temp_str1        VARCHAR2(100);            -- 임시계산용 문자열 1  
        v_temp_str2        VARCHAR2(100);            -- 임시계산용 문자열 2 
        n_temp_number1     NUMBER := 0;              -- 임시계산용 숫자 1  
        n_temp_number2     NUMBER := 0;              -- 임시계산용 숫자 2  
        
        v_error_msg        VARCHAR2(300) := '';

		    KIUP_BANK_CD       VARCHAR2(2) := '03';   -- 기업은행
		    KUKMIN_BANK_CD     VARCHAR2(2) := '04';   -- 국민은행
		    WOORI_BANK_CD      VARCHAR2(2) := '20';   -- 우리은행
		    HANA_BANK_CD       VARCHAR2(2) := '81';   -- 하나은행
            
        CURSOR cur_select IS 
              SELECT REPLACE(C.IN_ACCOUNT_NO,'-','') AS ACCOUNT_NO,  
                     A.PAY_AMT AS PAY_AMT , 
                     C.IN_BANK_CODE AS IN_BANK_CODE
                FROM T_FB_CASH_PAY_DIVIDED_DATA A ,
                     T_FB_CASH_PAY_HISTORY B,
                     T_FB_CASH_PAY_DATA C
               WHERE B.PAY_SEQ = A.PAY_SEQ
                 AND B.DIV_SEQ = A.DIV_SEQ     
                 AND B.PAY_SEQ = C.PAY_SEQ
                 AND B.EDI_HISTORY_SEQ = edi_history_seq ;
        
        ERR_VALUE_ERROR      EXCEPTION;        -- 오류발생시
        
    BEGIN
    
       -- 먼저 EDI이력테이블을 확인하여,  해당 송수신건이 현금건인지, 어음건인지 확인하며,
       -- EDI history테이블에 있는 출금은행코드,사업장코드 를 가져와서 사용합니다. 
       BEGIN
           SELECT CASH_BILL_GUBUN , BANK_CODE , COMP_CODE 
             INTO v_cash_bill_gubun , out_bank_cd , v_comp_code 
             FROM T_FB_EDI_HISTORY
            WHERE EDI_HISTORY_SEQ = edi_history_seq ;
       EXCEPTION
           WHEN NO_DATA_FOUND THEN
               v_sign_no := NULL;
           WHEN OTHERS THEN
               v_sign_no := NULL;               
       END; 
              
       
       -- 현금인 경우...
       -----------------
       
       IF v_cash_bill_gubun = 'C' THEN
    
            /**************************************************************************************/               
            /* 국민은행인 경우                                                                    */
            /**************************************************************************************/              
            IF out_bank_cd = KUKMIN_BANK_CD THEN  
    
                -- 업체암호를 가져옵니다.
                BEGIN
                    SELECT COMP_PASSWORD
                      INTO v_comp_password
                      FROM T_FB_ORG_BANK
                     WHERE COMP_CODE = v_comp_code
                       AND BANK_MAIN_CODE = out_bank_cd;
                       
                    IF v_comp_password IS NULL OR v_comp_password = '' THEN
                        v_error_msg := '업체암호가 등록되어 있지 않습니다.(업체코드:'|| v_comp_code || ',은행코드:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                    END IF;
                    
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        v_error_msg := '업체암호가 등록되어 있지 않습니다.(업체코드:'|| v_comp_code || ',은행코드:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                END;                   
                   
                -- LOOPING을 돌면서 계좌번호 10번째 합 및 총이체건수,총이체금액을 가져옵니다.
                FOR rec IN cur_select LOOP
                    
                    -- 계좌번호 10번째 자리가 BLANK이거나, 입금은행이 국민은행(04)이면서 계좌길이가 12자리 미만이면 0 처리
                    -- n_temp_number1 : 각 계좌의 10번째 자리의 합.
                    -- n_temp_number2 : 각 계좌의 10번째 자리를 숫자로 변환한 값.
                    IF ( LENGTH(TRIM(rec.ACCOUNT_NO)) < 10 ) OR 
                       ( SUBSTRB(TRIM(rec.ACCOUNT_NO) , 10 , 1 ) = ' ' ) OR
                       ( rec.IN_BANK_CODE = '04' AND LENGTH(TRIM(rec.ACCOUNT_NO)) < 12 ) THEN
                       
                        n_temp_number2 := 0;
                       
                    ELSE
                        n_temp_number2 := TO_NUMBER( SUBSTRB( TRIM(rec.ACCOUNT_NO) , 10 , 1 ) );
                    END IF;
                    
                    n_temp_number1 := n_temp_number1 + n_temp_number2;

                    -- 체크용으로 전체건수와 전체금액을 구합니다. (국민은행의 경우, 하단에서 계산에 활용함) 
                    n_total_cnt := n_total_cnt + 1;
                    n_total_sum := n_total_sum + rec.PAY_AMT;                
                
                END LOOP;
                
                -- 복기부호 생성규칙에 의거해서, 생성을 합니다.
                n_temp_number2 := ( n_temp_number1 + n_total_sum + n_total_cnt ) / ( n_total_cnt + TO_NUMBER( TRIM(v_comp_password) ) );
                  
                -- 소수이하자리만 남긴 후(Trunc함수 사용) , 10000을 곱하고, 소수이하를 잘라버려서 복기부호를 구합니다.
                n_temp_number2 := TRUNC( ( n_temp_number2 - TRUNC( n_temp_number2 ) ) * 10000 );
                
                -- 산출복기부호의 자리수를 만들어서 4자리 미만인 경우, 오른쪽에 '0'을 붙입니다.
                v_sign_no := RPAD( TO_CHAR( n_temp_number2 ) , 4 , '0' );
                    
                     
                    
            /**************************************************************************************/               
            /* 우리은행인 경우                                                                    */
            /**************************************************************************************/        
            ELSIF out_bank_cd = WOORI_BANK_CD THEN    
                
                --  LOOPOMG을 돌면서 , 정해진 데이타(입금계좌번호,입금금액)으로 복기부호를 계산합니다.           
                FOR rec IN cur_select LOOP     

                    v_temp_str1 := TO_CHAR( rec.PAY_AMT );
                    
                    FOR i IN 1..LENGTH(rec.ACCOUNT_NO) LOOP
                        n_temp_number1 := n_temp_number1 + TO_NUMBER( SUBSTRB( rec.ACCOUNT_NO , i , 1 ) );                    
                    END LOOP;
                    
                    FOR i IN 1..LENGTH(v_temp_str1) LOOP
                        n_temp_number2 := n_temp_number2 + TO_NUMBER( SUBSTRB( v_temp_str1 , i , 1 ) );                    
                    END LOOP;
                
                    -- 체크용으로 전체건수와 전체금액을 구합니다.
                    n_total_cnt := n_total_cnt + 1;
                    n_total_sum := n_total_sum + rec.PAY_AMT;
                
                END LOOP;   

                v_sign_no := TO_CHAR( MOD( n_temp_number1 , n_temp_number2  ) ); 
                
                -- 산출된 복기부호가 6글자를 넘어가는 경우, 뒤의 6자리를 취합니다. 
                IF LENGTHB(v_sign_no) > 6 THEN
                    v_sign_no := SUBSTRB( v_sign_no ,LENGTHB(v_sign_no) - 5 , 6 );
                ELSE
                    v_sign_no := LPAD( v_sign_no , 6 , '0' );
                END IF;

                                  
            /**************************************************************************************/          
            /* 하나은행인 경우                                                                    */
            /**************************************************************************************/        
            ELSIF out_bank_cd = HANA_BANK_CD THEN       
    
                -- 지급예정일필드 ( T_FB_EDI_HISTORY의 STD_YMD컬럼을 사용합니다. 타 필드 사용시 수정필요) 
                SELECT SUBSTRB(STD_YMD,1,4)
                  INTO v_temp_str2
                  FROM T_FB_EDI_HISTORY
                 WHERE EDI_HISTORY_SEQ = edi_history_seq;
                   
                IF v_temp_str2 IS NULL OR v_temp_str2 = '' THEN
                    v_error_msg := 'T_FB_EDI_HISTORY의 기준일자(STD_YMD)에 값이 없습니다.';
                    RAISE ERR_VALUE_ERROR;
                END IF;
                    
                -- 업체암호를 가져옵니다.
                BEGIN
                    SELECT SUBSTRB(COMP_PASSWORD,1,4)
                      INTO v_comp_password
                      FROM T_FB_ORG_BANK
                     WHERE COMP_CODE = v_comp_code
                       AND BANK_MAIN_CODE = out_bank_cd;
                       
                    IF v_comp_password IS NULL OR v_comp_password = '' THEN
                        v_error_msg := '업체암호가 등록되어 있지 않습니다.(업체코드:'|| v_comp_code || ',은행코드:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                    END IF;
                    
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        v_error_msg := '업체암호가 등록되어 있지 않습니다.(업체코드:'|| v_comp_code || ',은행코드:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                END;     
    
                -- LOOPING을 돌면서 계좌번호 7번째까지의 합 및 이체금액으로 계산합니다.
                FOR rec IN cur_select LOOP      
                    
                    n_temp_number1 := 0;
                    
                    FOR each_byte IN 1..7 LOOP
                    
                        v_temp_str1 := SUBSTRB( rec.ACCOUNT_NO , each_byte , 1 );
                        
                        IF v_temp_str1 IS NOT NULL AND v_temp_str1 != '' THEN
                            n_temp_number1 := n_temp_number1 + TO_NUMBER( v_temp_str1 );
                        END IF;
                    
                    END LOOP;
                
                    n_temp_number2 := n_temp_number2 + TRUNC( ( n_temp_number1 * rec.PAY_AMT ) / 100 );
                
                    -- 체크용으로 전체건수와 전체금액을 구합니다. (하나은행의 경우, 하단에서 계산에 활용함) 
                    n_total_cnt := n_total_cnt + 1;
                    n_total_sum := n_total_sum + rec.PAY_AMT;                 
                
                END LOOP;

                v_temp_str1 := TRIM( TO_CHAR( ( TO_NUMBER( v_temp_str2 ) + 
                                                TO_NUMBER( v_comp_password ) +
                                                n_total_cnt +
                                                n_total_sum 
                                              ) - n_temp_number2 ) ); 
                
                v_sign_no := SUBSTRB( v_temp_str1 , LENGTH(v_temp_str1) - 3 ,  4 );
    
            /**************************************************************************************/               
            /* 기업은행인 경우  ==> 사용하지 않습니다.                                            */
            /**************************************************************************************/              
            ELSIF out_bank_cd = KIUP_BANK_CD THEN     
            
                v_sign_no := '';          
    
            END IF;

            
        -- 전자어음인 경우.... 
        ----------------------
           
        ELSIF v_cash_bill_gubun = 'B' THEN    

            /**************************************************************************************/          
            /* 하나은행인 경우 ==> 사용치 않습니다.                                               */
            /**************************************************************************************/        
            IF out_bank_cd = HANA_BANK_CD THEN        
    
                v_sign_no := '';         
            
    
            /**************************************************************************************/               
            /* 기업은행인 경우 ==> 사용치 않습니다.                                               */
            /**************************************************************************************/              
            ELSIF out_bank_cd = KIUP_BANK_CD THEN  
            
                v_sign_no := '';          
    
            END IF;
        
        
        END IF;
        
        -- OUT paramter로 넘긴 총건수, 총금액을 셋팅합니다. 
        total_cnt := n_total_cnt;
        total_sum := n_total_sum;
            
        RETURN( v_sign_no);
        
    EXCEPTION
    
        WHEN ERR_VALUE_ERROR THEN
            fbs_util_pkg.write_log('FBS','[get_bank_sign_no] '|| v_error_msg );        
            RETURN( NULL );
    
        WHEN OTHERS THEN
            fbs_util_pkg.write_log('FBS','[get_bank_sign_no] SQL OTHER 오류발생' || sqlerrm );
            RETURN( NULL );
        
    END get_batch_sign_no;
/
