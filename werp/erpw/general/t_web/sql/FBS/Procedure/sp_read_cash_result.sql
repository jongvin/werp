    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : sp_read_cash_result                                   */
    /*  2. 모듈이름  : 현금이체 처리결과 수신                                */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : HP-UX + Oracle 9.2.0                                  */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 수신된 현금이체 Batch내역을 읽어서 연관TABLE에 UPDATE한다.     */
    /*      - 연관TABLE                                                      */
    /*                                                                       */
    /*    < 수정 이력 >                                                      */
    /*                                                                       */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년2월03일                                         */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
		CREATE OR REPLACE Procedure
    					sp_read_cash_result( comp_code        IN VARCHAR2 ,        -- 사업장 코드
    					                     bank_code        IN VARCHAR2 ,        -- 은행코드
                                   file_name        IN VARCHAR2 ,        -- 파일명
                                   edi_history_seq  IN NUMBER ) IS       -- edi이력일련번호

        v_input_file        UTL_FILE.FILE_TYPE;
        v_filename          VARCHAR2(100);
        v_buffer            VARCHAR2(4000);
        v_gubun             VARCHAR2(2) := '';  /* 수신파일의 각 행의 자료TYPE을 구분하는 구분 필드 */
        v_linecnt           NUMBER := 0;        /* DATA RECORD의 처리하는 라인번호 */
        v_success_yn        VARCHAR2(1) := 'Y'; /* 정상처리여부 */
        v_result_text       VARCHAR2(50);       /* 에러메시지 */
        v_result_code       VARCHAR2(4);
  			v_pay_status        VARCHAR2(1);
  			v_pay_success_amt   NUMBER := 0;
  			v_pay_fail_amt      NUMBER := 0; 
  			v_pay_amt           NUMBER := 0; 
  			v_edi_history_seq   NUMBER := 0; 
    		v_job_gubun         VARCHAR2(100):= 'C';
    		v_result            VARCHAR2(100);             -- EFT프로그램 호출 결과값
    		FBS_CASH_RECV_DIR   VARCHAR2(100) := FBS_UTIL_PKG.FBS_CASH_RECV_DIR; -- 현금이체
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
		        pay_ymd               VARCHAR2(6));      /* 지급일자                      */         
		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   : 송수신파일 DATA RECORD                           */
		    /*----------------------------------------------------------------------------*/     
		    TYPE DATA_RECORD IS RECORD (
		        gubun                  VARCHAR2(2),	  /* 레코드구분     "20"              */
		        record_seq             VARCHAR2(6),   /* 일련번호                         */				              
		        pay_amt                VARCHAR2(13),  /* 이체금액                         */
		        result_yn              VARCHAR2(1),   /* 1,Y:정상  2,N:불능               */
		        result_code            VARCHAR2(4));  /* 결과코드                         */
 		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   :  송수신파일 END RECORD                            */
		    /*----------------------------------------------------------------------------*/        
		    TYPE END_RECORD IS RECORD (
		        gubun 	               VARCHAR2(2),   /* 레코드구분     "30"           */
		        tot_send_cnt           VARCHAR2(7),   /* 총 의뢰건수                   */
		        tot_send_amt           VARCHAR2(13),  /* 총 의뢰금액                   */
		        normal_cnt             VARCHAR2(7),   /* 정상처리건수                  */  
		        normal_amt             VARCHAR2(13),  /* 정상처리금액                  */
		        error_cnt              VARCHAR2(7),   /* 오류처리건수                  */
		        error_amt              VARCHAR2(13)); /* 오류처리금액                  */

        v_start_rec     START_RECORD;         /* 파일 HEADER RECORD */
        v_edidata_rec   DATA_RECORD;          /* 파일 DATA RECORD   */
        v_ediend_rec    END_RECORD;           /* 파일 END RECORD    */
                
    BEGIN
        -- 수신 파일이름 설정 
        v_filename := file_name ;
  			-- 이력일련번호 읽기  
  			v_edi_history_seq := edi_history_seq ;
  			
				-- 파일수신하기 
    		v_result := f_recieve_file_from_van( v_filename ,v_job_gubun,comp_code,bank_code );
				
    		IF v_result = 'ERROR' THEN 
    			 RAISE_APPLICATION_ERROR(-20000,'파일수신에러');
				END IF;
				
        -- 수신파일을 open합니다.  
        v_input_file := UTL_FILE.FOPEN(FBS_CASH_RECV_DIR, v_filename, 'r');
        fbs_util_pkg.write_log('FBS','[INFO] '||'company_cd'||' '|| bank_code||' 현금이체 수신파일처리를 시작합니다. (파일명: ' ||  v_filename || ')');
            -- 파일을 읽어, DB작업을 합니다.
        BEGIN
            LOOP
              -- 파일을 읽습니다.
              UTL_FILE.GET_LINE(v_input_file, v_buffer);

              -- 구분에 따라서 각 FIELD를 셋팅한다.
              IF bank_code = '03' THEN 
              	 v_gubun := SUBSTR(v_buffer, 1, 2);
              ELSE
              	 v_gubun := SUBSTR(v_buffer, 1, 1);
              END IF;	 
    
              IF bank_code = KIUP_BANK_CD THEN 
              	 
                IF v_gubun = '11' THEN /* HEADER 레코드인 경우 */ 
                    v_start_rec.gubun                 := SUBSTRB(v_buffer, 1,2);    -- 레코드구분 
                    v_start_rec.pay_ymd               := SUBSTRB(v_buffer, 7,6);    -- 이체일자      
                ELSIF v_gubun = '22' THEN  /* DATA 레코드의 경우  */
                    v_linecnt := v_linecnt + 1;
                    v_edidata_rec.gubun               := SUBSTRB(v_buffer,  1, 2);   -- 레코드구분 
                    v_edidata_rec.record_seq          := SUBSTRB(v_buffer,  7, 6);   -- 일련번호 
                    v_edidata_rec.pay_amt             := SUBSTRB(v_buffer, 28,11);   -- 이체금액  
                    v_edidata_rec.result_yn           := SUBSTRB(v_buffer, 72, 1);   -- 1:정상  2:불능
                    v_edidata_rec.result_code         := SUBSTRB(v_buffer, 74, 4);   -- 결과코드       
                ELSIF v_gubun = '33' THEN /* END 레코드의 경우 */
                    v_ediend_rec.gubun                := SUBSTRB(v_buffer, 1,  2);    -- 레코드구분
                    v_ediend_rec.tot_send_cnt         := SUBSTRB(v_buffer, 7,  7);    -- 총 의뢰건수
                    v_ediend_rec.tot_send_amt         := SUBSTRB(v_buffer, 14,13);    -- 총의뢰금액
                    v_ediend_rec.normal_cnt           := SUBSTRB(v_buffer, 27, 7);    -- 정상처리건수
                    v_ediend_rec.normal_amt           := SUBSTRB(v_buffer, 34,13);    -- 정상처리금액
                    v_ediend_rec.error_cnt            := SUBSTRB(v_buffer, 47, 7);    -- 오류처리건수
                    v_ediend_rec.error_amt            := SUBSTRB(v_buffer, 54,13);    -- 오류처리금액      
                END IF;
              ELSIF  bank_code = HANA_BANK_CD THEN 
                IF v_gubun = 'S' THEN /* HEADER 레코드인 경우 */ 
                    v_start_rec.gubun                 := SUBSTRB(v_buffer, 1,1);    -- 레코드구분 
                    v_start_rec.pay_ymd               := SUBSTRB(v_buffer,20,6);    -- 이체일자      
                ELSIF v_gubun = 'D' THEN  /* DATA 레코드의 경우  */
                    v_linecnt := v_linecnt + 1;
                    v_edidata_rec.gubun               := SUBSTRB(v_buffer,  1, 1);   -- 레코드구분 
                    v_edidata_rec.record_seq          := SUBSTRB(v_buffer,  2, 7);   -- 일련번호 
                    v_edidata_rec.pay_amt             := SUBSTRB(v_buffer, 36,11);   -- 이체금액  
                    v_edidata_rec.result_yn           := SUBSTRB(v_buffer, 72, 1);   -- Y:정상  N:불능
                    v_edidata_rec.result_code         := SUBSTRB(v_buffer, 61, 4);   -- 결과코드       
                ELSIF v_gubun = 'E' THEN /* END 레코드의 경우 */
                    v_ediend_rec.gubun                := SUBSTRB(v_buffer, 1,  1);    -- 레코드구분
                    v_ediend_rec.tot_send_cnt         := SUBSTRB(v_buffer, 2,  7);    -- 총 의뢰건수
                    v_ediend_rec.tot_send_amt         := SUBSTRB(v_buffer, 9, 13);    -- 총의뢰금액
                    v_ediend_rec.normal_cnt           := SUBSTRB(v_buffer, 22, 7);    -- 정상처리건수
                    v_ediend_rec.normal_amt           := SUBSTRB(v_buffer, 29,13);    -- 정상처리금액
                    v_ediend_rec.error_cnt            := SUBSTRB(v_buffer, 42, 7);    -- 오류처리건수
                    v_ediend_rec.error_amt            := SUBSTRB(v_buffer, 49,13);    -- 오류처리금액      
                END IF;
        			ELSIF  bank_code = KUKMIN_BANK_CD THEN
                IF v_gubun = 'S' THEN /* HEADER 레코드인 경우 */ 
                    v_start_rec.gubun                 := SUBSTRB(v_buffer, 1,1);    -- 레코드구분 
                    v_start_rec.pay_ymd               := SUBSTRB(v_buffer,20,6);    -- 이체일자      
                ELSIF v_gubun = 'D' THEN  /* DATA 레코드의 경우  */
                    v_linecnt := v_linecnt + 1;
                    v_edidata_rec.gubun               := SUBSTRB(v_buffer,  1, 1);   -- 레코드구분 
                    v_edidata_rec.record_seq          := SUBSTRB(v_buffer,  2, 5);   -- 일련번호 
                    v_edidata_rec.pay_amt             := SUBSTRB(v_buffer, 38,10);   -- 이체금액  
                    v_edidata_rec.result_yn           := SUBSTRB(v_buffer, 48, 1);   -- Y:정상  N:불능
                    v_edidata_rec.result_code         := SUBSTRB(v_buffer, 49, 4);   -- 결과코드       
                ELSIF v_gubun = 'E' THEN /* END 레코드의 경우 */
                    v_ediend_rec.gubun                := SUBSTRB(v_buffer,  1,  1);  -- 레코드구분
                    v_ediend_rec.tot_send_cnt         := SUBSTRB(v_buffer,  9,  7);  -- 총 의뢰건수
                    v_ediend_rec.tot_send_amt         := SUBSTRB(v_buffer, 16, 13);  -- 총의뢰금액
                    v_ediend_rec.normal_cnt           := SUBSTRB(v_buffer, 29, 7);   -- 정상처리건수
                    v_ediend_rec.normal_amt           := SUBSTRB(v_buffer, 36,13);   -- 정상처리금액
                    v_ediend_rec.error_cnt            := SUBSTRB(v_buffer, 49, 7);   -- 오류처리건수
                    v_ediend_rec.error_amt            := SUBSTRB(v_buffer, 56,13);   -- 오류처리금액      
                END IF;
        			ELSIF  bank_code = WOORI_BANK_CD THEN
                IF v_gubun = 'S' THEN /* HEADER 레코드인 경우 */ 
                    v_start_rec.gubun                 := SUBSTRB(v_buffer, 1,1);    -- 레코드구분 
                    v_start_rec.pay_ymd               := SUBSTRB(v_buffer,22,6);    -- 이체일자      
                ELSIF v_gubun = 'D' THEN  /* DATA 레코드의 경우  */
                    v_linecnt := v_linecnt + 1;
                    v_edidata_rec.gubun               := SUBSTRB(v_buffer,  1, 1);   -- 레코드구분 
                    v_edidata_rec.record_seq          := SUBSTRB(v_buffer, 73, 4);   -- 일련번호 
                    v_edidata_rec.pay_amt             := SUBSTRB(v_buffer, 21,11);   -- 이체금액  
                    v_edidata_rec.result_yn           := SUBSTRB(v_buffer, 60, 1);   -- Y:정상  N:불능
                    v_edidata_rec.result_code         := SUBSTRB(v_buffer, 61, 4);   -- 결과코드       
                ELSIF v_gubun = 'E' THEN /* END 레코드의 경우 */
                    v_ediend_rec.gubun                := SUBSTRB(v_buffer,  1, 1);   -- 레코드구분
                    v_ediend_rec.tot_send_cnt         := SUBSTRB(v_buffer,  9, 7);   -- 총 의뢰건수
                    v_ediend_rec.tot_send_amt         := SUBSTRB(v_buffer, 16,13);   -- 총의뢰금액
                    v_ediend_rec.normal_cnt           := SUBSTRB(v_buffer, 29, 7);   -- 정상처리건수
                    v_ediend_rec.normal_amt           := SUBSTRB(v_buffer, 36,13);   -- 정상처리금액
                    v_ediend_rec.error_cnt            := SUBSTRB(v_buffer, 49, 7);   -- 오류처리건수
                    v_ediend_rec.error_amt            := SUBSTRB(v_buffer, 56,13);   -- 오류처리금액      
                END IF;
            	END IF;			  

              -- 데이타에 따라 에러메시지 설정 및 DB작업을 수행합니다.
              IF  (( v_gubun = '22') OR ( v_gubun = 'D')) THEN
                  
                      /* 에러메시지 설정 */
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
                              v_result_text := '알수없는 오류';
							            WHEN OTHERS THEN
							                RAISE_APPLICATION_ERROR(-20010,sqlerrm);
                      END;                      
          
                      IF v_edidata_rec.result_yn = '1' THEN
                      	 v_edidata_rec.result_yn := 'Y';
                      ELSIF v_edidata_rec.result_yn = '2' THEN
                      	 v_edidata_rec.result_yn := 'N';
                      END IF ;	 
          
                      /* 테이블에 UPDATE를 합니다. */
                      BEGIN
                         -- 현금지급내역을 UPDATE합니다. 
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
                         -- 현금지급분할DATA을 UPDATE합니다. 
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
                         -- 현금지급DATA을 UPDATE합니다.                           
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
                      -- HISTORY를 UPDATE합니다.  
                      UPDATE T_FB_EDI_HISTORY
                         SET RECV_DATE         = SYSDATE ,
                             RECEIVE_FILE_NAME = v_filename,
                             PAY_SUCCESS_CNT   = NVL(PAY_SUCCESS_CNT,0) + to_number(v_ediend_rec.normal_cnt) ,
                             PAY_SUCCESS_AMT   = NVL(PAY_SUCCESS_AMT,0) + to_number(v_ediend_rec.normal_amt) ,
                             PAY_FAIL_CNT      = NVL(PAY_FAIL_CNT,0) + to_number(v_ediend_rec.error_cnt) ,
                             PAY_FAIL_AMT      = NVL(PAY_FAIL_AMT,0) + to_number(v_ediend_rec.error_amt) ,                                   
                             RESULT_TEXT       = to_char(NVL(PAY_SUCCESS_CNT,0) + to_number(v_ediend_rec.normal_cnt))||'건 성공'||
                                                 to_char(NVL(PAY_FAIL_CNT,0) + to_number(v_ediend_rec.error_cnt))||'건 실패'
                       WHERE EDI_HISTORY_SEQ   = v_edi_history_seq  ;

	                    /* DB작업에 대한 EXCEPTION이 발생했을때 처리 */
	                    EXCEPTION
	                        WHEN OTHERS THEN
								 							RAISE_APPLICATION_ERROR(-20014,sqlerrm);
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
						RAISE_APPLICATION_ERROR(-20010,'파일이 아직 수신되지 않았습니다.');											
        WHEN OTHERS THEN
        	  ROLLBACK;
            fbs_util_pkg.write_log('FBS', sqlerrm);
						RAISE_APPLICATION_ERROR(-20030,sqlerrm);
    END ;