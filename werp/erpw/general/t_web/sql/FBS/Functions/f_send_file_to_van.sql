    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : f_send_file_to_van                                    */
    /*  2. 모듈이름  : 지정된 batch file을 VAN사로 송신합니다.               */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 구분/사업장 에 따라 디렉토리를 찾아서 , 해당 파일을 VAN사로    */
    /*        송신한 후, 처리결과 메시지를 반환한다.                         */
    /*                                                                       */
    /*      - 내부적으로 송신시, 사업장코드/은행코드를 참조하여 수신처를     */
    /*        확인 후, 송신을 처리한다. 처리결과는 별도로 파일로 LOGGING됨   */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월20일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
		CREATE OR REPLACE 
    FUNCTION f_send_file_to_van(p_file_name   IN VARCHAR2 ,                -- 전송할 파일명
                                p_gubun       IN VARCHAR2 ,                -- 전송데이타구분 (C:현금,B:전자어음)
                                p_comp_code   IN VARCHAR2 ,                -- 사업장 코드
                                p_bank_code   IN VARCHAR2 )                -- 은행 코드
        RETURN VARCHAR2 IS                                                 -- 송신결과 처리 메시지
    
        v_send_file             UTL_FILE.FILE_TYPE;                        -- 송신할 파일의 유무를 검사할 FILE HANDLER 
        v_command               VARCHAR2(400);                             -- PARAMETER를 담은 문자열 
        v_dummy_return		      VARCHAR2(100):= 'OK';                      -- 'OK'/'ERROR'
        v_send_dir_name         VARCHAR2(100); 
        v_send_dir              VARCHAR2(100); 
        v_subject_name          VARCHAR2(100);
        v_filename              VARCHAR2(100);
        FBS_CASH_SEND_DIR       VARCHAR2(100) := FBS_UTIL_PKG.FBS_CASH_SEND_DIR; -- 현금이체
        FBS_BILL_SEND_DIR       VARCHAR2(100) := FBS_UTIL_PKG.FBS_BILL_SEND_DIR; -- 전자어음       

				rec_org_bank            T_FB_ORG_BANK%ROWTYPE;                     -- 공통코드를 가져올 RECORD변수
				
				-- 공통 변수
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	                
    BEGIN
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<
        IF p_gubun = 'C' THEN
           v_send_dir_name := FBS_CASH_SEND_DIR ;
        ELSIF p_gubun = 'B' THEN
           v_send_dir_name := FBS_BILL_SEND_DIR ; 
				END IF; 
           
        -- 물리적인 OS상의 directory를 가져옵니다.(from DBA_DIRECTORIES )
        SELECT DIRECTORY_PATH || '/'            
        INTO v_send_dir
        FROM DBA_DIRECTORIES
        WHERE DIRECTORY_NAME = v_send_dir_name ;
        
        -- 등록된 SUBJECT NAME을 가져옵니다.
        SELECT *
        INTO   rec_org_bank
        FROM   T_FB_ORG_BANK
        WHERE  COMP_CODE      = p_comp_code
        AND    BANK_MAIN_CODE = p_bank_code;
        
        IF p_gubun = 'C' THEN
           v_subject_name := rec_org_bank.cash_send_subject_name ;
        ELSE
           v_subject_name := rec_org_bank.bill_send_subject_name ; 
				END IF; 
				
        -- 메일박스 송신할 BATCH파일이름 설정 
        v_filename := p_file_name;        
                
        -- 해당 파일의 유무를 검사하여, 파일이 없는 경우, 오류로그를 남긴다.
        BEGIN
            v_send_file := UTL_FILE.FOPEN( v_send_dir_name , v_filename, 'r');
            UTL_FILE.FCLOSE( v_send_file );
        EXCEPTION
            WHEN UTL_FILE.INVALID_OPERATION OR UTL_FILE.INVALID_FILEHANDLE THEN
	            	  fbs_util_pkg.write_log('FBS','[INFO] ' ||v_send_dir_name||'\'||v_filename||'이 존재하지 않습니다.'); 
	                RAISE Err ;
        END;

        BEGIN                   
            -- COMMAND문자열에 EFT프로그램을 CALL할 COMMAND를 구성합니다.             
            v_command := 'tcpsend' || ' -r:' || rec_org_bank.bank_edi_login_id ||
                                      ' -f:P'||
                                      ' -c:A'||
                                      ' -t:' || v_subject_name || 
                                      ' -p:ITCP/IP' ||
                                      ' -F:' || v_send_dir || v_filename ;

            v_dummy_return := fbs_util_pkg.exec_os_command( v_command );
            
        END;
                                 
        RETURN( v_dummy_return );
        
    EXCEPTION

        WHEN ERR THEN
             fbs_util_pkg.write_log('FBS','[ERROR] 파일이 존재하지 않습니다.');
             RETURN('ERROR');
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] 파일송신시 에러가 발생하였습니다.');
             RETURN('ERROR');                 
    END ;