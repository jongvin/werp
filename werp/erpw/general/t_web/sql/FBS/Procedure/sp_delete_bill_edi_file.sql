CREATE OR REPLACE Procedure SP_DELETE_BILL_EDI_FILE
(
	p_edi_seq     IN NUMBER ,        -- edi이력일련번호
	p_emp_no      IN VARCHAR2        -- 사번                                       
)
Is
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : SP_DELETE_BILL_EDI_FILE                               */
    /*  2. 모듈이름  : 이체파일삭제                                          */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /* 10. 최초작성자: 배민정                                                */
    /* 11. 최초작성일: 2006년02월09일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
-- 변수선언
				v_dummy_return		 VARCHAR2(100); 
				v_bill_send_dir    VARCHAR2(200);             -- BATCH 송신 DIRECTORY 
				v_send_date		     VARCHAR2(100); 
				v_sned_file_name	 VARCHAR2(100); 
-- 공통 변수
				errmsg           VARCHAR2(500);              -- Error Message Edit
				errflag          INTEGER        DEFAULT 0;   -- Process Error Code
-- User Define Error
				Err         			EXCEPTION;                  -- Select Data Not Found  

  CURSOR edi_data_cursor IS
      SELECT pay_seq 
        FROM T_FB_BILL_PAY_HISTORY
       WHERE EDI_HISTORY_SEQ = p_edi_seq
    GROUP BY pay_seq ; 
					      	
Begin

 	SELECT NVL(to_char(SEND_DATE ,'yyyymmdd') ,'N') ,
 	       SEND_FILE_NAME
	INTO   v_send_date,
	       v_sned_file_name 	        
 	FROM T_FB_EDI_HISTORY
 	WHERE EDI_HISTORY_SEQ = p_edi_seq ;
 	
 	IF v_send_date <> 'N' THEN 
	     errmsg  := '파일삭제불가!';
	     errflag := -20021;
	     RAISE Err;
	ELSE
      -- 물리적인 OS상의 directory를 가져옵니다.(from DBA_DIRECTORIES )
      BEGIN
          SELECT DIRECTORY_PATH || '\'
          INTO v_bill_send_dir
          FROM DBA_DIRECTORIES
          WHERE DIRECTORY_NAME = 'FBS_BILL_SEND_DIR';
      
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
					     errmsg  := '파일DIR검색 실패!';
					     errflag := -20022;
					     RAISE Err;
      END;

      BEGIN
					UPDATE T_FB_EDI_HISTORY
          SET    RESULT_TEXT     = 'EDI파일삭제'
          WHERE  EDI_HISTORY_SEQ = p_edi_seq;
          	
          FOR bill_seq_rec IN edi_data_cursor LOOP
               
              UPDATE T_FB_BILL_PAY_DATA
                 SET PAY_STATUS  = '2' ,
                     RESULT_TEXT = 'EDI파일삭제'
               WHERE PAY_SEQ     =  bill_seq_rec.PAY_SEQ ;
               
          END LOOP;
      
      		DELETE FROM T_FB_BILL_PAY_HISTORY
          WHERE  EDI_HISTORY_SEQ = p_edi_seq
          AND    SEND_DATE IS NULL;
          	
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
					     errmsg  := '파일이력수정 실패!';
					     errflag := -20022;
					     RAISE Err;
      END; 
           
      BEGIN
          v_dummy_return := fbs_util_pkg.exec_os_command(	'del ' || v_bill_send_dir || v_sned_file_name );
      EXCEPTION
          WHEN OTHERS THEN
              fbs_util_pkg.write_log('FBS',sqlerrm);
					    errmsg  := '파일삭제 실패!';
					    errflag := -20023;
					    RAISE Err;              
      END;

	END IF;	  

EXCEPTION
	WHEN Err THEN
		RAISE_APPLICATION_ERROR(errflag ,errmsg);
End;
/
