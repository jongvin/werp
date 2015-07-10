    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : f_get_edi_file_name(FBS_UTIL_PKG)                     */
    /*  2. 모듈이름  : 처리할 파일이름 생성                                  */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : HP-UX + Oracle 9.2.0                                  */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 회사코드/은행코드/구분을 입력받아서 파일명을 반환              */
    /*      - 구분코드                                                       */
    /*          CS ( Cash Send ) : 현금 송신 파일명                          */
    /*          CR ( Cash Receive ) : 현금 수신 파일명                       */
    /*          BS ( Bill Send ) : 전자어음 송신 파일명                      */
    /*          BR ( Bill Receive ) : 전자어음 수신 파일명                   */
    /*          VR ( Vendor Receive ) : 전자어음 거래선정보 수신 파일명      */
    /*                                                                       */
    /*                                                                       */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년1월27일                                         */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/  
    Create Or Replace Function f_get_edi_file_name(  
                                 company_cd  VARCHAR2 ,      -- 회사코드
                                 bank_cd     VARCHAR2 ,      -- 은행코드
                                 gubun       VARCHAR2 ,      -- 구분
                                 file_date   VARCHAR2 DEFAULT NULL) RETURN VARCHAR2 IS   -- 날짜  

        v_date                       VARCHAR2(8); 
        v_file_name                  VARCHAR2(100) := ''; 
        v_file_seq                   VARCHAR2(3);
        
        USR_ERR_NOT_VALID_GUBUN_CD   EXCEPTION;   -- 구분코드가 CS , CR , VR 이외인 경우..
        	                            
    BEGIN
        -- 별도로 날짜가 입력된 경우는 이 날짜를 사용하며, 그렇지 않으면 시스템 날짜를 사용한다.
        IF file_date IS NOT NULL AND LENGTH(file_date) != 0 THEN
            v_date := file_date;
        ELSE
            v_date := TO_CHAR(SYSDATE,'YYYYMMDD');
        END IF;
        
        -- file명에 필요하 seq를 가져옵니다.
        SELECT Lpad(T_FB_EDI_FILE_NAME_SEQ.nextval,3,'0')
        INTO   v_file_seq
        FROM   DUAL ;
        
        -- 회사코드와 은행코드로 송수신/협력업체정보 파일 명을 생성        
        IF UPPER(gubun) = 'CS' THEN
            v_file_name := company_cd ||'_'|| bank_cd ||'_'||v_date||'_'||v_file_seq||'.dat';
        ELSIF UPPER(gubun) = 'BS' THEN
            v_file_name := company_cd ||'_'|| bank_cd ||'_'||v_date||'_'||v_file_seq||'.dat';            
        ELSE
            RAISE USR_ERR_NOT_VALID_GUBUN_CD;
        END IF;

        RETURN( v_file_name );
    
    EXCEPTION
    
        WHEN USR_ERR_NOT_VALID_GUBUN_CD THEN
             fbs_util_pkg.write_log('FBS','[ERROR] 파일명 생성을 위해서 받은 구분코드가 잘못되었습니다.(구분코드:'||gubun||')');
             RETURN('ERROR');
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] 파일명 생성을 위한 SUBJECT NAME이 등록되어 있지 않습니다. (회사코드:'||company_cd||',은행코드:'||bank_cd||')');
             RETURN('ERROR');             
    END ;