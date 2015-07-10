CREATE OR REPLACE PROCEDURE Y_Sp_H_Slip_Customer (as_comp_code    IN   VARCHAR2,
																	  as_cust_name  IN   VARCHAR2,
																	  as_cust_code  IN   VARCHAR2,
																	  as_cust_type       IN   VARCHAR2,  --'개인','법인'
																	  as_dept_code   IN   VARCHAR2,
																	  as_zip         IN   VARCHAR2,
																	  as_addr1        IN   VARCHAR2,
                                                     as_addr2        IN   VARCHAR2,
																	  as_uptae       IN   VARCHAR2,
																	  as_upjong      IN   VARCHAR2 ) IS
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
   C_CORPORATION_NAME     VARCHAR2(100);
   C_COLLECTOR_NAME       VARCHAR2(100);
   C_SIDO                 VARCHAR2(100);
   C_GUGUN                VARCHAR2(100);
BEGIN
 BEGIN
-- 현장의 사업장코드로 ORG-ID 및 ORG-Name를 구한다.
		SELECT attribute1,org_name, CORPORATION_NAME
		  INTO C_ORG_ID,C_ORG_NAME, C_CORPORATION_NAME
		  FROM efin_corporations_v
		 WHERE corporation_code = as_comp_code;
		
      C_COLLECTOR_NAME := REPLACE(C_CORPORATION_NAME, '(주)','');
      C_COLLECTOR_NAME := REPLACE(C_COLLECTOR_NAME, '본점','');
      C_COLLECTOR_NAME := REPLACE(C_COLLECTOR_NAME, '김포지점','');
      C_COLLECTOR_NAME := REPLACE(C_COLLECTOR_NAME, '안산지점','');
      
      
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
                 
      
      INSERT INTO efin_customer_itf  
				( seq, batch_date, org_id, org_name, customer_name, tax_registration_num, taxable_person,
              postal_code, address_line_1,address_line_2,address_line_3,address_line_4,
              address,industry_classification, industry_sub_classification, customer_type, external_internal_type,
              customer_profile_class_name, status,  
              last_update_date,last_updated_by,last_update_login, creation_date,created_by, LOCATION, collector_name,
              customer_name_phonetic )
		VALUES(efin_cus_itf_s.NEXTVAL ,TO_CHAR(SYSDATE,'yyyy-mm-dd'),C_ORG_ID, C_ORG_NAME, as_cust_name,as_cust_code, as_cust_name,
				 SUBSTRB(as_zip,1,3) || '-' || SUBSTRB(as_zip,4,3),NVL(C_SIDO,'.'), NVL(C_GUGUN,'.'),NVL(as_addr1,'.'),NVL(as_addr2,'.'),
             '.',NVL(as_uptae,'.'), NVL(as_upjong,'.'), DECODE(as_cust_type, '개인','Person','법인', 'Organization', NULL) , 'External', 
             as_cust_type, 'NEW',
             TO_CHAR(SYSDATE,'yyyy-mm-dd'),'1','1',TO_CHAR(SYSDATE,'yyyy-mm-dd'),'1', as_cust_code, trim(C_COLLECTOR_NAME),
             as_cust_name);
                 		 
		
      EXCEPTION
      WHEN OTHERS THEN
           RAISE;
           /*IF SQL%NOTFOUND THEN
              e_msg      := '인터페이스 거래처 생성 실패! [Line No: 159]';
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
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END Y_Sp_H_Slip_Customer;
/

