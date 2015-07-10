    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : sp_read_bill_vendor_info                              */
    /*  2. 모듈이름  : 전자어음약정업체 처리결과 수신                        */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : HP-UX + Oracle 9.2.0                                  */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 수신된 wjswkdjdma Batch내역을 읽어서 연관TABLE에 UPDATE한다.   */
    /*      - 연관TABLE                                                      */
    /*                                                                       */
    /*    < 수정 이력 >                                                      */
    /*                                                                       */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년2월09일                                         */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
		CREATE OR REPLACE Procedure
    		 sp_read_bill_vendor_info( comp_code        IN VARCHAR2 ,       -- 시압징코드
    		                           bank_code        IN VARCHAR2 ,       -- 은행코드
    		                           emp_no           IN VARCHAR2 ) IS    -- 사원번호

        v_input_file        UTL_FILE.FILE_TYPE;
        v_filename          VARCHAR2(100);
        v_buffer            VARCHAR2(4000);
        v_gubun             VARCHAR2(2) := '';  /* 수신파일의 각 행의 자료TYPE을 구분하는 구분 필드 */
    		v_job_gubun         VARCHAR2(100);
    		v_result            VARCHAR2(100);             -- EFT프로그램 호출 결과값 
    		v_comp_code         VARCHAR2(2);	
    		v_cust_seq          NUMBER;
    		FBS_BILL_RECV_DIR   VARCHAR2(100) := FBS_UTIL_PKG.FBS_BILL_RECV_DIR; -- 전자어음 
		    /*----------------------------------------------------------------------------*/
		    /* 은행코드                                                                   */
		    /*----------------------------------------------------------------------------*/
		    KIUP_BANK_CD        VARCHAR2(2) := FBS_MAIN_PKG.KIUP_BANK_CD;   -- 기업은행
		    KUKMIN_BANK_CD      VARCHAR2(2) := FBS_MAIN_PKG.KUKMIN_BANK_CD; -- 국민은행
		    WOORI_BANK_CD       VARCHAR2(2) := FBS_MAIN_PKG.WOORI_BANK_CD;  -- 우리은행
		    HANA_BANK_CD        VARCHAR2(2) := FBS_MAIN_PKG.HANA_BANK_CD;   -- 하나은행    		   			
		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   : 송수신파일 HEADER RECORD                                  */
		    /*----------------------------------------------------------------------------*/      
		    TYPE START_RECORD IS RECORD (
		        gubun                 VARCHAR2(2),       /* 레코드구분      "10"          */
		        ente_code             VARCHAR2(8),       /* 업체코드                      */
		        bank_code             VARCHAR2(2),       /* 은행코드                      */
		        tran_date             VARCHAR2(8));      /* 전송일자                      */
		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   : 송수신파일 DATA RECORD                           */
		    /*----------------------------------------------------------------------------*/     
		    TYPE DATA_RECORD IS RECORD (
		        gubun                  VARCHAR2(2),	     /* 레코드구분     "20"           */
		        vendor_num             VARCHAR2(10),     /* 사업자번호                    */
		        vendor_name            VARCHAR2(30),     /* 업체명                        */
		        contract_gubun         VARCHAR2(1),      /* 구분(0:신규,1:변경,2:해지)    */
		        create_date            VARCHAR2(8),      /* 신규일자                      */
		        change_date            VARCHAR2(8),      /* 변경일자                      */
		        acct_no                VARCHAR2(15),     /* 계좌번호                      */
		        franchise_no           VARCHAR2(16));    /* 가맹점번호                    */
 		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   :  송수신파일 END RECORD                            */
		    /*----------------------------------------------------------------------------*/        
		    TYPE END_RECORD IS RECORD (
		        gubun 	               VARCHAR2(2),      /* 레코드구분     "30"           */
		        tot_send_cnt           VARCHAR2(6),      /* 총전소건수                    */
		        new_send_cnt           VARCHAR2(6),      /* 신규건수                      */
		        cha_send_cnt           VARCHAR2(6),      /* 변경건수                      */  
		        hae_send_cnt           VARCHAR2(6));     /* 해지건수                      */

        v_start_rec     START_RECORD;         /* 파일 HEADER RECORD */
        v_edidata_rec   DATA_RECORD;          /* 파일 DATA RECORD   */
        v_ediend_rec    END_RECORD;           /* 파일 END RECORD    */
                
    BEGIN
        -- 수신 파일이름 설정 
        v_filename := f_get_edi_file_name( comp_code , bank_code , 'V' ,'' );

				-- 파일수신하기  			    	
    		v_result := f_recieve_file_from_van( v_filename ,'V',comp_code,bank_code );

    		IF v_result = 'ERROR' THEN 
    			 RAISE_APPLICATION_ERROR(-20000,'파일수신에러');
				END IF;    			 

        -- 수신파일을 open합니다.  
        v_input_file := UTL_FILE.FOPEN(FBS_BILL_RECV_DIR, v_filename, 'r');
        fbs_util_pkg.write_log('FBS','[INFO] '||comp_code||' '|| bank_code||' 전자어음 수신파일처리를 시작합니다. (파일명: ' ||  v_filename || ')');
            -- 파일을 읽어, DB작업을 합니다.
        BEGIN
            LOOP
              -- 파일을 읽습니다.
              UTL_FILE.GET_LINE(v_input_file, v_buffer);
    
              IF bank_code = KIUP_BANK_CD THEN 

	              -- 구분에 따라서 각 FIELD를 셋팅한다.
	              v_gubun := SUBSTR(v_buffer, 1, 2); 

                IF v_gubun = '10' THEN /* HEADER 레코드인 경우 */ 
                    v_start_rec.gubun         := SUBSTRB(v_buffer, 1,2);    -- 레코드구분 
                    v_start_rec.ente_code     := SUBSTRB(v_buffer, 3,8);    -- 업체번호
                    v_start_rec.bank_code     := SUBSTRB(v_buffer, 11,2);   -- 은행코드
                    v_start_rec.tran_date     := SUBSTRB(v_buffer, 14,8);   -- 전송일자
                ELSIF v_gubun = '20' THEN  /* DATA 레코드의 경우  */
                    v_edidata_rec.gubun          := SUBSTRB(v_buffer,  1, 2);   -- 레코드구분 
                    v_edidata_rec.vendor_num     := SUBSTRB(v_buffer, 14,10);   -- 사업자번호
                    v_edidata_rec.vendor_name    := SUBSTRB(v_buffer, 37,30);   -- 업체명 
                    v_edidata_rec.contract_gubun := SUBSTRB(v_buffer, 67, 1);   -- 구분(0:신규,1:변경,2:해지)
                    v_edidata_rec.create_date    := SUBSTRB(v_buffer, 69, 8);   -- 신규일자 
                    v_edidata_rec.change_date    := SUBSTRB(v_buffer, 78,8);    -- 변경일자
                    v_edidata_rec.acct_no        := SUBSTRB(v_buffer, 91,15);   -- 계좌번호
                ELSIF v_gubun = '30' THEN /* END 레코드의 경우 */                
                    v_ediend_rec.gubun         := SUBSTRB(v_buffer, 1, 2);    -- 레코드구분
                    v_ediend_rec.tot_send_cnt  := SUBSTRB(v_buffer, 3, 6);    -- 총전소건수
                    v_ediend_rec.new_send_cnt  := SUBSTRB(v_buffer, 9, 6);    -- 신규건수
                    v_ediend_rec.cha_send_cnt  := SUBSTRB(v_buffer, 15,6);    -- 변경건수
                    v_ediend_rec.hae_send_cnt  := SUBSTRB(v_buffer, 21,6);    -- 해지건수
                END IF;
              ELSIF bank_code = HANA_BANK_CD THEN 
              	
	              -- 구분에 따라서 각 FIELD를 셋팅한다.
	              v_gubun := SUBSTR(v_buffer, 1, 1); 

                IF v_gubun = 'S' THEN /* HEADER 레코드인 경우 */ 
                    v_start_rec.gubun         := SUBSTRB(v_buffer, 1,1);    -- 레코드구분 
                    v_start_rec.ente_code     := SUBSTRB(v_buffer, 7,4);    -- 업체코드
                    v_start_rec.bank_code     := '81';                      -- 은행코드
                    v_start_rec.tran_date     := SUBSTRB(v_buffer, 16,8);   -- 전송일자
                ELSIF v_gubun = 'D' THEN  /* DATA 레코드의 경우  */       
                    v_edidata_rec.gubun          := SUBSTRB(v_buffer,1 ,  1);   -- 레코드구분 
                    v_edidata_rec.vendor_num     := SUBSTRB(v_buffer,463,13);   -- 사업자번호
                    v_edidata_rec.vendor_name    := SUBSTRB(v_buffer,11 ,32);   -- 업체명
                    v_edidata_rec.contract_gubun := SUBSTRB(v_buffer,93 , 1);   -- 구분(0:신규,9:해지)
                    v_edidata_rec.create_date    := SUBSTRB(v_buffer,94 , 8);   -- 신규일자
                    v_edidata_rec.change_date    := SUBSTRB(v_buffer,102, 8);   -- 변경일자
                    v_edidata_rec.franchise_no   := SUBSTRB(v_buffer,45 , 16);  -- 가맹점번호
                ELSIF v_gubun = 'E' THEN /* END 레코드의 경우 */                
                    v_ediend_rec.gubun        := SUBSTRB(v_buffer, 1,  1);    -- 레코드구분
                    v_ediend_rec.tot_send_cnt := SUBSTRB(v_buffer,11,  5);    -- 총의뢰건수
                END IF;
            	END IF;			  

	            --사업장정보
              BEGIN
                  SELECT comp_code
                  INTO v_comp_code
                  FROM T_FB_ORG_BANK
                  WHERE BANK_MAIN_CODE = v_start_rec.bank_code
                  AND ENTE_CODE = v_start_rec.ente_code   ;
              
              EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                      RAISE_APPLICATION_ERROR(-20010,v_start_rec.bank_code||'('||v_start_rec.ente_code||') 업체코드가 없습니다.');
			            WHEN OTHERS THEN
			                RAISE_APPLICATION_ERROR(-20010,sqlerrm);
              END;

              -- 데이타에 따라 에러메시지 설정 및 DB작업을 수행합니다.
              IF  ( v_gubun = '22'  OR v_gubun = 'D'  ) THEN
					  
					            --거래처일련번호(거래처정보에 없으면에러)
                      BEGIN
                          SELECT cust_seq
                          INTO v_cust_seq
                          FROM T_CUST_CODE
                          WHERE CUST_CODE = v_edidata_rec.vendor_num ;
                      
                      EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                              RAISE_APPLICATION_ERROR(-20010,v_edidata_rec.vendor_name||'('||v_edidata_rec.vendor_num||') 거래처가 없습니다.');
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
											      ATTRIBUTE1 )/* 신규일자 */
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

	                         -- UPDATE합니다. 
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
            WHEN NO_DATA_FOUND THEN    -- 파일을 다 읽은 경우..
                UTL_FILE.FCLOSE( v_input_file );
            WHEN OTHERS THEN
                UTL_FILE.FCLOSE( v_input_file );
                RAISE_APPLICATION_ERROR(-20020,sqlerrm);
        END;

        /* 정상인 경우이므로, COMMIT을 수행하고, 오류가 난 경우, ROLLBACK수행 .*/  
        fbs_util_pkg.write_log('FBS','[INFO] 수신파일 처리가 완료되었습니다.');        			  
    
    EXCEPTION
        WHEN UTL_FILE.INVALID_OPERATION THEN
            fbs_util_pkg.write_log('FBS', 'ORA-20004  수신파일 열기에 실패 (파일명:' || v_filename || ')');
						RAISE_APPLICATION_ERROR(-20010,'수신파일 열기에 실패');											
        WHEN OTHERS THEN
        	  ROLLBACK;
            fbs_util_pkg.write_log('FBS', sqlerrm);
						RAISE_APPLICATION_ERROR(-20030,sqlerrm);
    END ;