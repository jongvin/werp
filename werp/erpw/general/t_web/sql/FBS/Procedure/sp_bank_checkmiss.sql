    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : sp_bank_checkmiss                                     */
    /*  2. ����̸�  : ���ھ��������û                                      */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �ڵ����� ���ھ������������ �����.                            */
    /*                                                                       */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��3��10��                                         */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/  
    Create Or Replace Procedure sp_bank_checkmiss(p_param IN VARCHAR2 DEFAULT NULL ) IS

        v_company_cd               VARCHAR2(2); 
        v_bank_cd                  VARCHAR2(2); 
        v_hour                     NUMBER; 
        v_chk                      NUMBER; 
        v_max_docu_numc            NUMBER;
        
		    FB_DOCU_BILL_TRX_B   VARCHAR2(7) := FBS_MAIN_PKG.FB_DOCU_BILL_TRX_B;  /*  �����ŷ���     (����=>��ü) */  
		    FB_DOCU_BILL_MISS_T  VARCHAR2(7) := FBS_MAIN_PKG.FB_DOCU_BILL_MISS_T; /*  �����������û (��ü=>����) */
		    FB_DOCU_BILL_MISS_B  VARCHAR2(7) := FBS_MAIN_PKG.FB_DOCU_BILL_MISS_B; /*  �����������û (����=>��ü) */
        	                            
    BEGIN
        /***************************************************************/         
        /*  ���ھ����� ����� Ȯ���Ͽ�, �ڵ����� �����û            */
        /***************************************************************/         
         v_hour := TO_NUMBER( TO_CHAR( SYSDATE , 'HH24' ) );
            
         -- ��ħ9�ú��� ����9�ñ��� ������� �Ѵ�. 
         IF v_hour >= 9 AND v_hour <= 21 THEN

            -- ���ະ/�ŷ�ó�� LOOP   
            FOR rec_gubun IN ( SELECT DISTINCT TRAN_CODE, ENTE_CODE ,BANK_CODE
                               FROM   T_FB_VAN_RECV 
                               WHERE  SEND_DATE = TO_CHAR(SYSDATE,'YYYYMMDD') 
                               AND    DOCU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,1,4) 
                               AND    UPMU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,5,3) ) LOOP
                                   
                SELECT TO_NUMBER(MAX(DOCU_NUMC)) 
                INTO   v_max_docu_numc
                FROM   T_FB_VAN_RECV 
                WHERE  TRAN_CODE = rec_gubun.TRAN_CODE
                AND    ENTE_CODE = rec_gubun.ENTE_CODE
                AND    BANK_CODE = rec_gubun.BANK_CODE                          
                AND    DOCU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,1,4) 
                AND    UPMU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,5,3) 
                AND    SEND_DATE = TO_CHAR(SYSDATE,'YYYYMMDD') ;
                  
                -- �ش� ����/�ŷ�ó/��������/��¥�� �ش��ϴ� ������ 1���� �����ؼ� ���� ��ȣ�� �ִ��� Ȯ���մϴ�.
                FOR index_num IN 1..v_max_docu_numc LOOP 

                    -- �ش��ȣ�� ������ �ִ��� Ȯ���մϴ�.  
                    SELECT COUNT(*)
                    INTO   v_chk
                    FROM   T_FB_VAN_RECV
                    WHERE  TRAN_CODE = rec_gubun.TRAN_CODE
                    AND    ENTE_CODE = rec_gubun.ENTE_CODE
                    AND    BANK_CODE = rec_gubun.BANK_CODE
                    AND    DOCU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,1,4) 
                    AND    UPMU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,5,3) 
                    AND    SEND_DATE = TO_CHAR(SYSDATE,'YYYYMMDD')
                    AND    DOCU_NUMC = LPAD( TO_CHAR(index_num) , 6 , '0' );
                        
                    -- �ش� ��ȣ�� ������ ���� ����̹Ƿ�, ���� ��������� �ִ��� Ȯ�� �� ��, ������ �����û���� �۽�  
                    IF v_chk = 0 THEN   

                        SELECT COUNT(*)
                        INTO   v_chk
                        FROM   T_FB_VAN_RECV
                        WHERE  TRAN_CODE = rec_gubun.TRAN_CODE
                        AND    ENTE_CODE = rec_gubun.ENTE_CODE
                        AND    BANK_CODE = rec_gubun.BANK_CODE
                        AND    DOCU_CODE = SUBSTRB(FB_DOCU_BILL_MISS_B,1,4) 
                        AND    UPMU_CODE = SUBSTRB(FB_DOCU_BILL_MISS_B,5,3)
                        AND    SEND_DATE = TO_CHAR(SYSDATE,'YYYYMMDD') 
                        AND    DOCU_NUMC = LPAD( TO_CHAR(index_num) , 6 , '0' );
                            
                        -- �ش� ������ȣ�� ���Ͽ� �����û���䵵 ���� ���� �����û ���� �۽�    
                        IF v_chk = 0 THEN
                            -- �ŷ�ó�ڵ�κ��� ȸ���ڵ带 �����ɴϴ�.
                            SELECT COMP_CODE    ,rec_gubun.BANK_CODE
                            INTO   v_company_cd ,v_bank_cd
                            FROM   T_FB_ORG_BANK
                            WHERE  BANK_MAIN_CODE = rec_gubun.BANK_CODE
                            AND    TRAN_CODE      = rec_gubun.TRAN_CODE
                            AND    ENTE_CODE      = rec_gubun.ENTE_CODE
                            AND    ROWNUM = 1;
                                    
                            -- �����û ������ �۽��մϴ�.
													 sp_check_miss_req( v_company_cd	 ,	                      -- ������ڵ�
														                  rec_gubun.BANK_CODE	 ,	                -- �����ڵ�
																							TO_CHAR(SYSDATE,'YYYYMMDD'),	          -- �ŷ�����
																							LPAD( TO_CHAR(index_num) , 6 , '0' ));  -- ���
                                
                        END IF;
                                
                    END IF;    
                       
                END LOOP;  -- �ش�����/�ŷ�ó/��¥/�������к� 
                
            END LOOP;  -- �ش�����/�ŷ�ó
            
         END IF;
    
    EXCEPTION    
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] ������� �����߻�.(ȸ���ڵ�:'||v_company_cd||',�����ڵ�:'||v_bank_cd||')');
             RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(�����ڵ�:'||v_bank_cd||')');
    END ;