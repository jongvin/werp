CREATE OR REPLACE PACKAGE FBS_UTIL_PKG IS
	-- ������ ���� ����
	SUCCESS_CODE		Constant Varchar2(2) := 'OK';

    -- ��ȣȭ/��ȣȭ���� ���Ǵ� ��� 
    DEFAULT_ENCODE_KEY  VARCHAR2(16) := 'keepthesecretnum';
    DUMMY_CHAR          VARCHAR2(1) := '9';

    -- ���Ϲ߼ۿ��� ���Ǵ� ��� 
    SMTP_SERVER         VARCHAR2(50) := '52.10.123.200';  -- �ӽ÷� ���߼����� SMTP�� ��ġ�Ѱ���. ���� �������.
    SMTP_PORT           NUMBER       := 25;
    ADMIN_MAILER        VARCHAR2(50) := 'cjderp@cj.net';
    ADMIN_MAILER_NAME   VARCHAR2(50) := 'CJ����';
    CRLF                VARCHAR2( 2 ):= CHR( 13 ) || CHR( 10 );    

    TYPE addresslist_tab IS TABLE OF VARCHAR2( 1000 )
        INDEX BY BINARY_INTEGER;    
    
    -- DB�̸��� ���ϴµ��� ���Ǵ� ���
    PROD_DBNAME         VARCHAR2(10) := 'PROD';
    TEST_DBNAME         VARCHAR2(10) := 'TEST';
    
    -- OS���� DIRECTORY PATH�� �˱����� ORACLE�� DIRECTORY NAME 
    FBS_CASH_SEND_DIR      VARCHAR2(100) := 'FBS_CASH_SEND_DIR';      -- ���ݴ뷮��ü �۽�����  
    FBS_CASH_RECV_DIR      VARCHAR2(100) := 'FBS_CASH_RECV_DIR';      -- ���ݴ뷮��ü �����������  
    FBS_BILL_SEND_DIR      VARCHAR2(100) := 'FBS_BILL_SEND_DIR';      -- ���ھ��� �۽�����  
    FBS_BILL_RECV_DIR      VARCHAR2(100) := 'FBS_BILL_RECV_DIR';      -- ���ھ��� ������� ����  
    FBS_LOG_DIR            VARCHAR2(100) := 'FBS_LOG_DIR';            -- FBS�α� ����  
    
    -- �����ڵ� 
  
    KIUP_BANK_CD                   VARCHAR2(2) := '03';   -- ������� 
    KUKMIN_BANK_CD                 VARCHAR2(2) := '04';   -- ��������     
    WOORI_BANK_CD                  VARCHAR2(2) := '20';   -- �츮����     
    HANA_BANK_CD                   VARCHAR2(2) := '81';   -- �ϳ�����     
     
    -- EDI �ۼ����� ���� command���� (PATH�� �����Ͽ� �����մϴ�.)
    SEND_EDI_COMMAND         VARCHAR2(300) := 'C:\fbs\tcpsend.exe';         -- BATCH�� �۽Ž� ó���ϴ� ���α׷� ���� 
    RECV_EDI_COMMAND         VARCHAR2(300) := 'C:\fbs\tcprecv.exe';         -- BATCH�� ���Ž� ó���ϴ� ���α׷� ����      
     
    /*************************************************************************/
    /*  1. ���ID    : pw_encode                                             */
    /*  2. ����̸�  : ���ڿ� ��ȣȭ ���                                    */
    /*************************************************************************/     
    FUNCTION pw_encode( p_input_str IN VARCHAR2,
                        p_encode_key IN VARCHAR2 DEFAULT NULL )
         RETURN VARCHAR2;

    /*************************************************************************/
    /*  1. ���ID    : pw_decode                                             */
    /*  2. ����̸�  : ���ڿ� ��ȣȭ ���                                    */
    /*************************************************************************/     
    FUNCTION pw_decode( p_input_str  IN VARCHAR2,   -- ��ȣȭ�� ���ڿ� 
                        p_length     IN NUMBER,     -- ��ȣȭ�� ���ڿ��� �տ��� N�� �ڸ�����ŭ ��ȯ 
                        p_encode_key IN VARCHAR2 DEFAULT NULL )
          RETURN VARCHAR2;        
        
    /*************************************************************************/
    /*  ��� : ���ϳ����� �޾Ƽ� ������ �߼��Ѵ�.(�ǽð�)                    */
    /*         return : ����߼� Ȥ�� �����޽���                             */
    /*************************************************************************/
    FUNCTION mail_send( p_mailto    IN VARCHAR2 ,             -- ������   
                        p_mailcc    IN VARCHAR2 ,             -- ������  
                        p_subject   IN VARCHAR2 ,             -- ����  
                        p_contents  IN LONG     ,             -- ���� 
                        p_html_yn   IN VARCHAR2 DEFAULT 'N'   -- HTML���Ͽ���(default 'N')  
                      ) RETURN VARCHAR2;                   -- ���� Ȥ�� �����޽���          
        
    /*************************************************************************/
    /*  ��� : ����ڿ��� ������ ����Ŭ �޽����� ����ϰ� ����� �Լ�        */
    /*************************************************************************/
    FUNCTION format_msg( p_msg  IN VARCHAR2 ) RETURN VARCHAR2;           
        
    /*************************************************************************/
    /*  ��� : DB�̸��� ���ϴ� �Լ� (�WISE�� TEST�� �����ϱ� ���� )       */
    /*************************************************************************/
    FUNCTION get_db_name RETURN VARCHAR2;          
        
    /*************************************************************************/
    /*  ��� : format���ڿ����Ŀ� ���缭 input�� string�� ��ȯ�ؼ� ��ȯ      */
    /*************************************************************************/
    FUNCTION sprintf( format    IN VARCHAR2 , 
                      input_str IN VARCHAR2 ) return VARCHAR2;
  
    /*************************************************************************/
    /*  ��� : ������prefix�� �α׳����� �Է¹޾� ���Ϸ� �α׸� �����Ѵ�     */
    /*************************************************************************/
    PROCEDURE write_log( prefix   IN VARCHAR2 , 
                         contents IN VARCHAR2 );        
        
    /*************************************************************************/
    /*  ��� : �ǽð� ó���� ���ະ  �����ȣ�� ��ȯ�Ѵ�.                    */
    /*************************************************************************/  
    FUNCTION  get_real_sign_no( out_bank_cd     IN VARCHAR2 ,               -- ��������ڵ�
                                out_account_no  IN VARCHAR2 ,               -- ���������¹�ȣ                                 
                                in_bank_cd      IN VARCHAR2 ,               -- �Ա������ڵ�
                                in_account_no   IN VARCHAR2 ,               -- �Ա�������¹�ȣ
                                trade_amt       IN NUMBER ,                 -- ��ü�ݾ�
                                etc_field1      IN VARCHAR2 DEFAULT NULL)   -- �����ʵ�1 (�ַ� ������ȣ)
        RETURN VARCHAR2 ;         
        
    /*************************************************************************/
    /*  ��� : batch����ó����  �����ȣ�� ��ȯ�Ѵ�.                         */
    /*************************************************************************/  
    FUNCTION  get_batch_sign_no(  edi_history_seq IN NUMBER ,                 -- EDI�̷��Ϸù�ȣ 
                                  total_cnt       OUT NUMBER ,                -- �����ȣ�� ������ ����ڷ��� �� �Ǽ� 
                                  total_sum       OUT NUMBER ,                -- �����ȣ�� ������ ����ڷ��� �� �ݾ�     
                                  etc_field1      IN VARCHAR2 DEFAULT NULL,   -- �����ʵ�1   
                                  etc_field2      IN VARCHAR2 DEFAULT NULL)   -- �����ʵ�2   

        RETURN VARCHAR2 ;         
        
    /******************************************************************************/
    /*  ��� : OBJECT TYPE �� OBJECT NAME�� �޾� STATUS(VALID,INVALID) ��ȯ       */
    /******************************************************************************/
    FUNCTION get_object_status( p_object_type IN VARCHAR2 ,         -- OBJECT TYPE  
                                p_object_name IN VARCHAR2           -- OBJECT NAME  
                              ) RETURN VARCHAR2;                    -- ���� : VALID / INVALILD        
                              
        
    /******************************************************************************/
    /*  ��� : ������ batch file�� VAN��� �۽��մϴ�.                            */
    /******************************************************************************/
    FUNCTION send_file_to_VAN(  p_file_name   IN VARCHAR2 ,                -- ������ ���ϸ� 
                                p_gubun       IN VARCHAR2 ,                -- ���۵���Ÿ���� (C:����,B:���ھ���) 
                                p_comp_code   IN VARCHAR2 ,                -- ����� �ڵ� 
                                p_bank_code   IN VARCHAR2 )                -- ���� �ڵ� 
        RETURN VARCHAR2;                                                   -- �۽Ű�� ó�� �޽��� 
           
        
    /******************************************************************************/
    /*  ��� : VAN�翡�� data�� �޾� file�� �����մϴ�.                           */
    /******************************************************************************/
    FUNCTION receive_file_from_VAN( p_file_name   IN VARCHAR2 ,                -- ������ ���ϸ� 
                                    p_gubun       IN VARCHAR2 ,                -- ���۵���Ÿ���� (C:����,B:���ھ���) 
                                    p_comp_code   IN VARCHAR2 ,                -- ����� �ڵ� 
                                    p_bank_code   IN VARCHAR2 )                -- ���� �ڵ� 
        RETURN VARCHAR2;                                                       -- ���Ű�� ó�� �޽��� 
        
        
    /******************************************************************************/
    /*  ��� : EDI�ۼ����� ���� ���ϸ��� ��ȯ�մϴ�                               */
    /******************************************************************************/
    FUNCTION get_edi_file_name( p_comp_code   IN VARCHAR2 ,                -- ����� �ڵ� 
                                p_bank_code   IN VARCHAR2 ,                -- ���� �ڵ� 
                                p_gubun       IN VARCHAR2 )                -- ���۵���Ÿ���� 
        RETURN VARCHAR2;                                                   -- �����̸� ��ȯ  
        
        
    /******************************************************************************/
    /*  ��� : OS���� ��ɾ �����մϴ�.                                        */
    /******************************************************************************/        
    FUNCTION exec_os_command( p_string IN VARCHAR2 )     -- �����ų ��ɾ� 
        RETURN VARCHAR2;                                 -- ó����� : OK Ȥ�� ERROR
        

    /******************************************************************************/
    /*  ��� : ��ȣ���/����/Ȯ�ε��� ����� �����ϴ� ���� �Լ�                   */
    /******************************************************************************/
    FUNCTION do_pwd_job( p_gubun_code   IN VARCHAR2 ,                -- �۾������ڵ�
                         p_emp_no       IN VARCHAR2 ,                -- ��� 
                         p_password1    IN VARCHAR2 ,                -- ��ȣ���ڿ� 1 
                         p_password2    IN VARCHAR2 DEFAULT NULL)    -- ��ȣ���ڿ� 2 
        RETURN VARCHAR2;                                             -- �Լ�ó�����   
        
        
END FBS_UTIL_PKG;
/
Create Or Replace PACKAGE BODY FBS_UTIL_PKG IS
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : pw_encode                                             */
    /*  2. ����̸�  : ���ڿ� ��ȣȭ ���                                    */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ���ڿ��� �Է¹޾Ƽ� ����Ŭ�� DBMS_OBFUSCATION_TOOLKIT�� ���   */
    /*        �Ͽ� ��ȣȭ�� ��, ��ȭȭ ���ڿ��� ��ȯ�Ѵ�.                    */
    /*      - DES����� �ּ�8�ڸ��̹Ƿ�, 8�ڸ��� �ȵǴ�  ���� ���ʿ�       */
    /*        DUMMY����(9)�� �ٿ���, 8�ڸ��� �Ѿ�� ���� 8�ڸ��� �߶�  */
    /*        ��ȣȭ�� �Ѵ�.                                                 */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
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
        -- 8�ڸ��� �ȵǴ� ���� �ڿ� DUMMY CHAR�� �ٿ� 8�ڸ��� �����.
        IF length(p_input_str) > 8 THEN
            RAISE ERR_TOO_LONG_INPUT;
        ELSE
            raw_string := RPAD( p_input_str , 8 , DUMMY_CHAR );
        END IF;
        -- ENCODING KEY�� �Է¾ȵ� ����, DEFAULT ENCODING KEY�� ����Ѵ�.
        IF p_encode_key IS NULL THEN
            raw_key := UTL_RAW.CAST_TO_RAW( DEFAULT_ENCODE_KEY );
        ELSE
            raw_key := UTL_RAW.CAST_TO_RAW( RPAD( p_encode_key , 8 , DUMMY_CHAR  ));
        END IF;
        -- ��ȣȭ�� �����Ѵ�.
        dbms_obfuscation_toolkit.DESEncrypt( input => UTL_RAW.CAST_TO_RAW(raw_string) , key => raw_key , encrypted_data => encrypted_raw );
        encrypted_string := rawtohex( encrypted_raw );
        -- ��ȣȭ�� HEX���ڿ� ��ȯ
        RETURN( encrypted_string);
    EXCEPTION
        WHEN ERR_TOO_LONG_INPUT THEN
            RETURN( '8�ڸ����� �Է��� �����մϴ�.');
        WHEN OTHERS THEN
            RETURN( SQLERRM );
    END pw_encode;

    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : pw_encode                                             */
    /*  2. ����̸�  : ���ڿ� ��ȣȭ ���                                    */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ���ڿ��� �Է¹޾Ƽ� ����Ŭ�� DBMS_OBFUSCATION_TOOLKIT�� ���   */
    /*        �Ͽ� ��ȣȭ�� �� ��, ��ȣȭ�� ���ڿ��� ��ȯ�Ѵ�.               */
    /*      - DES����� �ּ�8�ڸ��̹Ƿ�, 8�ڸ��� �Ѿ�� ���ڿ��� ��ȣȭ    */
    /*        �� ��쵵 �����Ƿ�, ��ȣ��� �ڸ����� �ι�° �ʵ忡 ������     */
    /*        ���޵Ǹ�, �� ��������ŭ SUBSTRING�ؼ� ��ȯ�Ѵ�.                */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    FUNCTION pw_decode( p_input_str  IN VARCHAR2,   -- ��ȣȭ�� ���ڿ�
                        p_length     IN NUMBER,     -- ��ȣȭ�� ���ڿ��� �տ��� N�� �ڸ�����ŭ ��ȯ
                        p_encode_key IN VARCHAR2 DEFAULT NULL )
          RETURN VARCHAR2 IS
        encrypted_raw     RAW(2048);
        raw_key           RAW(128);
        decrypted_raw     RAW(2048);
        decrypted_string  VARCHAR2(2048);
    BEGIN
        encrypted_raw := hextoraw( p_input_str );
        -- ENCODING KEY�� �Է¾ȵ� ����, DEFAULT ENCODING KEY�� ����Ѵ�.
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
    /*  1. ���ID    : mail_send                                             */
    /*  2. ����̸�  : ���Ϲ߼�                                              */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �Էµ� ������,������,����,����,HTML���Ͽ��� ���� Ȱ���Ͽ�      */
    /*        ����Ǽ� ���ϼ����� �����Ͽ� ������ �߼��մϴ�                 */
    /*      - �߼۰���� return������ �����Ǹ�, ����߼��� ���, OK ���ڿ��� */
    /*        ��ȯ�ǰ�, ������ ������ ���� �޽����� ��ȯ�Ѵ�.              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    FUNCTION mail_send( p_mailto    IN VARCHAR2 ,             -- ������
                        p_mailcc    IN VARCHAR2 ,             -- ������
                        p_subject   IN VARCHAR2 ,             -- ����
                        p_contents  IN LONG     ,             -- ����
                        p_html_yn   IN VARCHAR2 DEFAULT 'N'   -- HTML���Ͽ���(default 'N')
                      ) RETURN VARCHAR2 IS                 -- ���� Ȥ�� �����޽���
        conn           UTL_SMTP.CONNECTION;
        addrlist       addresslist_tab;        -- ���ϼ�����/������ ����Ʈ :  �̸�<�ּ�> ����
        addrcnt        BINARY_INTEGER   := 1;
        mesg           LONG;                   -- ���� ����
        v_temp         VARCHAR2(4000);         -- �̸��� �ּҸ� �����ϱ����� �ӽú��� : �̸�<�ּ�>����
        v_remain       VARCHAR2(4000);
        USR_ERR_TO_LIST    EXCEPTION;  -- TO�� �ش��ϴ� ����� ���ų�, ���ڿ��� �߸��Ǿ�����
        USR_ERR_CC_LIST    EXCEPTION;  -- CC�� �ش��ϴ� ����� ���ڿ��� �߸��Ǿ�����..
    BEGIN
        conn:= UTL_SMTP.open_connection( SMTP_SERVER, SMTP_PORT );
        UTL_SMTP.helo( conn, SMTP_SERVER );
        UTL_SMTP.mail( conn, ADMIN_MAILER );
        -- mailto���ڿ��� Ȯ���Ͽ�, comma(,)�� ���е� �����ڸ� �����մϴ�.
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
        -- mailcc���ڿ��� Ȯ���Ͽ�, comma(,)�� ���е� �����ڸ� �����մϴ�.
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
        -- �߼۸��� ���ڿ��� �����մϴ�.
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
        -- ������ �߼��մϴ�.
        UTL_SMTP.open_data(conn);
        UTL_SMTP.write_raw_data(conn, UTL_RAW.CAST_TO_RAW(mesg));
        UTL_SMTP.close_data(conn);
        UTL_SMTP.quit( conn );
        RETURN(SUCCESS_CODE);
    EXCEPTION
        WHEN USR_ERR_TO_LIST THEN
            RETURN( '������ �׸� ����:'||p_mailto);
        WHEN USR_ERR_CC_LIST THEN
            RETURN( '������ �׸� ����:'||p_mailcc);
        WHEN OTHERS THEN
            RETURN(SQLERRM);
    END mail_send;

    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : format_msg                                            */
    /*  2. ����̸�  : �޽����� ����ϰ� ����� �Լ�                         */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ���������� ���� ���ڿ��� �Է¹޾Ƽ� ����ϰ� �����Ѵ�.         */
    /*      - P_TYPE�� ���� ����                                             */
    /*          (1) U : �Ϲ� ȭ��� ����� �޽���                            */
    /*          (2) S : �ý��� �޽���                                        */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    FUNCTION format_msg( p_msg   IN VARCHAR2 )   -- ���ڿ� FORMATING
                       RETURN VARCHAR2 IS
        v_return_msg VARCHAR2(2000);    -- ��ȯ�� ���ڿ�
        v_temp_str   VARCHAR2(2000);    -- �ӽ÷� ����� ���ڿ�
    BEGIN
        -- ORA�ڵ尪�� �����Ͽ� 20000�� �̻�(����� ���� ����)�� ���,
        -- ��Ÿ �ý��ۿ��� ������ ���ڵ��� �����ϰ� �����ݴϴ�. (����� message��)
        IF INSTR( p_msg , 'ORA-' ) > 0 THEN
            v_temp_str := SUBSTR( p_msg , INSTR( p_msg , 'ORA-' ) + 4 , INSTR( p_msg , ':' ) - INSTR( p_msg , 'ORA-' ) - 4 );
            IF TO_NUMBER( TRIM(v_temp_str) ) >= 20000 THEN
                  -- ù��° �ٸ� �����ɴϴ�.
                  IF INSTR( p_msg , CHR(10) ) > 0 THEN
                      v_return_msg := SUBSTR( p_msg , 1 , INSTR( p_msg , CHR(10) ) );
                  ELSE
                      v_return_msg := p_msg;
                  END IF;
                  -- ���ڿ� ���� "ORA-�����ڵ�"�κ��� �����մϴ�.
                  WHILE INSTR( v_return_msg , 'ORA-' ) > 0 LOOP
                      v_return_msg := SUBSTR( v_return_msg , INSTR( v_return_msg , ':' ) + 1 , LENGTH(v_return_msg) );
                  END LOOP;
                  -- "\n"�� ���๮�ڷ� ġȯ�մϴ�.
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
    /*  1. ���ID    : get_db_name                                           */
    /*  2. ����̸�  : database�� �̸��� ������                              */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �ǿ�� DB �� �׽�Ʈ�� DB�� �����ϱ����� �Լ�                 */
    /*        �� ���ǵ� �/TEST �̸��� ���,PROD Ȥ�� TEST�� ��ȯ�ϸ�,     */
    /*        ���ǵ��� ���� ���, ������ DB�̸��� ��ȯ�Ѵ�.                  */
    /*                                                                       */
    /*      - �� �Լ��� ������, system view�� v$parameter�� ����ϹǷ�, ���� */
    /*        ������ Compile�Ǳ� ���ؼ��� �ش� User���� v_$paramter�� ����   */
    /*        Object Select������ �ο��Ͽ��� ��                              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
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
    /*  1. ���ID    : sprint                                                */
    /*  2. ����̸�  : format�� ���� ���ڿ� ����                             */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �� ����� C����� sprint�� format����� ���������� �����Ͽ�    */
    /*        ���ڿ��� formatȭ�ؼ� ���鶧 ����Ѵ�.                         */
    /*      - ��������� format �� %s�� �����ϸ�, -���,����.���� �����     */
    /*        �����Ǿ� ����                                                  */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    FUNCTION sprintf( format    IN VARCHAR2,
                      input_str IN VARCHAR2)
           return VARCHAR2 IS
        v_temp_str    VARCHAR2(4000); /* �ӽ÷� ����� ���ڿ� */
        v_return_str  VARCHAR2(4000);
        v_front_digit INTEGER;
        v_end_digit   INTEGER;
        v_digit_pos   INTEGER;
        USR_ERR_NOT_VALID_FORMAT EXCEPTION; /* USER EXCEPTION : ����Ȯ�� FORMAT ��Ʈ�� */
    BEGIN
        -- �ʱ�ȭ
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
        -- PERIOD(.)�� �������� FRONT DIGIT�� END DIGIT�� ����
        v_digit_pos := INSTR(v_temp_str, '.', 1, 1);
        IF v_digit_pos = 0 THEN
            v_front_digit := NVL(TO_NUMBER(v_temp_str), 0);
        ELSE
            v_front_digit := NVL(TO_NUMBER(SUBSTR(v_temp_str, 1, v_digit_pos - 1)), 0);
            v_end_digit   := NVL(TO_NUMBER(SUBSTR(v_temp_str, v_digit_pos + 1)), 0);
        END IF;
        -- �Է¹��ڿ��� NULL�̰ų�, �����̸�, ���ڸ�ŭ SPACE ���ڿ��� ���� ��ȯ�Ѵ�.
        IF input_str IS NULL or LENGTH(input_str) = 0 THEN
            v_return_str := SUBSTR( RPAD( '.' , ABS(v_front_digit) + 1 , ' ' ) , 2 );
        ELSE
            -- �� ����� ���� ���� ó����ƾ�� ��ģ��.
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
    /*  1. ���ID    : write_log                                             */
    /*  2. ����̸�  : �α׸� ���Ϸ� ����                                    */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - prefix�� ���Ϸ� ���� �α׳����� ���ڿ��� �޾� ���Ϸ� log��     */
    /*        �����ϴ� ���α׷�                                              */
    /*                                                                       */
    /*      - �α״� LOG_DIR �� �����ϸ�, ���ϸ��� �Ʒ���Ģ�� �ǰ� �����ȴ�  */
    /*           [prefix]_��¥8�ڸ�.log                                      */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    PROCEDURE write_log( prefix   IN VARCHAR2,
                         contents IN VARCHAR2) IS
        v_output_file UTL_FILE.FILE_TYPE;
        v_date        VARCHAR2(8);
        v_datetime    VARCHAR2(20);
        v_filename    VARCHAR2(100);
        LF            CHAR(15) := '        ' || CHR(13) || CHR(10);
    BEGIN
        -- ���糯¥ ����
        v_date     := TO_CHAR(SYSDATE, 'YYYYMMDD');
        v_datetime := TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:mi:ss');
        -- �����̸� ����
        v_filename := prefix || '_' || v_date || '.log';
        -- log������ open�մϴ�.
        v_output_file := UTL_FILE.FOPEN( FBS_LOG_DIR , v_filename, 'a');
        -- �α׳����� write�մϴ�.
        UTL_FILE.PUT_LINE(v_output_file,'[' || v_datetime || ']  ' || REPLACE(contents, '\n', LF||'                  '));
        -- ������ �ݽ��ϴ�.
        UTL_FILE.FCLOSE(v_output_file);
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END write_log;

    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : get_real_sign_no                                      */
    /*  2. ����̸�  : �ǽð�ó�� ���ະ �����ȣ�� �����Ͽ� ��ȯ�Ѵ�.       */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ���� ������ �Է¹޾� ���ະ �����ȣ�� �����Ѵ�.               */
    /*        ������Ģ�� �ش��������κ��� �޾� �ۼ��ϸ�, �����Ѵ�.           */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    FUNCTION  get_real_sign_no( out_bank_cd     VARCHAR2 ,               -- ��������ڵ�
                                out_account_no  VARCHAR2 ,               -- ���������¹�ȣ
                                in_bank_cd      VARCHAR2 ,               -- �Ա������ڵ�
                                in_account_no   VARCHAR2 ,               -- �Ա�������¹�ȣ
                                trade_amt       NUMBER ,                 -- ��ü�ݾ�
                                etc_field1      VARCHAR2 DEFAULT NULL)   -- �����ʵ� (�ַ� ������ȣ)
                             RETURN VARCHAR2 IS
        v_sign_no          VARCHAR2(6) := '';        -- ��ȯ�� �����ȣ

    BEGIN

        /**************************************************************************************/
        /* ���������� ���                                                                    */
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
        /* �츮������ ���                                                                    */
        /**************************************************************************************/
        ELSIF out_bank_cd = WOORI_BANK_CD THEN
            SELECT TO_CHAR( ( SUBSTR(trade_date,1,1)     + SUBSTR(trade_date,2,1)      + SUBSTR(trade_date,3,1)
                            + SUBSTR(trade_date,4,1)     + SUBSTR(trade_date,5,1)      + SUBSTR(trade_date,6,1) ) +     /*--�ŷ����� */
                            ( SUBSTR(in_account_no,1,1)  + SUBSTR(in_account_no,2,1)   + SUBSTR(in_account_no,3,1)
                            + SUBSTR(in_account_no,4,1)  + SUBSTR(in_account_no,5,1)   + SUBSTR(in_account_no,6,1)
                            + SUBSTR(in_account_no,7,1)  + SUBSTR(in_account_no,8,1)   + SUBSTR(in_account_no,9,1)
                            + SUBSTR(in_account_no,10,1) + SUBSTR(in_account_no,11,1)  + SUBSTR(in_account_no,12,1)
                            + SUBSTR(in_account_no,13,1) + SUBSTR(in_account_no,14,1)  + SUBSTR(in_account_no,15,1) ) + /*--�Աݰ��¹�ȣ */
                            ( SUBSTR(trade_amt,1,1)      + SUBSTR(trade_amt,2,1)       + SUBSTR(trade_amt,3,1)
                            + SUBSTR(trade_amt,4,1)      + SUBSTR(trade_amt,5,1)       + SUBSTR(trade_amt,6,1)
                            + SUBSTR(trade_amt,7,1)      + SUBSTR(trade_amt,8,1)       + SUBSTR(trade_amt,9,1)
                            + SUBSTR(trade_amt,10,1)     + SUBSTR(trade_amt,11,1)      + SUBSTR(trade_amt,12,1)
                            + SUBSTR(trade_amt,13,1) )   +                                                              /*--�ŷ��ݾ�      */
                            ( SUBSTR(in_bank_cd,1,1)     + SUBSTR(in_bank_cd,2,1) )    +                                /*--�Ա������ڵ� */
                            ( SUBSTR(out_account_no,1,1) + SUBSTR(out_account_no,2,1)  + SUBSTR(out_account_no,3,1)
                            + SUBSTR(out_account_no,4,1) + SUBSTR(out_account_no,5,1)  + SUBSTR(out_account_no,6,1)
                            + SUBSTR(out_account_no,7,1) + SUBSTR(out_account_no,8,1)  + SUBSTR(out_account_no,9,1)
                            + SUBSTR(out_account_no,10,1)+ SUBSTR(out_account_no,11,1) + SUBSTR(out_account_no,12,1)
                            + SUBSTR(out_account_no,13,1)+ SUBSTR(out_account_no,14,1) + SUBSTR(out_account_no,15,1) )  /*--��ݰ��¹�ȣ */
                            ,'FM009') ||
                   TO_CHAR( MOD( TO_NUMBER(TRIM(trade_amt), 'FM9999999999999' ),
                            ( ( SUBSTR(trade_date,1,1)      + SUBSTR(trade_date,2,1)     + SUBSTR(trade_date,3,1)
                              + SUBSTR(trade_date,4,1)      + SUBSTR(trade_date,5,1)     + SUBSTR(trade_date,6,1) ) +  /*--�ŷ����� */
                              ( SUBSTR(in_account_no,1,1)   + SUBSTR(in_account_no,2,1)  + SUBSTR(in_account_no,3,1)
                              + SUBSTR(in_account_no,4,1)   + SUBSTR(in_account_no,5,1)  + SUBSTR(in_account_no,6,1)
                              + SUBSTR(in_account_no,7,1)   + SUBSTR(in_account_no,8,1)  + SUBSTR(in_account_no,9,1)
                              + SUBSTR(in_account_no,10,1)  + SUBSTR(in_account_no,11,1) + SUBSTR(in_account_no,12,1)
                              + SUBSTR(in_account_no,13,1)  + SUBSTR(in_account_no,14,1) + SUBSTR(in_account_no,15,1) ) + /*--�Աݰ��¹�ȣ      */
                              ( SUBSTR(trade_amt,1,1)       + SUBSTR(trade_amt,2,1)      + SUBSTR(trade_amt,3,1)
                              + SUBSTR(trade_amt,4,1)       + SUBSTR(trade_amt,5,1)      + SUBSTR(trade_amt,6,1)
                              + SUBSTR(trade_amt,7,1)       + SUBSTR(trade_amt,8,1)      + SUBSTR(trade_amt,9,1)
                              + SUBSTR(trade_amt,10,1)      + SUBSTR(trade_amt,11,1)     + SUBSTR(trade_amt,12,1)
                              + SUBSTR(trade_amt,13,1) )    +                              /*--�ŷ��ݾ�      */
                              ( SUBSTR(in_bank_cd,1,1)      + SUBSTR(in_bank_cd,2,1) )   + /*--�Ա������ڵ�  */
                              ( SUBSTR(out_account_no,1,1)  + SUBSTR(out_account_no,2,1) + SUBSTR(out_account_no,3,1)
                              + SUBSTR(out_account_no,4,1)  + SUBSTR(out_account_no,5,1) + SUBSTR(out_account_no,6,1)
                              + SUBSTR(out_account_no,7,1)  + SUBSTR(out_account_no,8,1) + SUBSTR(out_account_no,9,1)
                              + SUBSTR(out_account_no,10,1) + SUBSTR(out_account_no,11,1)+ SUBSTR(out_account_no,12,1)
                              + SUBSTR(out_account_no,13,1) + SUBSTR(out_account_no,14,1)+ SUBSTR(out_account_no,15,1) )) /*--��ݰ��¹�ȣ */
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
        /* �ϳ������� ��� : docu_numc�� etc_field1�� ����Ѵ�.                               */
        /**************************************************************************************/
        ELSIF out_bank_cd = HANA_BANK_CD THEN
            SELECT RPAD( SUBSTR( TRUNC( ( SUBSTR( RTRIM( out_account_no ) , 1 , 12 )  +
                   DECODE( RTRIM(in_bank_cd) , '81',  SUBSTR( RTRIM( in_account_no ) , 1 , 12 ) , RTRIM( in_bank_cd ) ) +
                   RTRIM( trade_amt ) + TO_CHAR(SYSDATE, 'YYMMDD' ) ) / TO_NUMBER( RTRIM( etc_field1 ) , 999999 ) ) , -4, 4 ), 6, ' ' )
              INTO v_sign_no
              FROM DUAL;

        /**************************************************************************************/
        /* ��������� ���                                                                    */
        /**************************************************************************************/
        ELSIF out_bank_cd = KIUP_BANK_CD THEN
            -- STEP 1,2,3�ܰ� ������ ó���Ѵ�.
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
            -- STEP 4�ܰ� ����
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
    /*  1. ���ID    : get_batch_sign_no                                     */
    /*  2. ����̸�  : batch����ó����  �����ȣ�� ��ȯ�Ѵ�.                 */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - EDI���ϻ����� �̷�key�μ� ������ �ִ� edi_history_seq�� �Ѱܹ� */
    /*        �Ƽ�, �ش� �ڷḦ SELECT�Ͽ�, ���ະ �����ȣ ������Ģ�� ����  */
    /*        �����ȣ�� ������ ��, ��ȯ�Ѵ�. (MAX��: VARCHAR2 8�ڸ�)        */
    /*                                                                       */
    /*      - �������                                                       */
    /*         (1) ������� [03]                                             */
    /*         (2) �������� [04]                                             */
    /*         (3) �츮���� [20]                                             */
    /*         (4) �ϳ����� [81]                                             */
    /*                                                                       */
    /*      - �����ȣ ����� ���ü� üũ�� ���ؼ� EDI_HISTORY_SEQ�� �޾�    */
    /*        ����ڷḦ SELECT�Ͽ� �����ȣ�� �����ϸ�, OUT PARAMETER��     */
    /*        �ѰǼ�, �ѱݾ��� ��ȯ�ϹǷ�, �� �Լ��� ȣ���ϴ� �Լ�������     */
    /*        �� �Ǽ� �� �ݾ��� ��Ȯ���Ͽ� ó���մϴ�                        */    
    /*                                                                       */
    /*      - ����BATCH(�ϳ�����)�� ���, ǥ���ο� ���� ���޿�����       */
    /*        (YYYYMMDD)�� ���, T_FB_EDI_HISTORY�� ������(STD_YMD)�� ���   */
    /*                                                                       */
    /*      - ������ ���, ������� / ������ ���, 2������(�ϳ�,���) ���   */
    /*        �����ȣ�� �������� �����Ƿ�, ����ġ �ʽ��ϴ�.                 */        
    /*                                                                       */
    /*      - ��ȯ�� : �������� ���, ������� �����ȣ�� ��ȯ�Ǹ�,          */
    /*                 ������ �� ���� NULL���� ��ȯ�˴ϴ�.                 */    
    /*                                                                       */        
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��26��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
    FUNCTION  get_batch_sign_no(  edi_history_seq IN NUMBER ,                 -- EDI�̷��Ϸù�ȣ   
                                  total_cnt       OUT NUMBER ,                -- �����ȣ�� ������ ����ڷ��� �� �Ǽ� 
                                  total_sum       OUT NUMBER ,                -- �����ȣ�� ������ ����ڷ��� �� �ݾ� 
                                  etc_field1      IN VARCHAR2 DEFAULT NULL,   -- �����ʵ�1   
                                  etc_field2      IN VARCHAR2 DEFAULT NULL)   -- �����ʵ�2  
        RETURN VARCHAR2 IS
        
        v_sign_no          VARCHAR2(8) := NULL;      -- ��ȯ�� �����ȣ
        v_cash_bill_gubun  VARCHAR2(1);              -- ��������, ���ھ������� ����.
        v_comp_code        VARCHAR2(10);             -- ��ü�ڵ� 
        v_comp_password    VARCHAR2(50);             -- ��ü��ȣ 
        n_total_cnt        NUMBER      := 0;         -- ���� �����ȣ������ ���� �� ����  ==> Ȯ�ο� 
        n_total_sum        NUMBER      := 0;         -- ���� �����ȣ������ ���� �� �ݾ�  ==> Ȯ�ο� 
        out_bank_cd        VARCHAR2(2);              -- ��������ڵ� 
        
        v_temp_str1        VARCHAR2(100);            -- �ӽð��� ���ڿ� 1  
        v_temp_str2        VARCHAR2(100);            -- �ӽð��� ���ڿ� 2 
        n_temp_number1     NUMBER := 0;              -- �ӽð��� ���� 1  
        n_temp_number2     NUMBER := 0;              -- �ӽð��� ���� 2  
        
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
        
        ERR_VALUE_ERROR      EXCEPTION;        -- �����߻���
        
    BEGIN
    
       -- ���� EDI�̷����̺��� Ȯ���Ͽ�,  �ش� �ۼ��Ű��� ���ݰ�����, ���������� Ȯ���ϸ�,
       -- EDI history���̺� �ִ� ��������ڵ�,������ڵ� �� �����ͼ� ����մϴ�. 
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
              
       
       -- ������ ���...
       -----------------
       
       IF v_cash_bill_gubun = 'C' THEN
    
            /**************************************************************************************/               
            /* ���������� ���                                                                    */
            /**************************************************************************************/              
            IF out_bank_cd = KUKMIN_BANK_CD THEN  
    
                -- ��ü��ȣ�� �����ɴϴ�.
                BEGIN
                    SELECT COMP_PASSWORD
                      INTO v_comp_password
                      FROM T_FB_ORG_BANK
                     WHERE COMP_CODE = v_comp_code
                       AND BANK_MAIN_CODE = out_bank_cd;
                       
                    IF v_comp_password IS NULL OR v_comp_password = '' THEN
                        v_error_msg := '��ü��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.(��ü�ڵ�:'|| v_comp_code || ',�����ڵ�:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                    END IF;
                    
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        v_error_msg := '��ü��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.(��ü�ڵ�:'|| v_comp_code || ',�����ڵ�:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                END;                   
                   
                -- LOOPING�� ���鼭 ���¹�ȣ 10��° �� �� ����ü�Ǽ�,����ü�ݾ��� �����ɴϴ�.
                FOR rec IN cur_select LOOP
                    
                    -- ���¹�ȣ 10��° �ڸ��� BLANK�̰ų�, �Ա������� ��������(04)�̸鼭 ���±��̰� 12�ڸ� �̸��̸� 0 ó��
                    -- n_temp_number1 : �� ������ 10��° �ڸ��� ��.
                    -- n_temp_number2 : �� ������ 10��° �ڸ��� ���ڷ� ��ȯ�� ��.
                    IF ( LENGTH(TRIM(rec.ACCOUNT_NO)) < 10 ) OR 
                       ( SUBSTRB(TRIM(rec.ACCOUNT_NO) , 10 , 1 ) = ' ' ) OR
                       ( rec.IN_BANK_CODE = '04' AND LENGTH(TRIM(rec.ACCOUNT_NO)) < 12 ) THEN
                       
                        n_temp_number2 := 0;
                       
                    ELSE
                        n_temp_number2 := TO_NUMBER( SUBSTRB( TRIM(rec.ACCOUNT_NO) , 10 , 1 ) );
                    END IF;
                    
                    n_temp_number1 := n_temp_number1 + n_temp_number2;

                    -- üũ������ ��ü�Ǽ��� ��ü�ݾ��� ���մϴ�. (���������� ���, �ϴܿ��� ��꿡 Ȱ����) 
                    n_total_cnt := n_total_cnt + 1;
                    n_total_sum := n_total_sum + rec.PAY_AMT;                
                
                END LOOP;
                
                -- �����ȣ ������Ģ�� �ǰ��ؼ�, ������ �մϴ�.
                n_temp_number2 := ( n_temp_number1 + n_total_sum + n_total_cnt ) / ( n_total_cnt + TO_NUMBER( TRIM(v_comp_password) ) );
                  
                -- �Ҽ������ڸ��� ���� ��(Trunc�Լ� ���) , 10000�� ���ϰ�, �Ҽ����ϸ� �߶������ �����ȣ�� ���մϴ�.
                n_temp_number2 := TRUNC( ( n_temp_number2 - TRUNC( n_temp_number2 ) ) * 10000 );
                
                -- ���⺹���ȣ�� �ڸ����� ���� 4�ڸ� �̸��� ���, �����ʿ� '0'�� ���Դϴ�.
                v_sign_no := RPAD( TO_CHAR( n_temp_number2 ) , 4 , '0' );
                    
                     
                    
            /**************************************************************************************/               
            /* �츮������ ���                                                                    */
            /**************************************************************************************/        
            ELSIF out_bank_cd = WOORI_BANK_CD THEN    
                
                --  LOOPOMG�� ���鼭 , ������ ����Ÿ(�Աݰ��¹�ȣ,�Աݱݾ�)���� �����ȣ�� ����մϴ�.           
                FOR rec IN cur_select LOOP     

                    v_temp_str1 := TO_CHAR( rec.PAY_AMT );
                    
                    FOR i IN 1..LENGTH(rec.ACCOUNT_NO) LOOP
                        n_temp_number1 := n_temp_number1 + TO_NUMBER( SUBSTRB( rec.ACCOUNT_NO , i , 1 ) );                    
                    END LOOP;
                    
                    FOR i IN 1..LENGTH(v_temp_str1) LOOP
                        n_temp_number2 := n_temp_number2 + TO_NUMBER( SUBSTRB( v_temp_str1 , i , 1 ) );                    
                    END LOOP;
                
                    -- üũ������ ��ü�Ǽ��� ��ü�ݾ��� ���մϴ�.
                    n_total_cnt := n_total_cnt + 1;
                    n_total_sum := n_total_sum + rec.PAY_AMT;
                
                END LOOP;   

                v_sign_no := TO_CHAR( MOD( n_temp_number1 , n_temp_number2  ) ); 
                
                -- ����� �����ȣ�� 6���ڸ� �Ѿ�� ���, ���� 6�ڸ��� ���մϴ�. 
                IF LENGTHB(v_sign_no) > 6 THEN
                    v_sign_no := SUBSTRB( v_sign_no ,LENGTHB(v_sign_no) - 5 , 6 );
                ELSE
                    v_sign_no := LPAD( v_sign_no , 6 , '0' );
                END IF;

                                  
            /**************************************************************************************/          
            /* �ϳ������� ���                                                                    */
            /**************************************************************************************/        
            ELSIF out_bank_cd = HANA_BANK_CD THEN       
    
                -- ���޿������ʵ� ( T_FB_EDI_HISTORY�� STD_YMD�÷��� ����մϴ�. Ÿ �ʵ� ���� �����ʿ�) 
                SELECT SUBSTRB(STD_YMD,1,4)
                  INTO v_temp_str2
                  FROM T_FB_EDI_HISTORY
                 WHERE EDI_HISTORY_SEQ = edi_history_seq;
                   
                IF v_temp_str2 IS NULL OR v_temp_str2 = '' THEN
                    v_error_msg := 'T_FB_EDI_HISTORY�� ��������(STD_YMD)�� ���� �����ϴ�.';
                    RAISE ERR_VALUE_ERROR;
                END IF;
                    
                -- ��ü��ȣ�� �����ɴϴ�.
                BEGIN
                    SELECT SUBSTRB(COMP_PASSWORD,1,4)
                      INTO v_comp_password
                      FROM T_FB_ORG_BANK
                     WHERE COMP_CODE = v_comp_code
                       AND BANK_MAIN_CODE = out_bank_cd;
                       
                    IF v_comp_password IS NULL OR v_comp_password = '' THEN
                        v_error_msg := '��ü��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.(��ü�ڵ�:'|| v_comp_code || ',�����ڵ�:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                    END IF;
                    
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        v_error_msg := '��ü��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.(��ü�ڵ�:'|| v_comp_code || ',�����ڵ�:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                END;     
    
                -- LOOPING�� ���鼭 ���¹�ȣ 7��°������ �� �� ��ü�ݾ����� ����մϴ�.
                FOR rec IN cur_select LOOP      
                    
                    n_temp_number1 := 0;
                    
                    FOR each_byte IN 1..7 LOOP
                    
                        v_temp_str1 := SUBSTRB( rec.ACCOUNT_NO , each_byte , 1 );
                        
                        IF v_temp_str1 IS NOT NULL AND v_temp_str1 != '' THEN
                            n_temp_number1 := n_temp_number1 + TO_NUMBER( v_temp_str1 );
                        END IF;
                    
                    END LOOP;
                
                    n_temp_number2 := n_temp_number2 + TRUNC( ( n_temp_number1 * rec.PAY_AMT ) / 100 );
                
                    -- üũ������ ��ü�Ǽ��� ��ü�ݾ��� ���մϴ�. (�ϳ������� ���, �ϴܿ��� ��꿡 Ȱ����) 
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
            /* ��������� ���  ==> ������� �ʽ��ϴ�.                                            */
            /**************************************************************************************/              
            ELSIF out_bank_cd = KIUP_BANK_CD THEN     
            
                v_sign_no := '';          
    
            END IF;

            
        -- ���ھ����� ���.... 
        ----------------------
           
        ELSIF v_cash_bill_gubun = 'B' THEN    

            /**************************************************************************************/          
            /* �ϳ������� ��� ==> ���ġ �ʽ��ϴ�.                                               */
            /**************************************************************************************/        
            IF out_bank_cd = HANA_BANK_CD THEN        
    
                v_sign_no := '';         
            
    
            /**************************************************************************************/               
            /* ��������� ��� ==> ���ġ �ʽ��ϴ�.                                               */
            /**************************************************************************************/              
            ELSIF out_bank_cd = KIUP_BANK_CD THEN  
            
                v_sign_no := '';          
    
            END IF;
        
        
        END IF;
        
        -- OUT paramter�� �ѱ� �ѰǼ�, �ѱݾ��� �����մϴ�. 
        total_cnt := n_total_cnt;
        total_sum := n_total_sum;
            
        RETURN( v_sign_no);
        
    EXCEPTION
    
        WHEN ERR_VALUE_ERROR THEN
            fbs_util_pkg.write_log('FBS','[get_bank_sign_no] '|| v_error_msg );        
            RETURN( NULL );
    
        WHEN OTHERS THEN
            fbs_util_pkg.write_log('FBS','[get_bank_sign_no] SQL OTHER �����߻�' || sqlerrm );
            RETURN( NULL );
        
    END get_batch_sign_no;

    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : get_object_status                                     */
    /*  2. ����̸�  : �ش� OBJECT�� ���� ��ȯ                               */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - OBJECT TYPE : PACKAGE / TIGGER / PROCEDURE /FUNCTION ��        */
    /*                                                                       */
    /*      - OBJECT TYPE �� OBJECT NAME�� �Է¹޾� VALID����, INVALID����   */
    /*        ��ȯ�ϴ� �����Լ�                                              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    FUNCTION get_object_status( p_object_type VARCHAR2 ,         -- OBJECT TYPE
                                p_object_name VARCHAR2           -- OBJECT NAME
                              ) RETURN VARCHAR2 IS               -- ���� : VALID / INVALILD
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
    /*  1. ���ID    : send_file_to_VAN                                      */
    /*  2. ����̸�  : ������ batch file�� VAN��� �۽��մϴ�.               */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ����/����� �� ���� ���丮�� ã�Ƽ� , �ش� ������ VAN���    */
    /*        �۽��� ��, ó����� �޽����� ��ȯ�Ѵ�.                         */
    /*                                                                       */
    /*      - ���������� �۽Ž�, ������ڵ�/�����ڵ带 �����Ͽ� ����ó��     */
    /*        Ȯ�� ��, �۽��� ó���Ѵ�. ó������� ������ ���Ϸ� LOGGING��   */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    FUNCTION send_file_to_VAN(  p_file_name   IN VARCHAR2 ,                -- ������ ���ϸ�
                                p_gubun       IN VARCHAR2 ,                -- ���۵���Ÿ���� (C:����,B:���ھ���)
                                p_comp_code   IN VARCHAR2 ,                -- ����� �ڵ�
                                p_bank_code   IN VARCHAR2 )                -- ���� �ڵ�
        RETURN VARCHAR2 IS                                                 -- �۽Ű�� ó�� �޽���
    BEGIN
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<
    	return	f_send_file_to_van(p_file_name   ,                -- ������ ���ϸ�
                           p_gubun       ,                -- ���۵���Ÿ���� (C:����,B:���ھ���)
                           p_comp_code   ,                -- ����� �ڵ�
                           p_bank_code   );               -- ���� �ڵ�
    END send_file_to_VAN;

    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : receive_file_from_VAN                                 */
    /*  2. ����̸�  : VAN�翡�� data�� �޾� file�� �����մϴ�.              */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ������ڵ�/�����ڵ�/���۵���Ÿ���� �� �Ǵ��ؼ�  VAN�翡�� �ڷ� */
    /*        �� ���� ����, ������ ���丮�� �Էµ� ���ϸ����� �����Ѵ�.    */
    /*        ó������� ������ �޽����� ��ȯ�ȴ�.                           */
    /*                                                                       */
    /*      - ó������� ������ ���Ϸ� LOGGING��                             */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    FUNCTION receive_file_from_VAN( p_file_name   IN VARCHAR2 ,                -- ������ ���ϸ�
                                    p_gubun       IN VARCHAR2 ,                -- ���۵���Ÿ���� (C:����,B:���ھ���)
                                    p_comp_code   IN VARCHAR2 ,                -- ����� �ڵ�
                                    p_bank_code   IN VARCHAR2 )                -- ���� �ڵ�
        RETURN VARCHAR2 IS
    BEGIN
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<
		return		f_recieve_file_from_van(p_file_name    ,           -- ������ ���ϸ�
                                p_gubun        ,           -- ���۵���Ÿ���� (C:����,B:���ھ���,V:���ھ������¾�ü)
                                p_comp_code    ,           -- ����� �ڵ�
                                p_bank_code    );           -- ���� �ڵ�
    END receive_file_from_VAN;

    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : get_edi_file_name                                     */
    /*  2. ����̸�  : EDI�ۼ����� ���� ���ϸ��� ��ȯ�մϴ�                  */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ������ڵ�/�����ڵ�/���۵���Ÿ���� �� �Ǵ��ؼ�  VAN��� �ۼ��� */
    /*        �� ���ϸ��� ���ؼ� ��ȯ�մϴ�                                  */
    /*        ��ȯ�ÿ��� ���ϸ� �ܿ� ������ġ ��α��� �����Ͽ� ��ȯ�Ѵ�.    */
    /*                                                                       */
    /*      - �����ڵ�                                                       */
    /*          CS ( Cash Send ) : ���� �۽� ���ϸ�                          */
    /*          CR ( Cash Receive ) : ���� ���� ���ϸ�                       */
    /*          BS ( Bill Send ) : ���ھ��� �۽� ���ϸ�                      */
    /*          BR ( Bill Receive ) : ���ھ��� ���� ���ϸ�                   */
    /*          VR ( Vendor Receive ) : ���ھ��� �ŷ������� ���� ���ϸ�      */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��20��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    FUNCTION get_edi_file_name( p_comp_code   IN VARCHAR2 ,                -- ����� �ڵ�
                                p_bank_code   IN VARCHAR2 ,                -- ���� �ڵ�
                                p_gubun       IN VARCHAR2 )                -- ���۵���Ÿ����
        RETURN VARCHAR2 IS                                                 -- �����̸� ��ȯ
    BEGIN
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<
		return		f_get_edi_file_name( p_comp_code   ,      -- ȸ���ڵ�
                             p_bank_code   ,      -- �����ڵ�
                             p_gubun       );     -- ����

    END get_edi_file_name;

    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : exec_os_command                                       */
    /*  2. ����̸�  : OS���� ��ɾ �����մϴ�.                           */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - JAVA �� ����Ͽ�, WINDOWS�� CMD�� ����Ͽ�, OS���� ��ɾ    */
    /*        PARAMETER�� �޾�, �����ŵ�ϴ�.                                */
    /*                                                                       */
    /*      - JAVA CLASS FUNCTION�� �Ʒ��� ���� ��ɾ�� �����Ͽ�����,       */
    /*        �������� ���� CLASS������ FBS���� ������ javaclass�W���� ����  */
    /*                                                                       */
    /*        (1) create directory fbs_javaclass as 'c:\FBS\javaclass';      */
    /*        (2) create java class using BFILE(fbs_javaclass,'ExecCommand.class'); */
    /*        (3) 	CREATE or REPLACE FUNCTION                               */
  	/*              exec_command (str IN varchar2) RETURN varchar2           */
  	/*              as language java                                         */
  	/*              name 'ExecCommand.exec(java.lang.String)                 */
    /*              return java.lang.String';                                */
    /*                                                                       */
    /*      - �� java�� �����ϱ� ���ؼ��� permmission�� �־�� �ϹǷ�,       */
    /*        �ϴ��� ��ɾ ����ؼ�, grant�Ͽ��� ���������� ������        */
    /*    begin                                                                                                     */
    /*       dbms_java.grant_permission( 'ERPW', 'SYS:java.io.FilePermission', '<<ALL FILES>>', 'execute' ) ;       */
    /*       dbms_java.grant_permission( 'ERPW', 'SYS:java.lang.RuntimePermission', 'writeFileDescriptor', '' );    */
    /*       dbms_java.grant_permission( 'ERPW', 'SYS:java.lang.RuntimePermission', 'readFileDescriptor', '' );     */
    /*    end;                                                                                                      */
    /*                                                                       */
    /*      - �������� write_log�Լ��� �̿��ؼ� ���Ͽ� log�� �ϸ�, ������  */
    /*        �� ���, "command => OS��� ����ó��"��� �αװ� �Ǹ�, ������  */
    /*        �� ����, Java�� ����dump�� ���Ϸα׵˴ϴ�.                   */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          ERROR : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)                   */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��28��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    FUNCTION exec_os_command( p_string IN VARCHAR2 )     -- �����ų ��ɾ�
        RETURN VARCHAR2 IS                               -- ó����� : OK Ȥ�� ERROR
       return_value VARCHAR2(100);
    BEGIN
        -- String���� ���� OS��ɾ �����ŵ�ϴ�. JAVA Class�� Ȱ��
        return_value := exec_command( p_string ) ;
        -- ó������� ���� OK Ȥ�� ERROR�� ��ȯ�ϸ�, ������ ���Ϸ� �α׸� �����.
        IF return_value = SUCCESS_CODE THEN
            write_log('FBS','OS COMMAND EXEC = ['|| p_string || '] ==> ����ó���Ϸ�' );
        ELSE
            write_log('FBS','OS COMMAND EXEC = ['|| p_string || '] ==> ERROR�߻� ' || CRLF || return_value );
            return_value := 'ERROR';
        END IF;
        RETURN(return_value);
    END exec_os_command;


    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : do_pwd_job                                            */
    /*  2. ����̸�  : ��ȣ���/����/Ȯ�ε��� ����� �����ϴ� ���� �Լ�      */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �����ȣ���/��ü/���������ȣ���,���� �� ���� ��ü Ȥ�� ���� */
    /*        �����, ��ȣ�� ���� Ȯ���۾��� �����ϴ� ���� �Լ���            */
    /*                                                                       */
    /*      - ��ȣ�� ����, ��Ÿ�ڵ����̺�(T_FB_LOOKUP_VALUES)�� ��� ���  */
    /*        �ϸ�, LOOKUP_TYPE="FBS_PASSWORD'��� �������� �ϰ�,            */
    /*        LOOKUP_VALUES�� ������� �ϵ�, LOOKUP_VALUE�� ���庻���� ��ȣ  */
    /*        ATTRIBUTE1�� �ǽð���ü��ȣ , ATTRIBUTE2�� ���ھ��� ��ȣ��     */
    /*        ��� ����Ѵ�.                                                 */
    /*        CJ����,NB������ �и��Ǿ� �����Ƿ�, ������ ���(����)�������   */
    /*        ���е� ü�踦 �д�.                                            */
    /*                                                                       */
    /*      - �� ������ ��Ÿ�ڵ带 �����ϴ� ȭ�鿡���� ������ ������ ������  */
    /*        �ý��� ���������θ� �����˴ϴ�.                                */
    /*                                                                       */
    /*      - �۾������ڵ�                                                   */
    /*          CHG_MNG_PW : �����ȣ ���/���� =>�����ȣ����� ���õ�      */
    /*                       ��ü/����� ���õ� ��� ��ȣ�� �ϰ�UPDATE�Ѵ�   */
    /*                       PARAMETER�� p_password1 �� �ű������ȣ�� ,     */
    /*                       p_password2�� ���������ȣ�� �Է¹޾� ����Ѵ�. */
    /*                                                                       */
    /*          CHG_CASH_PW : ������ü ��ȣ�� �����մϴ�.                    */
    /*                        p_password1�� �����ȣ, p_password2�� ��ü��ȣ */
    /*                                                                       */
    /*          CHG_BILL_PW : ���ھ��� ��ȣ�� �����մϴ�.                    */
    /*                        p_password1�� �����ȣ, p_password2�� ������ȣ */
    /*                                                                       */
    /*          CHK_MNG_PW  : �����ȣ�� Ȯ���մϴ�.                         */
    /*                        p_password1�� �����ȣ�� �Է¹޾� Ȯ����       */
    /*                                                                       */
    /*          CHK_CASH_PW : ������ü���޽� ��ȣ�� Ȯ���մϴ�.              */
    /*                        p_password1�� �����ȣ, p_password2�� ��ü��ȣ */
    /*                                                                       */
    /*          CHK_BILL_PW : ���ھ��� ����� ��ȣ�� Ȯ���մϴ�.             */
    /*                        p_password1�� �����ȣ, p_password2�� ������ȣ */
    /*                                                                       */
    /*          CHG_ACCT_PW : ���¿� ���� ��ü��ȣ�� �����Ѵ�.               */
    /*                       p_emp_no�� ��� , p_password1�� ���¹�ȣ        */
    /*                       p_password2�� ��ü��ȣ�Ͽ� ó���Ѵ�.            */
    /*                                                                       */
    /*          RET_ACCT_PW : ���¿� ���� ��ü��ȣ�� ��ȸ�Ѵ�.               */
    /*                       p_emp_no�� ��� , p_password1�� ���¹�ȣ�� �Ѵ� */
    /*                       NULL���� ��ȯ�Ǹ�, �ش� ��ȣ�� ���ų� �����̸�  */
    /*                       �������� ���, �ش� ������ ��ü��ȣ�� ��ȯ      */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��  or ��ȣ�� �´� ������ Ȯ�ε� ���.        */
    /*          �����޽��� : ��Ÿ ���� �߻���                                */
    /*          ���¾�ȣ : RET_ACCT_PW�� ȣ��Ǿ� ������ ���,������ NULL    */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��28��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    FUNCTION do_pwd_job( p_gubun_code   IN VARCHAR2 ,                -- �۾������ڵ�
                         p_emp_no       IN VARCHAR2 ,                -- ��� / ���¹�ȣ
                         p_password1    IN VARCHAR2 ,                -- ��ȣ���ڿ� 1
                         p_password2    IN VARCHAR2 DEFAULT NULL)    -- ��ȣ���ڿ� 2
        RETURN VARCHAR2 IS                                           -- �Լ�ó�����
        v_return_msg            VARCHAR2(200);                -- ��ȯ�� OR ��ȯ�޽���
        rec_lookup_values       T_FB_LOOKUP_VALUES%ROWTYPE;
        rec_new_lookup_values   T_FB_LOOKUP_VALUES%ROWTYPE;
        rec_accounts_pwd        T_FB_ACCOUNTS_PWD%ROWTYPE;
        v_record_exist_yn       VARCHAR2(1) := 'N';
        v_gubun_code            VARCHAR2(20);
        ERR_NO_GUBUN_CODE       EXCEPTION;   -- �����ڵ尡 �Էµ��� �ʾ�����...
        ERR_INVALID_GUBUN_CODE  EXCEPTION;   -- �����ڵ尡 �߸� �Էµ� ���...
        ERR_NO_EMP_NO           EXCEPTION;   -- ����� �Էµ��� �ʾ�����...
        ERR_NO_PASSWORD         EXCEPTION;   -- ��ȣ���ڿ�1�� �Էµ��� �ʾ�����..(��ȣ���ڿ�1�� �ʼ�,2�� �ɼ�)
        ERR_NOT_MATCH_MNG_PW    EXCEPTION;   -- �����ȣ�� ���� ������...
        ls_OldPwd				Varchar2(1000);
    BEGIN
        v_gubun_code := UPPER(p_gubun_code);
        rec_lookup_values.lookup_type := 'FBS_PASSWORD';
        rec_new_lookup_values.lookup_type := 'FBS_PASSWORD';
        -- �Է�PARAMETER�� �Է¿��� Ȯ��
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
        -- ������ record�� �ִ��� Ȯ���ؼ�, v_record_exist_yn ���� �� RECORD������ ���� ���
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

        -- 1) �����ȣ�� �����ϴ�, "CHG_MNG_PW'�� ���...
        -------------------------------------------------
        IF v_gubun_code = 'CHG_MNG_PW' THEN
            BEGIN
                IF v_record_exist_yn = 'Y' THEN
                    -- ���� �����ȣ�� Ȯ���մϴ�.
                    If p_password2 Is Null Then
                    	Raise_Application_Error(-20009,'���� ��ȣ�� �Է��Ͽ� �ֽʽÿ�.');
                    End If;
                    IF p_password2 Is Not Null And pw_decode(rec_lookup_values.lookup_value,4,p_password2) <> SubStrb(p_password2,1,4) THEN
                        RAISE ERR_NOT_MATCH_MNG_PW;
                    ELSE
                        -- ������ ��ϵ� ���� �ִ� ���...
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
                -- ������ ��ϵ� ���� ���� ���...
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
                                                    'FBS��ȣ����['||p_emp_no||']',
                                                    SYSDATE ,
                                                    p_emp_no ,
                                                    SYSDATE ,
                                                    p_emp_no ,
                                                    pw_encode( p_password1 , p_password1 ) ,  -- �ʱ���ü��ȣ�� �����ȣ�� ����
                                                    pw_encode( p_password1 , p_password1 ) ); -- �ʱ�����ȣ�� �����ȣ�� ����

                END IF;
                -- ����ó���� ���, commit�ϸ�, OK���ڿ� ��ȯ
                COMMIT;
                write_log('FBS','�����ȣ[���:'||p_emp_no||']�� �����Ͽ����ϴ�.');
                v_return_msg := SUCCESS_CODE;
            EXCEPTION
                WHEN ERR_NOT_MATCH_MNG_PW THEN
                    v_return_msg := '�����ȣ�� ���� �ʽ��ϴ�.\n�ٽ� �Է��Ͽ� �ּ���.';
                WHEN OTHERS THEN
                    v_return_msg := '[fbs_util_pkg.do_pwd_job �����ȣ���� �������]\n'||format_msg( sqlerrm );
            END;

        -- 2) ������ü ��ȣ�� �����ϴ� 'CHG_CASH_PW'�� ���...
        ------------------------------------------------------
        ELSIF v_gubun_code = 'CHG_CASH_PW' THEN
            BEGIN
                IF v_record_exist_yn = 'Y' THEN
                    -- ���� �����ȣ�� Ȯ���մϴ�.
                    If p_password1 Is Null Then
                    	Raise_Application_Error(-20009,'���� ��ȣ�� �Է��Ͽ� �ֽʽÿ�.');
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
                        -- ����ó���� ���, commit�ϸ�, OK���ڿ� ��ȯ
                        write_log('FBS','������ü��ȣ�� �����Ͽ����ϴ�.[���:'||p_emp_no||']');
                        COMMIT;
                        v_return_msg := SUCCESS_CODE;
                    END IF;
                ELSE
                    v_return_msg := '�����ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.\n���� �����ȣ�� �Է��ϼ���.';
                END IF;
            EXCEPTION
                WHEN ERR_NOT_MATCH_MNG_PW THEN
                    v_return_msg := '�����ȣ�� ���� �ʽ��ϴ�.\n�ٽ� �Է��Ͽ� �ּ���.';
                WHEN OTHERS THEN
                    v_return_msg := '[fbs_util_pkg.do_pwd_job ������ü��ȣ���� �������]\n'||format_msg( sqlerrm );
            END;

        -- 3) ���ھ��� ��ȣ�� �����ϴ� , 'CHG_BILL_PW'�� ���...
        --------------------------------------------------------
        ELSIF v_gubun_code = 'CHG_BILL_PW' THEN
            BEGIN
                IF v_record_exist_yn = 'Y' THEN
                    -- ���� �����ȣ�� Ȯ���մϴ�.
                    If p_password1 Is Null Then
                    	Raise_Application_Error(-20009,'���� ��ȣ�� �Է��Ͽ� �ֽʽÿ�.');
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
                        -- ����ó���� ���, commit�ϸ�, OK���ڿ� ��ȯ
                        write_log('FBS','���ھ�����ȣ�� �����Ͽ����ϴ�.[���:'||p_emp_no||']');
                        COMMIT;
                        v_return_msg := SUCCESS_CODE;
                    END IF;
                ELSE
                    v_return_msg := '�����ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.\n���� �����ȣ�� �Է��ϼ���.';
                END IF;
            EXCEPTION
                WHEN ERR_NOT_MATCH_MNG_PW THEN
                    v_return_msg := '�����ȣ�� ���� �ʽ��ϴ�.\n�ٽ� �Է��Ͽ� �ּ���.';
                WHEN OTHERS THEN
                    v_return_msg := '[fbs_util_pkg.do_pwd_job ���ھ��� ��ȣ���� �������]\n'||format_msg( sqlerrm );
            END;

        -- 4) �����ȣ Ȯ���ϴ� ���, "CHK_MNG_PW' �� ���...
        -----------------------------------------------------
        ELSIF v_gubun_code = 'CHK_MNG_PW' THEN
            IF v_record_exist_yn = 'Y' THEN
                If p_password1 Is Null Then
                	Raise_Application_Error(-20009,'���� ��ȣ�� �Է��Ͽ� �ֽʽÿ�.');
                End If;
                IF pw_decode( rec_lookup_values.lookup_value , 4 ) <> SubStrb(p_password1,1,4) THEN
                    v_return_msg := '��ȣ�� Ʋ�Ƚ��ϴ�. \nȮ�� ��, �ٽ� �Է��Ͽ� �ּ���.';
                ELSE
                    v_return_msg := SUCCESS_CODE;
                END IF;
            ELSE
                v_return_msg := '�����ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.\n���� �����ȣ�� �Է��ϼ���.';
            END IF;

        -- 5) ������ü�� ��ȣ���󿩺θ� Ȯ���ϴ�, 'CHK_CASH_PW' �� ���...
        ------------------------------------------------------------------
        ELSIF v_gubun_code = 'CHK_CASH_PW' THEN
            IF v_record_exist_yn = 'Y' THEN
                If p_password1 Is Null Then
                	Raise_Application_Error(-20009,'���� ��ȣ�� �Է��Ͽ� �ֽʽÿ�.');
                End If;
                IF pw_decode( rec_lookup_values.lookup_value , 4 ) <> SubStrb(p_password1,1,4) THEN
                     v_return_msg := '�����ȣ�� Ʋ�Ƚ��ϴ�.\nȮ�� ��, �ٽ� �Է��Ͽ� �ּ���.';
                ELSIF pw_decode(rec_lookup_values.attribute1,4 ) <> p_password2 THEN
                    v_return_msg := '��ü��ȣ�� Ʋ�Ƚ��ϴ�.\nȮ�� ��, �ٽ� �Է��Ͽ� �ּ���.';
                ELSE
                    v_return_msg := SUCCESS_CODE;
                END IF;
            ELSE
                v_return_msg := '��ü��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.\n���� �����ȣ�� �Է��ϼ���.';
            END IF;

        -- 6) ���ھ��� �߻���, ��ȣ���󿩺θ� Ȯ���ϴ�, 'CHK_BILL_PW' �� ���...
        ------------------------------------------------------------------------
        ELSIF v_gubun_code = 'CHK_BILL_PW' THEN
            IF v_record_exist_yn = 'Y' THEN
                If p_password1 Is Null Then
                	Raise_Application_Error(-20009,'���� ��ȣ�� �Է��Ͽ� �ֽʽÿ�.');
                End If;
                IF pw_decode( rec_lookup_values.lookup_value , 4 ) <> SubStrb(p_password1,1,4) THEN
                     v_return_msg := '�����ȣ�� Ʋ�Ƚ��ϴ�.\nȮ�� ��, �ٽ� �Է��Ͽ� �ּ���.';
                ELSIF pw_decode(rec_lookup_values.attribute2,4 ) <> p_password2 THEN
                    v_return_msg := '���ھ�����ȣ�� Ʋ�Ƚ��ϴ�.\nȮ�� ��, �ٽ� �Է��Ͽ� �ּ���.';
                ELSE
                    v_return_msg := SUCCESS_CODE;
                END IF;
            ELSE
                v_return_msg := '���ھ��� ��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.\n���� �����ȣ�� �Է��ϼ���.';
            END IF;

        -- 7) ���¾�ȣ�� �����ϴ� , 'CHG_ACCT_PW'�� ���...
        ---------------------------------------------------
        ELSIF v_gubun_code = 'CHG_ACCT_PW' THEN
            -- ������ ��ϵ� ���� �ִ��� Ȯ���մϴ�.
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
            -- �⺻���� ������ �����մϴ�.
            rec_accounts_pwd.change_ymd := TO_CHAR(SYSDATE,'YYYYMMDD');
            rec_accounts_pwd.last_modify_date := SYSDATE;
            rec_accounts_pwd.last_modify_emp_no := TRIM(p_emp_no);
            -- �ű�/���ſ��θ� Ȯ���Ͽ� ó���Ѵ�.
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
                -- ����ó���� ���, commit�ϸ�, OK���ڿ� ��ȯ
                write_log('FBS','���������� ���¾�ȣ�� �����Ͽ����ϴ�.[���¹�ȣ:'||p_password1||']');
                COMMIT;
                v_return_msg := SUCCESS_CODE;
            EXCEPTION
                WHEN OTHERS THEN
                    v_return_msg := '[fbs_util_pkg.do_pwd_job ���¾�ȣ ��ȣ���� �������]\n'||format_msg( sqlerrm );
            END;


        -- 8) ���¾�ȣ�� ��ȸ�ϴ� 'RET_ACCT_PW'�� ���...
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
            -- �����ڵ尡 �߸� �Էµ� ���...
            RAISE ERR_INVALID_GUBUN_CODE;
        END IF;
        RETURN( v_return_msg );

    EXCEPTION
        WHEN ERR_NO_GUBUN_CODE THEN
            RETURN( '[do_pwd_job] �����ڵ尡 �Էµ��� �ʾҽ��ϴ�.\n����ǿ� �����Ͽ��ֽʽÿ�.');
        WHEN ERR_INVALID_GUBUN_CODE THEN
            RETURN( '[do_pwd_job] �����ڵ尡 �߸� �ԷµǾ����ϴ�.\n����ǿ� �����Ͽ��ֽʽÿ�.');
        WHEN ERR_NO_EMP_NO THEN
            RETURN( '[do_pwd_job] ����� �Էµ��� �ʾҽ��ϴ�.\n����ǿ� �����Ͽ��ֽʽÿ�.');
        WHEN ERR_NO_PASSWORD THEN
            RETURN( '[do_pwd_job] ��ȣ�� �Էµ��� �ʾҽ��ϴ�.\n����ǿ� �����Ͽ��ֽʽÿ�.');
        WHEN OTHERS THEN
            RETURN( format_msg(SQLERRM) );
    END do_pwd_job;

END FBS_UTIL_PKG;
/
