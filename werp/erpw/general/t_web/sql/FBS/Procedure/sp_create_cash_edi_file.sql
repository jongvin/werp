    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : create_cash_edi_file                                  */
    /*  2. 모듈이름  : 현금이체 Batch파일 생성                               */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : HP-UX + Oracle 9.2.0                                  */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 현금이체내역을 EDI Batch File 생성                             */
    /*                                                                       */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년1월27일                                         */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/  
    CREATE OR REPLACE Procedure
 					 sp_create_cash_edi_file( company_cd   IN VARCHAR2 ,      -- 회사코드
    																pay_gubun    IN VARCHAR2 ,      -- 지급구분
                                 		pay_due_ymd  IN VARCHAR2 ,      -- 지급예정일자
                                 		bank_cd      IN VARCHAR2 ,      -- 은행코드 
                                 		account_no   IN VARCHAR2 ,      -- 출금계좌ID
                                 		emp_no       IN VARCHAR2 ,      -- 사원번호(최종수정자)
                                 		result_code  OUT VARCHAR2,      -- 처리결과코드 
                                 		edi_date     IN VARCHAR2 DEFAULT NULL ) IS  
                                 
        v_output_file                UTL_FILE.FILE_TYPE;
        
        v_filename                   VARCHAR2(100);              -- 작성할 파일 변수
        v_out_account_no             VARCHAR2(15);               -- 출금계좌번호
        v_biz_no                     VARCHAR2(12);               -- 사업자번호
        v_pay_date                   VARCHAR2(8);                -- 지급일자
        v_pay_success_yn						 VARCHAR2(1);                -- 지급성공여부
        v_account_pass						   VARCHAR2(4);                -- 계좌비밀번호

        v_tot_send_cnt               NUMBER := 0;                -- 전송된 총 의뢰건수
        v_tot_send_amt               NUMBER := 0;                -- 전송된 총 의뢰금액
				v_edi_history_seq            NUMBER := 0;                -- EDI일련번호
                    
        v_success_yn                 VARCHAR2(1) := 'Y';         -- 정상처리여부(Y OR N)
        v_data_cnt                   NUMBER := 0;                -- 데이타 COUNT 
        v_data_amt									 NUMBER := 0;                -- 데이타 금액
        v_error_msg                  VARCHAR2(300);              -- 각 행에 대하여 처리할때 오류난 경우, 오류메시지 
        v_edi_record								 NUMBER := 0;                -- edi레코드일련번호 	
        v_trx_seq								     NUMBER := 0;                -- 거래일련번호 	
        
        v_buffer                     VARCHAR2(500);              -- 임시버퍼(파일WRITE용) 
        v_today                      VARCHAR2(8);                -- 오늘날짜(YYYYMMDD)
				v_dummy_return		           VARCHAR2(100);
				
        rec_org_bank            		 T_FB_ORG_BANK%ROWTYPE;      -- 공통코드를 가져올 RECORD변수         
	      v_batch_sign_no              VARCHAR2(8) := NULL;        -- 복기부호
        v_send_cnt                   NUMBER := 0;                -- 전송된 총 의뢰건수
        v_send_amt                   NUMBER := 0;                -- 전송된 총 의뢰금액  
        
		    /*----------------------------------------------------------------------------*/
		    /* 은행코드                                                                   */
		    /*----------------------------------------------------------------------------*/
		    KIUP_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.KIUP_BANK_CD;   -- 기업은행
		    KUKMIN_BANK_CD               VARCHAR2(2) := FBS_MAIN_PKG.KUKMIN_BANK_CD; -- 국민은행
		    WOORI_BANK_CD                VARCHAR2(2) := FBS_MAIN_PKG.WOORI_BANK_CD;  -- 우리은행
		    HANA_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.HANA_BANK_CD;   -- 하나은행
		    
        -- 파일 DIRECTORY (오라클 내에 DIRECTORY 로 CREATE되어 있음 ) 
        v_cash_send_dir              VARCHAR2(200);             -- BATCH 송신 DIRECTORY          
        v_result                     VARCHAR2(200);

				-- 공통 변수
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				-- User Define Error
				Err         			EXCEPTION;                 -- Select Data Not Found  
            
        -- 현금이체 data 추출 CURSOR   
				CURSOR cash_pay_cursor IS        	
            SELECT a.pay_seq                       AS pay_seq,        -- 지급일련번호
            			 b.div_seq                       AS div_seq,        -- 분할일련번호	
            			 b.pay_amt                       AS pay_amt,        -- 분할지급금액
            			 a.in_bank_code                  AS in_bank_code,   -- 입금은행코드
            			 REPLACE(a.in_account_no,'-','') AS in_account_no,  -- 입금계좌번호
            			 c.cust_code                     AS cust_no         -- 거래처사업자번호
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
        -- 오늘날짜 설정  
        v_today := TO_CHAR(SYSDATE,'YYYYMMDD');
    
        -- 송신 파일이름 설정 
        v_filename := f_get_edi_file_name( company_cd , bank_cd , 'CS'  );
        
        -- 초기변수를 설정합니다.(출금계좌번호/이체일자)
        v_out_account_no := REPLACE(account_no,'-',''); 
        v_pay_date       := REPLACE(pay_due_ymd,'-','');
        
        -- 물리적인 OS상의 directory를 가져옵니다.(from DBA_DIRECTORIES )
        BEGIN
            SELECT DIRECTORY_PATH || '\'
            INTO v_cash_send_dir
            FROM DBA_DIRECTORIES
            WHERE DIRECTORY_NAME = 'FBS_CASH_SEND_DIR';
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            	  errmsg := 'Oracle DIRECTORY 에러' ;
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;         
        
        BEGIN
        	
        -- 출금은행정보를 가져옵니다.(이체비밀번호)
        SELECT fbs_util_pkg.pw_decode( NEW_PASSWORD , 4 ) 
        INTO   v_account_pass
        FROM   T_FB_ACCOUNTS_PWD
        WHERE  ACCOUNT_NO = v_out_account_no ;
        
        -- 해당사업장의 사업자번호를 가져옵니다.
        SELECT REPLACE(aa.BIZNO,'-','') AS BIZNO
          INTO v_biz_no
          FROM T_COMPANY  aa
         WHERE aa.COMP_CODE = company_cd ; 
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            	  errmsg := '비밀번호,사업자번호 에러' ;
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;        
        
        BEGIN
	        -- 등록된 SUBJECT NAME을 가져옵니다.
	        SELECT *
	        INTO   rec_org_bank
	        FROM   T_FB_ORG_BANK
	        WHERE  COMP_CODE      = company_cd
	        AND    BANK_MAIN_CODE = bank_cd;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            	  errmsg := '은행에 대한 업체코드 에러' ;
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;  
              
        -- edi 이력일련번호를 가져옵니다.
       	SELECT  T_EDI_HISTORY_SEQ.NEXTVAL
      	INTO    v_edi_history_seq  
      	FROM    DUAL ;
        -------------------------------------------------------------------------------
        -- 현금이체 송신정보를 HISTORY 테이블(T_FB_EDI_HISTORY )에 넣습니다.
        -------------------------------------------------------------------------------        
       	BEGIN      --EDI생성 송수신 이력 
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
            	  errmsg := '현금이체 이력 저장시 에러' ;
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;
        
        -------------------------------------------------------------------------------
        -- 전자어음 송신내역을 가져와서 파일을 생성합니다.
        -------------------------------------------------------------------------------    
        -- 수신파일을 OPEN합니다.  
        BEGIN
            v_output_file := UTL_FILE.FOPEN('FBS_CASH_SEND_DIR' , v_filename, 'w');
        EXCEPTION
            WHEN UTL_FILE.INVALID_OPERATION THEN
            	  errmsg := '현금이체 Batch파일 OPEN에 실패 (파일명:' || v_filename || ')';
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;
        
        fbs_util_pkg.write_log('FBS','[INFO] ' || bank_cd || ' 현금이체파일파일 생성을 시작합니다. (파일명: ' ||  v_filename || ')');   
        
        -- EDI 파일의 HEADER RECORD를 생성합니다.
        -----------------------------------------
        IF bank_cd = KIUP_BANK_CD THEN -- 기업은행
	        v_buffer := fbs_util_pkg.sprintf('%2.2s','11') ||                                   -- 레코드구분(10)
	                    fbs_util_pkg.sprintf('%2.2s',bank_cd)||                                 -- 은행코드
	                    fbs_util_pkg.sprintf('%2.2s','82') ||                                   -- 업무코드
	                    fbs_util_pkg.sprintf('%-6.6s',SUBSTRB(v_pay_date,3,6)) ||               -- 이체일자
	                    fbs_util_pkg.sprintf('%-6.6s','') ||                                    -- filler 
	                    fbs_util_pkg.sprintf('%-14.14s',SUBSTRB(v_out_account_no,1,14)) ||      -- 출금계좌번호
											fbs_util_pkg.sprintf('%-1.1s','') ||                                    -- filler 
	                    fbs_util_pkg.sprintf('%-7.7s',SUBSTRB(rec_org_bank.ente_code,1,7)) ||   -- 업체코드
	                    fbs_util_pkg.sprintf('%-40.40s','') ;  
				ELSIF  bank_cd = HANA_BANK_CD THEN 
	        v_buffer := fbs_util_pkg.sprintf('%1.1s','S') ||                                    -- 레코드구분(10)
	                    fbs_util_pkg.sprintf('%2.2s','10')||                                    -- 업무코드
	                    fbs_util_pkg.sprintf('%2.2s',bank_cd) ||                                -- 은행코드
	                    fbs_util_pkg.sprintf('%-8.8s',SUBSTRB(rec_org_bank.ente_code,1,8)) ||   -- 업체코드   
	                    fbs_util_pkg.sprintf('%-6.6s',SUBSTRB(v_today,3,6)) ||                  -- 이체의뢰일자
	                    fbs_util_pkg.sprintf('%-6.6s',SUBSTRB(v_pay_date,3,6)) ||               -- 이체일자 
	                    fbs_util_pkg.sprintf('%-14.14s',SUBSTRB(v_out_account_no,1,14)) ||      -- 출금계좌번호
	                    fbs_util_pkg.sprintf('%-2.2s','') ||                                    -- 이체종류  
											fbs_util_pkg.sprintf('%-6.6s','000000') ||                              -- 회사번호
											fbs_util_pkg.sprintf('%1.1s','1') ||                                    -- 처리결과 통보구분
											fbs_util_pkg.sprintf('%1.1s','1') ||                                    -- 전송차수
											fbs_util_pkg.sprintf('%-8.8s',SUBSTRB(v_account_pass,1,4)) ||           -- 계좌비밀번호	
	                    fbs_util_pkg.sprintf('%20.20s','')||                                    -- filler  
	                    fbs_util_pkg.sprintf('%1.1s','1')||                                     -- format
	                    fbs_util_pkg.sprintf('%2.2s','LG');                                     -- VAN
				ELSIF  bank_cd = KUKMIN_BANK_CD THEN 
	        v_buffer := fbs_util_pkg.sprintf('%1.1s','S') ||                                    -- 레코드구분(10)
	                    fbs_util_pkg.sprintf('%2.2s','C2')||                                    -- 업무코드
	                    fbs_util_pkg.sprintf('%2.2s',bank_cd) ||                                -- 은행코드
	                    fbs_util_pkg.sprintf('%-8.8s',SUBSTRB(rec_org_bank.ente_code,1,8)) ||   -- 업체코드                    
	                    fbs_util_pkg.sprintf('%-6.6s','') ||                                    -- filler
	                    fbs_util_pkg.sprintf('%-6.6s',SUBSTRB(v_pay_date,3,6)) ||               -- 이체일자 
	                    fbs_util_pkg.sprintf('%-6.6s','') ||                                    -- filler
	                    fbs_util_pkg.sprintf('%-8.8s',SUBSTRB(rec_org_bank.comp_password,1,8))||-- 업체암호                    
											fbs_util_pkg.sprintf('%-15.15s',SUBSTRB(v_out_account_no,1,15)) ||      -- 계좌번호
											fbs_util_pkg.sprintf('%-26.26s','');                                    -- filler
				ELSIF  bank_cd = WOORI_BANK_CD THEN 
	        v_buffer := fbs_util_pkg.sprintf('%1.1s','S') ||                                    -- 레코드구분(10)
	                    fbs_util_pkg.sprintf('%2.2s','C2')||                                    -- 화일구분
	                    fbs_util_pkg.sprintf('%-10.10s',SUBSTRB(rec_org_bank.ente_code,1,10))|| -- 업체코드                    
	                    fbs_util_pkg.sprintf('%2.2s',bank_cd) ||                                -- 은행코드                    
	                    fbs_util_pkg.sprintf('%6.6s',SUBSTRB(v_today,3,6)) ||                   -- 전송일자
	                    fbs_util_pkg.sprintf('%6.6s',SUBSTRB(v_pay_date,3,6)) ||                -- 이체일자 
											fbs_util_pkg.sprintf('%-15.15s',SUBSTRB(v_out_account_no,1,15)) ||      -- 계좌번호
	                    fbs_util_pkg.sprintf('%-8.8s','') ||                                    -- filler										                    
	                    fbs_util_pkg.sprintf('%-1.1s','') ||                                    -- 이체회수
	                    fbs_util_pkg.sprintf('%1.1s','1') ||                                    -- 통보구분
	                    fbs_util_pkg.sprintf('%1.1s','') ||                                     -- filler	
	                    fbs_util_pkg.sprintf('%4.4s','') ||                                     -- filler                     
	                    fbs_util_pkg.sprintf('%-6.6s','LGEDS') ||                               -- VAN코드
											fbs_util_pkg.sprintf('%17.17s','');                                     -- filler										
			  END IF;
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_buffer );
        EXCEPTION
            WHEN OTHERS THEN
            		v_success_yn := 'N';
            	  errmsg := '현금이체 Batch파일 생성에 실패 (파일명:' || v_filename || ')';
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;
        
        v_trx_seq    := 0;
				v_data_cnt   := 0;
				v_edi_record := 0;

				-- EDI 레코드 일련번호(max)	:기준일자별  
      	SELECT NVL(MAX(b.EDI_RECORD_SEQ),0) 
      	INTO   v_edi_record
      	FROM   T_FB_EDI_HISTORY a ,
      	       T_FB_CASH_PAY_HISTORY b
      	WHERE  a.EDI_HISTORY_SEQ = b.EDI_HISTORY_SEQ
      	AND    A.STD_YMD = v_today ;        

        -- EDI 파일의 DATA RECORDS 를 생성합니다.
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
						            	  errmsg := '현금지급이력 생성에 실패 (T_FB_CASH_PAY_HISTORY)';
						            	  errflag:= -20007 ;
						                RAISE ERR ;
				            END;
                
                    -- 국민은행의 경우, 협력업체코드부분의 한글명 처리때문에 18바이트로 만들어서 보냄.(예외사항) 
                    IF  bank_cd = KIUP_BANK_CD THEN 
                        v_buffer := fbs_util_pkg.sprintf('%2.2s','22') ||                                                -- 레코드구분(22)
                                    fbs_util_pkg.sprintf('%2.2s',cash_history_rec.in_bank_code) ||                       -- 입금은행코드
                                    fbs_util_pkg.sprintf('%2.2s','82') ||                                                -- 업무코드
                                    fbs_util_pkg.sprintf('%-6.6s',LPAD(v_edi_record,6,'0')) ||                           -- 데이타일련번호 
                                    fbs_util_pkg.sprintf('%-14.14s',cash_history_rec.in_account_no) ||                   -- 계좌번호
                                    fbs_util_pkg.sprintf('%-11.11s',LPAD(TO_CHAR(cash_history_rec.pay_amt),11,'0')) ||   -- 이체의뢰금액
                                    fbs_util_pkg.sprintf('%-34.34s','' )  ||                                             -- 업체사용정보 
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                                 -- 처리구분
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                                 -- 불능코드
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                                 -- 자금구분
                                    fbs_util_pkg.sprintf('%-3.3s','') ;                                                  -- filler

                    ELSIF  bank_cd = HANA_BANK_CD THEN 
                        v_buffer := fbs_util_pkg.sprintf('%1.1s','D') ||                                                 -- 레코드구분(20)
                                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_edi_record,7,'0')) ||                           -- 데이타일련번호
                                    fbs_util_pkg.sprintf('%-2.2s',cash_history_rec.in_bank_code) ||                      -- 입금은행코드
                                    fbs_util_pkg.sprintf('%-14.14s',cash_history_rec.in_account_no) ||                   -- 계좌번호  
                                    fbs_util_pkg.sprintf('%-11.11s',LPAD(TO_CHAR(cash_history_rec.pay_amt),11,'0')) ||   -- 이체의뢰금액
                                    fbs_util_pkg.sprintf('%-11.11s','00000000000') ||                                    -- 실제이체금액
                                    fbs_util_pkg.sprintf('%-13.13s',cash_history_rec.cust_no )  ||                       -- 주민/사업자번호 
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                                 -- 처리결과)
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                                 -- 불능코드
                                    fbs_util_pkg.sprintf('%-12.12s','') ||                                               -- 적요
                                    fbs_util_pkg.sprintf('%-4.4s','') ;                                                  -- 공란
                    ELSIF  bank_cd = KUKMIN_BANK_CD THEN 
                        v_buffer := fbs_util_pkg.sprintf('%1.1s','D') ||                                                -- 레코드구분(20)
                                    fbs_util_pkg.sprintf('%-5.5s',LPAD(v_edi_record,5,'0')) ||                          -- 데이타일련번호
                                    fbs_util_pkg.sprintf('%2.2s',cash_history_rec.in_bank_code) ||                      -- 입금은행코드
                                    fbs_util_pkg.sprintf('%-14.14s',cash_history_rec.in_account_no) ||                  -- 계좌번호 
                                    fbs_util_pkg.sprintf('%-10.10s',LPAD(TO_CHAR(cash_history_rec.pay_amt),10,'0')) ||  -- 이체의뢰금액
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                                -- 이체결과
                                    fbs_util_pkg.sprintf('%-4.4s','' )  ||                                              -- 이체결과코드
                                    fbs_util_pkg.sprintf('%-10.10s','0000000000') ||                                    -- 이체금액
                                    fbs_util_pkg.sprintf('%-10.10s','') ||                                              -- 업체사용정보
                                    fbs_util_pkg.sprintf('%-8.8s','') ||                                                -- 통장인자
                                    fbs_util_pkg.sprintf('%-12.12s','') ||                                              -- 예비  
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                                -- 인자구분                                    
                                    fbs_util_pkg.sprintf('%-2.2s','') ;                                                 -- 예비
                    ELSIF  bank_cd = WOORI_BANK_CD THEN 
                        v_buffer := fbs_util_pkg.sprintf('%1.1s','D') ||                                                -- 레코드구분(20)
                                    fbs_util_pkg.sprintf('%2.2s',cash_history_rec.in_bank_code) ||                      -- 입금은행코드 
                                    fbs_util_pkg.sprintf('%-15.15s',cash_history_rec.in_account_no) ||                  -- 계좌번호 
                                    fbs_util_pkg.sprintf('%2.2s','40') ||                                               -- 거래구분 
                                    fbs_util_pkg.sprintf('%-11.11s',LPAD(TO_CHAR(cash_history_rec.pay_amt),11,'0')) ||  -- 이체금액
                                    fbs_util_pkg.sprintf('%-2.2s','') ||                                                -- 이체일자
                                    fbs_util_pkg.sprintf('%-1.1s','' )  ||                                               -- 처리여부(
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                                 -- 불능코드
                                    fbs_util_pkg.sprintf('%-10.10s','') ||                                              -- 미처리금액 
                                    fbs_util_pkg.sprintf('%-24.24s','') ||                                              -- 납부자번호/주민번호
                                    fbs_util_pkg.sprintf('%-4.4s',LPAD(v_edi_record,4,'0')) ||                          -- 데이타일련번호                                     
                                    fbs_util_pkg.sprintf('%-2.2s','') ||                                                -- filler 
                                    fbs_util_pkg.sprintf('%-2.2s','') ;                                                 -- filler 

                    END IF;
                                        
                    UTL_FILE.PUT_LINE( v_output_file , v_buffer );
    
                    v_tot_send_cnt := v_tot_send_cnt + 1;                        -- 데이타건수
                    v_tot_send_amt := v_tot_send_amt + cash_history_rec.pay_amt; -- 데이타총금액
                END IF;
                       
            EXCEPTION
                WHEN OTHERS THEN
                    v_success_yn := 'N';
                    v_error_msg  := '\n입금은행:'||cash_history_rec.in_bank_code||'\n'||
                                    '입금계좌번호:'||TRIM(cash_history_rec.in_account_no)||'(사업자번호:'||''||') \n'||
                                    '입금금액:'||cash_history_rec.pay_amt||'원\n\n 지급자료 오류';
		            	  errmsg := v_error_msg;
		            	  errflag:= -20007 ;
		                RAISE ERR ;
            END;
        END LOOP;        

        IF v_data_cnt = 0 THEN
        	  v_success_yn := 'N';
        	  errmsg := '생성할 데이타가 존재하지 않습니다.';
        	  errflag:= -20007 ;
            RAISE ERR ;
        END IF;

		    -- 복기부호
				v_batch_sign_no := fbs_util_pkg.get_batch_sign_no ( v_edi_history_seq, v_send_cnt ,v_send_amt);

        -- EDI 파일의 END RECORD를 생성합니다.
        --------------------------------------
				IF  bank_cd = KIUP_BANK_CD THEN
		        v_buffer := fbs_util_pkg.sprintf('%2.2s','33' ) ||                                               -- 레코드구분(30)
		                    fbs_util_pkg.sprintf('%2.2s',bank_cd) ||                                             -- 은행코드
		                    fbs_util_pkg.sprintf('%2.2s','82') ||                                                -- 업무코드
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt,7,'0')) ||                         -- 의뢰건수
		                    fbs_util_pkg.sprintf('%-13.13s',LPAD(TO_CHAR(v_tot_send_amt),13,'0')) ||             -- 의뢰금액
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- 정상출금건수
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- 정상출금금액
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- 불능건수
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- 불능금액
		                    fbs_util_pkg.sprintf('%-6.6s','')||                                                   -- DUMMY FIELD
		                    fbs_util_pkg.sprintf('%-4.4s',v_batch_sign_no)||                                      -- 복기부호
		                    fbs_util_pkg.sprintf('%-4.4s','');                                                    -- DUMMY FIELD
				ELSIF  bank_cd = HANA_BANK_CD THEN
		        v_buffer := fbs_util_pkg.sprintf('%1.1s','E' ) ||                                                -- 레코드구분(30)
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt,7,'0')) ||                         -- 총 의뢰 건수
		                    fbs_util_pkg.sprintf('%-13.13s',LPAD(TO_CHAR(v_tot_send_amt),13,'0')) ||             -- 총 의뢰 금액
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- 정상출금건수
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- 정상출금금액
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- 불능건수
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- 불능금액 
		                    fbs_util_pkg.sprintf('%-8.8s',v_batch_sign_no)||                                      -- 복기부호
		                    fbs_util_pkg.sprintf('%-11.11s','');                                                  -- DUMMY FIELD
        ELSIF  bank_cd = KUKMIN_BANK_CD THEN 
		        v_buffer := fbs_util_pkg.sprintf('%1.1s','E' ) ||                                                -- 레코드구분(30)
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt+2,7,'0')) ||                       -- 총 의뢰 건수
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt,7,'0')) ||                         -- 총 의뢰 건수                  
		                    fbs_util_pkg.sprintf('%-13.13s',LPAD(TO_CHAR(v_tot_send_amt),13,'0')) ||             -- 총 의뢰 금액
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- 정상출금건수
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- 정상출금금액
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- 불능건수
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- 불능금액                     
		                    fbs_util_pkg.sprintf('%-4.4s',v_batch_sign_no)||                                     -- 복기부호
		                    fbs_util_pkg.sprintf('%-8.8s','');                                                   -- DUMMY FIELD        	
        ELSIF  bank_cd = WOORI_BANK_CD THEN 
		        v_buffer := fbs_util_pkg.sprintf('%1.1s','E' ) ||                                                -- 레코드구분(30)
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt+2,7,'0')) ||                       -- 총 의뢰 건수
		                    fbs_util_pkg.sprintf('%-7.7s',LPAD(v_tot_send_cnt,7,'0')) ||                         -- 총 의뢰 건수                     
		                    fbs_util_pkg.sprintf('%-13.13s',LPAD(TO_CHAR(v_tot_send_amt),13,'0')) ||             -- 총 의뢰 금액
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- 정상출금건수
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- 정상출금금액
		                    fbs_util_pkg.sprintf('%7.7s','0000000') ||                                           -- 불능건수
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                   -- 불능금액                     
		                    fbs_util_pkg.sprintf('%-6.6s',v_batch_sign_no)||                                     -- 복기부호
												fbs_util_pkg.sprintf('%-4.4s','')||                                                  -- DUMMY FIELD                    
		                    fbs_util_pkg.sprintf('%-2.2s','');                                                   -- DUMMY FIELD        	
				END IF;                    
 
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_buffer );
        EXCEPTION
            WHEN OTHERS THEN
            		v_success_yn := 'N';
            	  errmsg := '현금이체 Batch파일 생성에 실패 (파일명:' || v_filename || ')';
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;                    

        -- 파일을 닫습니다.        
        BEGIN
            UTL_FILE.FCLOSE( v_output_file );
        EXCEPTION
            WHEN OTHERS THEN
            		v_success_yn := 'N';
            	  errmsg := '현금이체 Batch파일 생성에 실패 (파일명:' || v_filename || ')';
            	  errflag:= -20007 ;
                RAISE ERR ;
        END;   

        -- 정상처리여부에 따라서 처리한다.
        IF v_success_yn = 'Y' THEN
        
            /* 정상인 경우... */
           result_code := CHR(10) ||
                          '은행명   : ' || bank_cd || CHR(10) ||
                          '생성일시 : ' || TO_CHAR(SYSDATE,'YYYY/MM/DD hh24:mi:ss') || CHR(10) ||
                          '총 건수  : ' || TO_CHAR(NVL(v_tot_send_cnt,0),'999,999,999,999,999') || '건' || CHR(10) ||
                          '총 금액  : ' || TO_CHAR(NVL(v_tot_send_amt,0),'999,999,999,999,999') || '원';
           
           fbs_util_pkg.write_log('FBS', '[INFO] 현금이체 파일 생성이 정상적으로 완료되었습니다.(파일명:'||v_filename||')\n' ||
                                '+--------------------------------------------------------+\n' ||
                                ' * 은행명    : ' || bank_cd|| '\n' ||
                                ' * 생성일시  : ' || TO_CHAR(SYSDATE,'YYYY/MM/DD hh24:mi:ss') || '\n' ||                    
                                ' * 총 건수   : ' || TO_CHAR(NVL(v_tot_send_cnt,0),'999,999,999,999,999') || '건\n' ||
                                ' * 총 금액   : ' || TO_CHAR(NVL(v_tot_send_amt,0),'999,999,999,999,999') || '원\n' ||     
                                '+--------------------------------------------------------+\n');
        ELSE
            /* 오류가 발생한 경우... */
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
            RAISE_APPLICATION_ERROR(errflag,errmsg ||' 전산실에 문의하세요.');
            
        WHEN OTHERS THEN
            fbs_util_pkg.write_log('FBS', sqlerrm);
            RAISE_APPLICATION_ERROR(-20000, sqlerrm); 
    END ;    