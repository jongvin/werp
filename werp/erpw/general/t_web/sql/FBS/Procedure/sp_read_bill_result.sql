    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : sp_read_bill_result                                   */
    /*  2. ����̸�  : jswkdjdma ó����� ����                               */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ���ŵ� wjswkdjdma Batch������ �о ����TABLE�� UPDATE�Ѵ�.   */
    /*      - ����TABLE                                                      */
    /*                                                                       */
    /*    < ���� �̷� >                                                      */
    /*                                                                       */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��2��09��                                         */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/
		CREATE OR REPLACE Procedure
    					sp_read_bill_result( comp_code        IN VARCHAR2 ,        -- ����� �ڵ�
    					                     bank_code        IN VARCHAR2 ,        -- �����ڵ�
                                   file_name        IN VARCHAR2 ,        -- ���ϸ�
                                   edi_history_seq  IN NUMBER ) IS       -- edi�̷��Ϸù�ȣ

        v_input_file        UTL_FILE.FILE_TYPE;
        v_filename          VARCHAR2(100);
        v_buffer            VARCHAR2(4000);
        v_gubun             VARCHAR2(2) := '';  /* ���������� �� ���� �ڷ�TYPE�� �����ϴ� ���� �ʵ� */
        v_linecnt           NUMBER := 0;        /* DATA RECORD�� ó���ϴ� ���ι�ȣ */
        v_success_yn        VARCHAR2(1) := 'Y'; /* ����ó������ */
        v_result_text       VARCHAR2(50);       /* �����޽��� */
        v_result_code       VARCHAR2(4);
  			v_edi_history_seq   NUMBER := 0; 
    		v_job_gubun         VARCHAR2(100):= 'B';
    		v_result            VARCHAR2(100);             -- EFT���α׷� ȣ�� ����� 
    		FBS_BILL_RECV_DIR   VARCHAR2(100) := FBS_UTIL_PKG.FBS_BILL_RECV_DIR; -- ���ھ���	
		    /*----------------------------------------------------------------------------*/
		    /* �����ڵ�                                                                   */
		    /*----------------------------------------------------------------------------*/
		    KIUP_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.KIUP_BANK_CD;   -- �������
		    KUKMIN_BANK_CD               VARCHAR2(2) := FBS_MAIN_PKG.KUKMIN_BANK_CD; -- ��������
		    WOORI_BANK_CD                VARCHAR2(2) := FBS_MAIN_PKG.WOORI_BANK_CD;  -- �츮����
		    HANA_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.HANA_BANK_CD;   -- �ϳ�����
		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   : �ۼ������� HEADER RECORD                                  */
		    /*----------------------------------------------------------------------------*/      
		    TYPE START_RECORD IS RECORD (
		        gubun                 VARCHAR2(2),       /* ���ڵ屸��      "10"          */
		        pay_ymd               VARCHAR2(6));      /* ��������                      */         
		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   : �ۼ������� DATA RECORD                           */
		    /*----------------------------------------------------------------------------*/     
		    TYPE DATA_RECORD IS RECORD (
		        gubun                  VARCHAR2(2),	  /* ���ڵ屸��     "20"              */
		        record_seq             VARCHAR2(6),   /* �Ϸù�ȣ                         */				              
		        pay_amt                VARCHAR2(13),  /* ��ü�ݾ�                         */
		        result_yn              VARCHAR2(1),   /* 1:����  2:�Ҵ�                   */
		        result_code            VARCHAR2(4),   /* ����ڵ�                         */
		        pay_date               VARCHAR2(8),   /* ��������                         */
		        approval_no            VARCHAR2(10)); /* ���ι�ȣ                         */
 		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   :  �ۼ������� END RECORD                            */
		    /*----------------------------------------------------------------------------*/        
		    TYPE END_RECORD IS RECORD (
		        gubun 	               VARCHAR2(2),   /* ���ڵ屸��     "30"           */
		        tot_send_cnt           VARCHAR2(7),   /* �� �ǷڰǼ�                   */
		        tot_send_amt           VARCHAR2(13),  /* �� �Ƿڱݾ�                   */
		        normal_cnt             VARCHAR2(7),   /* ����ó���Ǽ�                  */  
		        normal_amt             VARCHAR2(13),  /* ����ó���ݾ�                  */
		        error_cnt              VARCHAR2(7),   /* ����ó���Ǽ�                  */
		        error_amt              VARCHAR2(13)); /* ����ó���ݾ�                  */

        v_start_rec     START_RECORD;         /* ���� HEADER RECORD */
        v_edidata_rec   DATA_RECORD;          /* ���� DATA RECORD   */
        v_ediend_rec    END_RECORD;           /* ���� END RECORD    */
                
    BEGIN
        -- ���� �����̸� ���� 
        v_filename := file_name ;
  			-- �̷��Ϸù�ȣ �б�  
  			v_edi_history_seq := edi_history_seq ;

				-- ���ϼ����ϱ�  			    	
    		v_result := f_recieve_file_from_van( v_filename ,v_job_gubun,comp_code,bank_code );

    		IF v_result = 'ERROR' THEN 
    			 RAISE_APPLICATION_ERROR(-20000,'���ϼ��ſ���');
				END IF;    			 

        -- ���������� open�մϴ�.  
        v_input_file := UTL_FILE.FOPEN( FBS_BILL_RECV_DIR, v_filename, 'r');
        fbs_util_pkg.write_log('FBS','[INFO] '||'company_cd'||' '|| bank_code||' ���ھ��� ��������ó���� �����մϴ�. (���ϸ�: ' ||  v_filename || ')');
            -- ������ �о�, DB�۾��� �մϴ�.
        BEGIN
            LOOP
              -- ������ �н��ϴ�.
              UTL_FILE.GET_LINE(v_input_file, v_buffer);
    
              IF bank_code = KIUP_BANK_CD THEN 

	              -- ���п� ���� �� FIELD�� �����Ѵ�.
	              v_gubun := SUBSTR(v_buffer, 1, 2); 
              
                IF v_gubun = '10' THEN /* HEADER ���ڵ��� ��� */ 
                    v_start_rec.gubun         := SUBSTRB(v_buffer, 1,2);    -- ���ڵ屸�� 
                    v_start_rec.pay_ymd       := SUBSTRB(v_buffer, 7,6);    -- ��ü����      
                ELSIF v_gubun = '20' THEN  /* DATA ���ڵ��� ���  */       
                    v_linecnt := v_linecnt + 1;
                    v_edidata_rec.gubun       := SUBSTRB(v_buffer,  1, 2);   -- ���ڵ屸�� 
                    v_edidata_rec.pay_amt     := SUBSTRB(v_buffer, 20,13);   -- ä�Ǳݾ�
                    v_edidata_rec.record_seq  := SUBSTRB(v_buffer, 43,12);   -- ����Ÿ�Ϸù�ȣ 
                    v_edidata_rec.pay_date    := SUBSTRB(v_buffer, 75, 8);   -- ������
                    v_edidata_rec.result_code := SUBSTRB(v_buffer, 90, 4);   -- ����ڵ� 
                    v_edidata_rec.result_yn   := SUBSTRB(v_buffer, 147,1);   -- ����ó������      
                ELSIF v_gubun = '30' THEN /* END ���ڵ��� ��� */                
                    v_ediend_rec.gubun         := SUBSTRB(v_buffer, 1,  2);    -- ���ڵ屸��
                    v_ediend_rec.tot_send_cnt  := SUBSTRB(v_buffer, 3,  6);    -- ���ǷڰǼ�
                    v_ediend_rec.tot_send_amt  := SUBSTRB(v_buffer, 9, 13);    -- ���Ƿڱݾ�
                    v_ediend_rec.normal_cnt    := SUBSTRB(v_buffer, 23, 6);    -- ����ó���Ǽ�
                    v_ediend_rec.normal_amt    := SUBSTRB(v_buffer, 30,13);    -- ����ó���ݾ�
                    v_ediend_rec.error_cnt     := SUBSTRB(v_buffer, 44, 6);    -- ����ó���Ǽ�
                    v_ediend_rec.error_amt     := SUBSTRB(v_buffer, 51,13);    -- ����ó���ݾ�      
                END IF;
              ELSIF bank_code = HANA_BANK_CD THEN 
              	
	              -- ���п� ���� �� FIELD�� �����Ѵ�.
	              v_gubun := SUBSTR(v_buffer, 1, 1); 
	                            	  
                IF v_gubun = 'S' THEN /* HEADER ���ڵ��� ��� */ 
                    v_start_rec.gubun         := SUBSTRB(v_buffer, 1,1);    -- ���ڵ屸�� 
                    v_start_rec.pay_ymd       := SUBSTRB(v_buffer, 7,6);    -- ��ü����      
                ELSIF v_gubun = 'D' THEN  /* DATA ���ڵ��� ���  */       
                    v_linecnt := v_linecnt + 1;
                    v_edidata_rec.gubun       := SUBSTRB(v_buffer, 1,  1);   -- ���ڵ屸�� 
                    v_edidata_rec.record_seq  := SUBSTRB(v_buffer, 2,  5);   -- ����Ÿ�Ϸù�ȣ 
                    v_edidata_rec.pay_amt     := SUBSTRB(v_buffer, 42,11);   -- ä�Ǳݾ�
                    v_edidata_rec.result_yn   := SUBSTRB(v_buffer, 92,10);   -- ���ι�ȣ
                    v_edidata_rec.result_code := SUBSTRB(v_buffer,102, 4);   -- ����ڵ�
                    v_edidata_rec.pay_date    := SUBSTRB(v_buffer,126, 8);   -- ������
                ELSIF v_gubun = 'E' THEN /* END ���ڵ��� ��� */                
                    v_ediend_rec.gubun        := SUBSTRB(v_buffer, 1,  1);    -- ���ڵ屸��
                    v_ediend_rec.tot_send_cnt := SUBSTRB(v_buffer, 7,  5);    -- ���ǷڰǼ�
                    v_ediend_rec.tot_send_amt := SUBSTRB(v_buffer, 12,15);    -- ���Ƿڱݾ�
                    v_ediend_rec.normal_cnt   := SUBSTRB(v_buffer, 27, 5);    -- ����ó���Ǽ�
                    v_ediend_rec.normal_amt   := SUBSTRB(v_buffer, 32,15);    -- ����ó���ݾ�
                    v_ediend_rec.error_cnt    := SUBSTRB(v_buffer, 77, 5);    -- ����ó���Ǽ�
                    v_ediend_rec.error_amt    := SUBSTRB(v_buffer, 82,15);    -- ����ó���ݾ�      
                END IF;
            	END IF;			  


              -- ����Ÿ�� ���� �����޽��� ���� �� DB�۾��� �����մϴ�.
              IF  ( v_gubun = '22'  OR v_gubun = 'D'  ) THEN
                  
                      /* �����޽��� ���� */
                      v_result_code := LPAD( v_edidata_rec.result_code , 4 , '0' );
					  
                      BEGIN
                          SELECT RESP_CODE_NAME
                            INTO v_result_text
                            FROM T_FB_BATCH_RESP_CODE
                           WHERE PAY_METHOD_GUBUN = 'B'
                             AND BANK_CODE = bank_code
                             AND RESP_CODE = v_result_code
                             AND USE_YN    = 'Y';
                      
                      EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                              v_result_text := '�˼����� ����';
							            WHEN OTHERS THEN
							                RAISE_APPLICATION_ERROR(-20010,sqlerrm);
                      END;                      
          
                      /* ���̺� UPDATE�� �մϴ�. */
                      BEGIN
                         -- �������޳����� UPDATE�մϴ�. 
                         UPDATE T_FB_BILL_PAY_HISTORY
                            SET PAY_SUCCESS_YN  = decode(v_edidata_rec.result_code,'0000','Y','N') ,
                                RECV_DATE       = SYSDATE ,
                                RESULT_CODE     = v_result_code ,
                                RESULT_TEXT     = v_result_text 
                          WHERE EDI_HISTORY_SEQ = v_edi_history_seq
                            AND EDI_RECORD_SEQ  = to_number(v_edidata_rec.record_seq) ;                      
                      EXCEPTION
                          WHEN OTHERS THEN
                              RAISE_APPLICATION_ERROR(-20011,sqlerrm); 
                             
                      END;                    
					  
                      BEGIN
                         	  
                         UPDATE T_FB_BILL_PAY_DATA
                            SET PAY_YMD         = v_edidata_rec.pay_date ,
                                PAY_STATUS      = DECODE(v_edidata_rec.result_code ,'0000','4','5'),
                                RESULT_TEXT     = v_result_text 
                            WHERE PAY_SEQ = ( SELECT DISTINCT PAY_SEQ
                                              FROM T_FB_BILL_PAY_HISTORY
                                              WHERE EDI_HISTORY_SEQ = v_edi_history_seq
                                              AND   EDI_RECORD_SEQ  = to_number(v_edidata_rec.record_seq) ) ;
                      EXCEPTION
                          WHEN OTHERS THEN
                              RAISE_APPLICATION_ERROR(-20013,sqlerrm); 
                             
                      END;					  
					  
								ELSIF ( v_gubun = '30' or v_gubun = 'E' ) THEN
											BEGIN
                      -- HISTORY�� UPDATE�մϴ�.  
                      UPDATE T_FB_EDI_HISTORY
                         SET RECV_DATE         = SYSDATE ,
                             RECEIVE_FILE_NAME = v_filename,
                             PAY_SUCCESS_CNT   = NVL(PAY_SUCCESS_CNT,0) + to_number(v_ediend_rec.normal_cnt) ,
                             PAY_SUCCESS_AMT   = NVL(PAY_SUCCESS_AMT,0) + to_number(v_ediend_rec.normal_amt) ,
                             PAY_FAIL_CNT      = NVL(PAY_FAIL_CNT,0) + to_number(v_ediend_rec.error_cnt) ,
                             PAY_FAIL_AMT      = NVL(PAY_FAIL_AMT,0) + to_number(v_ediend_rec.error_amt) ,                                   
                             RESULT_TEXT       = to_char(NVL(PAY_SUCCESS_CNT,0) + to_number(v_ediend_rec.normal_cnt))||'�� ����'||
                                                 to_char(NVL(PAY_FAIL_CNT,0) + to_number(v_ediend_rec.error_cnt))||'�� ����'
                       WHERE EDI_HISTORY_SEQ   = v_edi_history_seq  ;

	                    /* DB�۾��� ���� EXCEPTION�� �߻������� ó�� */
	                    EXCEPTION
	                        WHEN OTHERS THEN
								 							RAISE_APPLICATION_ERROR(-20014,sqlerrm);
	                    END;
					  
                END IF;			  
				END LOOP;
				
        EXCEPTION
            WHEN NO_DATA_FOUND THEN    -- ������ �� ���� ���..
                UTL_FILE.FCLOSE( v_input_file );
            WHEN OTHERS THEN
                UTL_FILE.FCLOSE( v_input_file );
                RAISE_APPLICATION_ERROR(-20020,sqlerrm);
        END;

        /* ������ ����̹Ƿ�, COMMIT�� �����ϰ�, ������ �� ���, ROLLBACK���� .*/  
        fbs_util_pkg.write_log('FBS','[INFO] �������� ó���� �Ϸ�Ǿ����ϴ�.');        			  
    
    EXCEPTION
        WHEN UTL_FILE.INVALID_OPERATION THEN
            fbs_util_pkg.write_log('FBS', 'ORA-20004  �������� ���⿡ ���� (���ϸ�:' || v_filename || ')');
						RAISE_APPLICATION_ERROR(-20010,'������ ���� ���ŵ��� �ʾҽ��ϴ�.');											
        WHEN OTHERS THEN
        	  ROLLBACK;
            fbs_util_pkg.write_log('FBS', sqlerrm);
						RAISE_APPLICATION_ERROR(-20030,sqlerrm);
    END ;