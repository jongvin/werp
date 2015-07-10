    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : sp_read_cash_result                                   */
    /*  2. ����̸�  : ������ü ó����� ����                                */
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
    					sp_read_cash_result( comp_code        IN VARCHAR2 ,        -- ����� �ڵ�
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
  			v_pay_status        VARCHAR2(1);
  			v_pay_success_amt   NUMBER := 0;
  			v_pay_fail_amt      NUMBER := 0; 
  			v_pay_amt           NUMBER := 0; 
  			v_edi_history_seq   NUMBER := 0; 
    		v_job_gubun         VARCHAR2(100):= 'C';
    		v_result            VARCHAR2(100);             -- EFT���α׷� ȣ�� �����
    		FBS_CASH_RECV_DIR   VARCHAR2(100) := FBS_UTIL_PKG.FBS_CASH_RECV_DIR; -- ������ü
		    /*----------------------------------------------------------------------------*/
		    /* �����ڵ�                                                                   */
		    /*----------------------------------------------------------------------------*/
		    KIUP_BANK_CD        VARCHAR2(2) := FBS_MAIN_PKG.KIUP_BANK_CD;   -- �������
		    KUKMIN_BANK_CD      VARCHAR2(2) := FBS_MAIN_PKG.KUKMIN_BANK_CD; -- ��������
		    WOORI_BANK_CD       VARCHAR2(2) := FBS_MAIN_PKG.WOORI_BANK_CD;  -- �츮����
		    HANA_BANK_CD        VARCHAR2(2) := FBS_MAIN_PKG.HANA_BANK_CD;   -- �ϳ�����    		
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
		        result_yn              VARCHAR2(1),   /* 1,Y:����  2,N:�Ҵ�               */
		        result_code            VARCHAR2(4));  /* ����ڵ�                         */
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
        v_input_file := UTL_FILE.FOPEN(FBS_CASH_RECV_DIR, v_filename, 'r');
        fbs_util_pkg.write_log('FBS','[INFO] '||'company_cd'||' '|| bank_code||' ������ü ��������ó���� �����մϴ�. (���ϸ�: ' ||  v_filename || ')');
            -- ������ �о�, DB�۾��� �մϴ�.
        BEGIN
            LOOP
              -- ������ �н��ϴ�.
              UTL_FILE.GET_LINE(v_input_file, v_buffer);

              -- ���п� ���� �� FIELD�� �����Ѵ�.
              IF bank_code = '03' THEN 
              	 v_gubun := SUBSTR(v_buffer, 1, 2);
              ELSE
              	 v_gubun := SUBSTR(v_buffer, 1, 1);
              END IF;	 
    
              IF bank_code = KIUP_BANK_CD THEN 
              	 
                IF v_gubun = '11' THEN /* HEADER ���ڵ��� ��� */ 
                    v_start_rec.gubun                 := SUBSTRB(v_buffer, 1,2);    -- ���ڵ屸�� 
                    v_start_rec.pay_ymd               := SUBSTRB(v_buffer, 7,6);    -- ��ü����      
                ELSIF v_gubun = '22' THEN  /* DATA ���ڵ��� ���  */
                    v_linecnt := v_linecnt + 1;
                    v_edidata_rec.gubun               := SUBSTRB(v_buffer,  1, 2);   -- ���ڵ屸�� 
                    v_edidata_rec.record_seq          := SUBSTRB(v_buffer,  7, 6);   -- �Ϸù�ȣ 
                    v_edidata_rec.pay_amt             := SUBSTRB(v_buffer, 28,11);   -- ��ü�ݾ�  
                    v_edidata_rec.result_yn           := SUBSTRB(v_buffer, 72, 1);   -- 1:����  2:�Ҵ�
                    v_edidata_rec.result_code         := SUBSTRB(v_buffer, 74, 4);   -- ����ڵ�       
                ELSIF v_gubun = '33' THEN /* END ���ڵ��� ��� */
                    v_ediend_rec.gubun                := SUBSTRB(v_buffer, 1,  2);    -- ���ڵ屸��
                    v_ediend_rec.tot_send_cnt         := SUBSTRB(v_buffer, 7,  7);    -- �� �ǷڰǼ�
                    v_ediend_rec.tot_send_amt         := SUBSTRB(v_buffer, 14,13);    -- ���Ƿڱݾ�
                    v_ediend_rec.normal_cnt           := SUBSTRB(v_buffer, 27, 7);    -- ����ó���Ǽ�
                    v_ediend_rec.normal_amt           := SUBSTRB(v_buffer, 34,13);    -- ����ó���ݾ�
                    v_ediend_rec.error_cnt            := SUBSTRB(v_buffer, 47, 7);    -- ����ó���Ǽ�
                    v_ediend_rec.error_amt            := SUBSTRB(v_buffer, 54,13);    -- ����ó���ݾ�      
                END IF;
              ELSIF  bank_code = HANA_BANK_CD THEN 
                IF v_gubun = 'S' THEN /* HEADER ���ڵ��� ��� */ 
                    v_start_rec.gubun                 := SUBSTRB(v_buffer, 1,1);    -- ���ڵ屸�� 
                    v_start_rec.pay_ymd               := SUBSTRB(v_buffer,20,6);    -- ��ü����      
                ELSIF v_gubun = 'D' THEN  /* DATA ���ڵ��� ���  */
                    v_linecnt := v_linecnt + 1;
                    v_edidata_rec.gubun               := SUBSTRB(v_buffer,  1, 1);   -- ���ڵ屸�� 
                    v_edidata_rec.record_seq          := SUBSTRB(v_buffer,  2, 7);   -- �Ϸù�ȣ 
                    v_edidata_rec.pay_amt             := SUBSTRB(v_buffer, 36,11);   -- ��ü�ݾ�  
                    v_edidata_rec.result_yn           := SUBSTRB(v_buffer, 72, 1);   -- Y:����  N:�Ҵ�
                    v_edidata_rec.result_code         := SUBSTRB(v_buffer, 61, 4);   -- ����ڵ�       
                ELSIF v_gubun = 'E' THEN /* END ���ڵ��� ��� */
                    v_ediend_rec.gubun                := SUBSTRB(v_buffer, 1,  1);    -- ���ڵ屸��
                    v_ediend_rec.tot_send_cnt         := SUBSTRB(v_buffer, 2,  7);    -- �� �ǷڰǼ�
                    v_ediend_rec.tot_send_amt         := SUBSTRB(v_buffer, 9, 13);    -- ���Ƿڱݾ�
                    v_ediend_rec.normal_cnt           := SUBSTRB(v_buffer, 22, 7);    -- ����ó���Ǽ�
                    v_ediend_rec.normal_amt           := SUBSTRB(v_buffer, 29,13);    -- ����ó���ݾ�
                    v_ediend_rec.error_cnt            := SUBSTRB(v_buffer, 42, 7);    -- ����ó���Ǽ�
                    v_ediend_rec.error_amt            := SUBSTRB(v_buffer, 49,13);    -- ����ó���ݾ�      
                END IF;
        			ELSIF  bank_code = KUKMIN_BANK_CD THEN
                IF v_gubun = 'S' THEN /* HEADER ���ڵ��� ��� */ 
                    v_start_rec.gubun                 := SUBSTRB(v_buffer, 1,1);    -- ���ڵ屸�� 
                    v_start_rec.pay_ymd               := SUBSTRB(v_buffer,20,6);    -- ��ü����      
                ELSIF v_gubun = 'D' THEN  /* DATA ���ڵ��� ���  */
                    v_linecnt := v_linecnt + 1;
                    v_edidata_rec.gubun               := SUBSTRB(v_buffer,  1, 1);   -- ���ڵ屸�� 
                    v_edidata_rec.record_seq          := SUBSTRB(v_buffer,  2, 5);   -- �Ϸù�ȣ 
                    v_edidata_rec.pay_amt             := SUBSTRB(v_buffer, 38,10);   -- ��ü�ݾ�  
                    v_edidata_rec.result_yn           := SUBSTRB(v_buffer, 48, 1);   -- Y:����  N:�Ҵ�
                    v_edidata_rec.result_code         := SUBSTRB(v_buffer, 49, 4);   -- ����ڵ�       
                ELSIF v_gubun = 'E' THEN /* END ���ڵ��� ��� */
                    v_ediend_rec.gubun                := SUBSTRB(v_buffer,  1,  1);  -- ���ڵ屸��
                    v_ediend_rec.tot_send_cnt         := SUBSTRB(v_buffer,  9,  7);  -- �� �ǷڰǼ�
                    v_ediend_rec.tot_send_amt         := SUBSTRB(v_buffer, 16, 13);  -- ���Ƿڱݾ�
                    v_ediend_rec.normal_cnt           := SUBSTRB(v_buffer, 29, 7);   -- ����ó���Ǽ�
                    v_ediend_rec.normal_amt           := SUBSTRB(v_buffer, 36,13);   -- ����ó���ݾ�
                    v_ediend_rec.error_cnt            := SUBSTRB(v_buffer, 49, 7);   -- ����ó���Ǽ�
                    v_ediend_rec.error_amt            := SUBSTRB(v_buffer, 56,13);   -- ����ó���ݾ�      
                END IF;
        			ELSIF  bank_code = WOORI_BANK_CD THEN
                IF v_gubun = 'S' THEN /* HEADER ���ڵ��� ��� */ 
                    v_start_rec.gubun                 := SUBSTRB(v_buffer, 1,1);    -- ���ڵ屸�� 
                    v_start_rec.pay_ymd               := SUBSTRB(v_buffer,22,6);    -- ��ü����      
                ELSIF v_gubun = 'D' THEN  /* DATA ���ڵ��� ���  */
                    v_linecnt := v_linecnt + 1;
                    v_edidata_rec.gubun               := SUBSTRB(v_buffer,  1, 1);   -- ���ڵ屸�� 
                    v_edidata_rec.record_seq          := SUBSTRB(v_buffer, 73, 4);   -- �Ϸù�ȣ 
                    v_edidata_rec.pay_amt             := SUBSTRB(v_buffer, 21,11);   -- ��ü�ݾ�  
                    v_edidata_rec.result_yn           := SUBSTRB(v_buffer, 60, 1);   -- Y:����  N:�Ҵ�
                    v_edidata_rec.result_code         := SUBSTRB(v_buffer, 61, 4);   -- ����ڵ�       
                ELSIF v_gubun = 'E' THEN /* END ���ڵ��� ��� */
                    v_ediend_rec.gubun                := SUBSTRB(v_buffer,  1, 1);   -- ���ڵ屸��
                    v_ediend_rec.tot_send_cnt         := SUBSTRB(v_buffer,  9, 7);   -- �� �ǷڰǼ�
                    v_ediend_rec.tot_send_amt         := SUBSTRB(v_buffer, 16,13);   -- ���Ƿڱݾ�
                    v_ediend_rec.normal_cnt           := SUBSTRB(v_buffer, 29, 7);   -- ����ó���Ǽ�
                    v_ediend_rec.normal_amt           := SUBSTRB(v_buffer, 36,13);   -- ����ó���ݾ�
                    v_ediend_rec.error_cnt            := SUBSTRB(v_buffer, 49, 7);   -- ����ó���Ǽ�
                    v_ediend_rec.error_amt            := SUBSTRB(v_buffer, 56,13);   -- ����ó���ݾ�      
                END IF;
            	END IF;			  

              -- ����Ÿ�� ���� �����޽��� ���� �� DB�۾��� �����մϴ�.
              IF  (( v_gubun = '22') OR ( v_gubun = 'D')) THEN
                  
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
          
                      IF v_edidata_rec.result_yn = '1' THEN
                      	 v_edidata_rec.result_yn := 'Y';
                      ELSIF v_edidata_rec.result_yn = '2' THEN
                      	 v_edidata_rec.result_yn := 'N';
                      END IF ;	 
          
                      /* ���̺� UPDATE�� �մϴ�. */
                      BEGIN
                         -- �������޳����� UPDATE�մϴ�. 
                         UPDATE T_FB_CASH_PAY_HISTORY
                            SET PAY_SUCCESS_YN  = v_edidata_rec.result_yn ,
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
                         -- �������޺���DATA�� UPDATE�մϴ�. 
                         UPDATE T_FB_CASH_PAY_DIVIDED_DATA
                            SET PAY_YMD         = '20'||v_start_rec.pay_ymd ,
                                COMMISSION_AMT  = 0 ,
                                RESULT_TEXT     = v_result_text 
                          WHERE ( PAY_SEQ , DIV_SEQ ) = ( SELECT PAY_SEQ , DIV_SEQ
                                                          FROM T_FB_CASH_PAY_HISTORY
                                                          WHERE EDI_HISTORY_SEQ = v_edi_history_seq
                                                          AND   EDI_RECORD_SEQ  = to_number(v_edidata_rec.record_seq) ) ;                      
                      EXCEPTION
                          WHEN OTHERS THEN
                              RAISE_APPLICATION_ERROR(-20012,sqlerrm); 
                             
                      END;
					  
                      BEGIN
                      	
                      	v_pay_success_amt :=0;
                      	v_pay_fail_amt :=0;
                         -- ��������DATA�� UPDATE�մϴ�.                           
                          SELECT PAY_STATUS ,NVL(PAY_SUCCESS_AMT ,0),NVL(PAY_FAIL_AMT ,0),PAY_AMT
                          INTO   v_pay_status ,v_pay_success_amt ,v_pay_fail_amt ,v_pay_amt
                          FROM T_FB_CASH_PAY_DATA
                          WHERE PAY_SEQ = ( SELECT DISTINCT PAY_SEQ
                                            FROM T_FB_CASH_PAY_HISTORY
                                            WHERE EDI_HISTORY_SEQ = v_edi_history_seq
                                            AND   EDI_RECORD_SEQ  = to_number(v_edidata_rec.record_seq) ) ;
                        
                         IF v_edidata_rec.result_yn = 'Y' THEN
                         	  v_pay_success_amt := v_pay_success_amt + v_edidata_rec.pay_amt;
                         ELSE
														v_pay_fail_amt := v_pay_fail_amt + v_edidata_rec.pay_amt;
                         END IF;	  	  

                       	  IF v_pay_success_amt + v_pay_fail_amt = v_pay_amt THEN
                       	  	 IF v_pay_success_amt  = v_pay_amt THEN
                       	  	 	  v_pay_status := '4' ;
                       	  	 ELSIF v_pay_fail_amt  = v_pay_amt THEN	
                       	  	 	  v_pay_status := '5' ; 
                       	  	 ELSE
                       	  	 	  v_pay_status := '6' ;	
                       	  	 END IF;	     
                       	  END IF;
                         	  
                         UPDATE T_FB_CASH_PAY_DATA
                            SET PAY_YMD         = '20'||v_start_rec.pay_ymd ,
                                PAY_STATUS      = v_pay_status ,
                                PAY_SUCCESS_AMT = v_pay_success_amt ,
                                PAY_FAIL_AMT    = v_pay_fail_amt ,
                                RESULT_TEXT     = v_result_text 
                            WHERE PAY_SEQ = ( SELECT DISTINCT PAY_SEQ
                                              FROM T_FB_CASH_PAY_HISTORY
                                              WHERE EDI_HISTORY_SEQ = v_edi_history_seq
                                              AND   EDI_RECORD_SEQ  = to_number(v_edidata_rec.record_seq) ) ;                      
                      EXCEPTION
                          WHEN OTHERS THEN
                              RAISE_APPLICATION_ERROR(-20013,sqlerrm); 
                             
                      END;					  
					  
								ELSIF ( ( v_gubun = '33') OR (v_gubun = 'E' )) THEN
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