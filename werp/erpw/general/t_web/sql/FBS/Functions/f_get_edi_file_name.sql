    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : f_get_edi_file_name(FBS_UTIL_PKG)                     */
    /*  2. ����̸�  : ó���� �����̸� ����                                  */
    /*  3. �ý���    : FBS                                                   */
    /*  4. ����ý���: EFT                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : HP-UX + Oracle 9.2.0                                  */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ȸ���ڵ�/�����ڵ�/������ �Է¹޾Ƽ� ���ϸ��� ��ȯ              */
    /*      - �����ڵ�                                                       */
    /*          CS ( Cash Send ) : ���� �۽� ���ϸ�                          */
    /*          CR ( Cash Receive ) : ���� ���� ���ϸ�                       */
    /*          BS ( Bill Send ) : ���ھ��� �۽� ���ϸ�                      */
    /*          BR ( Bill Receive ) : ���ھ��� ���� ���ϸ�                   */
    /*          VR ( Vendor Receive ) : ���ھ��� �ŷ������� ���� ���ϸ�      */
    /*                                                                       */
    /*                                                                       */
    /* 10. �����ۼ���: �����                                                */
    /* 11. �����ۼ���: 2006��1��27��                                         */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/  
    Create Or Replace Function f_get_edi_file_name(  
                                 company_cd  VARCHAR2 ,      -- ȸ���ڵ�
                                 bank_cd     VARCHAR2 ,      -- �����ڵ�
                                 gubun       VARCHAR2 ,      -- ����
                                 file_date   VARCHAR2 DEFAULT NULL) RETURN VARCHAR2 IS   -- ��¥  

        v_date                       VARCHAR2(8); 
        v_file_name                  VARCHAR2(100) := ''; 
        v_file_seq                   VARCHAR2(3);
        
        USR_ERR_NOT_VALID_GUBUN_CD   EXCEPTION;   -- �����ڵ尡 CS , CR , VR �̿��� ���..
        	                            
    BEGIN
        -- ������ ��¥�� �Էµ� ���� �� ��¥�� ����ϸ�, �׷��� ������ �ý��� ��¥�� ����Ѵ�.
        IF file_date IS NOT NULL AND LENGTH(file_date) != 0 THEN
            v_date := file_date;
        ELSE
            v_date := TO_CHAR(SYSDATE,'YYYYMMDD');
        END IF;
        
        -- file�� �ʿ��� seq�� �����ɴϴ�.
        SELECT Lpad(T_FB_EDI_FILE_NAME_SEQ.nextval,3,'0')
        INTO   v_file_seq
        FROM   DUAL ;
        
        -- ȸ���ڵ�� �����ڵ�� �ۼ���/���¾�ü���� ���� ���� ����        
        IF UPPER(gubun) = 'CS' THEN
            v_file_name := company_cd ||'_'|| bank_cd ||'_'||v_date||'_'||v_file_seq||'.dat';
        ELSIF UPPER(gubun) = 'BS' THEN
            v_file_name := company_cd ||'_'|| bank_cd ||'_'||v_date||'_'||v_file_seq||'.dat';            
        ELSE
            RAISE USR_ERR_NOT_VALID_GUBUN_CD;
        END IF;

        RETURN( v_file_name );
    
    EXCEPTION
    
        WHEN USR_ERR_NOT_VALID_GUBUN_CD THEN
             fbs_util_pkg.write_log('FBS','[ERROR] ���ϸ� ������ ���ؼ� ���� �����ڵ尡 �߸��Ǿ����ϴ�.(�����ڵ�:'||gubun||')');
             RETURN('ERROR');
        WHEN OTHERS THEN
             fbs_util_pkg.write_log('FBS','[ERROR] ���ϸ� ������ ���� SUBJECT NAME�� ��ϵǾ� ���� �ʽ��ϴ�. (ȸ���ڵ�:'||company_cd||',�����ڵ�:'||bank_cd||')');
             RETURN('ERROR');             
    END ;