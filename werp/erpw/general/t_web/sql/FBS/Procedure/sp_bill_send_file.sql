    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : bill_send_file                                        */
    /*  2. 모듈이름  : 전자어음 Batch파일 송신                               */
    /*  3. 시스템    : FBS                                                   */
    /*  4. 서브시스템: EFT                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : HP-UX + Oracle 9.2.0                                  */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      -  DB 서버에서 EFT시스템으로 BATCH파일을 송신합니다.             */
    /*                                                                       */
    /*      - 사용모듈 : tcpsend                                             */
    /*                                                                       */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년2월3일                                          */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/
    CREATE OR REPLACE Procedure
    				  sp_bill_send_file ( p_file_name   IN VARCHAR2 ,                -- 전송할 파일명
                                  p_comp_code   IN VARCHAR2 ,                -- 사업장 코드
                                  p_bank_code   IN VARCHAR2 ,                -- 은행코드
                                  p_edi_seq     IN VARCHAR2 ,                -- edi이력일련번호
                                  p_std_ymd     IN VARCHAR2 )  IS            -- edi기준일자
        
        v_result                  VARCHAR2(100);             -- EFT프로그램 호출 결과값 
        v_send_seq_no             NUMBER(10)   := 0;
        v_gubun                   VARCHAR2(100):= 'B';
				-- 공통 변수
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
				-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found  
                
        -- UPDATE할 대상을 QUERY합니다.
        CURSOR edi_data_cursor IS
            SELECT pay_seq 
            FROM T_FB_BILL_PAY_HISTORY
            WHERE EDI_HISTORY_SEQ = p_edi_seq             
            GROUP BY pay_seq ;
                
    BEGIN
					
	        -- MAX송신일련번호.
	        SELECT NVL( MAX(send_seq_no) , 0)+ 1
	        INTO   v_send_seq_no
	        FROM   T_FB_EDI_HISTORY
	        WHERE  std_ymd   = p_std_ymd
	        AND    comp_code = p_comp_code ;

        -- 먼저 관련 TABLE에 대한 UPDATE를 수행한다.
        -- 오류가 난 경우, 오류메시지를 LOG로 남긴 후, ROLLBACK처리하며, 
        -- 정상인 경우, 송신모듈을 통해 BATCH파일 송신 시도

  	      BEGIN         
          UPDATE T_FB_EDI_HISTORY
             SET SEND_DATE    = SYSDATE ,
                 RESULT_TEXT  = 'EDI송신완료' ,
                 SEND_SEQ_NO  = v_send_seq_no
           WHERE EDI_HISTORY_SEQ = p_edi_seq;
           
	        EXCEPTION
	            WHEN OTHERS THEN	
	            	  errmsg := sqlerrm;
	                RAISE Err ;
	        END;

          BEGIN 
          UPDATE T_FB_BILL_PAY_HISTORY
             SET TRANSFER_YN     = 'Y',
                 SEND_DATE       = SYSDATE,
                 RESULT_TEXT     = 'EDI송신완료'
           WHERE EDI_HISTORY_SEQ = p_edi_seq;

	        EXCEPTION
	            WHEN OTHERS THEN
	            	  errmsg := sqlerrm;
	                RAISE Err ;
	        END;
            
          FOR edibill_rec IN edi_data_cursor LOOP

              BEGIN 
              UPDATE T_FB_BILL_PAY_DATA
                 SET RESULT_TEXT = 'EDI송신완료'
               WHERE PAY_SEQ     =  edibill_rec.pay_seq ;

			        EXCEPTION
			            WHEN OTHERS THEN
			            	  errmsg := sqlerrm;
			                RAISE Err ;
			        END;

          END LOOP;

					v_result := f_send_file_to_van( p_file_name ,v_gubun,p_comp_code,p_bank_code );

	        IF v_result = 'OK' THEN
	            fbs_util_pkg.write_log('FBS','[INFO] ' || ' 송신이 정상적으로 처리완료되었습니다.');
	        ELSE
	            fbs_util_pkg.write_log('FBS','[ERROR] '|| ' 송신 중 오류가 발생하여 작업이 취소되었습니다.');
	            errmsg := '송신 중 오류가 발생';
	            RAISE Err;
        	END IF;

    EXCEPTION
        WHEN Err THEN    
            fbs_util_pkg.write_log('FBS' , errmsg);
				    RAISE_APPLICATION_ERROR(-20010,errmsg);                 	
        WHEN OTHERS THEN
            fbs_util_pkg.write_log('FBS', sqlerrm);
            RAISE_APPLICATION_ERROR(-20020,sqlerrm);                  
    END ;