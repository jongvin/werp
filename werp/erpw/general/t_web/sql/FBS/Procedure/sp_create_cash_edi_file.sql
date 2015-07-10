    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : create_cash_edi_file                                  */
    /*  2. ����̸�  : ������ü Batch���� ����                               */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ������ü������ EDI Batch File ����                             */
    /*                                                                       */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��1��27��                                         */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/  
    CREATE OR REPLACE Procedure
 					 sp_create_cash_edi_file( company_cd   IN VARCHAR2 ,      -- ȸ���ڵ�
    																pay_gubun    IN VARCHAR2 ,      -- ���ޱ���
                                 		pay_due_ymd  IN VARCHAR2 ,      -- ���޿�������
                                 		bank_cd      IN VARCHAR2 ,      -- �����ڵ� 
                                 		account_no   IN VARCHAR2 ,      -- ��ݰ���ID
                                 		emp_no       IN VARCHAR2 ,      -- �����ȣ(����������)
                                 		result_code  OUT VARCHAR2,      -- ó������ڵ� 
                                 		edi_date     IN VARCHAR2 DEFAULT NULL ) IS  
                                 
        v_output_file                UTL_FILE.FILE_TYPE;
        
        v_filename                   VARCHAR2(100);              -- �ۼ��� ���� ����
        v_out_account_no             VARCHAR2(15);               -- ��ݰ��¹�ȣ
        v_biz_no                     VARCHAR2(12);               -- ����ڹ�ȣ
        v_pay_date                   VARCHAR2(8);                -- ��������
        v_pay_success_yn						 VARCHAR2(1);                -- ���޼�������
        v_account_pass						   VARCHAR2(4);                -- ���º�й�ȣ

        v_tot_send_cnt               NUMBER := 0;                -- ���۵� �� �ǷڰǼ�
        v_tot_send_amt               NUMBER := 0;                -- ���۵� �� �Ƿڱݾ�
				v_edi_history_seq            NUMBER := 0;                -- EDI�Ϸù�ȣ
                    
        v_success_yn                 VARCHAR2(1) := 'Y';         -- ����ó������(Y OR N)
        v_data_cnt                   NUMBER := 0;                -- ����Ÿ COUNT 
        v_data_amt									 NUMBER := 0;                -- ����Ÿ �ݾ�
        v_error_msg                  VARCHAR2(300);              -- �� �࿡ ���Ͽ� ó���Ҷ� ������ ���, �����޽��� 
        v_edi_record								 NUMBER := 0;                -- edi���ڵ��Ϸù�ȣ 	
        v_trx_seq								     NUMBER := 0;                -- �ŷ��Ϸù�ȣ 	
        
        v_buffer                     VARCHAR2(500);              -- �ӽù���(����WRITE��) 
        v_today                      VARCHAR2(8);                -- ���ó�¥(YYYYMMDD)
				v_dummy_return		           VARCHAR2(100);
				
        rec_org_bank            		 T_FB_ORG_BANK%ROWTYPE;      -- �����ڵ带 ������ RECORD����         
	      v_batch_sign_no              VARCHAR2(8) := NULL;        -- �����ȣ
        v_send_cnt                   NUMBER := 0;                -- ���۵� �� �ǷڰǼ�
        v_send_amt                   NUMBER := 0;                -- ���۵� �� �Ƿڱݾ�  
        
		    /*----------------------------------------------------------------------------*/
		    /* �����ڵ�                                                                   */
		    /*----------------------------------------------------------------------------*/
		    KIUP_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.KIUP_BANK_CD;   -- �������
		    KUKMIN_BANK_CD               VARCHAR2(2) := FBS_MAIN_PKG.KUKMIN_BANK_CD; -- ��������
		    WOORI_BANK_CD                VARCHAR2(2) := FBS_MAIN_PKG.WOORI_BANK_CD;  -- �츮����
		    HANA_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.HANA_BANK_CD;   -- �ϳ�����
		    
        -- ���� DIRECTORY (����Ŭ ���� DIRECTORY �� CREATE�Ǿ� ���� ) 
        v_cash_send_dir              VARCHAR2(200);             -- BATCH �۽� DIRECTORY          
        v_result                     VARCHAR2(200);

				-- ���� ����
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				-- User Define Error
				Err         			EXCEPTION;                 -- Select Data Not Found  
            
        -- ������ü data ���� CURSOR   
				CURSOR cash_pay_cursor IS        	
            SELECT a.pay_seq                       AS pay_seq,        -- �����Ϸù�ȣ
            			 b.div_seq                       AS div_seq,        -- �����Ϸù�ȣ	
            			 b.pay_amt                       AS pay_amt,        -- �������ޱݾ�
            			 a.in_bank_code                  AS in_bank_code,   -- �Ա������ڵ�
            			 REPLACE(a.in_account_no,'-','') AS in_account_no,  -- �Աݰ��¹�ȣ
            			 c.cust_code                     AS cust_no         -- �ŷ�ó����ڹ�ȣ
	            FROM T_FB_CASH_PAY_DATA a,
	                 T_FB_CASH_PAY_DIVIDED_DATA  b,
	                 T_CUST_CODE                 C
             WHERE a.pay_seq           = b.pay_seq
               AND a.cust_seq          = c.cust_seq
               AND a.comp_code         = company_cd
               AND a.pay_kind_gubun    LIKE pay_gubun||'%'
               AND a.out_bank_code     = bank_cd
               AND a.pay_due_ymd       = REPLACE(pay_due_ymd,'-','')
               AND REPLACE(a.out_account_no ,'-','') = account_no
               AND a.pay_status IN ('2','5','6')
               AND a.pay_amt - nvl(a.pay_success_amt,0) > 0 
               AND a.edi_create_req_yn = 'Y'
             ORDER BY a.pay_seq ,
                      b.div_seq ;
        
    BEGIN
        -- ���ó�¥ ����  
        v_today := TO_CHAR(SYSDATE,'YYYYMMDD');
    
        -- �۽� �����̸� ���� 
        v_filename := f_get_edi_file_name( company_cd , bank_cd , 'CS'  );
        
        -- �ʱ⺯���� �����մϴ�.(��ݰ��¹�ȣ/��ü����)
        v_out_account_no := REPLACE(account_no,'-',''); 
        v_pay_date       := REPLACE(pay_due_ymd,'-','');
        
        -- �������� OS���� directory�� �����ɴϴ�.(from DBA_DIRECTORIES )
        BEGIN
            SELECT DIRECTORY_PATH || '\'
            INTO v_cash_send_dir
            FROM DBA_DIRECTORIES
            WHERE DIRECTORY_NAME = 'FBS_CASH_SEND_DIR';
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            	  errmsg := 'Oracle DIRECTORY ����' ;
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;         
        
        BEGIN
        	
        -- ������������� �����ɴϴ�.(��ü��й�ȣ)
        SELECT fbs_util_pkg.pw_decode( NEW_PASSWORD , 4 ) 
        INTO   v_account_pass
        FROM   T_FB_ACCOUNTS_PWD
        WHERE  ACCOUNT_NO = v_out_account_no ;
        
        -- �ش������� ����ڹ�ȣ�� �����ɴϴ�.
        SELECT REPLACE(aa.BIZNO,'-','') AS BIZNO
          INTO v_biz_no
          FROM T_COMPANY  aa
         WHERE aa.COMP_CODE = company_cd ; 
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            	  errmsg := '��й�ȣ,����ڹ�ȣ ����' ;
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;        
        
        BEGIN
	        -- ��ϵ� SUBJECT NAME�� �����ɴϴ�.
	        SELECT *
	        INTO   rec_org_bank
	        FROM   T_FB_ORG_BANK
	        WHERE  COMP_CODE      = company_cd
	        AND    BANK_MAIN_CODE = bank_cd;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            	  errmsg := '���࿡ ���� ��ü�ڵ� ����' ;
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;  
              
        -- edi �̷��Ϸù�ȣ�� �����ɴϴ�.
       	SELECT  T_EDI_HISTORY_SEQ.NEXTVAL
      	INTO    v_edi_history_seq  
      	FROM    DUAL ;
        -------------------------------------------------------------------------------
        -- ������ü �۽������� HISTORY ���̺�(T_FB_EDI_HISTORY )�� �ֽ��ϴ�.
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
           'C' ,
           v_filename,
           SYSDATE ,
           emp_no  );
                                                             
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := '������ü �̷� ����� ����' ;
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;
        
        -------------------------------------------------------------------------------
        -- ���ھ��� �۽ų����� �����ͼ� ������ �����մϴ�.
        -------------------------------------------------------------------------------    
        -- ���������� OPEN�մϴ�.  
        BEGIN
            v_output_file := UTL_FILE.FOPEN('FBS_CASH_SEND_DIR' , v_filename, 'w');
        EXCEPTION
            WHEN UTL_FILE.INVALID_OPERATION THEN
            	  errmsg := '������ü Batch���� OPEN�� ���� (���ϸ�:' || v_filename || ')';
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;
        
        fbs_util_pkg.write_log('FBS','[INFO] ' || bank_cd || ' ������ü�������� ������ �����մϴ�. (���ϸ�: ' ||  v_filename || ')');   
        
        -- EDI ������ HEADER RECORD�� �����մϴ�.
        -----------------------------------------
        IF bank_cd = KIUP_BANK_CD THEN -- �������
	        v_buffer := fbs_util_pkg.sprintf('%2.2s','11') ||                                   -- ���ڵ屸��(10)
	                    fbs_util_pkg.sprintf('%2.2s',bank_cd)||                                 -- �����ڵ�
	                    fbs_util_pkg.sprintf('%2.2s','82') ||                                   -- �����ڵ�
	                    fbs_util_pkg.sprintf('%-6.6s',SUBSTRB(v_pay_date,3,6)) ||               -- ��ü����
	                    fbs_util_pkg.sprintf('%-6.6s','') ||                                    -- filler 
	                    fbs_util_pkg.sprintf('%-14.14s',SUBSTRB(v_out_account_no,1,14)) ||      -- ��ݰ��¹�ȣ
											fbs_util_pkg.sprintf('%-1.1s','') ||                                    -- filler 
	                    fbs_util_pkg.sprintf('%-7.7s',SUBSTRB(rec_org_bank.ente_code,1,7)) ||   -- ��ü�ڵ�
	                    fbs_util_pkg.sprintf('%-40.40s','') ;  
				ELSIF  bank_cd = HANA_BANK_CD THEN 
	        v_buffer := fbs_util_pkg.sprintf('%1.1s','S') ||                                    -- ���ڵ屸��(10)
	                    fbs_util_pkg.sprintf('%2.2s','10')||                                    -- �����ڵ�
	                    fbs_util_pkg.sprintf('%2.2s',bank_cd) ||                                -- �����ڵ�
	                    fbs_util_pkg.sprintf('%-8.8s',SUBSTRB(rec_org_bank.ente_code,1,8)) ||   -- ��ü�ڵ�   
	                    fbs_util_pkg.sprintf('%-6.6s',SUBSTRB(v_today,3,6)) ||                  -- ��ü�Ƿ�����
	                    fbs_util_pkg.sprintf('%-6.6s',SUBSTRB(v_pay_date,3,6)) ||               -- ��ü���� 
	                    fbs_util_pkg.sprintf('%-14.14s',SUBSTRB(v_out_account_no,1,14)) ||      -- ��ݰ��¹�ȣ
	                    fbs_util_pkg.sprintf('%-2.2s','') ||                                    -- ��ü����  
											fbs_util_pkg.sprintf('%-6.6s','000000') ||                              -- ȸ���ȣ
											fbs_util_pkg.sprintf('%1.1s','1') ||                                    -- ó����� �뺸����
											fbs_util_pkg.sprintf('%1.1s','1') ||                                    -- ��������
											fbs_util_pkg.sprintf('%-8.8s',SUBSTRB(v_account_pass,1,4)) ||           -- ���º�й�ȣ	
	                    fbs_util_pkg.sprintf('%20.20s','')||                                    -- filler  
	                    fbs_util_pkg.sprintf('%1.1s','1')||                                     -- format
	                    fbs_util_pkg.sprintf('%2.2s','LG');                                     -- VAN
				ELSIF  bank_cd = KUKMIN_BANK_CD THEN 
	        v_buffer := fbs_util_pkg.sprintf('%1.1s','S') ||                                    -- ���ڵ屸��(10)
	                    fbs_util_pkg.sprintf('%2.2s','C2')||                                    -- �����ڵ�
	                    fbs_util_pkg.sprintf('%2.2s',bank_cd) ||                                -- �����ڵ�
	                    fbs_util_pkg.sprintf('%-8.8s',SUBSTRB(rec_org_bank.ente_code,1,8)) ||   -- ��ü�ڵ�                    
	                    fbs_util_pkg.sprintf('%-6.6s','') ||                                    -- filler
	                    fbs_util_pkg.sprintf('%-6.6s',SUBSTRB(v_pay_date,3,6)) ||               -- ��ü���� 
	                    fbs_util_pkg.sprintf('%-6.6s','') ||                                    -- filler
	                    fbs_util_pkg.sprintf('%-8.8s',SUBSTRB(rec_org_bank.comp_password,1,8))||-- ��ü��ȣ                    
											fbs_util_pkg.sprintf('%-15.15s',SUBSTRB(v_out_account_no,1,15)) ||      -- ���¹�ȣ
											fbs_util_pkg.sprintf('%-26.26s','');                                    -- filler
				ELSIF  bank_cd = WOORI_BANK_CD THEN 
	        v_buffer := fbs_util_pkg.sprintf('%1.1s','S') ||                                    -- ���ڵ屸��(10)
	                    fbs_util_pkg.sprintf('%2.2s','C2')||                                    -- ȭ�ϱ���
	                    fbs_util_pkg.sprintf('%-10.10s',SUBSTRB(rec_org_bank.ente_code,1,10))|| -- ��ü�ڵ�                    
	                    fbs_util_pkg.sprintf('%2.2s',bank_cd) ||                                -- �����ڵ�                    
	                    fbs_util_pkg.sprintf('%6.6s',SUBSTRB(v_today,3,6)) ||                   -- ��������
	                    fbs_util_pkg.sprintf('%6.6s',SUBSTRB(v_pay_date,3,6)) ||                -- ��ü���� 
											fbs_util_pkg.sprintf('%-15.15s',SUBSTRB(v_out_account_no,1,15)) ||      -- ���¹�ȣ
	                    fbs_util_pkg.sprintf('%-8.8s','') ||                                    -- filler										                    
	                    fbs_util_pkg.sprintf('%-1.1s','') ||                                    -- ��üȸ��
	                    fbs_util_pkg.sprintf('%1.1s','1') ||                                    -- �뺸����
	                    fbs_util_pkg.sprintf('%1.1s','') ||                                     -- filler	
	                    fbs_util_pkg.sprintf('%4.4s','') ||                                     -- filler                     
	                    fbs_util_pkg.sprintf('%-6.6s','LGEDS') ||                               -- VAN�ڵ�
											fbs_util_pkg.sprintf('%17.17s','');                                     -- filler										
			  END IF;
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_buffer );
        EXCEPTION
            WHEN OTHERS THEN
            		v_success_yn := 'N';
            	  errmsg := '������ü Batch���� ������ ���� (���ϸ�:' || v_filename || ')';
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;
        
        v_trx_seq    := 0;
				v_data_cnt   := 0;
				v_edi_record := 0;

				-- EDI ���ڵ� �Ϸù�ȣ(max)	:�������ں�  
      	SELECT NVL(MAX(b.EDI_RECORD_SEQ),0) 
      	INTO   v_edi_record
      	FROM   T_FB_EDI_HISTORY a ,
      	       T_FB_CASH_PAY_HISTORY b
      	WHERE  a.EDI_HISTORY_SEQ = b.EDI_HISTORY_SEQ
      	AND    A.STD_YMD = v_today ;        

        -- EDI ������ DATA RECORDS �� �����մϴ�.
        -----------------------------------------
        FOR cash_history_rec IN cash_pay_cursor LOOP

            BEGIN

	             	BEGIN	            		
	            	SELECT NVL( SUBSTR(MAX( LPAD(TRX_SEQ, 15 , '0' )||PAY_SUCCESS_YN ),16,1),'N'),
	            	       NVL( MAX( TRX_SEQ ),0) + 1
	            	INTO   v_pay_success_yn ,
	            	       v_trx_seq  
	            	FROM   T_FB_CASH_PAY_HISTORY
	            	WHERE  PAY_SEQ = cash_history_rec.pay_seq
	            	AND    DIV_SEQ = cash_history_rec.div_seq ;
	            	
				        EXCEPTION
				            WHEN NO_DATA_FOUND THEN
				                v_pay_success_yn := 'N';
				        END;
              	        	
                IF v_pay_success_yn = 'N' THEN
                	
		              	v_data_cnt   := v_data_cnt + 1; 
		              	v_edi_record := v_edi_record + 1; 
		              	v_data_amt   := v_data_amt + cash_history_rec.pay_amt;
		              	
		              	BEGIN
		                INSERT INTO T_FB_CASH_PAY_HISTORY 
		                 ( PAY_SEQ ,
		                   DIV_SEQ ,
		                   TRX_SEQ ,
		                   EDI_CREATE_YN ,
		                   TRANSFER_YN,
		                   PAY_SUCCESS_YN,
		                   EDI_HISTORY_SEQ ,
		                   EDI_RECORD_SEQ )
		          			 VALUES 
		          			 ( cash_history_rec.pay_seq ,
		                   cash_history_rec.div_seq ,
		                   v_trx_seq ,
		                   'Y' ,
		                   'N' ,
		                   'N' ,
		                   v_edi_history_seq ,
		                   v_edi_record );
		                                                           
				            EXCEPTION
				                WHEN OTHERS THEN
				                	  v_success_yn := 'N';
				                	  v_error_msg := sqlerrm ; 
						            	  errmsg := '���������̷� ������ ���� (T_FB_CASH_PAY_HISTORY)';
						            	  errflag:= -20007 ;
						                RAISE ERR ;
				            END;
                
                    -- ���������� ���, ���¾�ü�ڵ�κ��� �ѱ۸� ó�������� 18����Ʈ�� ���� ����.(���ܻ���) 
                    IF  bank_cd = KIUP_BANK_CD THEN 
                        v_buffer := fbs_util_pkg.sprintf('%2.2s','22') ||                                                -- ���ڵ屸��(22)
                                    fbs_util_pkg.sprintf('%2.2s',cash_history_rec.in_bank_code) ||                       -- �Ա������ڵ�
                                    fbs_util_pkg.sprintf('%2.2s','82') ||                                                -- �����ڵ�
                                    fbs_util_pkg.sprintf('%-6.6s',LPAD(v_edi_record,6,'0')) ||                           -- ����Ÿ�Ϸù�ȣ 
                                    fbs_util_pkg.sprintf('%-14.14s',cash_history_rec.in_account_no) ||                   -- ���¹�ȣ
                                    fbs_util_pkg.sprintf('%-11.11s',LPAD(TO_CHAR(cash_history_rec.pay_amt),11,'0')) ||   -- ��ü�Ƿڱݾ�
                                    fbs_util_pkg.sprintf('%-34.34s','' )  ||                                             -- ��ü������� 
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                                 -- ó������
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                                 -- �Ҵ��ڵ�
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                                 -- �ڱݱ���
                                    fbs_util_pkg.sprintf('%-3.3s','') ;                                                  -- filler

                    ELSIF  bank_cd = HANA_BANK_CD THEN 
                        v_buffer := fbs_util_pkg.sprintf('%1.1s','D') ||                                                 -- ���ڵ屸��(20)
                                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_edi_record,7,'0')) ||                           -- ����Ÿ�Ϸù�ȣ
                                    fbs_util_pkg.sprintf('%-2.2s',cash_history_rec.in_bank_code) ||                      -- �Ա������ڵ�
                                    fbs_util_pkg.sprintf('%-14.14s',cash_history_rec.in_account_no) ||                   -- ���¹�ȣ  
                                    fbs_util_pkg.sprintf('%-11.11s',LPAD(TO_CHAR(cash_history_rec.pay_amt),11,'0')) ||   -- ��ü�Ƿڱݾ�
                                    fbs_util_pkg.sprintf('%-11.11s','00000000000') ||                                    -- ������ü�ݾ�
                                    fbs_util_pkg.sprintf('%-13.13s',cash_history_rec.cust_no )  ||                       -- �ֹ�/����ڹ�ȣ 
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                                 -- ó�����)
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                                 -- �Ҵ��ڵ�
                                    fbs_util_pkg.sprintf('%-12.12s','') ||                                               -- ����
                                    fbs_util_pkg.sprintf('%-4.4s','') ;                                                  -- ����
                    ELSIF  bank_cd = KUKMIN_BANK_CD THEN 
                        v_buffer := fbs_util_pkg.sprintf('%1.1s','D') ||                                                -- ���ڵ屸��(20)
                                    fbs_util_pkg.sprintf('%-5.5s',LPAD(v_edi_record,5,'0')) ||                          -- ����Ÿ�Ϸù�ȣ
                                    fbs_util_pkg.sprintf('%2.2s',cash_history_rec.in_bank_code) ||                      -- �Ա������ڵ�
                                    fbs_util_pkg.sprintf('%-14.14s',cash_history_rec.in_account_no) ||                  -- ���¹�ȣ 
                                    fbs_util_pkg.sprintf('%-10.10s',LPAD(TO_CHAR(cash_history_rec.pay_amt),10,'0')) ||  -- ��ü�Ƿڱݾ�
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                                -- ��ü���
                                    fbs_util_pkg.sprintf('%-4.4s','' )  ||                                              -- ��ü����ڵ�
                                    fbs_util_pkg.sprintf('%-10.10s','0000000000') ||                                    -- ��ü�ݾ�
                                    fbs_util_pkg.sprintf('%-10.10s','') ||                                              -- ��ü�������
                                    fbs_util_pkg.sprintf('%-8.8s','') ||                                                -- ��������
                                    fbs_util_pkg.sprintf('%-12.12s','') ||                                              -- ����  
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                                -- ���ڱ���                                    
                                    fbs_util_pkg.sprintf('%-2.2s','') ;                                                 -- ����
                    ELSIF  bank_cd = WOORI_BANK_CD THEN 
                        v_buffer := fbs_util_pkg.sprintf('%1.1s','D') ||                                                -- ���ڵ屸��(20)
                                    fbs_util_pkg.sprintf('%2.2s',cash_history_rec.in_bank_code) ||                      -- �Ա������ڵ� 
                                    fbs_util_pkg.sprintf('%-15.15s',cash_history_rec.in_account_no) ||                  -- ���¹�ȣ 
                                    fbs_util_pkg.sprintf('%2.2s','40') ||                                               -- �ŷ����� 
                                    fbs_util_pkg.sprintf('%-11.11s',LPAD(TO_CHAR(cash_history_rec.pay_amt),11,'0')) ||  -- ��ü�ݾ�
                                    fbs_util_pkg.sprintf('%-2.2s','') ||                                                -- ��ü����
                                    fbs_util_pkg.sprintf('%-1.1s','' )  ||                                               -- ó������(
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                                 -- �Ҵ��ڵ�
                                    fbs_util_pkg.sprintf('%-10.10s','') ||                                              -- ��ó���ݾ� 
                                    fbs_util_pkg.sprintf('%-24.24s','') ||                                              -- �����ڹ�ȣ/�ֹι�ȣ
                                    fbs_util_pkg.sprintf('%-4.4s',LPAD(v_edi_record,4,'0')) ||                          -- ����Ÿ�Ϸù�ȣ                                     
                                    fbs_util_pkg.sprintf('%-2.2s','') ||                                                -- filler 
                                    fbs_util_pkg.sprintf('%-2.2s','') ;                                                 -- filler 

                    END IF;
                                        
                    UTL_FILE.PUT_LINE( v_output_file , v_buffer );
    
                    v_tot_send_cnt := v_tot_send_cnt + 1;                        -- ����Ÿ�Ǽ�
                    v_tot_send_amt := v_tot_send_amt + cash_history_rec.pay_amt; -- ����Ÿ�ѱݾ�
                END IF;
                       
            EXCEPTION
                WHEN OTHERS THEN
                    v_success_yn := 'N';
                    v_error_msg  := '\n�Ա�����:'||cash_history_rec.in_bank_code||'\n'||
                                    '�Աݰ��¹�ȣ:'||TRIM(cash_history_rec.in_account_no)||'(����ڹ�ȣ:'||''||') \n'||
                                    '�Աݱݾ�:'||cash_history_rec.pay_amt||'��\n\n �����ڷ� ����';
		            	  errmsg := v_error_msg;
		            	  errflag:= -20007 ;
		                RAISE ERR ;
            END;
        END LOOP;        

        IF v_data_cnt = 0 THEN
        	  v_success_yn := 'N';
        	  errmsg := '������ ����Ÿ�� �������� �ʽ��ϴ�.';
        	  errflag:= -20007 ;
            RAISE ERR ;
        END IF;

		    -- �����ȣ
				v_batch_sign_no := fbs_util_pkg.get_batch_sign_no ( v_edi_history_seq, v_send_cnt ,v_send_amt);

        -- EDI ������ END RECORD�� �����մϴ�.
        --------------------------------------
				IF  bank_cd = KIUP_BANK_CD THEN
		        v_buffer := fbs_util_pkg.sprintf('%2.2s','33' ) ||                                               -- ���ڵ屸��(30)
		                    fbs_util_pkg.sprintf('%2.2s',bank_cd) ||                                             -- �����ڵ�
		                    fbs_util_pkg.sprintf('%2.2s','82') ||                                                -- �����ڵ�
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt,7,'0')) ||                         -- �ǷڰǼ�
		                    fbs_util_pkg.sprintf('%-13.13s',LPAD(TO_CHAR(v_tot_send_amt),13,'0')) ||             -- �Ƿڱݾ�
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- ������ݰǼ�
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- ������ݱݾ�
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- �ҴɰǼ�
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- �Ҵɱݾ�
		                    fbs_util_pkg.sprintf('%-6.6s','')||                                                   -- DUMMY FIELD
		                    fbs_util_pkg.sprintf('%-4.4s',v_batch_sign_no)||                                      -- �����ȣ
		                    fbs_util_pkg.sprintf('%-4.4s','');                                                    -- DUMMY FIELD
				ELSIF  bank_cd = HANA_BANK_CD THEN
		        v_buffer := fbs_util_pkg.sprintf('%1.1s','E' ) ||                                                -- ���ڵ屸��(30)
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt,7,'0')) ||                         -- �� �Ƿ� �Ǽ�
		                    fbs_util_pkg.sprintf('%-13.13s',LPAD(TO_CHAR(v_tot_send_amt),13,'0')) ||             -- �� �Ƿ� �ݾ�
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- ������ݰǼ�
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- ������ݱݾ�
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- �ҴɰǼ�
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- �Ҵɱݾ� 
		                    fbs_util_pkg.sprintf('%-8.8s',v_batch_sign_no)||                                      -- �����ȣ
		                    fbs_util_pkg.sprintf('%-11.11s','');                                                  -- DUMMY FIELD
        ELSIF  bank_cd = KUKMIN_BANK_CD THEN 
		        v_buffer := fbs_util_pkg.sprintf('%1.1s','E' ) ||                                                -- ���ڵ屸��(30)
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt+2,7,'0')) ||                       -- �� �Ƿ� �Ǽ�
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt,7,'0')) ||                         -- �� �Ƿ� �Ǽ�                  
		                    fbs_util_pkg.sprintf('%-13.13s',LPAD(TO_CHAR(v_tot_send_amt),13,'0')) ||             -- �� �Ƿ� �ݾ�
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- ������ݰǼ�
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- ������ݱݾ�
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- �ҴɰǼ�
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- �Ҵɱݾ�                     
		                    fbs_util_pkg.sprintf('%-4.4s',v_batch_sign_no)||                                     -- �����ȣ
		                    fbs_util_pkg.sprintf('%-8.8s','');                                                   -- DUMMY FIELD        	
        ELSIF  bank_cd = WOORI_BANK_CD THEN 
		        v_buffer := fbs_util_pkg.sprintf('%1.1s','E' ) ||                                                -- ���ڵ屸��(30)
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt+2,7,'0')) ||                       -- �� �Ƿ� �Ǽ�
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt,7,'0')) ||                         -- �� �Ƿ� �Ǽ�                     
		                    fbs_util_pkg.sprintf('%-13.13s',LPAD(TO_CHAR(v_tot_send_amt),13,'0')) ||             -- �� �Ƿ� �ݾ�
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- ������ݰǼ�
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- ������ݱݾ�
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- �ҴɰǼ�
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- �Ҵɱݾ�                     
		                    fbs_util_pkg.sprintf('%-6.6s',v_batch_sign_no)||                                     -- �����ȣ
												fbs_util_pkg.sprintf('%-4.4s','')||                                                  -- DUMMY FIELD                    
		                    fbs_util_pkg.sprintf('%-2.2s','');                                                   -- DUMMY FIELD        	
				END IF;                    
 
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_buffer );
        EXCEPTION
            WHEN OTHERS THEN
            		v_success_yn := 'N';
            	  errmsg := '������ü Batch���� ������ ���� (���ϸ�:' || v_filename || ')';
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;                    

        -- ������ �ݽ��ϴ�.        
        BEGIN
            UTL_FILE.FCLOSE( v_output_file );
        EXCEPTION
            WHEN OTHERS THEN
            		v_success_yn := 'N';
            	  errmsg := '������ü Batch���� ������ ���� (���ϸ�:' || v_filename || ')';
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;   

        -- ����ó�����ο� ���� ó���Ѵ�.
        IF v_success_yn = 'Y' THEN
        
            /* ������ ���... */
           result_code := CHR(10) ||
                          '�����   : ' || bank_cd || CHR(10) ||
                          '�����Ͻ� : ' || TO_CHAR(SYSDATE,'YYYY/MM/DD hh24:mi:ss') || CHR(10) ||
                          '�� �Ǽ�  : ' || TO_CHAR(NVL(v_tot_send_cnt,0),'999,999,999,999,999') || '��' || CHR(10) ||
                          '�� �ݾ�  : ' || TO_CHAR(NVL(v_tot_send_amt,0),'999,999,999,999,999') || '��';
           
           fbs_util_pkg.write_log('FBS', '[INFO] ������ü ���� ������ ���������� �Ϸ�Ǿ����ϴ�.(���ϸ�:'||v_filename||')\n' ||
                                '+--------------------------------------------------------+\n' ||
                                ' * �����    : ' || bank_cd|| '\n' ||
                                ' * �����Ͻ�  : ' || TO_CHAR(SYSDATE,'YYYY/MM/DD hh24:mi:ss') || '\n' ||                    
                                ' * �� �Ǽ�   : ' || TO_CHAR(NVL(v_tot_send_cnt,0),'999,999,999,999,999') || '��\n' ||
                                ' * �� �ݾ�   : ' || TO_CHAR(NVL(v_tot_send_amt,0),'999,999,999,999,999') || '��\n' ||     
                                '+--------------------------------------------------------+\n');
        ELSE
            /* ������ �߻��� ���... */
            errmsg  := sqlerrm ;
         	  errflag := -20007 ; 
            RAISE ERR;
        END IF;  
    
    EXCEPTION
               
        WHEN ERR THEN
            fbs_util_pkg.write_log('FBS', errmsg);
            BEGIN
                UTL_FILE.FCLOSE( v_output_file );
                v_dummy_return := fbs_util_pkg.exec_os_command(	'del ' || v_cash_send_dir || v_filename );
            EXCEPTION
                WHEN OTHERS THEN
                    fbs_util_pkg.write_log('FBS',sqlerrm);
            END;
            RAISE_APPLICATION_ERROR(errflag,errmsg ||' ����ǿ� �����ϼ���.');
            
        WHEN OTHERS THEN
            fbs_util_pkg.write_log('FBS', sqlerrm);
            RAISE_APPLICATION_ERROR(-20000, sqlerrm); 
    END ;    