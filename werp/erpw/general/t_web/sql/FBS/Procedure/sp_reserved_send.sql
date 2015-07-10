    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : sp_reserved_send                                      */
    /*  2. ����̸�  : ������ü ����۽�                                     */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ���ŵ� ������ü Batch������ �о ����TABLE�� UPDATE�Ѵ�.     */
    /*      - ����TABLE                                                      */
    /*                                                                       */
    /*    < ���� �̷� >                                                      */
    /*                                                                       */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��2��03��                                         */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
		CREATE OR REPLACE Procedure
    					sp_reserved_send( bank_code        IN VARCHAR2 ,        -- �����ڵ�
                                file_name        IN VARCHAR2 ,        -- ���ϸ�
                                edi_history_seq  IN NUMBER   ,        -- edi�̷��Ϸù�ȣ
                                reved_date       IN VARCHAR2 ) IS     -- ������ü����

        v_input_file        UTL_FILE.FILE_TYPE;
        v_input_file_temp   UTL_FILE.FILE_TYPE;
        v_filename          VARCHAR2(100);
        v_buffer            VARCHAR2(4000);
        v_gubun             VARCHAR2(2) := '';  /* ���������� �� ���� �ڷ�TYPE�� �����ϴ� ���� �ʵ� */
        v_linecnt           NUMBER := 0;        /* DATA RECORD�� ó���ϴ� ���ι�ȣ */
  			v_edi_history_seq   NUMBER := 0; 
    		v_reved_date        VARCHAR2(8);	
    		v_dummy_return		  VARCHAR2(100);   
    		v_cash_send_dir     VARCHAR2(200);       -- BATCH �۽� DIRECTORY 
        FBS_CASH_SEND_DIR   VARCHAR2(100):= FBS_UTIL_PKG.FBS_CASH_SEND_DIR; -- ������ü
        WOORI_BANK_CD       VARCHAR2(2) := FBS_MAIN_PKG.WOORI_BANK_CD;       -- �츮����
		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   : �ۼ������� HEADER RECORD                                  */
		    /*----------------------------------------------------------------------------*/      
		    TYPE START_RECORD IS RECORD (

						before_data           VARCHAR2(21),      /* ����������                    */
		        pay_ymd               VARCHAR2(6),       /* ��������                      */
		        after_data            VARCHAR2(33));     /* ����������                    */         

        v_start_rec     START_RECORD;         /* ���� HEADER RECORD */
                
    BEGIN
        -- ���� �����̸� ���� 
        v_filename := file_name ;

				-- �۽ſ�������
				v_reved_date := SUBSTRB(reved_date,3,2)||SUBSTRB(reved_date,6,2)||SUBSTRB(reved_date,9,2) ;
				
				-- EDI�̷��Ϸù�ȣ
				v_edi_history_seq := edi_history_seq ;
				
        -- �������� OS���� directory�� �����ɴϴ�.(from DBA_DIRECTORIES )
        BEGIN
            SELECT DIRECTORY_PATH || '\'
            INTO v_cash_send_dir
            FROM DBA_DIRECTORIES
            WHERE DIRECTORY_NAME = FBS_CASH_SEND_DIR;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20010,'���� DIR�� ���������ʽ��ϴ�.');
        END;  

        v_input_file := UTL_FILE.FOPEN(FBS_CASH_SEND_DIR, v_filename, 'r');
        v_input_file_temp := UTL_FILE.FOPEN(FBS_CASH_SEND_DIR, 'temp_'||v_filename, 'w');
       
        fbs_util_pkg.write_log('FBS','[INFO]����۽� ó���� �����մϴ�. (���ϸ�: ' ||  v_filename || ')');
          
        BEGIN
            LOOP
              -- ������ �н��ϴ�.
              UTL_FILE.GET_LINE(v_input_file, v_buffer);

              -- ���п� ���� �� FIELD�� �����Ѵ�.
              v_gubun := SUBSTR(v_buffer, 1, 2);
    
              IF bank_code = WOORI_BANK_CD THEN 
              	 
                IF v_gubun = '11' THEN /* HEADER ���ڵ��� ��� */                

                    v_start_rec.before_data           := SUBSTRB(v_buffer, 1,21);    -- ���������� 
                    v_start_rec.pay_ymd               := SUBSTRB(v_buffer, 7,6);     -- ��ü����
      							v_start_rec.after_data            := SUBSTRB(v_buffer, 28,33);   -- ���������� 
      
      							v_buffer := v_start_rec.before_data||v_reved_date||v_start_rec.after_data ;
      							
      							UTL_FILE.PUT_LINE( v_input_file_temp , v_buffer );
      							
                ELSIF v_gubun = '22' THEN  /* DATA ���ڵ��� ���  */              
      
                    v_linecnt := v_linecnt + 1;
										v_buffer := v_buffer ;

										UTL_FILE.PUT_LINE( v_input_file_temp , v_buffer );

                ELSIF v_gubun = '33' THEN /* END ���ڵ��� ��� */
                
										v_buffer := v_buffer ;
      
							      UTL_FILE.PUT_LINE( v_input_file_temp , v_buffer );
      
                END IF;
            	END IF;		

				END LOOP;
				
        EXCEPTION
            WHEN NO_DATA_FOUND THEN    -- ������ �� ���� ���..
                UTL_FILE.FCLOSE( v_input_file );
                UTL_FILE.FCLOSE( v_input_file_temp );
                UTL_FILE.FRENAME('FBS_CASH_SEND_DIR' , 'temp_'||v_filename ,'FBS_CASH_SEND_DIR' ,v_filename ,TRUE);
            WHEN OTHERS THEN
                UTL_FILE.FCLOSE( v_input_file );
                UTL_FILE.FCLOSE( v_input_file_temp );
                v_dummy_return := fbs_util_pkg.exec_os_command(	'del ' || v_cash_send_dir || 'temp_'||v_filename );
                RAISE_APPLICATION_ERROR(-20013,sqlerrm);
        END;

				BEGIN
        -- HISTORY�� UPDATE�մϴ�.  
        UPDATE T_FB_EDI_HISTORY
           SET RESERVE_YMD       = v_reved_date ,
               RESULT_TEXT       = v_reved_date||'�� ����۽ŵ��'
         WHERE EDI_HISTORY_SEQ   = v_edi_history_seq  ;

        /* DB�۾��� ���� EXCEPTION�� �߻������� ó�� */
        EXCEPTION
            WHEN OTHERS THEN
	 							RAISE_APPLICATION_ERROR(-20014,sqlerrm);
        END;

        /* ������ ����̹Ƿ�, COMMIT�� �����ϰ�, ������ �� ���, ROLLBACK���� .*/  
        fbs_util_pkg.write_log('FBS','[INFO] �������� ó���� �Ϸ�Ǿ����ϴ�.');        			  
    
    EXCEPTION
        WHEN UTL_FILE.INVALID_OPERATION THEN
            fbs_util_pkg.write_log('FBS', 'ORA-20004  �������� ���⿡ ���� (���ϸ�:' || v_filename || ')');
						RAISE_APPLICATION_ERROR(-20015,'�������� ���⿡ ����');		
        WHEN OTHERS THEN
        	  ROLLBACK;
            fbs_util_pkg.write_log('FBS', sqlerrm);
						RAISE_APPLICATION_ERROR(-20016,sqlerrm);
    END ;