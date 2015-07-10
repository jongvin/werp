    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : f_recieve_file_from_van                               */
    /*  2. ����̸�  : AN�翡�� data�� �޾� file�� �����մϴ�.               */
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
		CREATE OR REPLACE 
    FUNCTION f_recieve_file_from_van(p_file_name   IN VARCHAR2 ,           -- ������ ���ϸ�
                                p_gubun       IN VARCHAR2 ,                -- ���۵���Ÿ���� (C:����,B:���ھ���,V:���ھ������¾�ü)
                                p_comp_code   IN VARCHAR2 ,                -- ����� �ڵ�
                                p_bank_code   IN VARCHAR2 )                -- ���� �ڵ�
        RETURN VARCHAR2 IS                                                 -- �۽Ű�� ó�� �޽���

        v_command               VARCHAR2(400);                             -- PARAMETER�� ���� ���ڿ� 
        v_dummy_return		      VARCHAR2(100):= 'OK';                      -- 'OK'/'ERROR'
        v_recv_dir_name         VARCHAR2(100); 
        v_recv_dir              VARCHAR2(100); 
        v_subject_name          VARCHAR2(100);
        v_filename              VARCHAR2(100);
        FBS_CASH_RECV_DIR       VARCHAR2(100) := FBS_UTIL_PKG.FBS_CASH_RECV_DIR; -- ������ü
        FBS_BILL_RECV_DIR       VARCHAR2(100) := FBS_UTIL_PKG.FBS_BILL_RECV_DIR; -- ���ھ���
		    EDI_SEND_PRG            VARCHAR2(100) := 'tcpsend ';               -- EDI batch �۽� EFT���α׷� 
		    EDI_RECV_PRG            VARCHAR2(100) := 'tcprecv ';               -- EDI batch ���� EFT���α׷� 

				rec_org_bank            T_FB_ORG_BANK%ROWTYPE;                     -- �����ڵ带 ������ RECORD����
				
				-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	                
    BEGIN
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<
        IF p_gubun = 'C' THEN
           v_recv_dir_name := FBS_CASH_RECV_DIR ;
        ELSIF p_gubun = 'B' THEN
           v_recv_dir_name := FBS_BILL_RECV_DIR ; 
        ELSIF p_gubun = 'V' THEN
           v_recv_dir_name := FBS_BILL_RECV_DIR ;            
				END IF; 
           
        -- �������� OS���� directory�� �����ɴϴ�.(from DBA_DIRECTORIES )
        SELECT DIRECTORY_PATH || '/'            
        INTO v_recv_dir
        FROM DBA_DIRECTORIES
        WHERE DIRECTORY_NAME = v_recv_dir_name ;

        -- ��ϵ� SUBJECT NAME�� �����ɴϴ�.
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
				
        -- ���Ϲڽ� ������ BATCH�����̸� ���� 
        v_filename := p_file_name;        

        BEGIN                   
            -- COMMAND���ڿ��� EFT���α׷��� CALL�� COMMAND�� �����մϴ�.             
            v_command := 'tcprecv' || ' -o:' || rec_org_bank.bank_edi_login_id ||
                                      ' -b:A'||
                                      ' -t:' || v_subject_name || 
                                      ' -p:ITCP/IP' ||
                                      ' -F:' || v_recv_dir || v_filename ;

            v_dummy_return := fbs_util_pkg.exec_os_command( v_command );
            
        END;

        IF v_dummy_return = 'OK' THEN
            fbs_util_pkg.write_log('FBS','[INFO] ���ϼ����� ���������� �Ϸ�Ǿ����ϴ�.'||v_dummy_return ); 
        ELSE
            fbs_util_pkg.write_log('FBS','[ERROR] ���ϼ��Ž� ������ �߻��Ͽ����ϴ�.'||v_dummy_return );
        END IF;
        
        ---------------------------------------------------
        -- ���ŵ� ������ ����� 0 �� ������ ����ó���Ѵ�.
        ---------------------------------------------------
        --v_command := 'delete_zero_file.sh ' || v_recv_dir || v_filename;

        --v_dummy_return := fbs_util_pkg.exec_os_command( v_command );

        RETURN( v_dummy_return );
        
    EXCEPTION

        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] ���ϼ��Ž� ������ �߻��Ͽ����ϴ�.'||v_dummy_return);
             RETURN('ERROR');                 
    END ;