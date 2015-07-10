CREATE OR REPLACE PACKAGE FBS_UTIL_PKG IS
	-- 정상적 메일 전송
	SUCCESS_CODE		Constant Varchar2(2) := 'OK';

    -- 암호화/복호화에서 사용되는 상수 
    DEFAULT_ENCODE_KEY  VARCHAR2(16) := 'keepthesecretnum';
    DUMMY_CHAR          VARCHAR2(1) := '9';

    -- 메일발송에서 사용되는 상수 
    SMTP_SERVER         VARCHAR2(50) := '52.10.123.200';  -- 임시로 개발서버에 SMTP를 설치한것임. 추후 수정요망.
    SMTP_PORT           NUMBER       := 25;
    ADMIN_MAILER        VARCHAR2(50) := 'cjderp@cj.net';
    ADMIN_MAILER_NAME   VARCHAR2(50) := 'CJ개발';
    CRLF                VARCHAR2( 2 ):= CHR( 13 ) || CHR( 10 );    

    TYPE addresslist_tab IS TABLE OF VARCHAR2( 1000 )
        INDEX BY BINARY_INTEGER;    
    
    -- DB이름을 구하는데서 사용되는 상수
    PROD_DBNAME         VARCHAR2(10) := 'PROD';
    TEST_DBNAME         VARCHAR2(10) := 'TEST';
    
    -- OS상의 DIRECTORY PATH를 알기위한 ORACLE의 DIRECTORY NAME 
    FBS_CASH_SEND_DIR      VARCHAR2(100) := 'FBS_CASH_SEND_DIR';      -- 현금대량이체 송신파일  
    FBS_CASH_RECV_DIR      VARCHAR2(100) := 'FBS_CASH_RECV_DIR';      -- 현금대량이체 결과수신파일  
    FBS_BILL_SEND_DIR      VARCHAR2(100) := 'FBS_BILL_SEND_DIR';      -- 전자어음 송신파일  
    FBS_BILL_RECV_DIR      VARCHAR2(100) := 'FBS_BILL_RECV_DIR';      -- 전자어음 결과수신 파일  
    FBS_LOG_DIR            VARCHAR2(100) := 'FBS_LOG_DIR';            -- FBS로그 파일  
    
    -- 은행코드 
  
    KIUP_BANK_CD                   VARCHAR2(2) := '03';   -- 기업은행 
    KUKMIN_BANK_CD                 VARCHAR2(2) := '04';   -- 국민은행     
    WOORI_BANK_CD                  VARCHAR2(2) := '20';   -- 우리은행     
    HANA_BANK_CD                   VARCHAR2(2) := '81';   -- 하나은행     
     
    -- EDI 송수신을 위한 command모듈명 (PATH를 포함하여 설정합니다.)
    SEND_EDI_COMMAND         VARCHAR2(300) := 'C:\fbs\tcpsend.exe';         -- BATCH로 송신시 처리하는 프로그램 설정 
    RECV_EDI_COMMAND         VARCHAR2(300) := 'C:\fbs\tcprecv.exe';         -- BATCH로 수신시 처리하는 프로그램 설정      
     
    /*************************************************************************/
    /*  1. 모듈ID    : pw_encode                                             */
    /*  2. 모듈이름  : 문자열 암호화 모듈                                    */
    /*************************************************************************/     
    FUNCTION pw_encode( p_input_str IN VARCHAR2,
                        p_encode_key IN VARCHAR2 DEFAULT NULL )
         RETURN VARCHAR2;

    /*************************************************************************/
    /*  1. 모듈ID    : pw_decode                                             */
    /*  2. 모듈이름  : 문자열 복호화 모듈                                    */
    /*************************************************************************/     
    FUNCTION pw_decode( p_input_str  IN VARCHAR2,   -- 암호화된 문자열 
                        p_length     IN NUMBER,     -- 복호화된 문자열중 앞에서 N개 자리수만큼 반환 
                        p_encode_key IN VARCHAR2 DEFAULT NULL )
          RETURN VARCHAR2;        
        
    /*************************************************************************/
    /*  기능 : 메일내용을 받아서 메일을 발송한다.(실시간)                    */
    /*         return : 정상발송 혹은 오류메시지                             */
    /*************************************************************************/
    FUNCTION mail_send( p_mailto    IN VARCHAR2 ,             -- 수신자   
                        p_mailcc    IN VARCHAR2 ,             -- 참조자  
                        p_subject   IN VARCHAR2 ,             -- 제목  
                        p_contents  IN LONG     ,             -- 내용 
                        p_html_yn   IN VARCHAR2 DEFAULT 'N'   -- HTML메일여부(default 'N')  
                      ) RETURN VARCHAR2;                   -- 정상 혹은 에러메시지          
        
    /*************************************************************************/
    /*  기능 : 사용자에게 보여질 오라클 메시지를 깔끔하게 만드는 함수        */
    /*************************************************************************/
    FUNCTION format_msg( p_msg  IN VARCHAR2 ) RETURN VARCHAR2;           
        
    /*************************************************************************/
    /*  기능 : DB이름을 구하는 함수 (운영WISE와 TEST를 구분하기 위함 )       */
    /*************************************************************************/
    FUNCTION get_db_name RETURN VARCHAR2;          
        
    /*************************************************************************/
    /*  기능 : format문자열형식에 맞춰서 input된 string을 변환해서 반환      */
    /*************************************************************************/
    FUNCTION sprintf( format    IN VARCHAR2 , 
                      input_str IN VARCHAR2 ) return VARCHAR2;
  
    /*************************************************************************/
    /*  기능 : 구분자prefix와 로그내용을 입력받아 파일로 로그를 생성한다     */
    /*************************************************************************/
    PROCEDURE write_log( prefix   IN VARCHAR2 , 
                         contents IN VARCHAR2 );        
        
    /*************************************************************************/
    /*  기능 : 실시간 처리시 은행별  복기부호를 반환한다.                    */
    /*************************************************************************/  
    FUNCTION  get_real_sign_no( out_bank_cd     IN VARCHAR2 ,               -- 출금은행코드
                                out_account_no  IN VARCHAR2 ,               -- 출금은행계좌번호                                 
                                in_bank_cd      IN VARCHAR2 ,               -- 입금은행코드
                                in_account_no   IN VARCHAR2 ,               -- 입금은행계좌번호
                                trade_amt       IN NUMBER ,                 -- 이체금액
                                etc_field1      IN VARCHAR2 DEFAULT NULL)   -- 자유필드1 (주로 전문번호)
        RETURN VARCHAR2 ;         
        
    /*************************************************************************/
    /*  기능 : batch파일처리시  복기부호를 반환한다.                         */
    /*************************************************************************/  
    FUNCTION  get_batch_sign_no(  edi_history_seq IN NUMBER ,                 -- EDI이력일련번호 
                                  total_cnt       OUT NUMBER ,                -- 복기부호를 생성한 대상자료의 총 건수 
                                  total_sum       OUT NUMBER ,                -- 복기부호를 생성한 대상자료의 총 금액     
                                  etc_field1      IN VARCHAR2 DEFAULT NULL,   -- 자유필드1   
                                  etc_field2      IN VARCHAR2 DEFAULT NULL)   -- 자유필드2   

        RETURN VARCHAR2 ;         
        
    /******************************************************************************/
    /*  기능 : OBJECT TYPE 및 OBJECT NAME을 받아 STATUS(VALID,INVALID) 반환       */
    /******************************************************************************/
    FUNCTION get_object_status( p_object_type IN VARCHAR2 ,         -- OBJECT TYPE  
                                p_object_name IN VARCHAR2           -- OBJECT NAME  
                              ) RETURN VARCHAR2;                    -- 상태 : VALID / INVALILD        
                              
        
    /******************************************************************************/
    /*  기능 : 지정된 batch file을 VAN사로 송신합니다.                            */
    /******************************************************************************/
    FUNCTION send_file_to_VAN(  p_file_name   IN VARCHAR2 ,                -- 전송할 파일명 
                                p_gubun       IN VARCHAR2 ,                -- 전송데이타구분 (C:현금,B:전자어음) 
                                p_comp_code   IN VARCHAR2 ,                -- 사업장 코드 
                                p_bank_code   IN VARCHAR2 )                -- 은행 코드 
        RETURN VARCHAR2;                                                   -- 송신결과 처리 메시지 
           
        
    /******************************************************************************/
    /*  기능 : VAN사에서 data를 받아 file로 저장합니다.                           */
    /******************************************************************************/
    FUNCTION receive_file_from_VAN( p_file_name   IN VARCHAR2 ,                -- 저장할 파일명 
                                    p_gubun       IN VARCHAR2 ,                -- 전송데이타구분 (C:현금,B:전자어음) 
                                    p_comp_code   IN VARCHAR2 ,                -- 사업장 코드 
                                    p_bank_code   IN VARCHAR2 )                -- 은행 코드 
        RETURN VARCHAR2;                                                       -- 수신결과 처리 메시지 
        
        
    /******************************************************************************/
    /*  기능 : EDI송수신을 위한 파일명을 반환합니다                               */
    /******************************************************************************/
    FUNCTION get_edi_file_name( p_comp_code   IN VARCHAR2 ,                -- 사업장 코드 
                                p_bank_code   IN VARCHAR2 ,                -- 은행 코드 
                                p_gubun       IN VARCHAR2 )                -- 전송데이타구분 
        RETURN VARCHAR2;                                                   -- 파일이름 반환  
        
        
    /******************************************************************************/
    /*  기능 : OS단의 명령어를 수행합니다.                                        */
    /******************************************************************************/        
    FUNCTION exec_os_command( p_string IN VARCHAR2 )     -- 실행시킬 명령어 
        RETURN VARCHAR2;                                 -- 처리결과 : OK 혹은 ERROR
        

    /******************************************************************************/
    /*  기능 : 암호등록/변경/확인등의 기능을 수행하는 공통 함수                   */
    /******************************************************************************/
    FUNCTION do_pwd_job( p_gubun_code   IN VARCHAR2 ,                -- 작업구분코드
                         p_emp_no       IN VARCHAR2 ,                -- 사번 
                         p_password1    IN VARCHAR2 ,                -- 암호문자열 1 
                         p_password2    IN VARCHAR2 DEFAULT NULL)    -- 암호문자열 2 
        RETURN VARCHAR2;                                             -- 함수처리결과   
        
        
END FBS_UTIL_PKG;
/
Create Or Replace PACKAGE BODY FBS_UTIL_PKG IS
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : pw_encode                                             */
    /*  2. 모듈이름  : 문자열 암호화 모듈                                    */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 문자열을 입력받아서 오라클의 DBMS_OBFUSCATION_TOOLKIT을 사용   */
    /*        하여 암호화한 후, 암화화 문자열을 반환한다.                    */
    /*      - DES방식은 최소8자리이므로, 8자리가 안되는  경우는 뒷쪽에       */
    /*        DUMMY문자(9)를 붙여서, 8자리가 넘어가는 경우는 8자리만 잘라서  */
    /*        암호화를 한다.                                                 */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월20일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    FUNCTION pw_encode( p_input_str IN VARCHAR2,
                        p_encode_key IN VARCHAR2 DEFAULT NULL )
          RETURN VARCHAR2 IS
        raw_string        VARCHAR2(2048);
        raw_key           RAW(128);
        encrypted_raw     RAW(2048);
        encrypted_string  VARCHAR2(2048);
        ERR_TOO_LONG_INPUT   EXCEPTION;
    BEGIN
        -- 8자리가 안되는 경우는 뒤에 DUMMY CHAR를 붙여 8자리로 만든다.
        IF length(p_input_str) > 8 THEN
            RAISE ERR_TOO_LONG_INPUT;
        ELSE
            raw_string := RPAD( p_input_str , 8 , DUMMY_CHAR );
        END IF;
        -- ENCODING KEY가 입력안된 경우는, DEFAULT ENCODING KEY를 사용한다.
        IF p_encode_key IS NULL THEN
            raw_key := UTL_RAW.CAST_TO_RAW( DEFAULT_ENCODE_KEY );
        ELSE
            raw_key := UTL_RAW.CAST_TO_RAW( RPAD( p_encode_key , 8 , DUMMY_CHAR  ));
        END IF;
        -- 암호화를 수행한다.
        dbms_obfuscation_toolkit.DESEncrypt( input => UTL_RAW.CAST_TO_RAW(raw_string) , key => raw_key , encrypted_data => encrypted_raw );
        encrypted_string := rawtohex( encrypted_raw );
        -- 암호화된 HEX문자열 반환
        RETURN( encrypted_string);
    EXCEPTION
        WHEN ERR_TOO_LONG_INPUT THEN
            RETURN( '8자리까지 입력이 가능합니다.');
        WHEN OTHERS THEN
            RETURN( SQLERRM );
    END pw_encode;

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : pw_encode                                             */
    /*  2. 모듈이름  : 문자열 암호화 모듈                                    */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 문자열을 입력받아서 오라클의 DBMS_OBFUSCATION_TOOLKIT을 사용   */
    /*        하여 복호화를 한 후, 복호화한 문자열을 반환한다.               */
    /*      - DES방식은 최소8자리이므로, 8자리가 넘어가는 문자열을 암호화    */
    /*        한 경우도 있으므로, 암호사용 자리수를 두번째 필드에 변수로     */
    /*        전달되면, 이 변수값만큼 SUBSTRING해서 반환한다.                */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월20일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    FUNCTION pw_decode( p_input_str  IN VARCHAR2,   -- 암호화된 문자열
                        p_length     IN NUMBER,     -- 복호화된 문자열중 앞에서 N개 자리수만큼 반환
                        p_encode_key IN VARCHAR2 DEFAULT NULL )
          RETURN VARCHAR2 IS
        encrypted_raw     RAW(2048);
        raw_key           RAW(128);
        decrypted_raw     RAW(2048);
        decrypted_string  VARCHAR2(2048);
    BEGIN
        encrypted_raw := hextoraw( p_input_str );
        -- ENCODING KEY가 입력안된 경우는, DEFAULT ENCODING KEY를 사용한다.
        IF p_encode_key IS NULL THEN
            raw_key := UTL_RAW.CAST_TO_RAW( DEFAULT_ENCODE_KEY );
        ELSE
            raw_key := UTL_RAW.CAST_TO_RAW( RPAD( p_encode_key , 8 , DUMMY_CHAR ) );
        END IF;
      dbms_obfuscation_toolkit.DESDecrypt(input => encrypted_raw, key => raw_key, decrypted_data => decrypted_raw);
      decrypted_string :=  UTL_RAW.CAST_TO_VARCHAR2(decrypted_raw);
      IF p_length > 0 THEN
          decrypted_string := SUBSTR( decrypted_string , 1 , p_length  );
      END IF;
      RETURN( decrypted_string );
    EXCEPTION
        WHEN OTHERS THEN
            RETURN( SQLERRM );
    END pw_decode;

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : mail_send                                             */
    /*  2. 모듈이름  : 메일발송                                              */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 입력된 수신자,참조자,제목,내용,HTML메일여부 등을 활용하여      */
    /*        월드건설 메일서버로 접속하여 메일을 발송합니다                 */
    /*      - 발송결과는 return값으로 참조되며, 정상발송인 경우, OK 문자열이 */
    /*        반환되고, 에러가 난경우는 에러 메시지를 반환한다.              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월20일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    FUNCTION mail_send( p_mailto    IN VARCHAR2 ,             -- 수신자
                        p_mailcc    IN VARCHAR2 ,             -- 참조자
                        p_subject   IN VARCHAR2 ,             -- 제목
                        p_contents  IN LONG     ,             -- 내용
                        p_html_yn   IN VARCHAR2 DEFAULT 'N'   -- HTML메일여부(default 'N')
                      ) RETURN VARCHAR2 IS                 -- 정상 혹은 에러메시지
        conn           UTL_SMTP.CONNECTION;
        addrlist       addresslist_tab;        -- 메일수신자/참조자 리스트 :  이름<주소> 형식
        addrcnt        BINARY_INTEGER   := 1;
        mesg           LONG;                   -- 메일 내용
        v_temp         VARCHAR2(4000);         -- 이름과 주소를 추출하기위한 임시변수 : 이름<주소>형식
        v_remain       VARCHAR2(4000);
        USR_ERR_TO_LIST    EXCEPTION;  -- TO에 해당하는 사람이 없거나, 문자열이 잘못되었을때
        USR_ERR_CC_LIST    EXCEPTION;  -- CC에 해당하는 사람의 문자열이 잘못되었을때..
    BEGIN
        conn:= UTL_SMTP.open_connection( SMTP_SERVER, SMTP_PORT );
        UTL_SMTP.helo( conn, SMTP_SERVER );
        UTL_SMTP.mail( conn, ADMIN_MAILER );
        -- mailto문자열을 확인하여, comma(,)로 구분된 수신자를 설정합니다.
        v_temp := p_mailto;
        LOOP
            IF v_temp IS NULL OR LENGTH(v_temp) = 0 THEN
                RAISE USR_ERR_TO_LIST;
            ELSIF INSTR( v_temp , ',' ) = 0 THEN
                addrlist(addrcnt) := 'To: ' || v_temp || CRLF;
                addrcnt := addrcnt + 1;
                UTL_SMTP.rcpt( conn, SUBSTR( v_temp , INSTR( v_temp , '<' ) + 1 , INSTR( v_temp , '>' ) - INSTR( v_temp , '<' ) - 1 ) );
                EXIT;
            END IF;
            v_remain := SUBSTR( v_temp , INSTR( v_temp , ',' ) + 1 );
            v_temp   := SUBSTR( v_temp , 1 , INSTR( v_temp , ',' ) - 1 );
            addrlist(addrcnt) := 'To: ' || v_temp || CRLF;
            addrcnt := addrcnt + 1;
            UTL_SMTP.rcpt( conn, SUBSTR( v_temp , INSTR( v_temp , '<' ) + 1 , INSTR( v_temp , '>' ) - INSTR( v_temp , '<' ) - 1 ) );
            v_temp := v_remain;
        END LOOP;
        -- mailcc문자열을 확인하여, comma(,)로 구분된 참조자를 설정합니다.
        v_temp := p_mailcc;
        LOOP
            IF v_temp IS NULL OR LENGTH(v_temp) = 0 THEN
                EXIT;
            ELSIF INSTR( v_temp , ',' ) = 0 THEN
                addrlist(addrcnt) := 'Cc: ' || v_temp || CRLF;
                addrcnt := addrcnt + 1;
                UTL_SMTP.rcpt( conn, SUBSTR( v_temp , INSTR( v_temp , '<' ) + 1 , INSTR( v_temp , '>' ) - INSTR( v_temp , '<' ) - 1 ) );
                EXIT;
            END IF;
            v_remain := SUBSTR( v_temp , INSTR( v_temp , ',' ) + 1 );
            v_temp   := SUBSTR( v_temp , 1 , INSTR( v_temp , ',' ) - 1 );
            addrlist(addrcnt) := 'Cc: ' || v_temp || CRLF;
            addrcnt := addrcnt + 1;
            UTL_SMTP.rcpt( conn, SUBSTR( v_temp , INSTR( v_temp , '<' ) + 1 , INSTR( v_temp , '>' ) - INSTR( v_temp , '<' ) - 1 ) );
            v_temp := v_remain;
        END LOOP;
        -- 발송메일 문자열을 구성합니다.
        IF UPPER(p_html_yn) = 'Y' THEN
            mesg:= 'Content-Type: text/html;charset=EUC-KR' || CRLF;
        END IF;
        mesg := mesg ||
               'Date: ' || TO_CHAR( SYSDATE, 'dd Mon yy hh24:mi:ss' ) || CRLF ||
               'From: '||ADMIN_MAILER_NAME||'<'|| ADMIN_MAILER ||'>' || CRLF ||
               'Subject: ' || p_subject || CRLF;
        v_temp := '';
        FOR i IN 1..(addrcnt-1) LOOP
            v_temp := v_temp || addrlist(i);
        END LOOP;
        mesg := mesg || v_temp || CRLF || p_contents;
        -- 메일을 발송합니다.
        UTL_SMTP.open_data(conn);
        UTL_SMTP.write_raw_data(conn, UTL_RAW.CAST_TO_RAW(mesg));
        UTL_SMTP.close_data(conn);
        UTL_SMTP.quit( conn );
        RETURN(SUCCESS_CODE);
    EXCEPTION
        WHEN USR_ERR_TO_LIST THEN
            RETURN( '수신자 항목 오류:'||p_mailto);
        WHEN USR_ERR_CC_LIST THEN
            RETURN( '참조자 항목 오류:'||p_mailcc);
        WHEN OTHERS THEN
            RETURN(SQLERRM);
    END mail_send;

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : format_msg                                            */
    /*  2. 모듈이름  : 메시지를 깔끔하게 만드는 함수                         */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 오류내용을 담은 문자열을 입력받아서 깔끔하게 정리한다.         */
    /*      - P_TYPE에 따른 구분                                             */
    /*          (1) U : 일반 화면용 사용자 메시지                            */
    /*          (2) S : 시스템 메시지                                        */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월20일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    FUNCTION format_msg( p_msg   IN VARCHAR2 )   -- 문자열 FORMATING
                       RETURN VARCHAR2 IS
        v_return_msg VARCHAR2(2000);    -- 반환될 문자열
        v_temp_str   VARCHAR2(2000);    -- 임시로 사용할 문자열
    BEGIN
        -- ORA코드값을 구분하여 20000번 이상(사용자 정의 에러)인 경우,
        -- 기타 시스템에서 나오는 문자들을 제거하고 보여줍니다. (사용자 message용)
        IF INSTR( p_msg , 'ORA-' ) > 0 THEN
            v_temp_str := SUBSTR( p_msg , INSTR( p_msg , 'ORA-' ) + 4 , INSTR( p_msg , ':' ) - INSTR( p_msg , 'ORA-' ) - 4 );
            IF TO_NUMBER( TRIM(v_temp_str) ) >= 20000 THEN
                  -- 첫번째 줄만 가져옵니다.
                  IF INSTR( p_msg , CHR(10) ) > 0 THEN
                      v_return_msg := SUBSTR( p_msg , 1 , INSTR( p_msg , CHR(10) ) );
                  ELSE
                      v_return_msg := p_msg;
                  END IF;
                  -- 문자열 앞의 "ORA-에러코드"부분을 삭제합니다.
                  WHILE INSTR( v_return_msg , 'ORA-' ) > 0 LOOP
                      v_return_msg := SUBSTR( v_return_msg , INSTR( v_return_msg , ':' ) + 1 , LENGTH(v_return_msg) );
                  END LOOP;
                  -- "\n"을 개행문자로 치환합니다.
                  v_return_msg := CHR(10) || REPLACE(v_return_msg , '\n' , CHR(10) );
            ELSE
                v_return_msg := p_msg;
            END IF;
        ELSE
            v_return_msg := p_msg;
        END IF;
        RETURN( TRIM(v_return_msg) );

    END format_msg;

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : get_db_name                                           */
    /*  2. 모듈이름  : database의 이름을 가져움                              */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 실운영인 DB 와 테스트인 DB를 구분하기위한 함수                 */
    /*        기 정의된 운영/TEST 이름인 경우,PROD 혹은 TEST를 반환하며,     */
    /*        정의되지 않은 경우, 현재의 DB이름을 반환한다.                  */
    /*                                                                       */
    /*      - 본 함수의 내용중, system view인 v$parameter를 사용하므로, 정상 */
    /*        적으로 Compile되기 위해서는 해당 User에게 v_$paramter에 대한   */
    /*        Object Select권한을 부여하여야 함                              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월20일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    FUNCTION  get_db_name RETURN VARCHAR2 IS
        v_db_name VARCHAR2(200) := PROD_DBNAME;
    BEGIN
    	/*
        SELECT TRIM(VALUE)
          INTO v_db_name
          FROM v$parameter
         WHERE NAME = 'db_name';
        IF v_db_name = PROD_DBNAME THEN
            v_db_name := 'PROD';
        ELSIF v_db_name = TEST_DBNAME THEN
            v_db_name := 'TEST';
        END IF;
        */
        RETURN( v_db_name );
    END get_db_name;

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : sprint                                                */
    /*  2. 모듈이름  : format에 의한 문자열 생성                             */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 본 모듈은 C언어의 sprint의 format기능을 제한적으로 구현하여    */
    /*        문자열을 format화해서 만들때 사용한다.                         */
    /*      - 현재버전은 format 은 %s만 가능하며, -기능,숫자.숫자 기능이     */
    /*        구현되어 있음                                                  */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월20일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    FUNCTION sprintf( format    IN VARCHAR2,
                      input_str IN VARCHAR2)
           return VARCHAR2 IS
        v_temp_str    VARCHAR2(4000); /* 임시로 사용할 문자열 */
        v_return_str  VARCHAR2(4000);
        v_front_digit INTEGER;
        v_end_digit   INTEGER;
        v_digit_pos   INTEGER;
        USR_ERR_NOT_VALID_FORMAT EXCEPTION; /* USER EXCEPTION : 부정확한 FORMAT 스트링 */
    BEGIN
        -- 초기화
        v_return_str  := '';
        v_temp_str    := '';
        v_front_digit := 0;
        v_end_digit   := 0;
        v_digit_pos   := 0;
        -- FORMAT STRING VALIDATION
        IF LENGTH(format) IS NULL OR LENGTH(format) = 0 OR SUBSTR(format, 1, 1) != '%' OR UPPER(SUBSTR(format, LENGTH(format), 1)) != 'S' THEN
            RAISE USR_ERR_NOT_VALID_FORMAT;
        ELSE
            v_temp_str := SUBSTR(format, 2, LENGTH(format) - 2);
        END IF;
        -- PERIOD(.)를 기준으로 FRONT DIGIT와 END DIGIT를 셋팅
        v_digit_pos := INSTR(v_temp_str, '.', 1, 1);
        IF v_digit_pos = 0 THEN
            v_front_digit := NVL(TO_NUMBER(v_temp_str), 0);
        ELSE
            v_front_digit := NVL(TO_NUMBER(SUBSTR(v_temp_str, 1, v_digit_pos - 1)), 0);
            v_end_digit   := NVL(TO_NUMBER(SUBSTR(v_temp_str, v_digit_pos + 1)), 0);
        END IF;
        -- 입력문자열이 NULL이거나, 공백이면, 숫자만큼 SPACE 문자열을 만들어서 반환한다.
        IF input_str IS NULL or LENGTH(input_str) = 0 THEN
            v_return_str := SUBSTR( RPAD( '.' , ABS(v_front_digit) + 1 , ' ' ) , 2 );
        ELSE
            -- 각 경우의 수에 따라서 처리루틴을 거친다.
            IF v_front_digit = 0 THEN
                BEGIN
                    IF v_end_digit = 0 THEN
                        v_return_str := input_str;
                    ELSE
                        v_return_str := SUBSTRB(input_str, 1, v_end_digit);
                    END IF;
                END;
            ELSIF v_front_digit > 0 THEN
                BEGIN
                    IF v_end_digit = 0 THEN
                        v_return_str := SUBSTRB(input_str, 1, v_front_digit);
                        IF LENGTHB(v_return_str) < v_front_digit THEN
                            v_return_str := LPAD(v_return_str, v_front_digit, ' ');
                        END IF;
                    ELSE
                        v_return_str := SUBSTRB(input_str, 1, v_end_digit);
                        IF LENGTHB(v_return_str) < v_front_digit THEN
                            v_return_str := LPAD(v_return_str, v_front_digit, ' ');
                        END IF;
                    END IF;
                END;
            ELSIF v_front_digit < 0 THEN
                BEGIN
                    v_front_digit := ABS(v_front_digit);
                    IF v_end_digit = 0 THEN
                        v_return_str := SUBSTRB(input_str, 1, v_front_digit);
                        IF LENGTHB(v_return_str) < v_front_digit THEN
                            v_return_str := RPAD(v_return_str, v_front_digit, ' ');
                        END IF;
                    ELSE
                        v_return_str := SUBSTRB(input_str, 1, v_end_digit);
                        IF LENGTHB(v_return_str) < v_front_digit THEN
                            v_return_str := RPAD(v_return_str, v_front_digit, ' ');
                        END IF;
                    END IF;
                END;
            END IF;
        END IF;
        RETURN(v_return_str);
    EXCEPTION
        WHEN USR_ERR_NOT_VALID_FORMAT THEN
            RAISE_APPLICATION_ERROR(-20001, 'NOT VALID FORMAT STRING');
    END sprintf;

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : write_log                                             */
    /*  2. 모듈이름  : 로그를 파일로 저장                                    */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - prefix와 파일로 남길 로그내용을 문자열로 받아 파일로 log를     */
    /*        생성하는 프로그램                                              */
    /*                                                                       */
    /*      - 로그는 LOG_DIR 에 생성하며, 파일명은 아래규칙에 의거 생성된다  */
    /*           [prefix]_날짜8자리.log                                      */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월20일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    PROCEDURE write_log( prefix   IN VARCHAR2,
                         contents IN VARCHAR2) IS
        v_output_file UTL_FILE.FILE_TYPE;
        v_date        VARCHAR2(8);
        v_datetime    VARCHAR2(20);
        v_filename    VARCHAR2(100);
        LF            CHAR(15) := '        ' || CHR(13) || CHR(10);
    BEGIN
        -- 현재날짜 설정
        v_date     := TO_CHAR(SYSDATE, 'YYYYMMDD');
        v_datetime := TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:mi:ss');
        -- 파일이름 설정
        v_filename := prefix || '_' || v_date || '.log';
        -- log파일을 open합니다.
        v_output_file := UTL_FILE.FOPEN( FBS_LOG_DIR , v_filename, 'a');
        -- 로그내역을 write합니다.
        UTL_FILE.PUT_LINE(v_output_file,'[' || v_datetime || ']  ' || REPLACE(contents, '\n', LF||'                  '));
        -- 파일을 닫습니다.
        UTL_FILE.FCLOSE(v_output_file);
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END write_log;

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : get_real_sign_no                                      */
    /*  2. 모듈이름  : 실시간처리 은행별 복기부호를 산정하여 반환한다.       */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 각종 정보를 입력받아 은행별 복기부호를 생성한다.               */
    /*        생성규칙은 해당은행으로부터 받아 작성하며, 검증한다.           */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월20일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    FUNCTION  get_real_sign_no( out_bank_cd     VARCHAR2 ,               -- 출금은행코드
                                out_account_no  VARCHAR2 ,               -- 출금은행계좌번호
                                in_bank_cd      VARCHAR2 ,               -- 입금은행코드
                                in_account_no   VARCHAR2 ,               -- 입금은행계좌번호
                                trade_amt       NUMBER ,                 -- 이체금액
                                etc_field1      VARCHAR2 DEFAULT NULL)   -- 자유필드 (주로 전문번호)
                             RETURN VARCHAR2 IS
        v_sign_no          VARCHAR2(6) := '';        -- 반환할 복기부호

    BEGIN

        /**************************************************************************************/
        /* 국민은행인 경우                                                                    */
        /**************************************************************************************/
        IF out_bank_cd = KUKMIN_BANK_CD THEN
              SELECT SUBSTRB(LPAD(TO_CHAR(TRUNC(
                     ( TO_NUMBER(SUBSTRB(TO_CHAR(trade_amt),1,13))
                     + TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD'))
                     + TO_NUMBER(etc_field1)
                     + TO_NUMBER(SUBSTRB(TRIM(out_account_no),1,9)) )
                     / (   TO_NUMBER(TO_CHAR(SYSDATE,'MMDD'))
                         + TO_NUMBER(SUBSTRB(TRIM(in_account_no),1,4) ) )
                     ) ) , 6 , '0' ) , -6 )
                INTO v_sign_no
                FROM DUAL;
        /**************************************************************************************/
        /* 우리은행인 경우                                                                    */
        /**************************************************************************************/
        ELSIF out_bank_cd = WOORI_BANK_CD THEN
            SELECT TO_CHAR( ( SUBSTR(trade_date,1,1)     + SUBSTR(trade_date,2,1)      + SUBSTR(trade_date,3,1)
                            + SUBSTR(trade_date,4,1)     + SUBSTR(trade_date,5,1)      + SUBSTR(trade_date,6,1) ) +     /*--거래일자 */
                            ( SUBSTR(in_account_no,1,1)  + SUBSTR(in_account_no,2,1)   + SUBSTR(in_account_no,3,1)
                            + SUBSTR(in_account_no,4,1)  + SUBSTR(in_account_no,5,1)   + SUBSTR(in_account_no,6,1)
                            + SUBSTR(in_account_no,7,1)  + SUBSTR(in_account_no,8,1)   + SUBSTR(in_account_no,9,1)
                            + SUBSTR(in_account_no,10,1) + SUBSTR(in_account_no,11,1)  + SUBSTR(in_account_no,12,1)
                            + SUBSTR(in_account_no,13,1) + SUBSTR(in_account_no,14,1)  + SUBSTR(in_account_no,15,1) ) + /*--입금계좌번호 */
                            ( SUBSTR(trade_amt,1,1)      + SUBSTR(trade_amt,2,1)       + SUBSTR(trade_amt,3,1)
                            + SUBSTR(trade_amt,4,1)      + SUBSTR(trade_amt,5,1)       + SUBSTR(trade_amt,6,1)
                            + SUBSTR(trade_amt,7,1)      + SUBSTR(trade_amt,8,1)       + SUBSTR(trade_amt,9,1)
                            + SUBSTR(trade_amt,10,1)     + SUBSTR(trade_amt,11,1)      + SUBSTR(trade_amt,12,1)
                            + SUBSTR(trade_amt,13,1) )   +                                                              /*--거래금액      */
                            ( SUBSTR(in_bank_cd,1,1)     + SUBSTR(in_bank_cd,2,1) )    +                                /*--입금은행코드 */
                            ( SUBSTR(out_account_no,1,1) + SUBSTR(out_account_no,2,1)  + SUBSTR(out_account_no,3,1)
                            + SUBSTR(out_account_no,4,1) + SUBSTR(out_account_no,5,1)  + SUBSTR(out_account_no,6,1)
                            + SUBSTR(out_account_no,7,1) + SUBSTR(out_account_no,8,1)  + SUBSTR(out_account_no,9,1)
                            + SUBSTR(out_account_no,10,1)+ SUBSTR(out_account_no,11,1) + SUBSTR(out_account_no,12,1)
                            + SUBSTR(out_account_no,13,1)+ SUBSTR(out_account_no,14,1) + SUBSTR(out_account_no,15,1) )  /*--출금계좌번호 */
                            ,'FM009') ||
                   TO_CHAR( MOD( TO_NUMBER(TRIM(trade_amt), 'FM9999999999999' ),
                            ( ( SUBSTR(trade_date,1,1)      + SUBSTR(trade_date,2,1)     + SUBSTR(trade_date,3,1)
                              + SUBSTR(trade_date,4,1)      + SUBSTR(trade_date,5,1)     + SUBSTR(trade_date,6,1) ) +  /*--거래일자 */
                              ( SUBSTR(in_account_no,1,1)   + SUBSTR(in_account_no,2,1)  + SUBSTR(in_account_no,3,1)
                              + SUBSTR(in_account_no,4,1)   + SUBSTR(in_account_no,5,1)  + SUBSTR(in_account_no,6,1)
                              + SUBSTR(in_account_no,7,1)   + SUBSTR(in_account_no,8,1)  + SUBSTR(in_account_no,9,1)
                              + SUBSTR(in_account_no,10,1)  + SUBSTR(in_account_no,11,1) + SUBSTR(in_account_no,12,1)
                              + SUBSTR(in_account_no,13,1)  + SUBSTR(in_account_no,14,1) + SUBSTR(in_account_no,15,1) ) + /*--입금계좌번호      */
                              ( SUBSTR(trade_amt,1,1)       + SUBSTR(trade_amt,2,1)      + SUBSTR(trade_amt,3,1)
                              + SUBSTR(trade_amt,4,1)       + SUBSTR(trade_amt,5,1)      + SUBSTR(trade_amt,6,1)
                              + SUBSTR(trade_amt,7,1)       + SUBSTR(trade_amt,8,1)      + SUBSTR(trade_amt,9,1)
                              + SUBSTR(trade_amt,10,1)      + SUBSTR(trade_amt,11,1)     + SUBSTR(trade_amt,12,1)
                              + SUBSTR(trade_amt,13,1) )    +                              /*--거래금액      */
                              ( SUBSTR(in_bank_cd,1,1)      + SUBSTR(in_bank_cd,2,1) )   + /*--입금은행코드  */
                              ( SUBSTR(out_account_no,1,1)  + SUBSTR(out_account_no,2,1) + SUBSTR(out_account_no,3,1)
                              + SUBSTR(out_account_no,4,1)  + SUBSTR(out_account_no,5,1) + SUBSTR(out_account_no,6,1)
                              + SUBSTR(out_account_no,7,1)  + SUBSTR(out_account_no,8,1) + SUBSTR(out_account_no,9,1)
                              + SUBSTR(out_account_no,10,1) + SUBSTR(out_account_no,11,1)+ SUBSTR(out_account_no,12,1)
                              + SUBSTR(out_account_no,13,1) + SUBSTR(out_account_no,14,1)+ SUBSTR(out_account_no,15,1) )) /*--출금계좌번호 */
                            )
                          ,'FM009')
               INTO v_sign_no
               FROM ( SELECT TO_CHAR(SYSDATE,'YYMMDD')          AS trade_date,
                             RPAD(TRIM(out_account_no),15,'0')  AS out_account_no,
                             LPAD(TRIM(trade_amt),13,'0')       AS trade_amt,
                             TRIM(in_bank_cd)                   AS in_bank_cd,
                             RPAD(TRIM(in_account_no),15,'0')   AS in_account_no
                        FROM DUAL ) cal;

        /**************************************************************************************/
        /* 하나은행인 경우 : docu_numc로 etc_field1을 사용한다.                               */
        /**************************************************************************************/
        ELSIF out_bank_cd = HANA_BANK_CD THEN
            SELECT RPAD( SUBSTR( TRUNC( ( SUBSTR( RTRIM( out_account_no ) , 1 , 12 )  +
                   DECODE( RTRIM(in_bank_cd) , '81',  SUBSTR( RTRIM( in_account_no ) , 1 , 12 ) , RTRIM( in_bank_cd ) ) +
                   RTRIM( trade_amt ) + TO_CHAR(SYSDATE, 'YYMMDD' ) ) / TO_NUMBER( RTRIM( etc_field1 ) , 999999 ) ) , -4, 4 ), 6, ' ' )
              INTO v_sign_no
              FROM DUAL;

        /**************************************************************************************/
        /* 기업은행인 경우                                                                    */
        /**************************************************************************************/
        ELSIF out_bank_cd = KIUP_BANK_CD THEN
            -- STEP 1,2,3단계 변형을 처리한다.
            SELECT    SUBSTRB(
                         TO_CHAR( TO_NUMBER(
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,1,1)) + TO_NUMBER(SUBSTRB(in_account_no,1,1)),10) ) ||
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,2,1)) + TO_NUMBER(SUBSTRB(in_account_no,2,1)),10) ) ||
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,3,1)) + TO_NUMBER(SUBSTRB(in_account_no,3,1)),10) ) ||
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,4,1)) + TO_NUMBER(SUBSTRB(in_account_no,4,1)),10) ) ||
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,5,1)) + TO_NUMBER(SUBSTRB(in_account_no,5,1)),10) ) ||
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,6,1)) + TO_NUMBER(SUBSTRB(in_account_no,6,1)),10) )
                         ) + TO_NUMBER( SUBSTRB(  TO_CHAR(trade_amt) , LENGTHB(TO_CHAR(trade_amt))-5,6) ) ) , 4 , 3 ) ||
                      SUBSTRB(
                         TO_CHAR( TO_NUMBER(
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,1,1)) + TO_NUMBER(SUBSTRB(in_account_no,1,1)),10) ) ||
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,2,1)) + TO_NUMBER(SUBSTRB(in_account_no,2,1)),10) ) ||
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,3,1)) + TO_NUMBER(SUBSTRB(in_account_no,3,1)),10) ) ||
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,4,1)) + TO_NUMBER(SUBSTRB(in_account_no,4,1)),10) ) ||
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,5,1)) + TO_NUMBER(SUBSTRB(in_account_no,5,1)),10) ) ||
                         TO_CHAR( MOD(TO_NUMBER(SUBSTRB(out_account_no,6,1)) + TO_NUMBER(SUBSTRB(in_account_no,6,1)),10) )
                         ) + TO_NUMBER( SUBSTRB(  TO_CHAR(trade_amt) , LENGTHB(TO_CHAR(trade_amt))-5,6) ) ) , 1 , 3 )
              INTO v_sign_no
              FROM DUAL;
            -- STEP 4단계 변형
            SELECT TO_CHAR( MOD(TO_NUMBER(SUBSTRB(v_sign_no,1,1)) + TO_NUMBER(SUBSTRB(TO_CHAR(SYSDATE,'YYMMDD'),1,1)),10) ) ||
                   TO_CHAR( MOD(TO_NUMBER(SUBSTRB(v_sign_no,2,1)) + TO_NUMBER(SUBSTRB(TO_CHAR(SYSDATE,'YYMMDD'),2,1)),10) ) ||
                   TO_CHAR( MOD(TO_NUMBER(SUBSTRB(v_sign_no,3,1)) + TO_NUMBER(SUBSTRB(TO_CHAR(SYSDATE,'YYMMDD'),3,1)),10) ) ||
                   TO_CHAR( MOD(TO_NUMBER(SUBSTRB(v_sign_no,4,1)) + TO_NUMBER(SUBSTRB(TO_CHAR(SYSDATE,'YYMMDD'),4,1)),10) ) ||
                   TO_CHAR( MOD(TO_NUMBER(SUBSTRB(v_sign_no,5,1)) + TO_NUMBER(SUBSTRB(TO_CHAR(SYSDATE,'YYMMDD'),5,1)),10) ) ||
                   TO_CHAR( MOD(TO_NUMBER(SUBSTRB(v_sign_no,6,1)) + TO_NUMBER(SUBSTRB(TO_CHAR(SYSDATE,'YYMMDD'),6,1)),10) )
              INTO v_sign_no
              FROM DUAL;
        END IF;
        RETURN( v_sign_no);
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END get_real_sign_no;

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

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : get_object_status                                     */
    /*  2. 모듈이름  : 해당 OBJECT의 상태 반환                               */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - OBJECT TYPE : PACKAGE / TIGGER / PROCEDURE /FUNCTION 등        */
    /*                                                                       */
    /*      - OBJECT TYPE 과 OBJECT NAME을 입력받아 VALID인지, INVALID인지   */
    /*        반환하는 공통함수                                              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월20일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    FUNCTION get_object_status( p_object_type VARCHAR2 ,         -- OBJECT TYPE
                                p_object_name VARCHAR2           -- OBJECT NAME
                              ) RETURN VARCHAR2 IS               -- 상태 : VALID / INVALILD
        v_status  VARCHAR2(10);
    BEGIN
        SELECT STATUS
          INTO v_status
          FROM USER_OBJECTS
         WHERE OBJECT_TYPE = p_object_type
           AND OBJECT_NAME = p_object_name;
        RETURN( v_status );
    END get_object_status;


    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : send_file_to_VAN                                      */
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
    FUNCTION send_file_to_VAN(  p_file_name   IN VARCHAR2 ,                -- 전송할 파일명
                                p_gubun       IN VARCHAR2 ,                -- 전송데이타구분 (C:현금,B:전자어음)
                                p_comp_code   IN VARCHAR2 ,                -- 사업장 코드
                                p_bank_code   IN VARCHAR2 )                -- 은행 코드
        RETURN VARCHAR2 IS                                                 -- 송신결과 처리 메시지
    BEGIN
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<
    	return	f_send_file_to_van(p_file_name   ,                -- 전송할 파일명
                           p_gubun       ,                -- 전송데이타구분 (C:현금,B:전자어음)
                           p_comp_code   ,                -- 사업장 코드
                           p_bank_code   );               -- 은행 코드
    END send_file_to_VAN;

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : receive_file_from_VAN                                 */
    /*  2. 모듈이름  : VAN사에서 data를 받아 file로 저장합니다.              */
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
    FUNCTION receive_file_from_VAN( p_file_name   IN VARCHAR2 ,                -- 저장할 파일명
                                    p_gubun       IN VARCHAR2 ,                -- 전송데이타구분 (C:현금,B:전자어음)
                                    p_comp_code   IN VARCHAR2 ,                -- 사업장 코드
                                    p_bank_code   IN VARCHAR2 )                -- 은행 코드
        RETURN VARCHAR2 IS
    BEGIN
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<
		return		f_recieve_file_from_van(p_file_name    ,           -- 전송할 파일명
                                p_gubun        ,           -- 전송데이타구분 (C:현금,B:전자어음,V:전자어음협력업체)
                                p_comp_code    ,           -- 사업장 코드
                                p_bank_code    );           -- 은행 코드
    END receive_file_from_VAN;

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : get_edi_file_name                                     */
    /*  2. 모듈이름  : EDI송수신을 위한 파일명을 반환합니다                  */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 사업장코드/은행코드/전송데이타구분 을 판단해서  VAN사와 송수신 */
    /*        할 파일명을 구해서 반환합니다                                  */
    /*        반환시에는 파일명 외에 파일위치 경로까지 포함하여 반환한다.    */
    /*                                                                       */
    /*      - 구분코드                                                       */
    /*          CS ( Cash Send ) : 현금 송신 파일명                          */
    /*          CR ( Cash Receive ) : 현금 수신 파일명                       */
    /*          BS ( Bill Send ) : 전자어음 송신 파일명                      */
    /*          BR ( Bill Receive ) : 전자어음 수신 파일명                   */
    /*          VR ( Vendor Receive ) : 전자어음 거래선정보 수신 파일명      */
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
    FUNCTION get_edi_file_name( p_comp_code   IN VARCHAR2 ,                -- 사업장 코드
                                p_bank_code   IN VARCHAR2 ,                -- 은행 코드
                                p_gubun       IN VARCHAR2 )                -- 전송데이타구분
        RETURN VARCHAR2 IS                                                 -- 파일이름 반환
    BEGIN
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<
		return		f_get_edi_file_name( p_comp_code   ,      -- 회사코드
                             p_bank_code   ,      -- 은행코드
                             p_gubun       );     -- 구분

    END get_edi_file_name;

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : exec_os_command                                       */
    /*  2. 모듈이름  : OS단의 명령어를 수행합니다.                           */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - JAVA 를 사용하여, WINDOWS의 CMD를 사용하여, OS단의 명령어를    */
    /*        PARAMETER로 받아, 실행시킵니다.                                */
    /*                                                                       */
    /*      - JAVA CLASS FUNCTION은 아래와 같은 명령어로 생성하였으며,       */
    /*        물리적인 실제 CLASS파일은 FBS폴더 하위의 javaclass폳더에 있음  */
    /*                                                                       */
    /*        (1) create directory fbs_javaclass as 'c:\FBS\javaclass';      */
    /*        (2) create java class using BFILE(fbs_javaclass,'ExecCommand.class'); */
    /*        (3) 	CREATE or REPLACE FUNCTION                               */
  	/*              exec_command (str IN varchar2) RETURN varchar2           */
  	/*              as language java                                         */
  	/*              name 'ExecCommand.exec(java.lang.String)                 */
    /*              return java.lang.String';                                */
    /*                                                                       */
    /*      - 위 java를 실행하기 위해서는 permmission이 있어야 하므로,       */
    /*        하단의 명령어를 사용해서, grant하여야 정상적으로 동작함        */
    /*    begin                                                                                                     */
    /*       dbms_java.grant_permission( 'ERPW', 'SYS:java.io.FilePermission', '<<ALL FILES>>', 'execute' ) ;       */
    /*       dbms_java.grant_permission( 'ERPW', 'SYS:java.lang.RuntimePermission', 'writeFileDescriptor', '' );    */
    /*       dbms_java.grant_permission( 'ERPW', 'SYS:java.lang.RuntimePermission', 'readFileDescriptor', '' );     */
    /*    end;                                                                                                      */
    /*                                                                       */
    /*      - 수행결과는 write_log함수를 이용해서 파일에 log를 하며, 정상적  */
    /*        인 경우, "command => OS명령 정상처리"라고 로그가 되며, 오류가  */
    /*        난 경우는, Java의 오류dump가 파일로그됩니다.                   */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          ERROR : 기타 오류 발생시 (DEFAULT값:ERROR)                   */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월28일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    FUNCTION exec_os_command( p_string IN VARCHAR2 )     -- 실행시킬 명령어
        RETURN VARCHAR2 IS                               -- 처리결과 : OK 혹은 ERROR
       return_value VARCHAR2(100);
    BEGIN
        -- String으로 받은 OS명령어를 수행시킵니다. JAVA Class를 활용
        return_value := exec_command( p_string ) ;
        -- 처리결과에 따라서 OK 혹은 ERROR를 반환하며, 별도로 파일로 로그를 남긴다.
        IF return_value = SUCCESS_CODE THEN
            write_log('FBS','OS COMMAND EXEC = ['|| p_string || '] ==> 정상처리완료' );
        ELSE
            write_log('FBS','OS COMMAND EXEC = ['|| p_string || '] ==> ERROR발생 ' || CRLF || return_value );
            return_value := 'ERROR';
        END IF;
        RETURN(return_value);
    END exec_os_command;


    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : do_pwd_job                                            */
    /*  2. 모듈이름  : 암호등록/변경/확인등의 기능을 수행하는 공통 함수      */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 팀장암호등록/이체/어음발행암호등록,변경 및 실제 이체 혹은 어음 */
    /*        발행시, 암호에 대한 확인작업을 수행하는 공통 함수임            */
    /*                                                                       */
    /*      - 암호의 경우는, 기타코드테이블(T_FB_LOOKUP_VALUES)에 담아 사용  */
    /*        하며, LOOKUP_TYPE="FBS_PASSWORD'라는 구분으로 하고,            */
    /*        LOOKUP_VALUES는 사번으로 하되, LOOKUP_VALUE는 팀장본인의 암호  */
    /*        ATTRIBUTE1은 실시간이체암호 , ATTRIBUTE2는 전자어음 암호를     */
    /*        담아 사용한다.                                                 */
    /*        CJ개발,NB등으로 분리되어 있으므로, 별도의 사번(팀장)사번으로   */
    /*        구분된 체계를 둔다.                                            */
    /*                                                                       */
    /*      - 본 내용은 기타코드를 관리하는 화면에서는 별도로 나오지 않으며  */
    /*        시스템 내부적으로만 관리됩니다.                                */
    /*                                                                       */
    /*      - 작업구분코드                                                   */
    /*          CHG_MNG_PW : 팀장암호 등록/변경 =>팀장암호변경시 관련된      */
    /*                       이체/발행과 관련된 모든 암호를 일괄UPDATE한다   */
    /*                       PARAMETER는 p_password1 은 신규팀장암호를 ,     */
    /*                       p_password2는 이전팀장암호를 입력받아 사용한다. */
    /*                                                                       */
    /*          CHG_CASH_PW : 현금이체 암호를 변경합니다.                    */
    /*                        p_password1은 팀장암호, p_password2가 이체암호 */
    /*                                                                       */
    /*          CHG_BILL_PW : 전자어음 암호를 변경합니다.                    */
    /*                        p_password1은 팀장암호, p_password2가 어음암호 */
    /*                                                                       */
    /*          CHK_MNG_PW  : 팀장암호를 확인합니다.                         */
    /*                        p_password1을 팀장암호로 입력받아 확인함       */
    /*                                                                       */
    /*          CHK_CASH_PW : 현금이체지급시 암호를 확인합니다.              */
    /*                        p_password1은 팀장암호, p_password2가 이체암호 */
    /*                                                                       */
    /*          CHK_BILL_PW : 전자어음 발행시 암호를 확인합니다.             */
    /*                        p_password1은 팀장암호, p_password2가 어음암호 */
    /*                                                                       */
    /*          CHG_ACCT_PW : 계좌에 대한 이체암호를 설정한다.               */
    /*                       p_emp_no는 사번 , p_password1은 계좌번호        */
    /*                       p_password2는 이체암호하여 처리한다.            */
    /*                                                                       */
    /*          RET_ACCT_PW : 계좌에 대한 이체암호를 조회한다.               */
    /*                       p_emp_no는 사번 , p_password1은 계좌번호로 한다 */
    /*                       NULL값이 반환되면, 해당 암호가 없거나 오류이며  */
    /*                       정상적인 경우, 해당 계좌의 이체암호가 반환      */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시  or 암호가 맞는 것으로 확인된 경우.        */
    /*          오류메시지 : 기타 오류 발생시                                */
    /*          계좌암호 : RET_ACCT_PW로 호출되어 정상인 경우,오류는 NULL    */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월28일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    FUNCTION do_pwd_job( p_gubun_code   IN VARCHAR2 ,                -- 작업구분코드
                         p_emp_no       IN VARCHAR2 ,                -- 사번 / 계좌번호
                         p_password1    IN VARCHAR2 ,                -- 암호문자열 1
                         p_password2    IN VARCHAR2 DEFAULT NULL)    -- 암호문자열 2
        RETURN VARCHAR2 IS                                           -- 함수처리결과
        v_return_msg            VARCHAR2(200);                -- 반환값 OR 반환메시지
        rec_lookup_values       T_FB_LOOKUP_VALUES%ROWTYPE;
        rec_new_lookup_values   T_FB_LOOKUP_VALUES%ROWTYPE;
        rec_accounts_pwd        T_FB_ACCOUNTS_PWD%ROWTYPE;
        v_record_exist_yn       VARCHAR2(1) := 'N';
        v_gubun_code            VARCHAR2(20);
        ERR_NO_GUBUN_CODE       EXCEPTION;   -- 구분코드가 입력되지 않았을때...
        ERR_INVALID_GUBUN_CODE  EXCEPTION;   -- 구분코드가 잘못 입력된 경우...
        ERR_NO_EMP_NO           EXCEPTION;   -- 사번이 입력되지 않았을때...
        ERR_NO_PASSWORD         EXCEPTION;   -- 암호문자열1이 입력되지 않았을때..(암호문자열1은 필수,2는 옵션)
        ERR_NOT_MATCH_MNG_PW    EXCEPTION;   -- 팀장암호가 맞지 않을때...
        ls_OldPwd				Varchar2(1000);
    BEGIN
        v_gubun_code := UPPER(p_gubun_code);
        rec_lookup_values.lookup_type := 'FBS_PASSWORD';
        rec_new_lookup_values.lookup_type := 'FBS_PASSWORD';
        -- 입력PARAMETER의 입력여부 확인
        IF p_gubun_code IS NULL OR p_gubun_code = '' THEN
            RAISE ERR_NO_GUBUN_CODE;
        ELSIF p_emp_no IS NULL OR p_emp_no = '' THEN
            RAISE ERR_NO_EMP_NO;
        ELSIF p_password1 IS NULL OR p_password1 = '' THEN
            RAISE ERR_NO_PASSWORD;
        ELSE
            rec_lookup_values.lookup_code := TRIM( p_emp_no );
            rec_new_lookup_values.lookup_code := TRIM( p_emp_no );
        END IF;
        -- 이전의 record가 있는지 확인해서, v_record_exist_yn 설정 및 RECORD변수에 셋팅 담당
        BEGIN
            SELECT *
              INTO rec_lookup_values
              FROM T_FB_LOOKUP_VALUES
             WHERE LOOKUP_TYPE = rec_lookup_values.lookup_type
               AND LOOKUP_CODE = rec_lookup_values.lookup_code
               AND USE_YN = 'Y';
            v_record_exist_yn := 'Y';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_record_exist_yn := 'N';
        END;

        -- 1) 팀장암호를 변경하는, "CHG_MNG_PW'인 경우...
        -------------------------------------------------
        IF v_gubun_code = 'CHG_MNG_PW' THEN
            BEGIN
                IF v_record_exist_yn = 'Y' THEN
                    -- 이전 팀장암호를 확인합니다.
                    If p_password2 Is Null Then
                    	Raise_Application_Error(-20009,'기존 암호를 입력하여 주십시오.');
                    End If;
                    IF p_password2 Is Not Null And pw_decode(rec_lookup_values.lookup_value,4,p_password2) <> SubStrb(p_password2,1,4) THEN
                        RAISE ERR_NOT_MATCH_MNG_PW;
                    ELSE
                        -- 기존에 등록된 것이 있는 경우...
                        rec_new_lookup_values.lookup_value := pw_encode( p_password1 , p_password1 );
                        rec_new_lookup_values.attribute1   := pw_encode( pw_decode( rec_lookup_values.attribute1 , 4 , p_password2 ) , p_password1 );
                        rec_new_lookup_values.attribute2   := pw_encode( pw_decode( rec_lookup_values.attribute2 , 4 , p_password2 ) , p_password1 );
                        UPDATE T_FB_LOOKUP_VALUES
                           SET LOOKUP_VALUE = rec_new_lookup_values.lookup_value ,
                               ATTRIBUTE1   = rec_new_lookup_values.attribute1 ,
                               ATTRIBUTE2   = rec_new_lookup_values.attribute2 ,
                               LAST_MODIFY_EMP_NO = p_emp_no ,
                               LAST_MODIFY_DATE = SYSDATE
                         WHERE LOOKUP_TYPE = rec_new_lookup_values.lookup_type
                           AND LOOKUP_CODE = rec_new_lookup_values.lookup_code
                           AND USE_YN = 'Y';
                    END IF;
                ELSE
                -- 기존에 등록된 것이 없는 경우...
                   INSERT INTO T_FB_LOOKUP_VALUES ( LOOKUP_TYPE ,
                                                    LOOKUP_CODE ,
                                                    LOOKUP_VALUE ,
                                                    USE_YN,
                                                    DESCRIPTION,
                                                    CREATION_DATE,
                                                    CREATION_EMP_NO,
                                                    LAST_MODIFY_DATE,
                                                    LAST_MODIFY_EMP_NO,
                                                    ATTRIBUTE1,
                                                    ATTRIBUTE2)
                                           VALUES ( rec_new_lookup_values.lookup_type ,
                                                    rec_new_lookup_values.lookup_code ,
                                                    pw_encode( p_password1 , p_password1 ) ,
                                                    'Y',
                                                    'FBS암호설정['||p_emp_no||']',
                                                    SYSDATE ,
                                                    p_emp_no ,
                                                    SYSDATE ,
                                                    p_emp_no ,
                                                    pw_encode( p_password1 , p_password1 ) ,  -- 초기이체암호는 팀장암호로 설정
                                                    pw_encode( p_password1 , p_password1 ) ); -- 초기발행암호는 팀장암호로 설정

                END IF;
                -- 정상처리인 경우, commit하며, OK문자열 반환
                COMMIT;
                write_log('FBS','팀장암호[사번:'||p_emp_no||']를 변경하였습니다.');
                v_return_msg := SUCCESS_CODE;
            EXCEPTION
                WHEN ERR_NOT_MATCH_MNG_PW THEN
                    v_return_msg := '팀장암호가 맞지 않습니다.\n다시 입력하여 주세요.';
                WHEN OTHERS THEN
                    v_return_msg := '[fbs_util_pkg.do_pwd_job 팀장암호변경 수행오류]\n'||format_msg( sqlerrm );
            END;

        -- 2) 현금이체 암호를 변경하는 'CHG_CASH_PW'인 경우...
        ------------------------------------------------------
        ELSIF v_gubun_code = 'CHG_CASH_PW' THEN
            BEGIN
                IF v_record_exist_yn = 'Y' THEN
                    -- 이전 팀장암호를 확인합니다.
                    If p_password1 Is Null Then
                    	Raise_Application_Error(-20009,'팀장 암호를 입력하여 주십시오.');
                    End If;
                    IF pw_decode( rec_lookup_values.lookup_value , 4 , p_password1 ) <> SubStrb(p_password1,1,4) THEN
                        RAISE ERR_NOT_MATCH_MNG_PW;
                    ELSE
                        rec_new_lookup_values.attribute1 := pw_encode( p_password2 , p_password1 );
                        UPDATE T_FB_LOOKUP_VALUES
                           SET ATTRIBUTE1   = rec_new_lookup_values.attribute1 ,
                               LAST_MODIFY_EMP_NO = p_emp_no ,
                               LAST_MODIFY_DATE = SYSDATE
                         WHERE LOOKUP_TYPE = rec_new_lookup_values.lookup_type
                           AND LOOKUP_CODE = rec_new_lookup_values.lookup_code
                           AND USE_YN = 'Y';
                        -- 정상처리인 경우, commit하며, OK문자열 반환
                        write_log('FBS','현금이체암호를 변경하였습니다.[사번:'||p_emp_no||']');
                        COMMIT;
                        v_return_msg := SUCCESS_CODE;
                    END IF;
                ELSE
                    v_return_msg := '팀장암호가 등록되어 있지 않습니다.\n먼저 팀장암호를 입력하세요.';
                END IF;
            EXCEPTION
                WHEN ERR_NOT_MATCH_MNG_PW THEN
                    v_return_msg := '팀장암호가 맞지 않습니다.\n다시 입력하여 주세요.';
                WHEN OTHERS THEN
                    v_return_msg := '[fbs_util_pkg.do_pwd_job 현금이체암호변경 수행오류]\n'||format_msg( sqlerrm );
            END;

        -- 3) 전자어음 암호를 변경하는 , 'CHG_BILL_PW'인 경우...
        --------------------------------------------------------
        ELSIF v_gubun_code = 'CHG_BILL_PW' THEN
            BEGIN
                IF v_record_exist_yn = 'Y' THEN
                    -- 이전 팀장암호를 확인합니다.
                    If p_password1 Is Null Then
                    	Raise_Application_Error(-20009,'팀장 암호를 입력하여 주십시오.');
                    End If;
                    IF pw_decode( rec_lookup_values.lookup_value , 4 , p_password1 ) <> SubStrb(p_password1,1,4) THEN
                        RAISE ERR_NOT_MATCH_MNG_PW;
                    ELSE
                        rec_new_lookup_values.attribute2 := pw_encode( p_password2 , p_password1 );
                        UPDATE T_FB_LOOKUP_VALUES
                           SET ATTRIBUTE2   = rec_new_lookup_values.attribute2 ,
                               LAST_MODIFY_EMP_NO = p_emp_no ,
                               LAST_MODIFY_DATE = SYSDATE
                         WHERE LOOKUP_TYPE = rec_new_lookup_values.lookup_type
                           AND LOOKUP_CODE = rec_new_lookup_values.lookup_code
                           AND USE_YN = 'Y';
                        -- 정상처리인 경우, commit하며, OK문자열 반환
                        write_log('FBS','전자어음암호를 변경하였습니다.[사번:'||p_emp_no||']');
                        COMMIT;
                        v_return_msg := SUCCESS_CODE;
                    END IF;
                ELSE
                    v_return_msg := '팀장암호가 등록되어 있지 않습니다.\n먼저 팀장암호를 입력하세요.';
                END IF;
            EXCEPTION
                WHEN ERR_NOT_MATCH_MNG_PW THEN
                    v_return_msg := '팀장암호가 맞지 않습니다.\n다시 입력하여 주세요.';
                WHEN OTHERS THEN
                    v_return_msg := '[fbs_util_pkg.do_pwd_job 전자어음 암호변경 수행오류]\n'||format_msg( sqlerrm );
            END;

        -- 4) 팀장암호 확인하는 경우, "CHK_MNG_PW' 인 경우...
        -----------------------------------------------------
        ELSIF v_gubun_code = 'CHK_MNG_PW' THEN
            IF v_record_exist_yn = 'Y' THEN
                If p_password1 Is Null Then
                	Raise_Application_Error(-20009,'팀장 암호를 입력하여 주십시오.');
                End If;
                IF pw_decode( rec_lookup_values.lookup_value , 4 ) <> SubStrb(p_password1,1,4) THEN
                    v_return_msg := '암호가 틀렸습니다. \n확인 후, 다시 입력하여 주세요.';
                ELSE
                    v_return_msg := SUCCESS_CODE;
                END IF;
            ELSE
                v_return_msg := '팀장암호가 등록되어 있지 않습니다.\n먼저 팀장암호를 입력하세요.';
            END IF;

        -- 5) 현금이체시 암호정상여부를 확인하는, 'CHK_CASH_PW' 인 경우...
        ------------------------------------------------------------------
        ELSIF v_gubun_code = 'CHK_CASH_PW' THEN
            IF v_record_exist_yn = 'Y' THEN
                If p_password1 Is Null Then
                	Raise_Application_Error(-20009,'팀장 암호를 입력하여 주십시오.');
                End If;
                IF pw_decode( rec_lookup_values.lookup_value , 4 ) <> SubStrb(p_password1,1,4) THEN
                     v_return_msg := '팀장암호가 틀렸습니다.\n확인 후, 다시 입력하여 주세요.';
                ELSIF pw_decode(rec_lookup_values.attribute1,4 ) <> p_password2 THEN
                    v_return_msg := '이체암호가 틀렸습니다.\n확인 후, 다시 입력하여 주세요.';
                ELSE
                    v_return_msg := SUCCESS_CODE;
                END IF;
            ELSE
                v_return_msg := '이체암호가 등록되어 있지 않습니다.\n먼저 팀장암호를 입력하세요.';
            END IF;

        -- 6) 전자어음 발생시, 암호정상여부를 확인하는, 'CHK_BILL_PW' 인 경우...
        ------------------------------------------------------------------------
        ELSIF v_gubun_code = 'CHK_BILL_PW' THEN
            IF v_record_exist_yn = 'Y' THEN
                If p_password1 Is Null Then
                	Raise_Application_Error(-20009,'팀장 암호를 입력하여 주십시오.');
                End If;
                IF pw_decode( rec_lookup_values.lookup_value , 4 ) <> SubStrb(p_password1,1,4) THEN
                     v_return_msg := '팀장암호가 틀렸습니다.\n확인 후, 다시 입력하여 주세요.';
                ELSIF pw_decode(rec_lookup_values.attribute2,4 ) <> p_password2 THEN
                    v_return_msg := '전자어음암호가 틀렸습니다.\n확인 후, 다시 입력하여 주세요.';
                ELSE
                    v_return_msg := SUCCESS_CODE;
                END IF;
            ELSE
                v_return_msg := '전자어음 암호가 등록되어 있지 않습니다.\n먼저 팀장암호를 입력하세요.';
            END IF;

        -- 7) 계좌암호를 설정하는 , 'CHG_ACCT_PW'인 경우...
        ---------------------------------------------------
        ELSIF v_gubun_code = 'CHG_ACCT_PW' THEN
            -- 기존에 등록된 것이 있는지 확인합니다.
            BEGIN
                SELECT *
                  INTO rec_accounts_pwd
                  FROM T_FB_ACCOUNTS_PWD
                 WHERE ACCOUNT_NO = TRIM(p_password1);
                v_record_exist_yn := 'Y';

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    v_record_exist_yn := 'N';
            END;
            -- 기본적인 사항을 설정합니다.
            rec_accounts_pwd.change_ymd := TO_CHAR(SYSDATE,'YYYYMMDD');
            rec_accounts_pwd.last_modify_date := SYSDATE;
            rec_accounts_pwd.last_modify_emp_no := TRIM(p_emp_no);
            -- 신규/갱신여부를 확인하여 처리한다.
            BEGIN
                IF v_record_exist_yn = 'Y' THEN
                    UPDATE T_FB_ACCOUNTS_PWD
                       SET OLD_PASSWORD = rec_accounts_pwd.new_password ,
                           NEW_PASSWORD = pw_encode( TRIM(p_password2) ) ,
                           CHANGE_YMD   = rec_accounts_pwd.change_ymd ,
                           LAST_MODIFY_DATE = SYSDATE ,
                           LAST_MODIFY_EMP_NO = TRIM(p_emp_no)
                     WHERE ACCOUNT_NO = rec_accounts_pwd.account_no;
                ELSE
                    rec_accounts_pwd.account_no := TRIM(p_password1);
                    rec_accounts_pwd.creation_date := SYSDATE;
                    rec_accounts_pwd.creation_emp_no := p_emp_no;
                    rec_accounts_pwd.new_password := pw_encode( p_password2 );
                    INSERT INTO T_FB_ACCOUNTS_PWD VALUES rec_accounts_pwd;
                END IF;
                -- 정상처리인 경우, commit하며, OK문자열 반환
                write_log('FBS','정상적으로 계좌암호를 변경하였습니다.[계좌번호:'||p_password1||']');
                COMMIT;
                v_return_msg := SUCCESS_CODE;
            EXCEPTION
                WHEN OTHERS THEN
                    v_return_msg := '[fbs_util_pkg.do_pwd_job 계좌암호 암호변경 수행오류]\n'||format_msg( sqlerrm );
            END;


        -- 8) 계좌암호를 조회하는 'RET_ACCT_PW'인 경우...
        -------------------------------------------------
        ELSIF v_gubun_code = 'RET_ACCT_PW' THEN
            BEGIN
                SELECT pw_decode( NEW_PASSWORD , 4 )
                  INTO v_return_msg
                  FROM T_FB_ACCOUNTS_PWD
                 WHERE ACCOUNT_NO = TRIM(p_password1);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    v_return_msg := NULL;
                WHEN OTHERS THEN
                    v_return_msg := NULL;
            END;
        ELSE
            -- 구분코드가 잘못 입력된 경우...
            RAISE ERR_INVALID_GUBUN_CODE;
        END IF;
        RETURN( v_return_msg );

    EXCEPTION
        WHEN ERR_NO_GUBUN_CODE THEN
            RETURN( '[do_pwd_job] 구분코드가 입력되지 않았습니다.\n전산실에 문의하여주십시오.');
        WHEN ERR_INVALID_GUBUN_CODE THEN
            RETURN( '[do_pwd_job] 구분코드가 잘못 입력되었습니다.\n전산실에 문의하여주십시오.');
        WHEN ERR_NO_EMP_NO THEN
            RETURN( '[do_pwd_job] 사번이 입력되지 않았습니다.\n전산실에 문의하여주십시오.');
        WHEN ERR_NO_PASSWORD THEN
            RETURN( '[do_pwd_job] 암호가 입력되지 않았습니다.\n전산실에 문의하여주십시오.');
        WHEN OTHERS THEN
            RETURN( format_msg(SQLERRM) );
    END do_pwd_job;

END FBS_UTIL_PKG;
/
