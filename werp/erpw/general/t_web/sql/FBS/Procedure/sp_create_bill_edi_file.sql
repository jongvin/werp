    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : create_bill_edi_file                                  */
    /*  2. ����̸�  : ���ھ��� Batch���� ����                               */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ���ھ������޳����� EDI Batch File ����                         */
    /*                                                                       */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��2��07��                                         */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/  
    CREATE OR REPLACE Procedure
 					 sp_create_bill_edi_file( company_cd   IN VARCHAR2 ,      -- ȸ���ڵ�
    																pay_gubun    IN VARCHAR2 ,      -- ���ޱ���
                                 		pay_due_ymd  IN VARCHAR2 ,      -- ���࿹������     																  
                                 		bank_cd      IN VARCHAR2 ,      -- �����ڵ� 
                                 		account_no   IN VARCHAR2 ,      -- ��ݰ���ID
                                 		emp_no       IN VARCHAR2 ,      -- �����ȣ(����������)
                                 		result_code  OUT VARCHAR2 ) IS  -- ó������ڵ�� 
                                 
        v_output_file                UTL_FILE.FILE_TYPE;
        
        v_filename                   VARCHAR2(100);              -- �ۼ��� ���� ����
        v_out_account_no             VARCHAR2(15);               -- ��ݰ��¹�ȣ
        v_biz_no                     VARCHAR2(12);               -- ����ڹ�ȣ
        v_pay_date                   VARCHAR2(8);                -- ��������
        v_pay_success_yn						 VARCHAR2(1);                -- ���޼�������

        v_tot_send_cnt               NUMBER := 0;                -- ���۵� �� �ǷڰǼ�
        v_tot_send_amt               NUMBER := 0;                -- ���۵� �� �Ƿڱݾ�
				v_edi_history_seq            NUMBER := 0;                -- EDI�Ϸù�ȣ
                    
        v_success_yn                 VARCHAR2(1) := 'Y';         -- ����ó������(Y OR N)
        v_data_cnt                   NUMBER := 0;                -- ����Ÿ COUNT 
        v_data_amt									 NUMBER := 0;                -- ����Ÿ �ݾ�
        v_edi_record								 NUMBER := 0;                -- edi���ڵ��Ϸù�ȣ 	
        v_trx_seq								     NUMBER := 0;                -- �ŷ��Ϸù�ȣ 	
        
        v_buffer                     VARCHAR2(500);              -- �ӽù���(����WRITE��) 
        v_today                      VARCHAR2(8);                -- ���ó�¥(YYYYMMDD)
        v_time                       VARCHAR2(6);                -- ���ýð�(HH24MISS)
				v_dummy_return		           VARCHAR2(100);
				
        rec_org_bank            		 T_FB_ORG_BANK%ROWTYPE;      -- �����ڵ带 ������ RECORD����         
		    /*----------------------------------------------------------------------------*/
		    /* �����ڵ�                                                                   */
		    /*----------------------------------------------------------------------------*/
		    KIUP_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.KIUP_BANK_CD;   -- �������
		    KUKMIN_BANK_CD               VARCHAR2(2) := FBS_MAIN_PKG.KUKMIN_BANK_CD; -- ��������
		    WOORI_BANK_CD                VARCHAR2(2) := FBS_MAIN_PKG.WOORI_BANK_CD;  -- �츮����
		    HANA_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.HANA_BANK_CD;   -- �ϳ�����        
        -- ���� DIRECTORY (����Ŭ ���� DIRECTORY �� CREATE�Ǿ� ���� ) 
        FBS_BILL_SEND_DIR            VARCHAR2(100) := FBS_UTIL_PKG.FBS_BILL_SEND_DIR; -- ���ھ���
        v_bill_send_dir              VARCHAR2(200);             -- BATCH �۽� DIRECTORY          
				-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	        
            
        -- ���ھ�����ü data ���� CURSOR   
				CURSOR bill_pay_cursor IS        	
            SELECT a.pay_seq               AS pay_seq,        -- �����Ϸù�ȣ
            			 a.pay_amt               AS pay_amt,        -- ���ޱݾ�
            			 a.check_no              AS check_no,       -- ä�ǹ�ȣ
            			 a.vat_registration_num  AS regist_no,      -- ����ڹ�ȣ
            			 a.pay_due_ymd           AS pay_due_ymd,    -- ���࿹������
            			 a.future_pay_due_ymd    AS future_ymd,     -- ��������
            			 b.franchise_no          AS franchise_no    -- ��������ȣ
	            FROM T_FB_BILL_PAY_DATA a ,
	                 T_FB_BILL_VENDORS  b        
             WHERE a.cust_seq          = b.seq
               AND a.comp_code         = company_cd
               AND a.pay_kind_gubun    LIKE pay_gubun||'%'
               AND a.out_bank_code     = bank_cd
               AND a.pay_due_ymd       = REPLACE(pay_due_ymd,'-','')
               AND a.pay_status IN ('2','5')
               AND a.edi_create_req_yn = 'Y'
             ORDER BY a.pay_seq ;
        
    BEGIN
        -- ���ó�¥ ,�ð� ����  
        v_today := TO_CHAR(SYSDATE,'YYYYMMDD');
        v_time  := TO_CHAR(SYSDATE,'HH24MISS');
    
        -- �۽� �����̸� ���� 
        v_filename := f_get_edi_file_name( company_cd , bank_cd , 'BS'  );
        
        -- �ʱ⺯���� �����մϴ�.(��ݰ��¹�ȣ/��ü����)
        v_out_account_no := REPLACE(account_no,'-',''); 
        v_pay_date       := REPLACE(pay_due_ymd,'-','');
        
        -- �������� OS���� directory�� �����ɴϴ�.(from DBA_DIRECTORIES )
        BEGIN
            SELECT DIRECTORY_PATH || '\'
            INTO v_bill_send_dir
            FROM DBA_DIRECTORIES
            WHERE DIRECTORY_NAME = FBS_BILL_SEND_DIR;
        
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := 'DIR ����' ;
            	  errflag := -20010 ;
                RAISE Err ;
        END;         

        -- �ش������� ����ڹ�ȣ�� �����ɴϴ�.
        BEGIN        
            SELECT REPLACE(BIZNO,'-','') AS BIZNO
            INTO v_biz_no
            FROM T_COMPANY 
            WHERE COMP_CODE = company_cd ; 
            
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := '������� ����ڹ�ȣ ����' ;
            	  errflag := -20020 ;
                RAISE Err ;
        END;        
        
        BEGIN
	        -- ��ϵ� SUBJECT NAME�� �����ɴϴ�.
	        SELECT *
	        INTO   rec_org_bank
	        FROM   T_FB_ORG_BANK
	        WHERE  COMP_CODE      = company_cd
	        AND    BANK_MAIN_CODE = bank_cd;
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := '���࿡ ���� ��ü�ڵ� ����' ;
            	  errflag := -20030 ;
                RAISE Err ;
        END;  
              
        -- edi �̷��Ϸù�ȣ�� �����ɴϴ�.
       	SELECT  T_EDI_HISTORY_SEQ.NEXTVAL
      	INTO    v_edi_history_seq  
      	FROM    DUAL ;
      	
        -------------------------------------------------------------------------------
        -- ���ھ��� �۽������� HISTORY ���̺�(T_FB_EDI_HISTORY )�� �ֽ��ϴ�.
        -------------------------------------------------------------------------------        
       	BEGIN      --EDI���� �ۼ��� �̷� 
        INSERT INTO T_FB_EDI_HISTORY 
         ( EDI_HISTORY_SEQ ,
           STD_YMD ,
           COMP_CODE ,
           BANK_CODE ,
           CASH_BILL_GUBUN,
           SEND_FILE_NAME,
           CREATION_DATE ,
           CREATION_EMP_NO )
  			 VALUES 
  			 ( v_edi_history_seq  ,
           TO_CHAR(SYSDATE,'YYYYMMDD'),
           company_cd ,
           bank_cd ,
           'B' ,
           v_filename,
           SYSDATE ,
           emp_no  );
                                                             
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := 'EDI���� �ۼ����̷��̷�  ����' ;
            	  errflag := -20040 ;
                RAISE Err ;
        END;
        
        -------------------------------------------------------------------------------
        -- ���ھ��� �۽ų����� �����ͼ� ������ �����մϴ�.
        -------------------------------------------------------------------------------
        -- ���������� OPEN�մϴ�.  
        BEGIN
            v_output_file := UTL_FILE.FOPEN(FBS_BILL_SEND_DIR , v_filename, 'w');
        EXCEPTION
            WHEN UTL_FILE.INVALID_OPERATION THEN
			          errmsg := 'FILE OPEN ����('||v_filename||')' ;
            	  errflag := -20050 ;
                RAISE Err ;
        END;
        
        fbs_util_pkg.write_log('FBS','[INFO] ' || bank_cd || ' ���ھ����������� ������ �����մϴ�. (���ϸ�: ' ||  v_filename || ')');
        
        -- EDI ������ HEADER RECORD�� �����մϴ�.
        -----------------------------------------
        IF bank_cd = KIUP_BANK_CD THEN -- �������(���ھ���)
	        v_buffer := fbs_util_pkg.sprintf('%2.2s','10') ||                                        -- ���ڵ屸��(10)
	                    fbs_util_pkg.sprintf('%-6.6s','')  ||                                        -- ����1
	                    fbs_util_pkg.sprintf('%-4.4s','')  ||                                        -- ����2
	                    fbs_util_pkg.sprintf('%-4.4s','')  ||                                        -- ����3
	                    fbs_util_pkg.sprintf('%-8.8s',v_today )  ||                                  -- ��������
	                    fbs_util_pkg.sprintf('%-12.12s',SUBSTRB(rec_org_bank.bill_ente_code,1,12))|| -- ��ü�ڵ�
											fbs_util_pkg.sprintf('%-2.2s','03') ||                                       -- �����ڵ� 
	                    fbs_util_pkg.sprintf('%-14.14s',SUBSTRB(v_out_account_no,1,14)) ||           -- ��ݰ��¹�ȣ
	                    fbs_util_pkg.sprintf('%-13.13s','') ||                                       -- ����4	
											fbs_util_pkg.sprintf('%-1.1s','1') ||                                        -- ó������(1,2)
											fbs_util_pkg.sprintf('%-82.82s','') ||                                       -- ����6
	                    fbs_util_pkg.sprintf('%-2.2s','') ;                                          
				ELSIF  bank_cd = HANA_BANK_CD THEN --�ϳ�����(����ī��)
	        v_buffer := fbs_util_pkg.sprintf('%1.1s','S') ||                                         -- ���ڵ屸��(10)
	                    fbs_util_pkg.sprintf('%4.4s','R351')||                                       -- �����ڵ�
	                    fbs_util_pkg.sprintf('%4.4s',SUBSTRB(rec_org_bank.bill_ente_code,1,4)) ||    -- ��ü�ڵ�
	                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                        -- ���񽺱���  
	                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                    -- ���ο�û����
	                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                        -- ��������
	                    fbs_util_pkg.sprintf('%-3.3s','001') ||                                      -- ������ȣ
	                    fbs_util_pkg.sprintf('%-6.6s',v_time) ||                                     -- ���۽ð�  
											fbs_util_pkg.sprintf('%-1.1s','R') ||                                        -- �׽�Ʈ����
											fbs_util_pkg.sprintf('%13.13s',SUBSTRB('999'||v_biz_no,1,13)) ||             -- ����ڹ�ȣ
											fbs_util_pkg.sprintf('%13.13s','') ||                                        -- ���ڱ���ID(����1)
											fbs_util_pkg.sprintf('%-145.145s','') ;                                      -- ����2
			  END IF;
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_buffer );
        EXCEPTION
            WHEN OTHERS THEN
			          errmsg := 'FILE WRITE ����('||v_filename||')-HEADER' ;
            	  errflag := -20060 ;
                RAISE Err ;
        END;
        
        v_trx_seq    := 0;
				v_data_cnt   := 0;
				v_edi_record := 0;

				-- EDI ���ڵ� �Ϸù�ȣ(max)	:�������ں�  
      	SELECT NVL(MAX(b.EDI_RECORD_SEQ),0) 
      	INTO   v_edi_record
      	FROM   T_FB_EDI_HISTORY a ,
      	       T_FB_BILL_PAY_HISTORY b
      	WHERE  a.EDI_HISTORY_SEQ = b.EDI_HISTORY_SEQ
      	AND    A.STD_YMD = v_today ;        

        -- EDI ������ DATA RECORDS �� �����մϴ�.
        -----------------------------------------
        FOR cash_rec IN bill_pay_cursor LOOP

            BEGIN

	            	SELECT NVL( SUBSTR(MAX( LPAD(TRX_SEQ, 15 , '0' )||PAY_SUCCESS_YN ),16,1),'N'),
	            	       NVL( MAX( TRX_SEQ ),0) + 1
	            	INTO   v_pay_success_yn ,
	            	       v_trx_seq  
	            	FROM   T_FB_BILL_PAY_HISTORY
	            	WHERE  PAY_SEQ = cash_rec.pay_seq ;

                IF v_pay_success_yn = 'N' THEN
                	
		              	v_data_cnt   := v_data_cnt + 1; 
		              	v_edi_record := v_edi_record + 1; 
		              	v_data_amt   := v_data_amt + cash_rec.pay_amt;

		                INSERT INTO T_FB_BILL_PAY_HISTORY 
		                 ( PAY_SEQ ,
		                   TRX_SEQ ,
		                   EDI_CREATE_YN ,
		                   TRANSFER_YN,
		                   PAY_SUCCESS_YN,
		                   EDI_HISTORY_SEQ ,
		                   EDI_RECORD_SEQ )
		          			 VALUES 
		          			 ( cash_rec.pay_seq ,
		                   v_trx_seq ,
		                   'Y' ,
		                   'N' ,
		                   'N' ,
		                   v_edi_history_seq ,
		                   v_edi_record );

                    IF  bank_cd = KIUP_BANK_CD THEN 
                   	
                        v_buffer := fbs_util_pkg.sprintf('%2.2s','20') ||                                     -- ���ڵ屸��(20)
                                    fbs_util_pkg.sprintf('%2.2s','00') ||                                     -- �ŷ�����('00','99')
                                    fbs_util_pkg.sprintf('%-14.14s',SUBSTRB(cash_rec.check_no,1,14))||        -- ä�ǹ�ȣ
                                    fbs_util_pkg.sprintf('%-1.1s','2') ||                                     -- ��������('1','2')
                                    fbs_util_pkg.sprintf('%-13.13s',LPAD(TO_CHAR(cash_rec.pay_amt),13,'0'))|| -- ä�Ǳݾ�
                                    fbs_util_pkg.sprintf('%-10.10s',SUBSTRB(cash_rec.regist_no,1,10))||       -- ����ڹ�ȣ
                                    fbs_util_pkg.sprintf('%-12.12s',LPAD(TO_CHAR(v_edi_record),12,'0') )  ||  -- ����1(�ŷ���ȣ)
                                    fbs_util_pkg.sprintf('%-20.20s',v_biz_no ) ||                             -- ���޻����
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.pay_due_ymd) ||                    -- ��ݰ�����
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- ä�Ǹ�����
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                      -- ó�����('0000':����,�ݼ�)
                                    fbs_util_pkg.sprintf('%-8.8s','') ||                                      -- ����2
                                    fbs_util_pkg.sprintf('%-6.6s','') ||                                      -- ����3
                                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                 -- ��ǰ����
                                    fbs_util_pkg.sprintf('%-20.20s','') ||                                    -- ǰ��
                                    fbs_util_pkg.sprintf('%-9.9s','') ||                                      -- ����4
                                    fbs_util_pkg.sprintf('%-2.2s','') ||                                      -- ó��returncode 
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                      -- ����ó������('Y')
                                    fbs_util_pkg.sprintf('%-2.2s','') ;                                       -- ����5

                    ELSIF  bank_cd = HANA_BANK_CD THEN 
                        v_buffer := fbs_util_pkg.sprintf('%1.1s','D') ||                                      -- ���ڵ屸��(D)
                                    fbs_util_pkg.sprintf('%-5.5s',LPAD(TO_CHAR(v_edi_record),5,'0')) ||       -- ����Ÿ�Ϸù�ȣ
                                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                 --��������
                                    fbs_util_pkg.sprintf('%-16.16s',cash_rec.check_no) ||                     -- ī���ȣ  
                                    fbs_util_pkg.sprintf('%-11.11s',cash_rec.franchise_no ) ||                -- ��������ȣ
                                    fbs_util_pkg.sprintf('%-11.11s',LPAD(TO_CHAR(cash_rec.pay_amt),11,'0')) ||-- ���αݾ�
                                    fbs_util_pkg.sprintf('%-3.3s','' )  ||                                    -- ����ȸ��
                                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                     -- ��ġ������δ�
                                    fbs_util_pkg.sprintf('%-3.3s','') ||                                      -- ����Աݰ�ġ�Ⱓ
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- ����Ա�����
                                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                     -- ���Ҽ�����δ�
                                    fbs_util_pkg.sprintf('%-3.3s','') ||                                      -- ������ġ�Ⱓ
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- ��������
                                    fbs_util_pkg.sprintf('%-12.12s','') ||                                    -- ���
                                    fbs_util_pkg.sprintf('%-10.10s','') ||                                    -- ���ι�ȣ
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                      -- �����ڵ�
                                    fbs_util_pkg.sprintf('%-9.9s','') ||                                      -- �������δ������
                                    fbs_util_pkg.sprintf('%-11.11s','') ||                                    -- �������Ա��Ѿ�
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.pay_due_ymd) ||                    -- �����Աݽ�����
                                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                 -- ���ݰ�꼭����                                                                                                                                                                                                                       
                                    fbs_util_pkg.sprintf('%-15.15s','') ||                                    -- ����
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- �ڵ���ü����
                                    fbs_util_pkg.sprintf('%-20.20s','') ||                                    -- ���ּ���ȣ                                                                                                        
                                    fbs_util_pkg.sprintf('%-16.16s','');                                      -- ����

                    END IF;

                    UTL_FILE.PUT_LINE( v_output_file , v_buffer );

                    v_tot_send_cnt := v_tot_send_cnt + 1;                -- ����Ÿ�Ǽ�
                    v_tot_send_amt := v_tot_send_amt + cash_rec.pay_amt; -- ����Ÿ�ѱݾ�
                END IF;
                       
            EXCEPTION
                WHEN OTHERS THEN
                    v_success_yn := 'N';
                    errmsg  := sqlerrm ;
		            	  errflag := -20080 ;
		                RAISE Err ;
            END;
        END LOOP;        

        IF v_data_cnt = 0 THEN
            v_success_yn := 'N';
            errmsg  := '����Ÿ�� �����ϴ�.';
        	  errflag := -20090 ;
            RAISE Err ;
        END IF;
        
        -- EDI ������ END RECORD�� �����մϴ�.
        --------------------------------------
				IF  bank_cd = KIUP_BANK_CD THEN         
		        v_buffer := fbs_util_pkg.sprintf('%2.2s','30' ) ||                                            -- ���ڵ屸��(30)
		                    fbs_util_pkg.sprintf('%6.6s',LPAD(v_tot_send_cnt,6,'0')) ||                       -- �ѰǼ�
		                    fbs_util_pkg.sprintf('%13.13s',LPAD(v_tot_send_amt,13,'0'))||                     -- �ѱݾ�
		                    fbs_util_pkg.sprintf('%-6.6s','000000') ||                                        -- ����ó���Ǽ�
		                    fbs_util_pkg.sprintf('%-13.13s','0000000000000') ||                               -- ����ó���ݾ�
		                    fbs_util_pkg.sprintf('%6.6s','000000') ||                                         -- ����ó���Ǽ�
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                -- ����ó���ݾ�
		                    fbs_util_pkg.sprintf('%91.91s','') ;                                              -- ����
				ELSIF  bank_cd = HANA_BANK_CD THEN
		        v_buffer := fbs_util_pkg.sprintf('%1.1s'   ,'E' ) ||                                          -- ���ڵ屸��(E)
		                    fbs_util_pkg.sprintf('%-5.5s'  ,LPAD(v_tot_send_cnt+2,5,'0'))||                   -- �� �Ƿ� �Ǽ�
		                    fbs_util_pkg.sprintf('%-5.5s'  ,LPAD(v_tot_send_cnt,5,'0'))  ||                   -- �� �Ƿ� �Ǽ�
		                    fbs_util_pkg.sprintf('%-15.15s',LPAD(v_tot_send_amt,15,'0'))||                    -- �� �Ƿ� �ݾ�
		                    fbs_util_pkg.sprintf('%5.5s'   ,'00000') ||                                       -- ������ΰǼ�
		                    fbs_util_pkg.sprintf('%15.15s' ,'000000000000000') ||                             -- ������αݾ�
		                    fbs_util_pkg.sprintf('%15.15s' ,'00000') ||                                       -- �������δ��Ѽ�����
		                    fbs_util_pkg.sprintf('%15.15s' ,'000000000000000') ||                             -- �������Ա��Ѿ�
		                    fbs_util_pkg.sprintf('%5.5s'   ,'00000')||                                        -- ���ο����Ǽ�
		                    fbs_util_pkg.sprintf('%15.15s' ,'000000000000000') ||                             -- ���ο����ݾ�
		                    fbs_util_pkg.sprintf('%11.11s' ,'') ||                                            -- �����ȣ(������������) 
		                    fbs_util_pkg.sprintf('%93.93s' ,'');                                              -- ����
				END IF;                    
 
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_buffer );
        EXCEPTION
            WHEN OTHERS THEN
            	  v_success_yn := 'N';
                errmsg  := 'FILE WRITE ����('||v_filename||')-END' ;
            	  errflag := -20100 ;
                RAISE Err ;
        END;                    

        -- ������ �ݽ��ϴ�.        
        BEGIN
            UTL_FILE.FCLOSE( v_output_file );
        EXCEPTION
            WHEN OTHERS THEN
            		v_success_yn := 'N';
                errmsg  := 'FILE WRITE ����('||v_filename||')' ;
            	  errflag := -20110 ;
                RAISE Err ;
        END;   

        -- ����ó�����ο� ���� ó���Ѵ�.
        IF v_success_yn = 'Y' THEN
        
            /* ������ ���... */
           result_code := CHR(10) ||
                          '�����   : ' || bank_cd || CHR(10) ||
                          '�����Ͻ� : ' || TO_CHAR(SYSDATE,'YYYY/MM/DD hh24:mi:ss') || CHR(10) ||
                          '�� �Ǽ�  : ' || TO_CHAR(NVL(v_tot_send_cnt,0),'999,999,999,999,999') || '��' || CHR(10) ||
                          '�� �ݾ�  : ' || TO_CHAR(NVL(v_tot_send_amt,0),'999,999,999,999,999') || '��';
           
           fbs_util_pkg.write_log('FBS', '[INFO] ���ھ�Ѥ� ���� ������ ���������� �Ϸ�Ǿ����ϴ�.(���ϸ�:'||v_filename||')\n' ||
                                '+--------------------------------------------------------+\n' ||
                                ' * �����    : ' || bank_cd|| '\n' ||
                                ' * �����Ͻ�  : ' || TO_CHAR(SYSDATE,'YYYY/MM/DD hh24:mi:ss') || '\n' ||                    
                                ' * �� �Ǽ�   : ' || TO_CHAR(NVL(v_tot_send_cnt,0),'999,999,999,999,999') || '��\n' ||
                                ' * �� �ݾ�   : ' || TO_CHAR(NVL(v_tot_send_amt,0),'999,999,999,999,999') || '��\n' ||     
                                '+--------------------------------------------------------+\n');
        ELSE
            /* ������ �߻��� ���... */
            errmsg  := sqlerrm ;
         	  errflag := -20120 ; 
            RAISE ERR;
        END IF;  
    
    EXCEPTION
        WHEN ERR THEN
            fbs_util_pkg.write_log('FBS', '[ERROR] ���ھ��� �۽����� ������ ������ �߻��Ͽ����ϴ�.\n (���ϸ�:' || v_filename || ') \n '||errmsg);
            -- ������ �̹� ������ ���� ������ EXCEPTION�̹Ƿ�, �� ������ �����ϴ� ���� 
            IF v_success_yn = 'N' THEN
	            BEGIN
	                UTL_FILE.FCLOSE( v_output_file );
	                v_dummy_return := fbs_util_pkg.exec_os_command(	'del ' || v_bill_send_dir || v_filename );
	            EXCEPTION
	                WHEN OTHERS THEN
	                    fbs_util_pkg.write_log('FBS',sqlerrm);
	            END;
	          END IF;  
            RAISE_APPLICATION_ERROR(errflag,errmsg);
        WHEN OTHERS THEN
            fbs_util_pkg.write_log('FBS', sqlerrm);
            RAISE_APPLICATION_ERROR(-20000, sqlerrm); 
    END ;