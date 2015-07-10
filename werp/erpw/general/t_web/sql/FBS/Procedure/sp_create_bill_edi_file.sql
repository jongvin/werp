    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : create_bill_edi_file                                  */
    /*  2. 모듈이름  : 전자어음 Batch파일 생성                               */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : HP-UX + Oracle 9.2.0                                  */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 전자어음지급내역을 EDI Batch File 생성                         */
    /*                                                                       */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년2월07일                                         */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/  
    CREATE OR REPLACE Procedure
 					 sp_create_bill_edi_file( company_cd   IN VARCHAR2 ,      -- 회사코드
    																pay_gubun    IN VARCHAR2 ,      -- 지급구분
                                 		pay_due_ymd  IN VARCHAR2 ,      -- 발행예정일자     																  
                                 		bank_cd      IN VARCHAR2 ,      -- 은행코드 
                                 		account_no   IN VARCHAR2 ,      -- 출금계좌ID
                                 		emp_no       IN VARCHAR2 ,      -- 사원번호(최종수정자)
                                 		result_code  OUT VARCHAR2 ) IS  -- 처리결과코드� 
                                 
        v_output_file                UTL_FILE.FILE_TYPE;
        
        v_filename                   VARCHAR2(100);              -- 작성할 파일 변수
        v_out_account_no             VARCHAR2(15);               -- 출금계좌번호
        v_biz_no                     VARCHAR2(12);               -- 사업자번호
        v_pay_date                   VARCHAR2(8);                -- 지급일자
        v_pay_success_yn						 VARCHAR2(1);                -- 지급성공여부

        v_tot_send_cnt               NUMBER := 0;                -- 전송된 총 의뢰건수
        v_tot_send_amt               NUMBER := 0;                -- 전송된 총 의뢰금액
				v_edi_history_seq            NUMBER := 0;                -- EDI일련번호
                    
        v_success_yn                 VARCHAR2(1) := 'Y';         -- 정상처리여부(Y OR N)
        v_data_cnt                   NUMBER := 0;                -- 데이타 COUNT 
        v_data_amt									 NUMBER := 0;                -- 데이타 금액
        v_edi_record								 NUMBER := 0;                -- edi레코드일련번호 	
        v_trx_seq								     NUMBER := 0;                -- 거래일련번호 	
        
        v_buffer                     VARCHAR2(500);              -- 임시버퍼(파일WRITE용) 
        v_today                      VARCHAR2(8);                -- 오늘날짜(YYYYMMDD)
        v_time                       VARCHAR2(6);                -- 오늘시간(HH24MISS)
				v_dummy_return		           VARCHAR2(100);
				
        rec_org_bank            		 T_FB_ORG_BANK%ROWTYPE;      -- 공통코드를 가져올 RECORD변수         
		    /*----------------------------------------------------------------------------*/
		    /* 은행코드                                                                   */
		    /*----------------------------------------------------------------------------*/
		    KIUP_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.KIUP_BANK_CD;   -- 기업은행
		    KUKMIN_BANK_CD               VARCHAR2(2) := FBS_MAIN_PKG.KUKMIN_BANK_CD; -- 국민은행
		    WOORI_BANK_CD                VARCHAR2(2) := FBS_MAIN_PKG.WOORI_BANK_CD;  -- 우리은행
		    HANA_BANK_CD                 VARCHAR2(2) := FBS_MAIN_PKG.HANA_BANK_CD;   -- 하나은행        
        -- 파일 DIRECTORY (오라클 내에 DIRECTORY 로 CREATE되어 있음 ) 
        FBS_BILL_SEND_DIR            VARCHAR2(100) := FBS_UTIL_PKG.FBS_BILL_SEND_DIR; -- 전자어음
        v_bill_send_dir              VARCHAR2(200);             -- BATCH 송신 DIRECTORY          
				-- 공통 변수
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found        	        
            
        -- 전자어음이체 data 추출 CURSOR   
				CURSOR bill_pay_cursor IS        	
            SELECT a.pay_seq               AS pay_seq,        -- 지급일련번호
            			 a.pay_amt               AS pay_amt,        -- 지급금액
            			 a.check_no              AS check_no,       -- 채권번호
            			 a.vat_registration_num  AS regist_no,      -- 사업자번호
            			 a.pay_due_ymd           AS pay_due_ymd,    -- 발행예정일자
            			 a.future_pay_due_ymd    AS future_ymd,     -- 만기일자
            			 b.franchise_no          AS franchise_no    -- 가맹점번호
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
        -- 오늘날짜 ,시간 설정  
        v_today := TO_CHAR(SYSDATE,'YYYYMMDD');
        v_time  := TO_CHAR(SYSDATE,'HH24MISS');
    
        -- 송신 파일이름 설정 
        v_filename := f_get_edi_file_name( company_cd , bank_cd , 'BS'  );
        
        -- 초기변수를 설정합니다.(출금계좌번호/이체일자)
        v_out_account_no := REPLACE(account_no,'-',''); 
        v_pay_date       := REPLACE(pay_due_ymd,'-','');
        
        -- 물리적인 OS상의 directory를 가져옵니다.(from DBA_DIRECTORIES )
        BEGIN
            SELECT DIRECTORY_PATH || '\'
            INTO v_bill_send_dir
            FROM DBA_DIRECTORIES
            WHERE DIRECTORY_NAME = FBS_BILL_SEND_DIR;
        
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := 'DIR 에러' ;
            	  errflag := -20010 ;
                RAISE Err ;
        END;         

        -- 해당사업장의 사업자번호를 가져옵니다.
        BEGIN        
            SELECT REPLACE(BIZNO,'-','') AS BIZNO
            INTO v_biz_no
            FROM T_COMPANY 
            WHERE COMP_CODE = company_cd ; 
            
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := '사업장의 사업자번호 에러' ;
            	  errflag := -20020 ;
                RAISE Err ;
        END;        
        
        BEGIN
	        -- 등록된 SUBJECT NAME을 가져옵니다.
	        SELECT *
	        INTO   rec_org_bank
	        FROM   T_FB_ORG_BANK
	        WHERE  COMP_CODE      = company_cd
	        AND    BANK_MAIN_CODE = bank_cd;
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := '은행에 대한 업체코드 에러' ;
            	  errflag := -20030 ;
                RAISE Err ;
        END;  
              
        -- edi 이력일련번호를 가져옵니다.
       	SELECT  T_EDI_HISTORY_SEQ.NEXTVAL
      	INTO    v_edi_history_seq  
      	FROM    DUAL ;
      	
        -------------------------------------------------------------------------------
        -- 전자어음 송신정보를 HISTORY 테이블(T_FB_EDI_HISTORY )에 넣습니다.
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
           'B' ,
           v_filename,
           SYSDATE ,
           emp_no  );
                                                             
        EXCEPTION
            WHEN OTHERS THEN
            	  errmsg := 'EDI생성 송수신이력이력  에러' ;
            	  errflag := -20040 ;
                RAISE Err ;
        END;
        
        -------------------------------------------------------------------------------
        -- 전자어음 송신내역을 가져와서 파일을 생성합니다.
        -------------------------------------------------------------------------------
        -- 수신파일을 OPEN합니다.  
        BEGIN
            v_output_file := UTL_FILE.FOPEN(FBS_BILL_SEND_DIR , v_filename, 'w');
        EXCEPTION
            WHEN UTL_FILE.INVALID_OPERATION THEN
			          errmsg := 'FILE OPEN 에러('||v_filename||')' ;
            	  errflag := -20050 ;
                RAISE Err ;
        END;
        
        fbs_util_pkg.write_log('FBS','[INFO] ' || bank_cd || ' 전자어음발행파일 생성을 시작합니다. (파일명: ' ||  v_filename || ')');
        
        -- EDI 파일의 HEADER RECORD를 생성합니다.
        -----------------------------------------
        IF bank_cd = KIUP_BANK_CD THEN -- 기업은행(전자어음)
	        v_buffer := fbs_util_pkg.sprintf('%2.2s','10') ||                                        -- 레코드구분(10)
	                    fbs_util_pkg.sprintf('%-6.6s','')  ||                                        -- 예비1
	                    fbs_util_pkg.sprintf('%-4.4s','')  ||                                        -- 예비2
	                    fbs_util_pkg.sprintf('%-4.4s','')  ||                                        -- 예비3
	                    fbs_util_pkg.sprintf('%-8.8s',v_today )  ||                                  -- 전송일자
	                    fbs_util_pkg.sprintf('%-12.12s',SUBSTRB(rec_org_bank.bill_ente_code,1,12))|| -- 업체코드
											fbs_util_pkg.sprintf('%-2.2s','03') ||                                       -- 은행코드 
	                    fbs_util_pkg.sprintf('%-14.14s',SUBSTRB(v_out_account_no,1,14)) ||           -- 출금계좌번호
	                    fbs_util_pkg.sprintf('%-13.13s','') ||                                       -- 예비4	
											fbs_util_pkg.sprintf('%-1.1s','1') ||                                        -- 처리구분(1,2)
											fbs_util_pkg.sprintf('%-82.82s','') ||                                       -- 예비6
	                    fbs_util_pkg.sprintf('%-2.2s','') ;                                          
				ELSIF  bank_cd = HANA_BANK_CD THEN --하나은행(구매카드)
	        v_buffer := fbs_util_pkg.sprintf('%1.1s','S') ||                                         -- 레코드구분(10)
	                    fbs_util_pkg.sprintf('%4.4s','R351')||                                       -- 업무코드
	                    fbs_util_pkg.sprintf('%4.4s',SUBSTRB(rec_org_bank.bill_ente_code,1,4)) ||    -- 업체코드
	                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                        -- 서비스구분  
	                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                    -- 승인요청일자
	                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                        -- 전송차수
	                    fbs_util_pkg.sprintf('%-3.3s','001') ||                                      -- 사업장번호
	                    fbs_util_pkg.sprintf('%-6.6s',v_time) ||                                     -- 전송시간  
											fbs_util_pkg.sprintf('%-1.1s','R') ||                                        -- 테스트구분
											fbs_util_pkg.sprintf('%13.13s',SUBSTRB('999'||v_biz_no,1,13)) ||             -- 사업자번호
											fbs_util_pkg.sprintf('%13.13s','') ||                                        -- 전자금융ID(예비1)
											fbs_util_pkg.sprintf('%-145.145s','') ;                                      -- 예비2
			  END IF;
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_buffer );
        EXCEPTION
            WHEN OTHERS THEN
			          errmsg := 'FILE WRITE 에러('||v_filename||')-HEADER' ;
            	  errflag := -20060 ;
                RAISE Err ;
        END;
        
        v_trx_seq    := 0;
				v_data_cnt   := 0;
				v_edi_record := 0;

				-- EDI 레코드 일련번호(max)	:기준일자별  
      	SELECT NVL(MAX(b.EDI_RECORD_SEQ),0) 
      	INTO   v_edi_record
      	FROM   T_FB_EDI_HISTORY a ,
      	       T_FB_BILL_PAY_HISTORY b
      	WHERE  a.EDI_HISTORY_SEQ = b.EDI_HISTORY_SEQ
      	AND    A.STD_YMD = v_today ;        

        -- EDI 파일의 DATA RECORDS 를 생성합니다.
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
                   	
                        v_buffer := fbs_util_pkg.sprintf('%2.2s','20') ||                                     -- 레코드구분(20)
                                    fbs_util_pkg.sprintf('%2.2s','00') ||                                     -- 거래구분('00','99')
                                    fbs_util_pkg.sprintf('%-14.14s',SUBSTRB(cash_rec.check_no,1,14))||        -- 채권번호
                                    fbs_util_pkg.sprintf('%-1.1s','2') ||                                     -- 결제구분('1','2')
                                    fbs_util_pkg.sprintf('%-13.13s',LPAD(TO_CHAR(cash_rec.pay_amt),13,'0'))|| -- 채권금액
                                    fbs_util_pkg.sprintf('%-10.10s',SUBSTRB(cash_rec.regist_no,1,10))||       -- 사업자번호
                                    fbs_util_pkg.sprintf('%-12.12s',LPAD(TO_CHAR(v_edi_record),12,'0') )  ||  -- 예비1(거래번호)
                                    fbs_util_pkg.sprintf('%-20.20s',v_biz_no ) ||                             -- 지급사업장
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.pay_due_ymd) ||                    -- 출금가능일
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- 채권만기일
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                      -- 처리결과('0000':정상,반송)
                                    fbs_util_pkg.sprintf('%-8.8s','') ||                                      -- 예비2
                                    fbs_util_pkg.sprintf('%-6.6s','') ||                                      -- 예비3
                                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                 -- 납품일자
                                    fbs_util_pkg.sprintf('%-20.20s','') ||                                    -- 품목
                                    fbs_util_pkg.sprintf('%-9.9s','') ||                                      -- 예비4
                                    fbs_util_pkg.sprintf('%-2.2s','') ||                                      -- 처리returncode 
                                    fbs_util_pkg.sprintf('%-1.1s','') ||                                      -- 은행처리여부('Y')
                                    fbs_util_pkg.sprintf('%-2.2s','') ;                                       -- 예비5

                    ELSIF  bank_cd = HANA_BANK_CD THEN 
                        v_buffer := fbs_util_pkg.sprintf('%1.1s','D') ||                                      -- 레코드구분(D)
                                    fbs_util_pkg.sprintf('%-5.5s',LPAD(TO_CHAR(v_edi_record),5,'0')) ||       -- 데이타일련번호
                                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                 --전송일자
                                    fbs_util_pkg.sprintf('%-16.16s',cash_rec.check_no) ||                     -- 카드번호  
                                    fbs_util_pkg.sprintf('%-11.11s',cash_rec.franchise_no ) ||                -- 가맹점번호
                                    fbs_util_pkg.sprintf('%-11.11s',LPAD(TO_CHAR(cash_rec.pay_amt),11,'0')) ||-- 승인금액
                                    fbs_util_pkg.sprintf('%-3.3s','' )  ||                                    -- 분할회차
                                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                     -- 거치수수료부담
                                    fbs_util_pkg.sprintf('%-3.3s','') ||                                      -- 대금입금거치기간
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- 대금입금일자
                                    fbs_util_pkg.sprintf('%-1.1s','1') ||                                     -- 분할수수료부담
                                    fbs_util_pkg.sprintf('%-3.3s','') ||                                      -- 결제거치기간
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- 결제일자
                                    fbs_util_pkg.sprintf('%-12.12s','') ||                                    -- 비고
                                    fbs_util_pkg.sprintf('%-10.10s','') ||                                    -- 승인번호
                                    fbs_util_pkg.sprintf('%-4.4s','') ||                                      -- 에러코드
                                    fbs_util_pkg.sprintf('%-9.9s','') ||                                      -- 가맹점부담수수료
                                    fbs_util_pkg.sprintf('%-11.11s','') ||                                    -- 가맹점입금총액
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.pay_due_ymd) ||                    -- 최초입금시작일
                                    fbs_util_pkg.sprintf('%-8.8s',v_today) ||                                 -- 세금계산서일자                                                                                                                                                                                                                       
                                    fbs_util_pkg.sprintf('%-15.15s','') ||                                    -- 적요
                                    fbs_util_pkg.sprintf('%-8.8s',cash_rec.future_ymd) ||                     -- 자동이체일자
                                    fbs_util_pkg.sprintf('%-20.20s','') ||                                    -- 발주서번호                                                                                                        
                                    fbs_util_pkg.sprintf('%-16.16s','');                                      -- 예비

                    END IF;

                    UTL_FILE.PUT_LINE( v_output_file , v_buffer );

                    v_tot_send_cnt := v_tot_send_cnt + 1;                -- 데이타건수
                    v_tot_send_amt := v_tot_send_amt + cash_rec.pay_amt; -- 데이타총금액
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
            errmsg  := '데이타가 없습니다.';
        	  errflag := -20090 ;
            RAISE Err ;
        END IF;
        
        -- EDI 파일의 END RECORD를 생성합니다.
        --------------------------------------
				IF  bank_cd = KIUP_BANK_CD THEN         
		        v_buffer := fbs_util_pkg.sprintf('%2.2s','30' ) ||                                            -- 레코드구분(30)
		                    fbs_util_pkg.sprintf('%6.6s',LPAD(v_tot_send_cnt,6,'0')) ||                       -- 총건수
		                    fbs_util_pkg.sprintf('%13.13s',LPAD(v_tot_send_amt,13,'0'))||                     -- 총금액
		                    fbs_util_pkg.sprintf('%-6.6s','000000') ||                                        -- 정상처리건수
		                    fbs_util_pkg.sprintf('%-13.13s','0000000000000') ||                               -- 정상처리금액
		                    fbs_util_pkg.sprintf('%6.6s','000000') ||                                         -- 에러처리건수
		                    fbs_util_pkg.sprintf('%13.13s','0000000000000') ||                                -- 에러처리금액
		                    fbs_util_pkg.sprintf('%91.91s','') ;                                              -- 예비
				ELSIF  bank_cd = HANA_BANK_CD THEN
		        v_buffer := fbs_util_pkg.sprintf('%1.1s'   ,'E' ) ||                                          -- 레코드구분(E)
		                    fbs_util_pkg.sprintf('%-5.5s'  ,LPAD(v_tot_send_cnt+2,5,'0'))||                   -- 총 의뢰 건수
		                    fbs_util_pkg.sprintf('%-5.5s'  ,LPAD(v_tot_send_cnt,5,'0'))  ||                   -- 총 의뢰 건수
		                    fbs_util_pkg.sprintf('%-15.15s',LPAD(v_tot_send_amt,15,'0'))||                    -- 총 의뢰 금액
		                    fbs_util_pkg.sprintf('%5.5s'   ,'00000') ||                                       -- 정상승인건수
		                    fbs_util_pkg.sprintf('%15.15s' ,'000000000000000') ||                             -- 정상승인금액
		                    fbs_util_pkg.sprintf('%15.15s' ,'00000') ||                                       -- 가맹점부담총수수료
		                    fbs_util_pkg.sprintf('%15.15s' ,'000000000000000') ||                             -- 가맹점입금총액
		                    fbs_util_pkg.sprintf('%5.5s'   ,'00000')||                                        -- 승인에러건수
		                    fbs_util_pkg.sprintf('%15.15s' ,'000000000000000') ||                             -- 승인에러금액
		                    fbs_util_pkg.sprintf('%11.11s' ,'') ||                                            -- 복기부호(검증하지않음) 
		                    fbs_util_pkg.sprintf('%93.93s' ,'');                                              -- 예비
				END IF;                    
 
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_buffer );
        EXCEPTION
            WHEN OTHERS THEN
            	  v_success_yn := 'N';
                errmsg  := 'FILE WRITE 에러('||v_filename||')-END' ;
            	  errflag := -20100 ;
                RAISE Err ;
        END;                    

        -- 파일을 닫습니다.        
        BEGIN
            UTL_FILE.FCLOSE( v_output_file );
        EXCEPTION
            WHEN OTHERS THEN
            		v_success_yn := 'N';
                errmsg  := 'FILE WRITE 에러('||v_filename||')' ;
            	  errflag := -20110 ;
                RAISE Err ;
        END;   

        -- 정상처리여부에 따라서 처리한다.
        IF v_success_yn = 'Y' THEN
        
            /* 정상인 경우... */
           result_code := CHR(10) ||
                          '은행명   : ' || bank_cd || CHR(10) ||
                          '생성일시 : ' || TO_CHAR(SYSDATE,'YYYY/MM/DD hh24:mi:ss') || CHR(10) ||
                          '총 건수  : ' || TO_CHAR(NVL(v_tot_send_cnt,0),'999,999,999,999,999') || '건' || CHR(10) ||
                          '총 금액  : ' || TO_CHAR(NVL(v_tot_send_amt,0),'999,999,999,999,999') || '원';
           
           fbs_util_pkg.write_log('FBS', '[INFO] 전자어ㅡㅁ 파일 생성이 정상적으로 완료되었습니다.(파일명:'||v_filename||')\n' ||
                                '+--------------------------------------------------------+\n' ||
                                ' * 은행명    : ' || bank_cd|| '\n' ||
                                ' * 생성일시  : ' || TO_CHAR(SYSDATE,'YYYY/MM/DD hh24:mi:ss') || '\n' ||                    
                                ' * 총 건수   : ' || TO_CHAR(NVL(v_tot_send_cnt,0),'999,999,999,999,999') || '건\n' ||
                                ' * 총 금액   : ' || TO_CHAR(NVL(v_tot_send_amt,0),'999,999,999,999,999') || '원\n' ||     
                                '+--------------------------------------------------------+\n');
        ELSE
            /* 오류가 발생한 경우... */
            errmsg  := sqlerrm ;
         	  errflag := -20120 ; 
            RAISE ERR;
        END IF;  
    
    EXCEPTION
        WHEN ERR THEN
            fbs_util_pkg.write_log('FBS', '[ERROR] 전자어음 송신파일 생성시 오류가 발생하였습니다.\n (파일명:' || v_filename || ') \n '||errmsg);
            -- 파일이 이미 생성된 다음 나오는 EXCEPTION이므로, 이 파일을 삭제하는 로직 
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