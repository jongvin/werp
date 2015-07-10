CREATE OR REPLACE PROCEDURE Y_Sp_Comm_Slip_Supplier (as_comp_code    IN   VARCHAR2,
																	  as_vendor_name  IN   VARCHAR2,
																	  as_vendor_site_code  IN   VARCHAR2,
																	  as_vendor_type_lookup_code  IN   VARCHAR2,
																	  as_dept_code   IN   VARCHAR2,
																	  as_accts_code  IN   VARCHAR2,
																	  as_zip         IN   VARCHAR2,
																	  as_addr        IN   VARCHAR2,
																	  as_uptae       IN   VARCHAR2,
																	  as_upjong      IN   VARCHAR2,
																	  as_tread       IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	C_SLIP_DT              DATE;
   C_CNT                  INTEGER        DEFAULT 0; 
	C_ORG_ID               VARCHAR2(10);
	C_ORG_NAME             VARCHAR2(100);
	C_PAY_CODE_ACCOUNTS    VARCHAR2(100);
	C_PREPAY_CODE_ACCOUNTS VARCHAR2(100);
	C_FUTURE_ACCOUNTS      VARCHAR2(100);
   C_SIDO                 VARCHAR2(100);
   C_GUGUN                VARCHAR2(100);
   C_ZIP                  VARCHAR2(10);
BEGIN
 BEGIN
-- 현장의 사업장코드로 ORG-ID 및 ORG-Name를 구한다.
		SELECT attribute1,org_name
		  INTO C_ORG_ID,C_ORG_NAME
		  FROM efin_corporations_v
		 WHERE corporation_code = as_comp_code;
		C_PAY_CODE_ACCOUNTS    := as_comp_code || '.' || as_dept_code || '.' || as_accts_code || '.' || as_comp_code || '99999.0000';
		C_PREPAY_CODE_ACCOUNTS := as_comp_code || '.' || as_dept_code || '.112212.' || as_comp_code || '99999.0000';
		C_FUTURE_ACCOUNTS      := as_comp_code || '.' || as_dept_code || '.211115.' || as_comp_code || '99999.0000';
      
      BEGIN
      SELECT NVL(a.sido,'.'),NVL(a.gugun,'.')
        INTO C_SIDO, C_GUGUN
		  FROM Z_CODE_ZIP a,
		  	    (SELECT MAX(seq) seq
			 	    FROM Z_CODE_ZIP
		         WHERE zipcode = as_zip) b
		 WHERE a.seq = b.seq;
      EXCEPTION 
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;
      
      IF LENGTH(TRIM(AS_ZIP)) = NULL THEN 
         C_ZIP := '.';
      ELSE
         C_ZIP := SUBSTRB(as_zip,1,3) || '-' || SUBSTRB(as_zip,4,3);
      END IF;
      
		INSERT INTO efin_supplier_itf  
				( seq,batch_date,org_id,org_name,vendor_name,vendor_name_alt,
				  vendor_site_code,vendor_site_code_alt,vat_registration_num,vendor_type_lookup_code,
				  accts_pay_code_accounts,prepay_code_accounts,future_dated_payment_accounts,
				  ap_term,invoice_currency_code,payment_currency_code,terms_date_basis,pay_date_basis_lookup_code,
				  payment_method_lookup_code,zip,address_line_1,address_line_2,address_line_3,global_attribute4,
				  global_attribute5,global_attribute1,status,last_update_date,last_updated_by,last_update_login,
				  creation_date,created_by )
		VALUES( efin_sup_itf_s.NEXTVAL,TO_CHAR(SYSDATE,'yyyy-mm-dd'),C_ORG_ID,C_ORG_NAME,as_vendor_name,as_vendor_name,
				 as_vendor_site_code,as_vendor_name,as_vendor_site_code,as_vendor_type_lookup_code,
				 C_PAY_CODE_ACCOUNTS,C_PREPAY_CODE_ACCOUNTS,C_FUTURE_ACCOUNTS,
				 '현금즉시지급','KRW','KRW','invoice','Due',
 				 'Check',C_ZIP,C_SIDO, C_GUGUN,NVL(as_addr,'.'),NVL(as_uptae,'.'),
				 NVL(as_upjong,'.'),as_tread,'NEW',TO_CHAR(SYSDATE,'yyyy-mm-dd'),'1','1',
				 TO_CHAR(SYSDATE,'yyyy-mm-dd'),'1');
             		 
		SELECT NVL(COUNT(*),0)
		  INTO C_CNT
		  FROM efin_batch_flag
		 WHERE TO_CHAR(batch_date,'yyyy-mm-dd') = TO_CHAR(SYSDATE,'yyyy-mm-dd')
			AND org_id = C_ORG_ID
			AND batch_type = 'Supplier' ;
		IF C_CNT = 0 THEN
			INSERT INTO efin_batch_flag  
							( batch_date,org_id,batch_type,status,last_update_date,last_updated_by,last_update_login,
					  		  creation_date,created_by )  
				  VALUES ( TO_CHAR(SYSDATE,'yyyy-mm-dd'),C_ORG_ID,'Supplier','1',SYSDATE,1,1,SYSDATE,1)  ;
		ELSE
			UPDATE efin_batch_flag
			   SET last_update_date = SYSDATE
			 WHERE TO_CHAR(batch_date,'yyyy-mm-dd') = TO_CHAR(SYSDATE,'yyyy-mm-dd')
				AND org_id = C_ORG_ID
				AND batch_type = 'Supplier' ;
		END IF;
      EXCEPTION
      WHEN OTHERS THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '인터페이스 거래처 생성 실패! [Line No: 159]'||SQLERRM;
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;
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
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END Y_Sp_Comm_Slip_Supplier;
/

