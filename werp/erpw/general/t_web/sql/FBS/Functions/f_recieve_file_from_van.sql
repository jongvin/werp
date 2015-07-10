    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : f_recieve_file_from_van                               */
    /*  2. 모듈이름  : AN사에서 data를 받아 file로 저장합니다.               */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 사업장코드/은행코드/전송데이타구분 을 판단해서  VAN사에서 자료 */
    /*        를 수신 한후, 적절한 디렉토리에 입력된 파일명으로 저장한다.    */
    /*        처리결과는 적절한 메시지로 반환된다.                           */
    /*                                                                       */
    /*      - 처리결과는 별도로 파일로 LOGGING됨                             */
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
    FUNCTION f_recieve_file_from_van(p_file_name   IN VARCHAR2 ,           -- 전송할 파일명
                                p_gubun       IN VARCHAR2 ,                -- 전송데이타구분 (C:현금,B:전자어음,V:전자어음협력업체)
                                p_comp_code   IN VARCHAR2 ,                -- 사업장 코드
                                p_bank_code   IN VARCHAR2 )                -- 은행 코드
        RETURN VARCHAR2 IS                                                 -- 송신결과 처리 메시지

        v_command               VARCHAR2(400);                             -- PARAMETER를 담은 문자열 
        v_dummy_return		      VARCHAR2(100):= 'OK';                      -- 'OK'/'ERROR'
        v_recv_dir_name         VARCHAR2(100); 
        v_recv_dir              VARCHAR2(100); 
        v_subject_name          VARCHAR2(100);
        v_filename              VARCHAR2(100);
        FBS_CASH_RECV_DIR       VARCHAR2(100) := FBS_UTIL_PKG.FBS_CASH_RECV_DIR; -- 현금이체
        FBS_BILL_RECV_DIR       VARCHAR2(100) := FBS_UTIL_PKG.FBS_BILL_RECV_DIR; -- 전자어음
		    EDI_SEND_PRG            VARCHAR2(100) := 'tcpsend ';               -- EDI batch 송신 EFT프로그램 
		    EDI_RECV_PRG            VARCHAR2(100) := 'tcprecv ';               -- EDI batch 수신 EFT프로그램 

				rec_org_bank            T_FB_ORG_BANK%ROWTYPE;                     -- 공통코드를 가져올 RECORD변수
				
				-- 공통 변수
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	                
    BEGIN
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<
        IF p_gubun = 'C' THEN
           v_recv_dir_name := FBS_CASH_RECV_DIR ;
        ELSIF p_gubun = 'B' THEN
           v_recv_dir_name := FBS_BILL_RECV_DIR ; 
        ELSIF p_gubun = 'V' THEN
           v_recv_dir_name := FBS_BILL_RECV_DIR ;            
				END IF; 
           
        -- 물리적인 OS상의 directory를 가져옵니다.(from DBA_DIRECTORIES )
        SELECT DIRECTORY_PATH || '/'            
        INTO v_recv_dir
        FROM DBA_DIRECTORIES
        WHERE DIRECTORY_NAME = v_recv_dir_name ;

        -- 등록된 SUBJECT NAME을 가져옵니다.
        SELECT *
        INTO   rec_org_bank
        FROM   T_FB_ORG_BANK
        WHERE  COMP_CODE      = p_comp_code
        AND    BANK_MAIN_CODE = p_bank_code;
        
        IF p_gubun = 'C' THEN
           v_subject_name := rec_org_bank.cash_recv_subject_name ;
        ELSIF p_gubun = 'B' THEN
           v_subject_name := rec_org_bank.bill_recv_subject_name ; 
        ELSIF p_gubun = 'V' THEN
           v_subject_name := rec_org_bank.vendor_subject_name ;            
				END IF; 
				
        -- 메일박스 수신할 BATCH파일이름 설정 
        v_filename := p_file_name;        

        BEGIN                   
            -- COMMAND문자열에 EFT프로그램을 CALL할 COMMAND를 구성합니다.             
            v_command := 'tcprecv' || ' -o:' || rec_org_bank.bank_edi_login_id ||
                                      ' -b:A'||
                                      ' -t:' || v_subject_name || 
                                      ' -p:ITCP/IP' ||
                                      ' -F:' || v_recv_dir || v_filename ;

            v_dummy_return := fbs_util_pkg.exec_os_command( v_command );
            
        END;

        IF v_dummy_return = 'OK' THEN
            fbs_util_pkg.write_log('FBS','[INFO] 파일수신이 정상적으로 완료되었습니다.'||v_dummy_return ); 
        ELSE
            fbs_util_pkg.write_log('FBS','[ERROR] 파일수신시 에러가 발생하였습니다.'||v_dummy_return );
        END IF;
        
        ---------------------------------------------------
        -- 수신된 파일의 사이즈가 0 인 파일은 삭제처리한다.
        ---------------------------------------------------
        --v_command := 'delete_zero_file.sh ' || v_recv_dir || v_filename;

        --v_dummy_return := fbs_util_pkg.exec_os_command( v_command );

        RETURN( v_dummy_return );
        
    EXCEPTION

        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] 파일수신시 에러가 발생하였습니다.'||v_dummy_return);
             RETURN('ERROR');                 
    END ;