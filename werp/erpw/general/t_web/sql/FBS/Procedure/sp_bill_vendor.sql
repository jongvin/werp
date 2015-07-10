    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : sp_bill_vendor                                        */
    /*  2. ����̸�  : ���ھ�����ü����                                      */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �ڵ����� ���ھ�����ü ������ �����.                           */
    /*                                                                       */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��3��08��                                         */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/  
    Create Or Replace Procedure sp_bill_vendor(p_param IN VARCHAR2 DEFAULT NULL ) IS

        v_company_cd               VARCHAR2(2); 
        v_bank_cd                  VARCHAR2(2); 
        	                            
    BEGIN
        /***************************************************************/         
        /*  �ڵ����� ���ھ������� ��û                                 */
        /***************************************************************/         
        -- �����/���ະ LOOP   
        FOR rec_gubun IN ( SELECT DISTINCT COMP_CODE, BANK_MAIN_CODE
                           FROM   T_FB_ORG_BANK 
                           WHERE  VENDOR_SUBJECT_NAME IS NOT NULL  ) LOOP
                                    
	           -- ���ھ���������û ������ �۽��մϴ�.
	           v_company_cd := rec_gubun.comp_code;
	           v_bank_cd := rec_gubun.bank_main_code;
	           
		    		 sp_read_bill_vendor_info( v_company_cd ,     -- �þ�¡�ڵ�
		    		                           v_bank_cd    ,     -- �����ڵ�
		    		                           'SYSTEM'   ) ;     -- �����ȣ
             
        END LOOP;  -- �����/���ະ
    
    EXCEPTION    
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] ���ھ����������� �����߻�.(ȸ���ڵ�:'||v_company_cd||',�����ڵ�:'||v_bank_cd||')');
             RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(�����ڵ�:'||v_bank_cd||')');
    END ;