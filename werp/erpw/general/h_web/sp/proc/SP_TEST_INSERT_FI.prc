CREATE OR REPLACE PROCEDURE Sp_Test_Insert_Fi (as_par VARCHAR2) IS

cnt NUMBER DEFAULT 0;
C_UNQ_SEQ NUMBER ;

BEGIN
   LOOP
      
		EXIT WHEN cnt = 4000;
      
      SELECT efin_invoice_lines_itf_s.NEXTVAL@crp
		  INTO C_UNQ_SEQ
		  FROM dual;
      
      
      INSERT INTO efin_gl_import_itf@crp
				( seq,batch_date,
				  last_update_date,last_updated_by,last_update_login,creation_date,created_by,
              invoice_group_id)
		VALUES (C_UNQ_SEQ,TO_CHAR(SYSDATE,'yyyy-mm-dd'),
				  TO_CHAR(SYSDATE,'yyyy-mm-dd'),1,1,TO_CHAR(SYSDATE,'yyyy-mm-dd'),1,
              999999);
              
      cnt := cnt +1;
   
   END LOOP;
   
    
END Sp_Test_Insert_Fi;
/

