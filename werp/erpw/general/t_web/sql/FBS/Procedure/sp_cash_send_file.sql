    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : cash_send_file                                        */
    /*  2. 모듈이름  : 현금이체 Batch파일 송신                               */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : HP-UX + Oracle 9.2.0                                  */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - WORLD DB 서버에서 EFT시스템으로 BATCH파일을 송신합니다.        */
    /*                                                                       */
    /*      - 사용모듈 : tcpsend                                             */
    /*      - DIRECTORY : FBS_REALTIME_SEND_DIR                              */
    /*      - 연관TABLE => 하기table에 state와 전송일자를 update한다.        */
    /*                                                                       */
    /*      - SUBJECT NAME                                                   */
    /*         (1) BATCH송신 : S + [거래처번호]                              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년2월3일                                          */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    CREATE OR REPLACE Procedure
    				sp_cash_send_file ( p_file_name   IN VARCHAR2 ,                -- 전송할 파일명
                                p_gubun       IN VARCHAR2 ,                -- 전송데이타구분 (C:현금,B:전자어음)
                                p_comp_code   IN VARCHAR2 ,                -- 사업장 코드
                                p_bank_code   IN VARCHAR2 ,                -- 은행코드
                                p_edi_seq     IN VARCHAR2 ,                -- edi이력일련번호
                                p_std_ymd     IN VARCHAR2 )  IS            -- edi기준일자
                                  
        v_send_file                  UTL_FILE.FILE_TYPE;        -- 송신할 파일의 유무를 검사할 FILE HANDLER                                    
        rec_org_bank            		 T_FB_ORG_BANK%ROWTYPE;     -- 공통코드를 가져올 RECORD변수
        
        v_filename                   VARCHAR2(100);             -- 파일명                               
        v_recv_desc                  VARCHAR2(100);             -- 회사/은행명 (EAP_LOOKUP_VALUES의 DESCRIPTION에서 '업체코드'단어만 제외한 문자열)
        v_result                     VARCHAR2(100);             -- EFT프로그램 호출 결과값 
        v_command                    VARCHAR2(400);             -- EFT PROGRAM을 호출한 프로그램명과 PARAMETER를 담은 문자열
        v_success_yn                 VARCHAR2(1):='Y';          -- 송신/UPDATE성공여부
        v_gubun                      VARCHAR2(100):= 'C';
        
        -- 파일 DIRECTORY (오라클 내에 DIRECTORY 로 CREATE되어 있음 ) 
        v_cash_send_dir              VARCHAR2(200);             -- BATCH 송신 DIRECTORY           
        v_dummy_return		           VARCHAR2(100);
        DEFAULT_TIMEOUT              NUMBER(10)   := 60;
        v_send_seq_no                NUMBER(10)   := 0;
        
				-- 공통 변수
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				e_msg            VARCHAR2(100);
				i  		           INTEGER        DEFAULT 0;
				-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found  
                
        -- UPDATE할 대상을 QUERY합니다.
        CURSOR edi_data_divided_cursor IS
            SELECT pay_seq ,
                   div_seq 
              FROM T_FB_CASH_PAY_HISTORY
             WHERE EDI_HISTORY_SEQ = p_edi_seq 
          GROUP BY pay_seq,
                   div_seq ;
        
        CURSOR edi_data_cursor IS
            SELECT pay_seq 
              FROM T_FB_CASH_PAY_HISTORY
             WHERE EDI_HISTORY_SEQ = p_edi_seq             
          GROUP BY pay_seq ;
                
    BEGIN
        
        BEGIN
	        -- MAX송신일련번호.
	        SELECT NVL( MAX(send_seq_no) , 0)+ 1
	        INTO   v_send_seq_no
	        FROM   T_FB_EDI_HISTORY
	        WHERE  std_ymd   = p_std_ymd
	        AND    comp_code = p_comp_code ;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE Err ;
        END; 
        
        -- 안내STRING설정  
        v_recv_desc := '' ;
        
        -- 메일박스 송신할 BATCH파일이름 설정 
        v_filename := p_file_name;        
                
        -- 해당 파일의 유무를 검사하여, 파일이 없는 경우, 오류로그를 남긴다.
        BEGIN
            v_send_file := UTL_FILE.FOPEN( 'FBS_CASH_SEND_DIR', v_filename, 'r');
            UTL_FILE.FCLOSE( v_send_file );
        EXCEPTION
            WHEN UTL_FILE.INVALID_OPERATION OR UTL_FILE.INVALID_FILEHANDLE THEN
                RAISE Err;
        END;

        -- 먼저 관련 TABLE에 대한 UPDATE를 수행한다.
        -- 오류가 난 경우, 오류메시지를 LOG로 남긴 후, ROLLBACK처리하며, 정상인 경우, 송신모듈을 통해 BATCH파일 송신 시도
        
	      BEGIN         
        UPDATE T_FB_EDI_HISTORY
           SET SEND_DATE    = SYSDATE ,
               RESULT_TEXT  = 'EDI송신완료' ,
               SEND_SEQ_NO  = v_send_seq_no
         WHERE EDI_HISTORY_SEQ = p_edi_seq;
         
        EXCEPTION
            WHEN OTHERS THEN
                RAISE Err ;
        END;

        BEGIN 
        UPDATE T_FB_CASH_PAY_HISTORY
           SET TRANSFER_YN     = 'Y',
               SEND_DATE       = SYSDATE,
               RESULT_TEXT     = 'EDI송신완료'
         WHERE EDI_HISTORY_SEQ = p_edi_seq;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE Err ;
        END;
				        
        FOR edicash_rec IN edi_data_divided_cursor LOOP

            BEGIN 
            UPDATE T_FB_CASH_PAY_DIVIDED_DATA
               SET RESULT_TEXT = 'EDI송신완료'
             WHERE PAY_SEQ     =  edicash_rec.PAY_SEQ
             AND   DIV_SEQ     =  edicash_rec.DIV_SEQ;

		        EXCEPTION
		            WHEN OTHERS THEN
		                RAISE Err ;
		        END;
        
        END LOOP;
            
        FOR edicashseq_rec IN edi_data_cursor LOOP

            BEGIN 
            UPDATE T_FB_CASH_PAY_DATA
               SET RESULT_TEXT = 'EDI송신완료'
             WHERE PAY_SEQ     =  edicashseq_rec.PAY_SEQ ;

		        EXCEPTION
		            WHEN OTHERS THEN
		                RAISE Err ;
		        END;
        END LOOP;
        
				v_result := f_send_file_to_van( p_file_name ,v_gubun,p_comp_code,p_bank_code );

        IF v_result = 'OK' THEN
            fbs_util_pkg.write_log('FBS','[INFO] ' || ' 송신이 정상적으로 처리완료되었습니다.');
        ELSE
            fbs_util_pkg.write_log('FBS','[ERROR] '|| ' 송신 중 오류가 발생하여 작업이 취소되었습니다.');
            RAISE Err;
      	END IF;
    
    EXCEPTION
        WHEN Err THEN    
            fbs_util_pkg.write_log('FBS' , sqlerrm);
				    RAISE_APPLICATION_ERROR(-20010,sqlerrm);                 	
        WHEN OTHERS THEN
            fbs_util_pkg.write_log('FBS', sqlerrm);
            RAISE_APPLICATION_ERROR(-20014,sqlerrm);                  
    END ;