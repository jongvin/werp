    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : sp_reserved_send                                      */
    /*  2. 모듈이름  : 현금이체 예약송신                                     */
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
    					sp_reserved_send( bank_code        IN VARCHAR2 ,        -- 은행코드
                                file_name        IN VARCHAR2 ,        -- 파일명
                                edi_history_seq  IN NUMBER   ,        -- edi이력일련번호
                                reved_date       IN VARCHAR2 ) IS     -- 예약이체일자

        v_input_file        UTL_FILE.FILE_TYPE;
        v_input_file_temp   UTL_FILE.FILE_TYPE;
        v_filename          VARCHAR2(100);
        v_buffer            VARCHAR2(4000);
        v_gubun             VARCHAR2(2) := '';  /* 수신파일의 각 행의 자료TYPE을 구분하는 구분 필드 */
        v_linecnt           NUMBER := 0;        /* DATA RECORD의 처리하는 라인번호 */
  			v_edi_history_seq   NUMBER := 0; 
    		v_reved_date        VARCHAR2(8);	
    		v_dummy_return		  VARCHAR2(100);   
    		v_cash_send_dir     VARCHAR2(200);       -- BATCH 송신 DIRECTORY 
        FBS_CASH_SEND_DIR   VARCHAR2(100):= FBS_UTIL_PKG.FBS_CASH_SEND_DIR; -- 현금이체
        WOORI_BANK_CD       VARCHAR2(2) := FBS_MAIN_PKG.WOORI_BANK_CD;       -- 우리은행
		    /*----------------------------------------------------------------------------*/
		    /*   REC   NAME   : 송수신파일 HEADER RECORD                                  */
		    /*----------------------------------------------------------------------------*/      
		    TYPE START_RECORD IS RECORD (

						before_data           VARCHAR2(21),      /* 지급일자전                    */
		        pay_ymd               VARCHAR2(6),       /* 지급일자                      */
		        after_data            VARCHAR2(33));     /* 지급일자후                    */         

        v_start_rec     START_RECORD;         /* 파일 HEADER RECORD */
                
    BEGIN
        -- 수신 파일이름 설정 
        v_filename := file_name ;

				-- 송신예약일자
				v_reved_date := SUBSTRB(reved_date,3,2)||SUBSTRB(reved_date,6,2)||SUBSTRB(reved_date,9,2) ;
				
				-- EDI이력일련번호
				v_edi_history_seq := edi_history_seq ;
				
        -- 물리적인 OS상의 directory를 가져옵니다.(from DBA_DIRECTORIES )
        BEGIN
            SELECT DIRECTORY_PATH || '\'
            INTO v_cash_send_dir
            FROM DBA_DIRECTORIES
            WHERE DIRECTORY_NAME = FBS_CASH_SEND_DIR;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20010,'파일 DIR가 존재하지않습니다.');
        END;  

        v_input_file := UTL_FILE.FOPEN(FBS_CASH_SEND_DIR, v_filename, 'r');
        v_input_file_temp := UTL_FILE.FOPEN(FBS_CASH_SEND_DIR, 'temp_'||v_filename, 'w');
       
        fbs_util_pkg.write_log('FBS','[INFO]예약송신 처리를 시작합니다. (파일명: ' ||  v_filename || ')');
          
        BEGIN
            LOOP
              -- 파일을 읽습니다.
              UTL_FILE.GET_LINE(v_input_file, v_buffer);

              -- 구분에 따라서 각 FIELD를 셋팅한다.
              v_gubun := SUBSTR(v_buffer, 1, 2);
    
              IF bank_code = WOORI_BANK_CD THEN 
              	 
                IF v_gubun = '11' THEN /* HEADER 레코드인 경우 */                

                    v_start_rec.before_data           := SUBSTRB(v_buffer, 1,21);    -- 지급일자전 
                    v_start_rec.pay_ymd               := SUBSTRB(v_buffer, 7,6);     -- 이체일자
      							v_start_rec.after_data            := SUBSTRB(v_buffer, 28,33);   -- 지급일자후 
      
      							v_buffer := v_start_rec.before_data||v_reved_date||v_start_rec.after_data ;
      							
      							UTL_FILE.PUT_LINE( v_input_file_temp , v_buffer );
      							
                ELSIF v_gubun = '22' THEN  /* DATA 레코드의 경우  */              
      
                    v_linecnt := v_linecnt + 1;
										v_buffer := v_buffer ;

										UTL_FILE.PUT_LINE( v_input_file_temp , v_buffer );

                ELSIF v_gubun = '33' THEN /* END 레코드의 경우 */
                
										v_buffer := v_buffer ;
      
							      UTL_FILE.PUT_LINE( v_input_file_temp , v_buffer );
      
                END IF;
            	END IF;		

				END LOOP;
				
        EXCEPTION
            WHEN NO_DATA_FOUND THEN    -- 파일을 다 읽은 경우..
                UTL_FILE.FCLOSE( v_input_file );
                UTL_FILE.FCLOSE( v_input_file_temp );
                UTL_FILE.FRENAME('FBS_CASH_SEND_DIR' , 'temp_'||v_filename ,'FBS_CASH_SEND_DIR' ,v_filename ,TRUE);
            WHEN OTHERS THEN
                UTL_FILE.FCLOSE( v_input_file );
                UTL_FILE.FCLOSE( v_input_file_temp );
                v_dummy_return := fbs_util_pkg.exec_os_command(	'del ' || v_cash_send_dir || 'temp_'||v_filename );
                RAISE_APPLICATION_ERROR(-20013,sqlerrm);
        END;

				BEGIN
        -- HISTORY를 UPDATE합니다.  
        UPDATE T_FB_EDI_HISTORY
           SET RESERVE_YMD       = v_reved_date ,
               RESULT_TEXT       = v_reved_date||'에 예약송신등록'
         WHERE EDI_HISTORY_SEQ   = v_edi_history_seq  ;

        /* DB작업에 대한 EXCEPTION이 발생했을때 처리 */
        EXCEPTION
            WHEN OTHERS THEN
	 							RAISE_APPLICATION_ERROR(-20014,sqlerrm);
        END;

        /* 정상인 경우이므로, COMMIT을 수행하고, 오류가 난 경우, ROLLBACK수행 .*/  
        fbs_util_pkg.write_log('FBS','[INFO] 수신파일 처리가 완료되었습니다.');        			  
    
    EXCEPTION
        WHEN UTL_FILE.INVALID_OPERATION THEN
            fbs_util_pkg.write_log('FBS', 'ORA-20004  수신파일 열기에 실패 (파일명:' || v_filename || ')');
						RAISE_APPLICATION_ERROR(-20015,'수신파일 열기에 실패');		
        WHEN OTHERS THEN
        	  ROLLBACK;
            fbs_util_pkg.write_log('FBS', sqlerrm);
						RAISE_APPLICATION_ERROR(-20016,sqlerrm);
    END ;