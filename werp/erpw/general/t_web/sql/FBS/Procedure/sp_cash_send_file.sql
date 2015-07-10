    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : cash_send_file                                        */
    /*  2. ����̸�  : ������ü Batch���� �۽�                               */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - WORLD DB �������� EFT�ý������� BATCH������ �۽��մϴ�.        */
    /*                                                                       */
    /*      - ����� : tcpsend                                             */
    /*      - DIRECTORY : FBS_REALTIME_SEND_DIR                              */
    /*      - ����TABLE => �ϱ�table�� state�� �������ڸ� update�Ѵ�.        */
    /*                                                                       */
    /*      - SUBJECT NAME                                                   */
    /*         (1) BATCH�۽� : S + [�ŷ�ó��ȣ]                              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��2��3��                                          */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
    CREATE OR REPLACE Procedure
    				sp_cash_send_file ( p_file_name   IN VARCHAR2 ,                -- ������ ���ϸ�
                                p_gubun       IN VARCHAR2 ,                -- ���۵���Ÿ���� (C:����,B:���ھ���)
                                p_comp_code   IN VARCHAR2 ,                -- ����� �ڵ�
                                p_bank_code   IN VARCHAR2 ,                -- �����ڵ�
                                p_edi_seq     IN VARCHAR2 ,                -- edi�̷��Ϸù�ȣ
                                p_std_ymd     IN VARCHAR2 )  IS            -- edi��������
                                  
        v_send_file                  UTL_FILE.FILE_TYPE;        -- �۽��� ������ ������ �˻��� FILE HANDLER                                    
        rec_org_bank            		 T_FB_ORG_BANK%ROWTYPE;     -- �����ڵ带 ������ RECORD����
        
        v_filename                   VARCHAR2(100);             -- ���ϸ�                               
        v_recv_desc                  VARCHAR2(100);             -- ȸ��/����� (EAP_LOOKUP_VALUES�� DESCRIPTION���� '��ü�ڵ�'�ܾ ������ ���ڿ�)
        v_result                     VARCHAR2(100);             -- EFT���α׷� ȣ�� ����� 
        v_command                    VARCHAR2(400);             -- EFT PROGRAM�� ȣ���� ���α׷���� PARAMETER�� ���� ���ڿ�
        v_success_yn                 VARCHAR2(1):='Y';          -- �۽�/UPDATE��������
        v_gubun                      VARCHAR2(100):= 'C';
        
        -- ���� DIRECTORY (����Ŭ ���� DIRECTORY �� CREATE�Ǿ� ���� ) 
        v_cash_send_dir              VARCHAR2(200);             -- BATCH �۽� DIRECTORY           
        v_dummy_return		           VARCHAR2(100);
        DEFAULT_TIMEOUT              NUMBER(10)   := 60;
        v_send_seq_no                NUMBER(10)   := 0;
        
				-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				e_msg            VARCHAR2(100);
				i  		           INTEGER        DEFAULT 0;
				-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found  
                
        -- UPDATE�� ����� QUERY�մϴ�.
        CURSOR edi_data_divided_cursor IS
            SELECT pay_seq ,
                   div_seq 
              FROM T_FB_CASH_PAY_HISTORY
             WHERE EDI_HISTORY_SEQ = p_edi_seq 
          GROUP BY pay_seq,
                   div_seq ;
        
        CURSOR edi_data_cursor IS
            SELECT pay_seq 
              FROM T_FB_CASH_PAY_HISTORY
             WHERE EDI_HISTORY_SEQ = p_edi_seq             
          GROUP BY pay_seq ;
                
    BEGIN
        
        BEGIN
	        -- MAX�۽��Ϸù�ȣ.
	        SELECT NVL( MAX(send_seq_no) , 0)+ 1
	        INTO   v_send_seq_no
	        FROM   T_FB_EDI_HISTORY
	        WHERE  std_ymd   = p_std_ymd
	        AND    comp_code = p_comp_code ;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE Err ;
        END; 
        
        -- �ȳ�STRING����  
        v_recv_desc := '' ;
        
        -- ���Ϲڽ� �۽��� BATCH�����̸� ���� 
        v_filename := p_file_name;        
                
        -- �ش� ������ ������ �˻��Ͽ�, ������ ���� ���, �����α׸� �����.
        BEGIN
            v_send_file := UTL_FILE.FOPEN( 'FBS_CASH_SEND_DIR', v_filename, 'r');
            UTL_FILE.FCLOSE( v_send_file );
        EXCEPTION
            WHEN UTL_FILE.INVALID_OPERATION OR UTL_FILE.INVALID_FILEHANDLE THEN
                RAISE Err;
        END;

        -- ���� ���� TABLE�� ���� UPDATE�� �����Ѵ�.
        -- ������ �� ���, �����޽����� LOG�� ���� ��, ROLLBACKó���ϸ�, ������ ���, �۽Ÿ���� ���� BATCH���� �۽� �õ�
        
	      BEGIN         
        UPDATE T_FB_EDI_HISTORY
           SET SEND_DATE    = SYSDATE ,
               RESULT_TEXT  = 'EDI�۽ſϷ�' ,
               SEND_SEQ_NO  = v_send_seq_no
         WHERE EDI_HISTORY_SEQ = p_edi_seq;
         
        EXCEPTION
            WHEN OTHERS THEN
                RAISE Err ;
        END;

        BEGIN 
        UPDATE T_FB_CASH_PAY_HISTORY
           SET TRANSFER_YN     = 'Y',
               SEND_DATE       = SYSDATE,
               RESULT_TEXT     = 'EDI�۽ſϷ�'
         WHERE EDI_HISTORY_SEQ = p_edi_seq;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE Err ;
        END;
				        
        FOR edicash_rec IN edi_data_divided_cursor LOOP

            BEGIN 
            UPDATE T_FB_CASH_PAY_DIVIDED_DATA
               SET RESULT_TEXT = 'EDI�۽ſϷ�'
             WHERE PAY_SEQ     =  edicash_rec.PAY_SEQ
             AND   DIV_SEQ     =  edicash_rec.DIV_SEQ;

		        EXCEPTION
		            WHEN OTHERS THEN
		                RAISE Err ;
		        END;
        
        END LOOP;
            
        FOR edicashseq_rec IN edi_data_cursor LOOP

            BEGIN 
            UPDATE T_FB_CASH_PAY_DATA
               SET RESULT_TEXT = 'EDI�۽ſϷ�'
             WHERE PAY_SEQ     =  edicashseq_rec.PAY_SEQ ;

		        EXCEPTION
		            WHEN OTHERS THEN
		                RAISE Err ;
		        END;
        END LOOP;
        
				v_result := f_send_file_to_van( p_file_name ,v_gubun,p_comp_code,p_bank_code );

        IF v_result = 'OK' THEN
            fbs_util_pkg.write_log('FBS','[INFO] ' || ' �۽��� ���������� ó���Ϸ�Ǿ����ϴ�.');
        ELSE
            fbs_util_pkg.write_log('FBS','[ERROR] '|| ' �۽� �� ������ �߻��Ͽ� �۾��� ��ҵǾ����ϴ�.');
            RAISE Err;
      	END IF;
    
    EXCEPTION
        WHEN Err THEN    
            fbs_util_pkg.write_log('FBS' , sqlerrm);
				    RAISE_APPLICATION_ERROR(-20010,sqlerrm);                 	
        WHEN OTHERS THEN
            fbs_util_pkg.write_log('FBS', sqlerrm);
            RAISE_APPLICATION_ERROR(-20014,sqlerrm);                  
    END ;