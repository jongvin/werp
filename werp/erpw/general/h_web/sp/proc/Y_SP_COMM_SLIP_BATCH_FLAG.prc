CREATE OR REPLACE PROCEDURE Y_Sp_Comm_Slip_Batch_Flag(as_org_id        IN VARCHAR2,
  																       as_batch_type    IN VARCHAR2 --'AP Invoice'
                                                                                    --'Journal'
                                                                                    --'Customer'
                                                                                    --'Supplier'  
                                                        ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	C_CNT             INTEGER        DEFAULT 0;   
   
BEGIN
 BEGIN
   
		
      
      SELECT NVL(COUNT(*),0)
		  INTO C_CNT
		  FROM efin_batch_flag
		 WHERE TO_CHAR(batch_date,'yyyy-mm-dd') = TO_CHAR(SYSDATE,'yyyy-mm-dd')
			AND org_id = as_org_id
			AND batch_type = as_batch_type ;
		IF C_CNT = 0 THEN
			INSERT INTO efin_batch_flag  
							( batch_date,org_id,batch_type,status,last_update_date,last_updated_by,last_update_login,
					  		  creation_date,created_by )  
				  VALUES ( TO_CHAR(SYSDATE,'yyyy-mm-dd'),as_org_id,as_batch_type,'1',SYSDATE,1,1,SYSDATE,1)  ;
		ELSE
			UPDATE efin_batch_flag
			   SET last_update_date = SYSDATE
			 WHERE TO_CHAR(batch_date,'yyyy-mm-dd') = TO_CHAR(SYSDATE,'yyyy-mm-dd')
				AND org_id = as_org_id
				AND batch_type = as_batch_type ;
		END IF;
      
      
      EXCEPTION
      WHEN OTHERS THEN
           RAISE;
           /*IF SQL%NOTFOUND THEN
              e_msg      := '인터페이스 GL 생성 실패! [Line No: 159]'||TO_CHAR(SYSDATE,'yyyy-mm-dd')||'/'||as_org_id||'/'||C_CNT;
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;*/
 END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   -- ENDING...[0.1] CURSOR CLOSE 재 확인 처리 !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- 사용자 정의 Error Message
      Wk_errflag := 0;                         -- 사용자 정의 Error Code
   ELSE
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;
EXCEPTION
  WHEN UserErr       THEN
       RAISE;
       --RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END Y_Sp_Comm_Slip_Batch_Flag;
/

