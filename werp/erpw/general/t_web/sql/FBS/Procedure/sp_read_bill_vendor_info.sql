    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : sp_read_bill_vendor_info                              */
    /*  2. ����̸�  : ���ھ���������ü ó����� ����                        */
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
    		 sp_read_bill_vendor_info( comp_code        IN VARCHAR2 ,       -- �þ�¡�ڵ�
    		                           bank_code        IN VARCHAR2 ,       -- �����ڵ�
    		                           emp_no           IN VARCHAR2 ) IS    -- �����ȣ

        v_input_file        UTL_FILE.FILE_TYPE;
        v_filename          VARCHAR2(100);
        v_buffer            VARCHAR2(4000);
        v_gubun             VARCHAR2(2) := '';  /* ���������� �� ���� �ڷ�TYPE�� �����ϴ� ���� �ʵ� */
    		v_job_gubun         VARCHAR2(100);
    		v_result            VARCHAR2(100);             -- EFT���α׷� ȣ�� ����� 
    		v_comp_code         VARCHAR2(2);	
    		v_cust_seq          NUMBER;
    		FBS_BILL_RECV_DIR   VARCHAR2(100) := FBS_UTIL_PKG.FBS_BILL_RECV_DIR; -- ���ھ��� 
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
		        ente_code             VARCHAR2(8),       /* ��ü�ڵ�                      */
		        bank_code             VARCHAR2(2),       /* �����ڵ�                      */
		        tran_date             VARCHAR2(8));      /* ��������                      */
		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   : �ۼ������� DATA RECORD                           */
		    /*----------------------------------------------------------------------------*/     
		    TYPE DATA_RECORD IS RECORD (
		        gubun                  VARCHAR2(2),	     /* ���ڵ屸��     "20"           */
		        vendor_num             VARCHAR2(10),     /* ����ڹ�ȣ                    */
		        vendor_name            VARCHAR2(30),     /* ��ü��                        */
		        contract_gubun         VARCHAR2(1),      /* ����(0:�ű�,1:����,2:����)    */
		        create_date            VARCHAR2(8),      /* �ű�����                      */
		        change_date            VARCHAR2(8),      /* ��������                      */
		        acct_no                VARCHAR2(15),     /* ���¹�ȣ                      */
		        franchise_no           VARCHAR2(16));    /* ��������ȣ                    */
 		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   :  �ۼ������� END RECORD                            */
		    /*----------------------------------------------------------------------------*/        
		    TYPE END_RECORD IS RECORD (
		        gubun 	               VARCHAR2(2),      /* ���ڵ屸��     "30"           */
		        tot_send_cnt           VARCHAR2(6),      /* �����ҰǼ�                    */
		        new_send_cnt           VARCHAR2(6),      /* �ű԰Ǽ�                      */
		        cha_send_cnt           VARCHAR2(6),      /* ����Ǽ�                      */  
		        hae_send_cnt           VARCHAR2(6));     /* �����Ǽ�                      */

        v_start_rec     START_RECORD;         /* ���� HEADER RECORD */
        v_edidata_rec   DATA_RECORD;          /* ���� DATA RECORD   */
        v_ediend_rec    END_RECORD;           /* ���� END RECORD    */
                
    BEGIN
        -- ���� �����̸� ���� 
        v_filename := f_get_edi_file_name( comp_code , bank_code , 'V' ,'' );

				-- ���ϼ����ϱ�  			    	
    		v_result := f_recieve_file_from_van( v_filename ,'V',comp_code,bank_code );

    		IF v_result = 'ERROR' THEN 
    			 RAISE_APPLICATION_ERROR(-20000,'���ϼ��ſ���');
				END IF;    			 

        -- ���������� open�մϴ�.  
        v_input_file := UTL_FILE.FOPEN(FBS_BILL_RECV_DIR, v_filename, 'r');
        fbs_util_pkg.write_log('FBS','[INFO] '||comp_code||' '|| bank_code||' ���ھ��� ��������ó���� �����մϴ�. (���ϸ�: ' ||  v_filename || ')');
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
                    v_start_rec.ente_code     := SUBSTRB(v_buffer, 3,8);    -- ��ü��ȣ
                    v_start_rec.bank_code     := SUBSTRB(v_buffer, 11,2);   -- �����ڵ�
                    v_start_rec.tran_date     := SUBSTRB(v_buffer, 14,8);   -- ��������
                ELSIF v_gubun = '20' THEN  /* DATA ���ڵ��� ���  */
                    v_edidata_rec.gubun          := SUBSTRB(v_buffer,  1, 2);   -- ���ڵ屸�� 
                    v_edidata_rec.vendor_num     := SUBSTRB(v_buffer, 14,10);   -- ����ڹ�ȣ
                    v_edidata_rec.vendor_name    := SUBSTRB(v_buffer, 37,30);   -- ��ü�� 
                    v_edidata_rec.contract_gubun := SUBSTRB(v_buffer, 67, 1);   -- ����(0:�ű�,1:����,2:����)
                    v_edidata_rec.create_date    := SUBSTRB(v_buffer, 69, 8);   -- �ű����� 
                    v_edidata_rec.change_date    := SUBSTRB(v_buffer, 78,8);    -- ��������
                    v_edidata_rec.acct_no        := SUBSTRB(v_buffer, 91,15);   -- ���¹�ȣ
                ELSIF v_gubun = '30' THEN /* END ���ڵ��� ��� */                
                    v_ediend_rec.gubun         := SUBSTRB(v_buffer, 1, 2);    -- ���ڵ屸��
                    v_ediend_rec.tot_send_cnt  := SUBSTRB(v_buffer, 3, 6);    -- �����ҰǼ�
                    v_ediend_rec.new_send_cnt  := SUBSTRB(v_buffer, 9, 6);    -- �ű԰Ǽ�
                    v_ediend_rec.cha_send_cnt  := SUBSTRB(v_buffer, 15,6);    -- ����Ǽ�
                    v_ediend_rec.hae_send_cnt  := SUBSTRB(v_buffer, 21,6);    -- �����Ǽ�
                END IF;
              ELSIF bank_code = HANA_BANK_CD THEN 
              	
	              -- ���п� ���� �� FIELD�� �����Ѵ�.
	              v_gubun := SUBSTR(v_buffer, 1, 1); 

                IF v_gubun = 'S' THEN /* HEADER ���ڵ��� ��� */ 
                    v_start_rec.gubun         := SUBSTRB(v_buffer, 1,1);    -- ���ڵ屸�� 
                    v_start_rec.ente_code     := SUBSTRB(v_buffer, 7,4);    -- ��ü�ڵ�
                    v_start_rec.bank_code     := '81';                      -- �����ڵ�
                    v_start_rec.tran_date     := SUBSTRB(v_buffer, 16,8);   -- ��������
                ELSIF v_gubun = 'D' THEN  /* DATA ���ڵ��� ���  */       
                    v_edidata_rec.gubun          := SUBSTRB(v_buffer,1 ,  1);   -- ���ڵ屸�� 
                    v_edidata_rec.vendor_num     := SUBSTRB(v_buffer,463,13);   -- ����ڹ�ȣ
                    v_edidata_rec.vendor_name    := SUBSTRB(v_buffer,11 ,32);   -- ��ü��
                    v_edidata_rec.contract_gubun := SUBSTRB(v_buffer,93 , 1);   -- ����(0:�ű�,9:����)
                    v_edidata_rec.create_date    := SUBSTRB(v_buffer,94 , 8);   -- �ű�����
                    v_edidata_rec.change_date    := SUBSTRB(v_buffer,102, 8);   -- ��������
                    v_edidata_rec.franchise_no   := SUBSTRB(v_buffer,45 , 16);  -- ��������ȣ
                ELSIF v_gubun = 'E' THEN /* END ���ڵ��� ��� */                
                    v_ediend_rec.gubun        := SUBSTRB(v_buffer, 1,  1);    -- ���ڵ屸��
                    v_ediend_rec.tot_send_cnt := SUBSTRB(v_buffer,11,  5);    -- ���ǷڰǼ�
                END IF;
            	END IF;			  

	            --���������
              BEGIN
                  SELECT comp_code
                  INTO v_comp_code
                  FROM T_FB_ORG_BANK
                  WHERE BANK_MAIN_CODE = v_start_rec.bank_code
                  AND ENTE_CODE = v_start_rec.ente_code   ;
              
              EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                      RAISE_APPLICATION_ERROR(-20010,v_start_rec.bank_code||'('||v_start_rec.ente_code||') ��ü�ڵ尡 �����ϴ�.');
			            WHEN OTHERS THEN
			                RAISE_APPLICATION_ERROR(-20010,sqlerrm);
              END;

              -- ����Ÿ�� ���� �����޽��� ���� �� DB�۾��� �����մϴ�.
              IF  ( v_gubun = '22'  OR v_gubun = 'D'  ) THEN
					  
					            --�ŷ�ó�Ϸù�ȣ(�ŷ�ó������ �����鿡��)
                      BEGIN
                          SELECT cust_seq
                          INTO v_cust_seq
                          FROM T_CUST_CODE
                          WHERE CUST_CODE = v_edidata_rec.vendor_num ;
                      
                      EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                              RAISE_APPLICATION_ERROR(-20010,v_edidata_rec.vendor_name||'('||v_edidata_rec.vendor_num||') �ŷ�ó�� �����ϴ�.');
							            WHEN OTHERS THEN
							                RAISE_APPLICATION_ERROR(-20010,sqlerrm);
                      END;

                      BEGIN
											    INSERT INTO T_FB_BILL_VENDORS	
											    ( SEQ ,
											      TRANSFER_YMD,
											      VAT_REGISTRATION_NUM,
											      FRANCHISE_NO,
											      VENDOR_NAME,
											      SSN,
											      CONTRACT_GUBUN,
											      CHANGE_YMD,
											      BANK_CODE,
											      ACCOUNT_NO,
											      COMP_CODE,
											      CREATION_DATE,
											      CREATION_EMP_NO,
											      ATTRIBUTE1 )/* �ű����� */
											    VALUES  
											    ( v_cust_seq ,
											      v_start_rec.tran_date,
														v_edidata_rec.vendor_num ,
														v_edidata_rec.franchise_no ,
														v_edidata_rec.vendor_name ,
														null,
														'N',
														v_edidata_rec.create_date ,
														v_start_rec.bank_code ,
														v_edidata_rec.acct_no ,
														v_comp_code ,
														SYSDATE,
														emp_no,
														v_edidata_rec.create_date ) ;

                          Exception When Dup_Val_On_Index Then

	                         -- UPDATE�մϴ�. 
	                         UPDATE T_FB_BILL_VENDORS
	                            SET TRANSFER_YMD          = v_start_rec.tran_date ,
	                                VAT_REGISTRATION_NUM  = v_edidata_rec.vendor_num ,
	                                FRANCHISE_NO          = v_edidata_rec.franchise_no ,
	                                VENDOR_NAME           = v_edidata_rec.vendor_name ,
	                                SSN                   = NULL ,
	                                CONTRACT_GUBUN        = DECODE(v_edidata_rec.contract_gubun,'9','C','2','C','M') ,
	                                CHANGE_YMD            = v_edidata_rec.change_date ,
	                                ACCOUNT_NO            = v_edidata_rec.acct_no ,
	                                BANK_CODE             = v_start_rec.bank_code ,
	                                COMP_CODE             = v_comp_code ,
	                                LAST_MODIFY_DATE      = SYSDATE ,
	                                LAST_MODIFY_EMP_NO    = emp_no
	                          WHERE SEQ = v_cust_seq  ;

							            WHEN OTHERS THEN
							                RAISE_APPLICATION_ERROR(-20010,sqlerrm);
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
						RAISE_APPLICATION_ERROR(-20010,'�������� ���⿡ ����');											
        WHEN OTHERS THEN
        	  ROLLBACK;
            fbs_util_pkg.write_log('FBS', sqlerrm);
						RAISE_APPLICATION_ERROR(-20030,sqlerrm);
    END ;