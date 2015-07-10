CREATE OR REPLACE PACKAGE FBS_BANK_PKG IS

    /*----------------------------------------------------------------------------*/
    /* �����ڵ�                                                                   */
    /*----------------------------------------------------------------------------*/    
    KIUP_BANK_CD                   VARCHAR2(2) := '03';   -- ������� 
    KUKMIN_BANK_CD                 VARCHAR2(2) := '04';   -- ��������     
    WOORI_BANK_CD                  VARCHAR2(2) := '20';   -- �츮����     
    HANA_BANK_CD                   VARCHAR2(2) := '81';   -- �ϳ�����        

    
    /*----------------------------------------------------------------------------*/    
    /* ��Ÿ ��� ����                                                             */
    /*----------------------------------------------------------------------------*/    
    CRLF                VARCHAR2(2)  := CHR(10)||CHR(13);          

    -- OS���� DIRECTORY PATH�� �˱����� ORACLE�� DIRECTORY NAME 
    FBS_REALTIME_SEND_DIR    VARCHAR2(100) := 'FBS_REALTIME_SEND_DIR';      -- �ǽð� ó�� �������� �۽�����  
    FBS_REALTIME_TEMP_DIR    VARCHAR2(100) := 'FBS_REALTIME_TEMP_DIR';      -- �ǽð� ó�� �������� �ӽ�����       
    
    
    /*----------------------------------------------------------------------------*/
    /*   �ǽð� �߹�ŷ ������ȣ DEFINE                                            */
    /*----------------------------------------------------------------------------*/         
    FB_DOCU_OPEN_T          VARCHAR2(7) := '0810100'; /*  ��������        (��ü=>����)  */          
    FB_DOCU_OPEN_B          VARCHAR2(7) := '0800100'; /*  ��������        (����=>��ü)  */          

    FB_DOCU_DEPO_TR_T       VARCHAR2(7) := '0210300'; /*  ���ݰŷ�������(��ü=>����)  */          
    FB_DOCU_DEPO_TR_B       VARCHAR2(7) := '0200300'; /*  ���ݰŷ�������(����=>��ü)  */          
                                                                             
    FB_DOCU_DEPO_MISS_T     VARCHAR2(7) := '0200600'; /*  ���ݰŷ����    (��ü=>����)  */          
    FB_DOCU_DEPO_MISS_B     VARCHAR2(7) := '0210600'; /*  ���ݰŷ����    (����=>��ü)  */          
                                               
    FB_DOCU_VIRT_TR_T       VARCHAR2(7) := '0210100'; /*  ������°ŷ���(��ü=>����)  */                                               
    FB_DOCU_VIRT_TR_B       VARCHAR2(7) := '0200100'; /*  ������°ŷ���(����=>��ü)  */
    
    FB_DOCU_VIRT_MISS_T     VARCHAR2(7) := '0200200'; /*  ������°����û(��ü=>����)  */
    FB_DOCU_VIRT_MISS_B     VARCHAR2(7) := '0210200'; /*  ������°����û(����=>��ü)  */
                                                                             
    FB_DOCU_DATR_T          VARCHAR2(7) := '0100100'; /*  ������ü        (��ü=>����)  */          
    FB_DOCU_DATR_B          VARCHAR2(7) := '0110100'; /*  ������ü        (����=>��ü)  */          
                                                                             
    FB_DOCU_TATR_T          VARCHAR2(7) := '0100200'; /*  Ÿ����ü        (��ü=>����)  */          
    FB_DOCU_TATR_B          VARCHAR2(7) := '0110200'; /*  Ÿ����ü        (����=>��ü)  */          
                                                                             
    FB_DOCU_TR_RE_T         VARCHAR2(7) := '0600100'; /*  ��üó�������ȸ(��ü=>����)  */          
    FB_DOCU_TR_RE_B         VARCHAR2(7) := '0610100'; /*  ��üó�������ȸ(����=>��ü)  */          
                                                                             
    FB_DOCU_REMAIN_T        VARCHAR2(7) := '0600300'; /*  �ܾ���ȸ        (��ü=>����)  */          
    FB_DOCU_REMAIN_B        VARCHAR2(7) := '0610300'; /*  �ܾ���ȸ        (����=>��ü)  */          
                                                                             
    FB_DOCU_SUM_T           VARCHAR2(7) := '0700100'; /*  ����ó��        (��ü=>����)  */          
    FB_DOCU_SUM_B           VARCHAR2(7) := '0710000'; /*  ����ó��        (����=>��ü)  */          
                                                                             
    FB_DOCU_TATR_RE_T       VARCHAR2(7) := '0410100'; /*  Ÿ����ü�������(��ü=>����)  */          
    FB_DOCU_TATR_RE_B       VARCHAR2(7) := '0400100'; /*  Ÿ����ü�������(����=>��ü)  */          

    FB_DOCU_NAME_CHECK_T    VARCHAR2(7) := '0400400'; /*  ������ ������ȸ (��ü=>����)  */          
    FB_DOCU_NAME_CHECK_B    VARCHAR2(7) := '0410400'; /*  ������ ������ȸ (����=>��ü)  */  
                                                                             
    FB_DOCU_BILL_ISSUE_T    VARCHAR2(7) := '0100310'; /*  ��������        (��ü=>����)  */
    FB_DOCU_BILL_ISSUE_B    VARCHAR2(7) := '0110310'; /*  ��������        (����=>��ü)  */
    
    FB_DOCU_VENDOR_T        VARCHAR2(7) := '0110320'; /*  �����ŷ�������  (��ü=>����)  */
    FB_DOCU_VENDOR_B        VARCHAR2(7) := '0100320'; /*  �����ŷ�������  (����=>��ü)  */
    
    FB_DOCU_BILL_TRX_T      VARCHAR2(7) := '0210400'; /*  �����ŷ���     (��ü=>����) */
    FB_DOCU_BILL_TRX_B      VARCHAR2(7) := '0200400'; /*  �����ŷ���     (����=>��ü) */
    
    FB_DOCU_BILL_MISS_T     VARCHAR2(7) := '0200500'; /*  �����������û (��ü=>����) */
    FB_DOCU_BILL_MISS_B     VARCHAR2(7) := '0210500'; /*  �����������û (����=>��ü) */
    
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : �ǽð� �߹�ŷ �۽����̺� RECORD                           */
    /*----------------------------------------------------------------------------*/               
    TYPE FB_VAN_SEND_RECORD IS RECORD (
        tran_code             VARCHAR2(9),         /* �ĺ��ڵ�                  */
        ente_code             VARCHAR2(8),         /* ��ü�ڵ�                  */
        bank_code             VARCHAR2(2),         /* �����ڵ�                  */
        docu_code             VARCHAR2(4),         /* �����ڵ�                  */
        upmu_code             VARCHAR2(3),         /* �����ڵ�                  */
        send_cont             VARCHAR2(1),         /* �۽�Ƚ��                  */
        docu_numc             VARCHAR2(6),         /* ������ȣ                  */
        send_date             VARCHAR2(8),         /* ��������                  */
        send_time             VARCHAR2(6),         /* ���۽ð�                  */
        resp_code             VARCHAR2(4),         /* �����ڵ�                  */
        gaeb_area             VARCHAR2(200),       /* ������ ����               */
        resp_yebu             VARCHAR2(1));        /* ���俩��                  */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : �ǽð� �߹�ŷ �������̺� RECORD                           */
    /*----------------------------------------------------------------------------*/               
    TYPE FB_VAN_RECV_RECORD IS RECORD (
        tran_code             VARCHAR2(9),         /* �ĺ��ڵ�                  */
        ente_code             VARCHAR2(8),         /* ��ü�ڵ�                  */
        bank_code             VARCHAR2(2),         /* �����ڵ�                  */
        docu_code             VARCHAR2(4),         /* �����ڵ�                  */
        upmu_code             VARCHAR2(3),         /* �����ڵ�                  */
        send_cont             VARCHAR2(1),         /* �۽�Ƚ��                  */
        docu_numc             VARCHAR2(6),         /* ������ȣ                  */
        send_date             VARCHAR2(8),         /* ��������                  */
        send_time             VARCHAR2(6),         /* ���۽ð�                  */
        resp_code             VARCHAR2(4),         /* �����ڵ�                  */
        gaeb_area             VARCHAR2(200),       /* ������ ����               */
        resp_yebu             VARCHAR2(1));        /* ���俩��                  */            


    /******************************************************************************/
    /*  ��� : �������� ���� �׽�Ʈ��                                             */
    /******************************************************************************/        
    FUNCTION create_document_test( p_ente_code VARCHAR2,
                                   p_bank_code VARCHAR2,
                                   p_docu_code VARCHAR2,
                                   p_upmu_code VARCHAR2,
                                   p_send_cont VARCHAR2,
                                   p_docu_numc VARCHAR2,
                                   p_send_date VARCHAR2,
                                   p_send_time VARCHAR2,
                                   p_gaeb_area VARCHAR2 )
        RETURN VARCHAR2;                                                           -- �Լ� ó����� �޽���     
                
                
END FBS_BANK_PKG;
/
CREATE OR REPLACE PACKAGE BODY FBS_BANK_PKG IS

    FUNCTION create_document_test( p_ente_code VARCHAR2,
                                   p_bank_code VARCHAR2,
                                   p_docu_code VARCHAR2,
                                   p_upmu_code VARCHAR2,
                                   p_send_cont VARCHAR2,
                                   p_docu_numc VARCHAR2,
                                   p_send_date VARCHAR2,
                                   p_send_time VARCHAR2,
                                   p_gaeb_area VARCHAR2 )
        RETURN VARCHAR2 IS                                                         -- �Լ� ó����� �޽���     
  
        rec_send  T_FB_VAN_SEND%ROWTYPE; 
        rec_recv  T_FB_VAN_RECV%ROWTYPE;
  
        v_return_msg VARCHAR2(200);
        v_result_code VARCHAR2(10);
        v_result_msg  VARCHAR2(500);
        
    BEGIN
    
        rec_send.ente_code := p_ente_code;
        rec_send.bank_code := p_bank_code;
        rec_send.docu_code := p_docu_code;
        rec_send.upmu_code := p_upmu_code;
        rec_send.send_cont := p_send_cont;
        rec_send.docu_numc := p_docu_numc;
        rec_send.send_date := p_send_date;
        rec_send.send_time := p_send_time;
        rec_send.gaeb_area := p_gaeb_area;
        rec_send.resp_yebu := 'N';
        
        v_return_msg := fbs_main_pkg.send_realtime_document( rec_send , 3 , rec_recv , v_result_code , v_result_msg );
        
        v_return_msg := v_return_msg || '---' || v_result_code || '---' || v_result_msg;
    
        RETURN( v_return_msg );
        
    END create_document_test;

  
  
END FBS_BANK_PKG;
/
