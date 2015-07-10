    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : f_opening_result                                      */
    /*  2. ����̸�  : �����������                                          */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ȸ���ڵ�/�����ڵ� �Է¹޾Ƽ� ������������� ��ȯ               */
    /*                                                                       */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��3��08��                                         */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/  
    Create Or Replace Function f_opening_result(  
                                 company_cd  VARCHAR2 ,                      -- ȸ���ڵ�
                                 bank_cd     VARCHAR2 ) RETURN VARCHAR2 IS   -- �����ڵ�


        v_tran_code                VARCHAR2(9); 
        v_ente_code                VARCHAR2(8); 
        v_result_code              VARCHAR2(10); 
        
		    FB_DOCU_OPEN_T    VARCHAR2(7) := '0800100'; /*  ��������        (��ü=>����)  */
		    FB_DOCU_OPEN_B    VARCHAR2(7) := '0810100'; /*  ��������        (����=>��ü)  */
        	                            
    BEGIN
    	  --�����/�������� �˻�
    	  SELECT TRAN_CODE,
    	         ENTE_CODE
    	  INTO   v_tran_code ,
    	         v_ente_code
        FROM   T_FB_ORG_BANK
        WHERE  COMP_CODE = company_cd
        AND    BANK_MAIN_CODE = bank_cd ;
            	         
        -- ����˻�.
				SELECT RESP_CODE
				INTO   v_result_code
				FROM   T_FB_VAN_RECV
				WHERE  TRAN_CODE = v_tran_code
				AND    ENTE_CODE = v_ente_code
				AND    BANK_CODE = bank_cd
				AND    DOCU_CODE = SUBSTRB(FB_DOCU_OPEN_B,1,4)
				AND    UPMU_CODE = SUBSTRB(FB_DOCU_OPEN_B,5,3)
				AND    SEND_DATE = TO_CHAR(SYSDATE ,'yyyymmdd') ;

        RETURN( v_result_code );
    
    EXCEPTION
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] ���ϸ� ������ ���� SUBJECT NAME�� ��ϵǾ� ���� �ʽ��ϴ�. (ȸ���ڵ�:'||company_cd||',�����ڵ�:'||bank_cd||')');
             RETURN('ERROR');             
    END ;