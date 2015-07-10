CREATE OR REPLACE FUNCTION F_Comm_Slip_Check_Supplier ( as_org_id    IN VARCHAR2,
                                                        as_supplier_code IN VARCHAR2)
                                                          
      RETURN BOOLEAN       --�ش���� FI �� ������ return true
                           --                 ������ return false (**Ȯ�ν��нÿ��� false return ��)  
                           --(������� �������� y_sp_slip_agree���� Ȯ�� �ٶ�)
    AS
    
    c_org_id VARCHAR2(50);
    c_cnt1   INTEGER;
    c_cnt2   INTEGER;
    
BEGIN
  /*SELECT attribute1 
     INTO C_ORG_ID
     FROM efin_corporations_v 
    WHERE corporation_code = as_comp_code;*/
   
	SELECT NVL(COUNT(*),0)
	  INTO C_CNT1
	  FROM efin_check_supplier_v
	 WHERE org_id = as_org_id
		AND vat_registration_num = as_supplier_code;
       
	IF C_CNT1 = 0 THEN
   
		SELECT NVL(COUNT(*),0)
		  INTO C_CNT2
		  FROM efin_supplier_itf
	    WHERE org_id = as_org_id
			AND vendor_site_code = as_supplier_code;
         
		IF C_CNT2 = 0 THEN
      
         RETURN FALSE;
         
      END IF;
      
   END IF;
   
   RETURN TRUE;
      
EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;
END;
/

