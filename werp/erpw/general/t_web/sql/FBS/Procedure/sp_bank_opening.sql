    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : sp_bank_opening                                        */
    /*  2. ����̸�  : ��������                                              */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �����/������������ ������ ��ȸ�Ͽ��� ���������� �����.       */
    /*                                                                       */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��3��08��                                         */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/  
    Create Or Replace Procedure sp_bank_opening(p_param IN VARCHAR2 DEFAULT NULL ) IS

        v_company_cd               VARCHAR2(2); 
        v_bank_cd                  VARCHAR2(2); 
        	                            
    BEGIN

        FOR rec IN ( SELECT DISTINCT A.BANK_MAIN_CODE   AS bank_cd ,
                                     A.COMP_CODE        AS company_cd
                       FROM T_FB_ORG_BANK A
                    )
        LOOP

        v_company_cd := rec.company_cd;
        v_bank_cd := rec.bank_cd;
        
        -- ������ ����
        sp_send_start_document( v_company_cd , v_bank_cd );    
                         
		    END LOOP;
    
    EXCEPTION    
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] �������� �����߻�.(ȸ���ڵ�:'||v_company_cd||',�����ڵ�:'||v_bank_cd||')');
             RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(�����ڵ�:'||v_bank_cd||')');
    END ;