    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : get_batch_sign_no                                     */
    /*  2. ����̸�  : batch����ó����  �����ȣ�� ��ȯ�Ѵ�.                 */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - EDI���ϻ����� �̷�key�μ� ������ �ִ� edi_history_seq�� �Ѱܹ� */
    /*        �Ƽ�, �ش� �ڷḦ SELECT�Ͽ�, ���ະ �����ȣ ������Ģ�� ����  */
    /*        �����ȣ�� ������ ��, ��ȯ�Ѵ�. (MAX��: VARCHAR2 8�ڸ�)        */
    /*                                                                       */
    /*      - �������                                                       */
    /*         (1) ������� [03]                                             */
    /*         (2) �������� [04]                                             */
    /*         (3) �츮���� [20]                                             */
    /*         (4) �ϳ����� [81]                                             */
    /*                                                                       */
    /*      - �����ȣ ����� ���ü� üũ�� ���ؼ� EDI_HISTORY_SEQ�� �޾�    */
    /*        ����ڷḦ SELECT�Ͽ� �����ȣ�� �����ϸ�, OUT PARAMETER��     */
    /*        �ѰǼ�, �ѱݾ��� ��ȯ�ϹǷ�, �� �Լ��� ȣ���ϴ� �Լ�������     */
    /*        �� �Ǽ� �� �ݾ��� ��Ȯ���Ͽ� ó���մϴ�                        */    
    /*                                                                       */
    /*      - ����BATCH(�ϳ�����)�� ���, ǥ���ο� ���� ���޿�����       */
    /*        (YYYYMMDD)�� ���, T_FB_EDI_HISTORY�� ������(STD_YMD)�� ���   */
    /*                                                                       */
    /*      - ������ ���, ������� / ������ ���, 2������(�ϳ�,���) ���   */
    /*        �����ȣ�� �������� �����Ƿ�, ����ġ �ʽ��ϴ�.                 */        
    /*                                                                       */
    /*      - ��ȯ�� : �������� ���, ������� �����ȣ�� ��ȯ�Ǹ�,          */
    /*                 ������ �� ���� NULL���� ��ȯ�˴ϴ�.                 */    
    /*                                                                       */        
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��26��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
    create or replace     
    FUNCTION  get_batch_sign_no(  edi_history_seq IN NUMBER ,                 -- EDI�̷��Ϸù�ȣ   
                                  total_cnt       OUT NUMBER ,                -- �����ȣ�� ������ ����ڷ��� �� �Ǽ� 
                                  total_sum       OUT NUMBER ,                -- �����ȣ�� ������ ����ڷ��� �� �ݾ� 
                                  etc_field1      IN VARCHAR2 DEFAULT NULL,   -- �����ʵ�1   
                                  etc_field2      IN VARCHAR2 DEFAULT NULL)   -- �����ʵ�2  
        RETURN VARCHAR2 IS
        
        v_sign_no          VARCHAR2(8) := NULL;      -- ��ȯ�� �����ȣ
        v_cash_bill_gubun  VARCHAR2(1);              -- ��������, ���ھ������� ����.
        v_comp_code        VARCHAR2(10);             -- ��ü�ڵ� 
        v_comp_password    VARCHAR2(50);             -- ��ü��ȣ 
        n_total_cnt        NUMBER      := 0;         -- ���� �����ȣ������ ���� �� ����  ==> Ȯ�ο� 
        n_total_sum        NUMBER      := 0;         -- ���� �����ȣ������ ���� �� �ݾ�  ==> Ȯ�ο� 
        out_bank_cd        VARCHAR2(2);              -- ��������ڵ� 
        
        v_temp_str1        VARCHAR2(100);            -- �ӽð��� ���ڿ� 1  
        v_temp_str2        VARCHAR2(100);            -- �ӽð��� ���ڿ� 2 
        n_temp_number1     NUMBER := 0;              -- �ӽð��� ���� 1  
        n_temp_number2     NUMBER := 0;              -- �ӽð��� ���� 2  
        
        v_error_msg        VARCHAR2(300) := '';

		    KIUP_BANK_CD       VARCHAR2(2) := '03';   -- �������
		    KUKMIN_BANK_CD     VARCHAR2(2) := '04';   -- ��������
		    WOORI_BANK_CD      VARCHAR2(2) := '20';   -- �츮����
		    HANA_BANK_CD       VARCHAR2(2) := '81';   -- �ϳ�����
            
        CURSOR cur_select IS 
              SELECT REPLACE(C.IN_ACCOUNT_NO,'-','') AS ACCOUNT_NO,  
                     A.PAY_AMT AS PAY_AMT , 
                     C.IN_BANK_CODE AS IN_BANK_CODE
                FROM T_FB_CASH_PAY_DIVIDED_DATA A ,
                     T_FB_CASH_PAY_HISTORY B,
                     T_FB_CASH_PAY_DATA C
               WHERE B.PAY_SEQ = A.PAY_SEQ
                 AND B.DIV_SEQ = A.DIV_SEQ     
                 AND B.PAY_SEQ = C.PAY_SEQ
                 AND B.EDI_HISTORY_SEQ = edi_history_seq ;
        
        ERR_VALUE_ERROR      EXCEPTION;        -- �����߻���
        
    BEGIN
    
       -- ���� EDI�̷����̺��� Ȯ���Ͽ�,  �ش� �ۼ��Ű��� ���ݰ�����, ���������� Ȯ���ϸ�,
       -- EDI history���̺� �ִ� ��������ڵ�,������ڵ� �� �����ͼ� ����մϴ�. 
       BEGIN
           SELECT CASH_BILL_GUBUN , BANK_CODE , COMP_CODE 
             INTO v_cash_bill_gubun , out_bank_cd , v_comp_code 
             FROM T_FB_EDI_HISTORY
            WHERE EDI_HISTORY_SEQ = edi_history_seq ;
       EXCEPTION
           WHEN NO_DATA_FOUND THEN
               v_sign_no := NULL;
           WHEN OTHERS THEN
               v_sign_no := NULL;               
       END; 
              
       
       -- ������ ���...
       -----------------
       
       IF v_cash_bill_gubun = 'C' THEN
    
            /**************************************************************************************/               
            /* ���������� ���                                                                    */
            /**************************************************************************************/              
            IF out_bank_cd = KUKMIN_BANK_CD THEN  
    
                -- ��ü��ȣ�� �����ɴϴ�.
                BEGIN
                    SELECT COMP_PASSWORD
                      INTO v_comp_password
                      FROM T_FB_ORG_BANK
                     WHERE COMP_CODE = v_comp_code
                       AND BANK_MAIN_CODE = out_bank_cd;
                       
                    IF v_comp_password IS NULL OR v_comp_password = '' THEN
                        v_error_msg := '��ü��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.(��ü�ڵ�:'|| v_comp_code || ',�����ڵ�:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                    END IF;
                    
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        v_error_msg := '��ü��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.(��ü�ڵ�:'|| v_comp_code || ',�����ڵ�:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                END;                   
                   
                -- LOOPING�� ���鼭 ���¹�ȣ 10��° �� �� ����ü�Ǽ�,����ü�ݾ��� �����ɴϴ�.
                FOR rec IN cur_select LOOP
                    
                    -- ���¹�ȣ 10��° �ڸ��� BLANK�̰ų�, �Ա������� ��������(04)�̸鼭 ���±��̰� 12�ڸ� �̸��̸� 0 ó��
                    -- n_temp_number1 : �� ������ 10��° �ڸ��� ��.
                    -- n_temp_number2 : �� ������ 10��° �ڸ��� ���ڷ� ��ȯ�� ��.
                    IF ( LENGTH(TRIM(rec.ACCOUNT_NO)) < 10 ) OR 
                       ( SUBSTRB(TRIM(rec.ACCOUNT_NO) , 10 , 1 ) = ' ' ) OR
                       ( rec.IN_BANK_CODE = '04' AND LENGTH(TRIM(rec.ACCOUNT_NO)) < 12 ) THEN
                       
                        n_temp_number2 := 0;
                       
                    ELSE
                        n_temp_number2 := TO_NUMBER( SUBSTRB( TRIM(rec.ACCOUNT_NO) , 10 , 1 ) );
                    END IF;
                    
                    n_temp_number1 := n_temp_number1 + n_temp_number2;

                    -- üũ������ ��ü�Ǽ��� ��ü�ݾ��� ���մϴ�. (���������� ���, �ϴܿ��� ��꿡 Ȱ����) 
                    n_total_cnt := n_total_cnt + 1;
                    n_total_sum := n_total_sum + rec.PAY_AMT;                
                
                END LOOP;
                
                -- �����ȣ ������Ģ�� �ǰ��ؼ�, ������ �մϴ�.
                n_temp_number2 := ( n_temp_number1 + n_total_sum + n_total_cnt ) / ( n_total_cnt + TO_NUMBER( TRIM(v_comp_password) ) );
                  
                -- �Ҽ������ڸ��� ���� ��(Trunc�Լ� ���) , 10000�� ���ϰ�, �Ҽ����ϸ� �߶������ �����ȣ�� ���մϴ�.
                n_temp_number2 := TRUNC( ( n_temp_number2 - TRUNC( n_temp_number2 ) ) * 10000 );
                
                -- ���⺹���ȣ�� �ڸ����� ���� 4�ڸ� �̸��� ���, �����ʿ� '0'�� ���Դϴ�.
                v_sign_no := RPAD( TO_CHAR( n_temp_number2 ) , 4 , '0' );
                    
                     
                    
            /**************************************************************************************/               
            /* �츮������ ���                                                                    */
            /**************************************************************************************/        
            ELSIF out_bank_cd = WOORI_BANK_CD THEN    
                
                --  LOOPOMG�� ���鼭 , ������ ����Ÿ(�Աݰ��¹�ȣ,�Աݱݾ�)���� �����ȣ�� ����մϴ�.           
                FOR rec IN cur_select LOOP     

                    v_temp_str1 := TO_CHAR( rec.PAY_AMT );
                    
                    FOR i IN 1..LENGTH(rec.ACCOUNT_NO) LOOP
                        n_temp_number1 := n_temp_number1 + TO_NUMBER( SUBSTRB( rec.ACCOUNT_NO , i , 1 ) );                    
                    END LOOP;
                    
                    FOR i IN 1..LENGTH(v_temp_str1) LOOP
                        n_temp_number2 := n_temp_number2 + TO_NUMBER( SUBSTRB( v_temp_str1 , i , 1 ) );                    
                    END LOOP;
                
                    -- üũ������ ��ü�Ǽ��� ��ü�ݾ��� ���մϴ�.
                    n_total_cnt := n_total_cnt + 1;
                    n_total_sum := n_total_sum + rec.PAY_AMT;
                
                END LOOP;   

                v_sign_no := TO_CHAR( MOD( n_temp_number1 , n_temp_number2  ) ); 
                
                -- ����� �����ȣ�� 6���ڸ� �Ѿ�� ���, ���� 6�ڸ��� ���մϴ�. 
                IF LENGTHB(v_sign_no) > 6 THEN
                    v_sign_no := SUBSTRB( v_sign_no ,LENGTHB(v_sign_no) - 5 , 6 );
                ELSE
                    v_sign_no := LPAD( v_sign_no , 6 , '0' );
                END IF;

                                  
            /**************************************************************************************/          
            /* �ϳ������� ���                                                                    */
            /**************************************************************************************/        
            ELSIF out_bank_cd = HANA_BANK_CD THEN       
    
                -- ���޿������ʵ� ( T_FB_EDI_HISTORY�� STD_YMD�÷��� ����մϴ�. Ÿ �ʵ� ���� �����ʿ�) 
                SELECT SUBSTRB(STD_YMD,1,4)
                  INTO v_temp_str2
                  FROM T_FB_EDI_HISTORY
                 WHERE EDI_HISTORY_SEQ = edi_history_seq;
                   
                IF v_temp_str2 IS NULL OR v_temp_str2 = '' THEN
                    v_error_msg := 'T_FB_EDI_HISTORY�� ��������(STD_YMD)�� ���� �����ϴ�.';
                    RAISE ERR_VALUE_ERROR;
                END IF;
                    
                -- ��ü��ȣ�� �����ɴϴ�.
                BEGIN
                    SELECT SUBSTRB(COMP_PASSWORD,1,4)
                      INTO v_comp_password
                      FROM T_FB_ORG_BANK
                     WHERE COMP_CODE = v_comp_code
                       AND BANK_MAIN_CODE = out_bank_cd;
                       
                    IF v_comp_password IS NULL OR v_comp_password = '' THEN
                        v_error_msg := '��ü��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.(��ü�ڵ�:'|| v_comp_code || ',�����ڵ�:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                    END IF;
                    
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        v_error_msg := '��ü��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.(��ü�ڵ�:'|| v_comp_code || ',�����ڵ�:'|| out_bank_cd || ')';
                        RAISE ERR_VALUE_ERROR;
                END;     
    
                -- LOOPING�� ���鼭 ���¹�ȣ 7��°������ �� �� ��ü�ݾ����� ����մϴ�.
                FOR rec IN cur_select LOOP      
                    
                    n_temp_number1 := 0;
                    
                    FOR each_byte IN 1..7 LOOP
                    
                        v_temp_str1 := SUBSTRB( rec.ACCOUNT_NO , each_byte , 1 );
                        
                        IF v_temp_str1 IS NOT NULL AND v_temp_str1 != '' THEN
                            n_temp_number1 := n_temp_number1 + TO_NUMBER( v_temp_str1 );
                        END IF;
                    
                    END LOOP;
                
                    n_temp_number2 := n_temp_number2 + TRUNC( ( n_temp_number1 * rec.PAY_AMT ) / 100 );
                
                    -- üũ������ ��ü�Ǽ��� ��ü�ݾ��� ���մϴ�. (�ϳ������� ���, �ϴܿ��� ��꿡 Ȱ����) 
                    n_total_cnt := n_total_cnt + 1;
                    n_total_sum := n_total_sum + rec.PAY_AMT;                 
                
                END LOOP;

                v_temp_str1 := TRIM( TO_CHAR( ( TO_NUMBER( v_temp_str2 ) + 
                                                TO_NUMBER( v_comp_password ) +
                                                n_total_cnt +
                                                n_total_sum 
                                              ) - n_temp_number2 ) ); 
                
                v_sign_no := SUBSTRB( v_temp_str1 , LENGTH(v_temp_str1) - 3 ,  4 );
    
            /**************************************************************************************/               
            /* ��������� ���  ==> ������� �ʽ��ϴ�.                                            */
            /**************************************************************************************/              
            ELSIF out_bank_cd = KIUP_BANK_CD THEN     
            
                v_sign_no := '';          
    
            END IF;

            
        -- ���ھ����� ���.... 
        ----------------------
           
        ELSIF v_cash_bill_gubun = 'B' THEN    

            /**************************************************************************************/          
            /* �ϳ������� ��� ==> ���ġ �ʽ��ϴ�.                                               */
            /**************************************************************************************/        
            IF out_bank_cd = HANA_BANK_CD THEN        
    
                v_sign_no := '';         
            
    
            /**************************************************************************************/               
            /* ��������� ��� ==> ���ġ �ʽ��ϴ�.                                               */
            /**************************************************************************************/              
            ELSIF out_bank_cd = KIUP_BANK_CD THEN  
            
                v_sign_no := '';          
    
            END IF;
        
        
        END IF;
        
        -- OUT paramter�� �ѱ� �ѰǼ�, �ѱݾ��� �����մϴ�. 
        total_cnt := n_total_cnt;
        total_sum := n_total_sum;
            
        RETURN( v_sign_no);
        
    EXCEPTION
    
        WHEN ERR_VALUE_ERROR THEN
            fbs_util_pkg.write_log('FBS','[get_bank_sign_no] '|| v_error_msg );        
            RETURN( NULL );
    
        WHEN OTHERS THEN
            fbs_util_pkg.write_log('FBS','[get_bank_sign_no] SQL OTHER �����߻�' || sqlerrm );
            RETURN( NULL );
        
    END get_batch_sign_no;
/
