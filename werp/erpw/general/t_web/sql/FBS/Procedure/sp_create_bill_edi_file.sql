    /*************************************************************************/
    /*                                                                       */
    /*  1. ¸ðµâID    : create_bill_edi_file                                  */
    /*  2. ¸ðµâÀÌ¸§  : ÀüÀÚ¾îÀ½ BatchÆÄÀÏ »ý¼º                               */
    /*  3. ½Ã½ºÅÛ    : È¸°è½Ã½ºÅÛ                                            */
    /*  4. ¼­ºê½Ã½ºÅÛ: FBS                                                   */
    /*  5. ¸ðµâÀ¯Çü  :                                                       */
    /*  6. ¸ðµâ¾ð¾î  : PL/SQL                                                */
    /*  7. ¸ðµâÈ¯°æ  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ¸ðµâDBMS  : Oracle                                                */
    /*  9. ¸ðµâÀÇ ¸ñÀû ¹× ÁÖ¿ä±â´É                                           */
    /*                                                                       */
    /*      - ÀüÀÚ¾îÀ½Áö±Þ³»¿ªÀ» EDI Batch File »ý¼º                         */
    /*                                                                       */
    /* 10. ÃÖÃÊÀÛ¼ºÀÚ: ¹è¹ÎÁ¤                                                */
    /* 11. ÃÖÃÊÀÛ¼ºÀÏ: 2006³â2¿ù07ÀÏ                                         */
    /* 12. ÃÖÁ¾¼öÁ¤ÀÚ:                                                       */
    /* 13. ÃÖÁ¾¼öÁ¤ÀÏ:                                                       */
    /*************************************************************************/  
    CREATE OR REPLACE Procedure
 					 sp_create_bill_edi_file( company_cd   IN VARCHAR2 ,      -- È¸»çÄÚµå
    																pay_gubun    IN VARCHAR2 ,      -- Áö±Þ±¸ºÐ
                                 		pay_due_ymd  IN VARCHAR2 ,      -- ¹ßÇà¿¹Á¤ÀÏÀÚ     																  
                                 		bank_cd      IN VARCHAR2 ,      -- ÀºÇàÄÚµå 
                                 		account_no   IN VARCHAR2 ,      -- Ãâ±Ý°èÁÂID
                                 		emp_no       IN VARCHAR2 ,      -- »ç¿ø¹øÈ£(ÃÖÁ¾¼öÁ¤ÀÚ)
                                 		result_code  OUT VARCHAR2 ) IS  -- Ã³¸®°á°úÄÚµåç 
                                 
        v_output_file                UTL_FILE.FILE_TYPE;
        
        v_filename                   VARCHAR2(100);              -- ÀÛ¼ºÇÒ ÆÄÀÏ º¯¼ö
        v_out_account_no             VARCHAR2(15);               -- Ãâ±Ý°èÁÂ¹øÈ£
        v_biz_no                     VARCHAR2(12);               -- »ç¾÷ÀÚ¹øÈ£
        v_pay_date                   VARCHAR2(8);                -- Áö±ÞÀÏÀÚ
        v_pay_success_yn						 VARCHAR2(1);                -- Áö±Þ¼º°ø¿©ºÎ

        v_tot_send_cnt               NUMBER := 0;                -- Àü¼ÛµÈ ÃÑ ÀÇ·Ú°Ç¼ö
        v_tot_send_amt               NUMBER := 0;                -- Àü¼ÛµÈ ÃÑ ÀÇ·Ú±Ý¾×
				v_edi_history_seq            NUMBER := 0;                -- EDIÀÏ·Ã¹øÈ£
                    
        v_success_yn                 VARCHAR2(1) := 'Y';         -- Á¤»óÃ³¸®¿©ºÎ(Y OR N)
        v_data_cnt                   NUMBER := 0;                -- µ¥ÀÌÅ¸ COUNT 
        v_data_amt									 NUMBER := 0;                -- µ¥ÀÌÅ¸ ±Ý¾×
        v_edi_record								 NUMBER := 0;                -- edi·¹ÄÚµåÀÏ·Ã¹øÈ£ 	
        v_trx_seq								     NUMBER := 0;                -- °Å·¡ÀÏ·Ã¹øÈ£ 	
        
        v_buffer                     VARCHAR2(500);              -- ÀÓ½Ã¹öÆÛ(ÆÄÀÏWRITE¿ë) 
        v_today                      VARCHAR2(8);                -- ¿À´Ã³¯Â¥(YYYYMMDD)
        v_time                       VARCHAR2(6);                -- ¿À´Ã½Ã°£(HH24MISS)
				v_dummy_return		           VARCHAR2(100);
				
        rec_org_bank            		 T_FB_ORG_BANK%ROWTYPE;      -- °øÅëÄÚµå¸¦ °¡Á®¿Ã RECORDº¯¼ö         
		    /*----------------------------------------------------------------------------*/
		    /* ÀºÇàÄÚµå                                                                   */
		    /*----------------------------------------------------------------------------*/
		    KIUP_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.KIUP_BANK_CD;   -- ±â¾÷ÀºÇà
		    KUKMIN_BANK_CD               VARCHAR2(2) := FBS_MAIN_PKG.KUKMIN_BANK_CD; -- ±¹¹ÎÀºÇà
		    WOORI_BANK_CD                VARCHAR2(2) := FBS_MAIN_PKG.WOORI_BANK_CD;  -- ¿ì¸®ÀºÇà
		    HANA_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.HANA_BANK_CD;   -- ÇÏ³ªÀºÇà        
        -- ÆÄÀÏ DIRECTORY (¿À¶óÅ¬ ³»¿¡ DIRECTORY ·Î CREATEµÇ¾î ÀÖÀ½ ) 
        FBS_BILL_SEND_DIR            VARCHAR2(100) := FBS_UTIL_PKG.FBS_BILL_SEND_DIR; -- ÀüÀÚ¾îÀ½
        v_bill_send_dir              VARCHAR2(200);             -- BATCH ¼Û½Å DIRECTORY          
				-- °øÅë º¯¼ö
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	        
            
        -- ÀüÀÚ¾îÀ½ÀÌÃ¼ data ÃßÃâ CURSOR   
				CURSOR bill_pay_cursor IS        	
            SELECT a.pay_seq               AS pay_seq,        -- Áö±ÞÀÏ·Ã¹øÈ£
            			 a.pay_amt               AS pay_amt,        -- Áö±Þ±Ý¾×
            			 a.check_no              AS check_no,       -- Ã¤±Ç¹øÈ£
            			 a.vat_registration_num  AS regist_no,      -- »ç¾÷ÀÚ¹øÈ£
            			 a.pay_due_ymd           AS pay_due_ymd,    -- ¹ßÇà¿¹Á¤ÀÏÀÚ
            			 a.future_pay_due_ymd    AS future_ymd,     -- ¸¸±âÀÏÀÚ
            			 b.franchise_no          AS franchise_no    -- °¡¸ÍÁ¡¹øÈ£
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
        -- ¿À´Ã³¯Â¥ ,½Ã°£ ¼³Á¤  
        v_today := TO_CHAR(SYSDATE,'YYYYMMDD');
        v_time  := TO_CHAR(SYSDATE,'HH24MISS');
    
        -- ¼Û½Å ÆÄÀÏÀÌ¸§ ¼³Á¤ 
        v_filename := f_get_edi_file_name( company_cd , bank_cd , 'BS'  );
        
        -- ÃÊ±âº¯¼ö¸¦ ¼³Á¤ÇÕ´Ï´Ù.(Ãâ±Ý°èÁÂ¹øÈ£/ÀÌÃ¼ÀÏÀÚ)
        v_out_account_no := REPLACE(account_no,'-',''); 
        v_pay_date       := REPLACE(pay_due_ymd,'-','');
        
        -- ¹°¸®ÀûÀÎ OS»óÀÇ directory¸¦ °¡Á®¿É´Ï´Ù.(from DBA_DIRECTORIES )
        BEGIN
            SELECT DIRECTORY_PATH || '\'
            INTO v_bill_send_dir
            FROM DBA_DIRECTORIES
            WHERE DIRECTORY_NAME = FBS_BILL_SEND_DIR;
        
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := 'DIR ¿¡·¯' ;
            	  errflag := -20010 ;
                RAISE Err ;
        END;         

        -- ÇØ´ç»ç¾÷ÀåÀÇ »ç¾÷ÀÚ¹øÈ£¸¦ °¡Á®¿É´Ï´Ù.
        BEGIN        
            SELECT REPLACE(BIZNO,'-','') AS BIZNO
            INTO v_biz_no
            FROM T_COMPANY 
            WHERE COMP_CODE = company_cd ; 
            
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := '»ç¾÷ÀåÀÇ »ç¾÷ÀÚ¹øÈ£ ¿¡·¯' ;
            	  errflag := -20020 ;
                RAISE Err ;
        END;        
        
        BEGIN
	        -- µî·ÏµÈ SUBJECT NAMEÀ» °¡Á®¿É´Ï´Ù.
	        SELECT *
	        INTO   rec_org_bank
	        FROM   T_FB_ORG_BANK
	        WHERE  COMP_CODE      = company_cd
	        AND    BANK_MAIN_CODE = bank_cd;
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := 'ÀºÇà¿¡ ´ëÇÑ ¾÷Ã¼ÄÚµå ¿¡·¯' ;
            	  errflag := -20030 ;
                RAISE Err ;
        END;  
              
        -- edi ÀÌ·ÂÀÏ·Ã¹øÈ£¸¦ °¡Á®¿É´Ï´Ù.
       	SELECT  T_EDI_HISTORY_SEQ.NEXTVAL
      	INTO    v_edi_history_seq  
      	FROM    DUAL ;
      	
        -------------------------------------------------------------------------------
        -- ÀüÀÚ¾îÀ½ ¼Û½ÅÁ¤º¸¸¦ HISTORY Å×ÀÌºí(T_FB_EDI_HISTORY )¿¡ ³Ö½À´Ï´Ù.
        -------------------------------------------------------------------------------        
       	BEGIN      --EDI»ý¼º ¼Û¼ö½Å ÀÌ·Â 
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
            	  errmsg := 'EDI»ý¼º ¼Û¼ö½ÅÀÌ·ÂÀÌ·Â  ¿¡·¯' ;
            	  errflag := -20040 ;
                RAISE Err ;
        END;
        
        -------------------------------------------------------------------------------
        -- ÀüÀÚ¾îÀ½ ¼Û½Å³»¿ªÀ» °¡Á®¿Í¼­ ÆÄÀÏÀ» »ý¼ºÇÕ´Ï´Ù.
        -------------------------------------------------------------------------------
        -- ¼ö½ÅÆÄÀÏÀ» OPENÇÕ´Ï´Ù.  
        BEGIN
            v_output_file := UTL_FILE.FOPEN(FBS_BILL_SEND_DIR , v_filename, 'w');
        EXCEPTION
            WHEN UTL_FILE.INVALID_OPERATION THEN
			          errmsg := 'FILE OPEN ¿¡·¯('||v_filename||')' ;
            	  errflag := -20050 ;
                RAISE Err ;
        END;
        
        fbs_util_pkg.write_log('FBS','[INFO] ' || bank_cd || ' ÀüÀÚ¾îÀ½¹ßÇàÆÄÀÏ »ý¼ºÀ» ½ÃÀÛÇÕ´Ï´Ù. (ÆÄÀÏ¸í: ' ||  v_filename || ')');
        
        -- EDI ÆÄÀÏÀÇ HEADER RECORD¸¦ »ý¼ºÇÕ´Ï´Ù.
        -----------------------------------------
        IF bank_cd = KIUP_BANK_CD THEN -- ±â¾÷ÀºÇà(ÀüÀÚ¾îÀ½)
	        v_buffer := fbs_util_pkg.sprintf('%2.2s','10') ||                                        -- ·¹ÄÚµå±¸ºÐ(10)
	                    fbs_util_pkg.sprintf('%-6.6s','')  ||                                        -- ¿¹ºñ1
	                    fbs_util_pkg.sprintf('%-4.4s','')  ||                                        -- ¿¹ºñ2
	                    fbs_util_pkg.sprintf('%-4.4s','')  ||                                        -- ¿¹ºñ3
	                    fbs_util_pkg.sprintf('%-8.8s',v_today )  ||                                  -- Àü¼ÛÀÏÀÚ
	                    fbs_util_pkg.sprintf('%-12.12s',SUBSTRB(rec_org_bank.bill_ente_code,1,12))|| -- ¾÷Ã¼ÄÚµå
											fbs_util_pkg.sprintf('%-2.2s','03') ||                                       -- ÀºÇàÄÚµå 
	                    fbs_util_pkg.sprintf('%-14.14s',SUBSTRB(v_out_account_no,1,14)) ||           -- Ãâ±Ý°èÁÂ¹øÈ£
	                    fbs_util_pkg.sprintf('%-13.13s','') ||                                       -- ¿¹ºñ4	
											fbs_util_pkg.sprintf('%-1.1s','1') ||                                        -- Ã³¸®±¸ºÐ(1,2)
											fbs_util_pkg.sprintf('%-82.82s','') ||                                       -- ¿¹ºñ6
	                    fbs_util_pkg.sprintf('%-2.2s','') ;                                          
				ELSIF  bank_cd = HANA_BANK_CD THEN --ÇÏ³ªÀºÇà(±¸¸ÅÄ«µå)
	        v_buffer := fbs_util_pkg.sprintf('%1.1s','S') ||                                         -- ·¹ÄÚµå±¸ºÐ(10)
	                    fbs_util_pkg.sprintf('%4.4s','R351')||                                       -- ¾÷¹«ÄÚµå
	                    fbs_util_pkg.sprintf('%4.4s',SUBSTRB(rec_org_bank.bill_ente_code,1,4)) ||    -- ¾÷Ã¼ÄÚµå
	                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                        -- ¼­ºñ½º±¸ºÐ  
	                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                    -- ½ÂÀÎ¿äÃ»ÀÏÀÚ
	                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                        -- Àü¼ÛÂ÷¼ö
	                    fbs_util_pkg.sprintf('%-3.3s','001') ||                                      -- »ç¾÷Àå¹øÈ£
	                    fbs_util_pkg.sprintf('%-6.6s',v_time) ||                                     -- Àü¼Û½Ã°£  
											fbs_util_pkg.sprintf('%-1.1s','R') ||                                        -- Å×½ºÆ®±¸ºÐ
											fbs_util_pkg.sprintf('%13.13s',SUBSTRB('999'||v_biz_no,1,13)) ||             -- »ç¾÷ÀÚ¹øÈ£
											fbs_util_pkg.sprintf('%13.13s','') ||                                        -- ÀüÀÚ±ÝÀ¶ID(¿¹ºñ1)
											fbs_util_pkg.sprintf('%-145.145s','') ;                                      -- ¿¹ºñ2
			  END IF;
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_buffer );
        EXCEPTION
            WHEN OTHERS THEN
			          errmsg := 'FILE WRITE ¿¡·¯('||v_filename||')-HEADER' ;
            	  errflag := -20060 ;
                RAISE Err ;
        END;
        
        v_trx_seq    := 0;
				v_data_cnt   := 0;
				v_edi_record := 0;

				-- EDI ·¹ÄÚµå ÀÏ·Ã¹øÈ£(max)	:±âÁØÀÏÀÚº°  
      	SELECT NVL(MAX(b.EDI_RECORD_SEQ),0) 
      	INTO   v_edi_record
      	FROM   T_FB_EDI_HISTORY a ,
      	       T_FB_BILL_PAY_HISTORY b
      	WHERE  a.EDI_HISTORY_SEQ = b.EDI_HISTORY_SEQ
      	AND    A.STD_YMD = v_today ;        

        -- EDI ÆÄÀÏÀÇ DATA RECORDS ¸¦ »ý¼ºÇÕ´Ï´Ù.
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
                   	
                        v_buffer := fbs_util_pkg.sprintf('%2.2s','20') ||                                     -- ·¹ÄÚµå±¸ºÐ(20)
                                    fbs_util_pkg.sprintf('%2.2s','00') ||                                     -- °Å·¡±¸ºÐ('00','99')
                                    fbs_util_pkg.sprintf('%-14.14s',SUBSTRB(cash_rec.check_no,1,14))||        -- Ã¤±Ç¹øÈ£
                                    fbs_util_pkg.sprintf('%-1.1s','2') ||                                     -- °áÁ¦±¸ºÐ('1','2')
                                    fbs_util_pkg.sprintf('%-13.13s',LPAD(TO_CHAR(cash_rec.pay_amt),13,'0'))|| -- Ã¤±Ç±Ý¾×
                                    fbs_util_pkg.sprintf('%-10.10s',SUBSTRB(cash_rec.regist_no,1,10))||       -- »ç¾÷ÀÚ¹øÈ£
                                    fbs_util_pkg.sprintf('%-12.12s',LPAD(TO_CHAR(v_edi_record),12,'0') )  ||  -- ¿¹ºñ1(°Å·¡¹øÈ£)
                                    fbs_util_pkg.sprintf('%-20.20s',v_biz_no ) ||                             -- Áö±Þ»ç¾÷Àå
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.pay_due_ymd) ||                    -- Ãâ±Ý°¡´ÉÀÏ
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- Ã¤±Ç¸¸±âÀÏ
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                      -- Ã³¸®°á°ú('0000':Á¤»ó,¹Ý¼Û)
                                    fbs_util_pkg.sprintf('%-8.8s','') ||                                      -- ¿¹ºñ2
                                    fbs_util_pkg.sprintf('%-6.6s','') ||                                      -- ¿¹ºñ3
                                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                 -- ³³Ç°ÀÏÀÚ
                                    fbs_util_pkg.sprintf('%-20.20s','') ||                                    -- Ç°¸ñ
                                    fbs_util_pkg.sprintf('%-9.9s','') ||                                      -- ¿¹ºñ4
                                    fbs_util_pkg.sprintf('%-2.2s','') ||                                      -- Ã³¸®returncode 
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                      -- ÀºÇàÃ³¸®¿©ºÎ('Y')
                                    fbs_util_pkg.sprintf('%-2.2s','') ;                                       -- ¿¹ºñ5

                    ELSIF  bank_cd = HANA_BANK_CD THEN 
                        v_buffer := fbs_util_pkg.sprintf('%1.1s','D') ||                                      -- ·¹ÄÚµå±¸ºÐ(D)
                                    fbs_util_pkg.sprintf('%-5.5s',LPAD(TO_CHAR(v_edi_record),5,'0')) ||       -- µ¥ÀÌÅ¸ÀÏ·Ã¹øÈ£
                                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                 --Àü¼ÛÀÏÀÚ
                                    fbs_util_pkg.sprintf('%-16.16s',cash_rec.check_no) ||                     -- Ä«µå¹øÈ£  
                                    fbs_util_pkg.sprintf('%-11.11s',cash_rec.franchise_no ) ||                -- °¡¸ÍÁ¡¹øÈ£
                                    fbs_util_pkg.sprintf('%-11.11s',LPAD(TO_CHAR(cash_rec.pay_amt),11,'0')) ||-- ½ÂÀÎ±Ý¾×
                                    fbs_util_pkg.sprintf('%-3.3s','' )  ||                                    -- ºÐÇÒÈ¸Â÷
                                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                     -- °ÅÄ¡¼ö¼ö·áºÎ´ã
                                    fbs_util_pkg.sprintf('%-3.3s','') ||                                      -- ´ë±ÝÀÔ±Ý°ÅÄ¡±â°£
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- ´ë±ÝÀÔ±ÝÀÏÀÚ
                                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                     -- ºÐÇÒ¼ö¼ö·áºÎ´ã
                                    fbs_util_pkg.sprintf('%-3.3s','') ||                                      -- °áÁ¦°ÅÄ¡±â°£
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- °áÁ¦ÀÏÀÚ
                                    fbs_util_pkg.sprintf('%-12.12s','') ||                                    -- ºñ°í
                                    fbs_util_pkg.sprintf('%-10.10s','') ||                                    -- ½ÂÀÎ¹øÈ£
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                      -- ¿¡·¯ÄÚµå
                                    fbs_util_pkg.sprintf('%-9.9s','') ||                                      -- °¡¸ÍÁ¡ºÎ´ã¼ö¼ö·á
                                    fbs_util_pkg.sprintf('%-11.11s','') ||                                    -- °¡¸ÍÁ¡ÀÔ±ÝÃÑ¾×
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.pay_due_ymd) ||                    -- ÃÖÃÊÀÔ±Ý½ÃÀÛÀÏ
                                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                 -- ¼¼±Ý°è»ê¼­ÀÏÀÚ                                                                                                                                                                                                                       
                                    fbs_util_pkg.sprintf('%-15.15s','') ||                                    -- Àû¿ä
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- ÀÚµ¿ÀÌÃ¼ÀÏÀÚ
                                    fbs_util_pkg.sprintf('%-20.20s','') ||                                    -- ¹ßÁÖ¼­¹øÈ£                                                                                                        
                                    fbs_util_pkg.sprintf('%-16.16s','');                                      -- ¿¹ºñ

                    END IF;

                    UTL_FILE.PUT_LINE( v_output_file , v_buffer );

                    v_tot_send_cnt := v_tot_send_cnt + 1;                -- µ¥ÀÌÅ¸°Ç¼ö
                    v_tot_send_amt := v_tot_send_amt + cash_rec.pay_amt; -- µ¥ÀÌÅ¸ÃÑ±Ý¾×
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
            errmsg  := 'µ¥ÀÌÅ¸°¡ ¾ø½À´Ï´Ù.';
        	  errflag := -20090 ;
            RAISE Err ;
        END IF;
        
        -- EDI ÆÄÀÏÀÇ END RECORD¸¦ »ý¼ºÇÕ´Ï´Ù.
        --------------------------------------
				IF  bank_cd = KIUP_BANK_CD THEN         
		        v_buffer := fbs_util_pkg.sprintf('%2.2s','30' ) ||                                            -- ·¹ÄÚµå±¸ºÐ(30)
		                    fbs_util_pkg.sprintf('%6.6s',LPAD(v_tot_send_cnt,6,'0')) ||                       -- ÃÑ°Ç¼ö
		                    fbs_util_pkg.sprintf('%13.13s',LPAD(v_tot_send_amt,13,'0'))||                     -- ÃÑ±Ý¾×
		                    fbs_util_pkg.sprintf('%-6.6s','000000') ||                                        -- Á¤»óÃ³¸®°Ç¼ö
		                    fbs_util_pkg.sprintf('%-13.13s','0000000000000') ||                               -- Á¤»óÃ³¸®±Ý¾×
		                    fbs_util_pkg.sprintf('%6.6s','000000') ||                                         -- ¿¡·¯Ã³¸®°Ç¼ö
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                -- ¿¡·¯Ã³¸®±Ý¾×
		                    fbs_util_pkg.sprintf('%91.91s','') ;                                              -- ¿¹ºñ
				ELSIF  bank_cd = HANA_BANK_CD THEN
		        v_buffer := fbs_util_pkg.sprintf('%1.1s'   ,'E' ) ||                                          -- ·¹ÄÚµå±¸ºÐ(E)
		                    fbs_util_pkg.sprintf('%-5.5s'  ,LPAD(v_tot_send_cnt+2,5,'0'))||                   -- ÃÑ ÀÇ·Ú °Ç¼ö
		                    fbs_util_pkg.sprintf('%-5.5s'  ,LPAD(v_tot_send_cnt,5,'0'))  ||                   -- ÃÑ ÀÇ·Ú °Ç¼ö
		                    fbs_util_pkg.sprintf('%-15.15s',LPAD(v_tot_send_amt,15,'0'))||                    -- ÃÑ ÀÇ·Ú ±Ý¾×
		                    fbs_util_pkg.sprintf('%5.5s'   ,'00000') ||                                       -- Á¤»ó½ÂÀÎ°Ç¼ö
		                    fbs_util_pkg.sprintf('%15.15s' ,'000000000000000') ||                             -- Á¤»ó½ÂÀÎ±Ý¾×
		                    fbs_util_pkg.sprintf('%15.15s' ,'00000') ||                                       -- °¡¸ÍÁ¡ºÎ´ãÃÑ¼ö¼ö·á
		                    fbs_util_pkg.sprintf('%15.15s' ,'000000000000000') ||                             -- °¡¸ÍÁ¡ÀÔ±ÝÃÑ¾×
		                    fbs_util_pkg.sprintf('%5.5s'   ,'00000')||                                        -- ½ÂÀÎ¿¡·¯°Ç¼ö
		                    fbs_util_pkg.sprintf('%15.15s' ,'000000000000000') ||                             -- ½ÂÀÎ¿¡·¯±Ý¾×
		                    fbs_util_pkg.sprintf('%11.11s' ,'') ||                                            -- º¹±âºÎÈ£(°ËÁõÇÏÁö¾ÊÀ½) 
		                    fbs_util_pkg.sprintf('%93.93s' ,'');                                              -- ¿¹ºñ
				END IF;                    
 
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_buffer );
        EXCEPTION
            WHEN OTHERS THEN
            	  v_success_yn := 'N';
                errmsg  := 'FILE WRITE ¿¡·¯('||v_filename||')-END' ;
            	  errflag := -20100 ;
                RAISE Err ;
        END;                    

        -- ÆÄÀÏÀ» ´Ý½À´Ï´Ù.        
        BEGIN
            UTL_FILE.FCLOSE( v_output_file );
        EXCEPTION
            WHEN OTHERS THEN
            		v_success_yn := 'N';
                errmsg  := 'FILE WRITE ¿¡·¯('||v_filename||')' ;
            	  errflag := -20110 ;
                RAISE Err ;
        END;   

        -- Á¤»óÃ³¸®¿©ºÎ¿¡ µû¶ó¼­ Ã³¸®ÇÑ´Ù.
        IF v_success_yn = 'Y' THEN
        
            /* Á¤»óÀÎ °æ¿ì... */
           result_code := CHR(10) ||
                          'ÀºÇà¸í   : ' || bank_cd || CHR(10) ||
                          '»ý¼ºÀÏ½Ã : ' || TO_CHAR(SYSDATE,'YYYY/MM/DD hh24:mi:ss') || CHR(10) ||
                          'ÃÑ °Ç¼ö  : ' || TO_CHAR(NVL(v_tot_send_cnt,0),'999,999,999,999,999') || '°Ç' || CHR(10) ||
                          'ÃÑ ±Ý¾×  : ' || TO_CHAR(NVL(v_tot_send_amt,0),'999,999,999,999,999') || '¿ø';
           
           fbs_util_pkg.write_log('FBS', '[INFO] ÀüÀÚ¾î¤Ñ¤± ÆÄÀÏ »ý¼ºÀÌ Á¤»óÀûÀ¸·Î ¿Ï·áµÇ¾ú½À´Ï´Ù.(ÆÄÀÏ¸í:'||v_filename||')\n' ||
                                '+--------------------------------------------------------+\n' ||
                                ' * ÀºÇà¸í    : ' || bank_cd|| '\n' ||
                                ' * »ý¼ºÀÏ½Ã  : ' || TO_CHAR(SYSDATE,'YYYY/MM/DD hh24:mi:ss') || '\n' ||                    
                                ' * ÃÑ °Ç¼ö   : ' || TO_CHAR(NVL(v_tot_send_cnt,0),'999,999,999,999,999') || '°Ç\n' ||
                                ' * ÃÑ ±Ý¾×   : ' || TO_CHAR(NVL(v_tot_send_amt,0),'999,999,999,999,999') || '¿ø\n' ||     
                                '+--------------------------------------------------------+\n');
        ELSE
            /* ¿À·ù°¡ ¹ß»ýÇÑ °æ¿ì... */
            errmsg  := sqlerrm ;
         	  errflag := -20120 ; 
            RAISE ERR;
        END IF;  
    
    EXCEPTION
        WHEN ERR THEN
            fbs_util_pkg.write_log('FBS', '[ERROR] ÀüÀÚ¾îÀ½ ¼Û½ÅÆÄÀÏ »ý¼º½Ã ¿À·ù°¡ ¹ß»ýÇÏ¿´½À´Ï´Ù.\n (ÆÄÀÏ¸í:' || v_filename || ') \n '||errmsg);
            -- ÆÄÀÏÀÌ ÀÌ¹Ì »ý¼ºµÈ ´ÙÀ½ ³ª¿À´Â EXCEPTIONÀÌ¹Ç·Î, ÀÌ ÆÄÀÏÀ» »èÁ¦ÇÏ´Â ·ÎÁ÷ 
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