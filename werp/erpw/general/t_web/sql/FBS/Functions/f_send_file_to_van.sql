    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : f_send_file_to_van                                    */
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
		CREATE OR REPLACE 
    FUNCTION f_send_file_to_van(p_file_name   IN VARCHAR2 ,                -- ������ ���ϸ�
                                p_gubun       IN VARCHAR2 ,                -- ���۵���Ÿ���� (C:����,B:���ھ���)
                                p_comp_code   IN VARCHAR2 ,                -- ����� �ڵ�
                                p_bank_code   IN VARCHAR2 )                -- ���� �ڵ�
        RETURN VARCHAR2 IS                                                 -- �۽Ű�� ó�� �޽���
    
        v_send_file             UTL_FILE.FILE_TYPE;                        -- �۽��� ������ ������ �˻��� FILE HANDLER 
        v_command               VARCHAR2(400);                             -- PARAMETER�� ���� ���ڿ� 
        v_dummy_return		      VARCHAR2(100):= 'OK';                      -- 'OK'/'ERROR'
        v_send_dir_name         VARCHAR2(100); 
        v_send_dir              VARCHAR2(100); 
        v_subject_name          VARCHAR2(100);
        v_filename              VARCHAR2(100);
        FBS_CASH_SEND_DIR       VARCHAR2(100) := FBS_UTIL_PKG.FBS_CASH_SEND_DIR; -- ������ü
        FBS_BILL_SEND_DIR       VARCHAR2(100) := FBS_UTIL_PKG.FBS_BILL_SEND_DIR; -- ���ھ���       

				rec_org_bank            T_FB_ORG_BANK%ROWTYPE;                     -- �����ڵ带 ������ RECORD����
				
				-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	                
    BEGIN
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<
        IF p_gubun = 'C' THEN
           v_send_dir_name := FBS_CASH_SEND_DIR ;
        ELSIF p_gubun = 'B' THEN
           v_send_dir_name := FBS_BILL_SEND_DIR ; 
				END IF; 
           
        -- �������� OS���� directory�� �����ɴϴ�.(from DBA_DIRECTORIES )
        SELECT DIRECTORY_PATH || '/'            
        INTO v_send_dir
        FROM DBA_DIRECTORIES
        WHERE DIRECTORY_NAME = v_send_dir_name ;
        
        -- ��ϵ� SUBJECT NAME�� �����ɴϴ�.
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
				
        -- ���Ϲڽ� �۽��� BATCH�����̸� ���� 
        v_filename := p_file_name;        
                
        -- �ش� ������ ������ �˻��Ͽ�, ������ ���� ���, �����α׸� �����.
        BEGIN
            v_send_file := UTL_FILE.FOPEN( v_send_dir_name , v_filename, 'r');
            UTL_FILE.FCLOSE( v_send_file );
        EXCEPTION
            WHEN UTL_FILE.INVALID_OPERATION OR UTL_FILE.INVALID_FILEHANDLE THEN
	            	  fbs_util_pkg.write_log('FBS','[INFO] ' ||v_send_dir_name||'\'||v_filename||'�� �������� �ʽ��ϴ�.'); 
	                RAISE Err ;
        END;

        BEGIN                   
            -- COMMAND���ڿ��� EFT���α׷��� CALL�� COMMAND�� �����մϴ�.             
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
             fbs_util_pkg.write_log('FBS','[ERROR] ������ �������� �ʽ��ϴ�.');
             RETURN('ERROR');
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] ���ϼ۽Ž� ������ �߻��Ͽ����ϴ�.');
             RETURN('ERROR');                 
    END ;