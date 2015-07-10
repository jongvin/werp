CREATE OR REPLACE PACKAGE FBS_MAIN_PKG IS

    /******************************************************************************/
    /****                                                                      ****/
    /****                                                                      ****/
    /****           LG CNS VAN�� [�������]�� Batchó���� ���� ��������        ****/
    /****                                                                      ****/    
    /****                                                                      ****/
    /******************************************************************************/

    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ���� �뷮��ü�� RECORD                                    */
    /*----------------------------------------------------------------------------*/   
    TYPE FB_KIUP_CASH_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(2) := '11',               /* �ĺ��ڵ� : 11            */
        bank_code             VARCHAR2(2) := '03',               /* �����ڵ� : 03            */
        upmu_code             VARCHAR2(2) := '82',               /* �����ڵ� : 82            */
        pay_date              VARCHAR2(6) ,                      /* ��ü ó����(YYMMDD)6�ڸ� */        
        dummy1                VARCHAR2(6) ,                      /* ����(SPACE)              */
        out_account_no        VARCHAR2(14) ,                     /* ��ݰ��¹�ȣ             */
        dummy2                VARCHAR2(1) ,                      /* ����(SPACE)              */        
        ente_code             VARCHAR2(7) ,                      /* ����ڵ�                 */
        dummy3                VARCHAR2(40));                     /* ����(SPACE)              */
        
    TYPE FB_KIUP_CASH_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(2) := '22',               /* �ĺ��ڵ� : 22            */
        bank_code             VARCHAR2(2) ,                      /* �Ա������ڵ�             */
        upmu_code             VARCHAR2(2) := '82',               /* �����ڵ� : 82            */        
        data_seq              VARCHAR2(6) ,                      /* ������ �Ϸù�ȣ          */ 
        in_account_no         VARCHAR2(14) ,                     /* �Աݰ��¹�ȣ             */
        pay_amt               VARCHAR2(10) ,                     /* ��ü��û�ݾ�             */
        ente_use_field        VARCHAR2(10) ,                     /* ��ü�������             */
        result_yebu           VARCHAR2(1) ,                      /* ó����� 1:���� 2:�Ҵ�   */        
        result_code           VARCHAR2(4),                       /* ó������ڵ�             */
        money_gubun           VARCHAR2(1),                       /* �ڱݱ���                 */
        dummy                 VARCHAR2(3) );                     /* ����(SPACE)              */
                
    TYPE FB_KIUP_CASH_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(2) := '33',               /* �ĺ��ڵ� : 33            */
        bank_code             VARCHAR2(2) ,                      /* �Ա������ڵ�             */
        upmu_code             VARCHAR2(2) := '82',               /* �����ڵ� : 82            */        
        total_request_cnt     VARCHAR2(7) ,                      /* �� �ǷڰǼ�              */
        total_request_amt     VARCHAR2(13) ,                     /* �� �Ƿڱݾ�              */
        success_cnt           VARCHAR2(7)  := '0000000',         /* ����ó���Ǽ�             */
        success_amt           VARCHAR2(13) := '0000000000000' ,  /* ����ó���ݾ�             */
        fail_cnt              VARCHAR2(7)  := '0000000',         /* �Ҵ�ó���Ǽ�             */
        fail_amt              VARCHAR2(13) := '0000000000000',   /* �Ҵ�ó���ݾ�             */
        dummy1                VARCHAR2(6),                       /* ����(SPACE)              */
        sign_no               VARCHAR2(4) ,                      /* �����ȣ                 */
        dummy2                VARCHAR2(4));                      /* ����(SPACE)              */   
    

    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ���ڿܻ����ä�Ǵ㺸���� ��  RECORD                       */
    /*----------------------------------------------------------------------------*/           
    TYPE FB_KIUP_BILL_HEAD_RECORD IS RECORD (
        h_gubun          VARCHAR2(2) := '10',              /* ���ڵ屸�� : 10           */    
        h_filename       VARCHAR2(6) ,                     /* ����1                     */
        h_filecd         VARCHAR2(4) ,                     /* ����2                     */
        h_fill11         VARCHAR2(4) ,                     /* ����3                     */
        h_procdate       VARCHAR2(8) ,                     /* ��������                  */
        h_upchecd        VARCHAR2(12) ,                    /* ��ü�ڵ�                  */
        h_bankcd         VARCHAR2(2) := '03' ,             /* �����ڵ�                  */
        h_culacc         VARCHAR2(13) ,                    /* ���� ���¹�ȣ             */
        h_fill12         VARCHAR2(13) ,                    /* ����4                     */
        h_procgb         VARCHAR2(1) := '1',               /* ó������ 1:��ü�䱸(��ü->����)  2:ó�����(����->��ü) */
        h_filler         VARCHAR2(82) ,                    /* ����5                     */
        h_filler_2       VARCHAR2(2) );                    /* ����6                     */
        
    TYPE FB_KIUP_BILL_DATA_RECORD IS RECORD (
        d_gubun          VARCHAR2(2) := '20' ,             /* ���ڵ屸�� : 20           */
        d_nor_can        VARCHAR2(2) := '00' ,             /* �ŷ����� 00:����  99:��� */
        d_docno          VARCHAR2(14) ,                    /* ä�ǹ�ȣ                  */
        d_cash_trx_yn    VARCHAR2(1) := '2' ,              /* �������� 1:���� , 2:ä��  */
        d_bil_amt        VARCHAR2(13) ,                    /* ä�Ǳݾ�                  */
        d_slco_bzno      VARCHAR2(10) ,                    /* ��ǰ��ü ����ڹ�ȣ       */
        d_fill11         VARCHAR2(12) ,                    /* ����1                     */
        d_gtext          VARCHAR2(20) ,                    /* ���޻����                */
        d_chulgail       VARCHAR2(8) ,                     /* ��ݰ�����(��������)      */
        d_aummanki       VARCHAR2(8) ,                     /* ä�Ǹ�����                */
        d_result         VARCHAR2(4) ,                     /* ó�����                  */
        d_paymentdate    VARCHAR2(8) ,                     /* ����2                     */
        d_paymentid      VARCHAR2(6) ,                     /* ����3                     */
        d_indate         VARCHAR2(8) ,                     /* ��ǰ����:���ݰ�꼭����   */
        d_pummok         VARCHAR2(20) ,                    /* ǰ��                      */
        d_fill12         VARCHAR2(9) ,                     /* ����4                     */
        d_dbrtcd         VARCHAR2(2) ,                     /* ó��RETURN CODE           */
        d_cheriy         VARCHAR2(1) ,                     /* ����ó������              */
        d_filler         VARCHAR2(2) );                    /* ����5                     */
        
    TYPE FB_KIUP_BILL_TAIL_RECORD IS RECORD (
        t_gubun          VARCHAR2(2) := '30',              /* ���ڵ屸�� : 30           */
        t_totgun         VARCHAR2(6) ,                     /* �� ���۰Ǽ�               */
        t_totamt         VARCHAR2(13) ,                    /* �� ���۱ݾ�               */
        t_norgun         VARCHAR2(6) ,                     /* ����ó���Ǽ�              */
        t_noramt         VARCHAR2(13) ,                    /* ����ó���ݾ�              */
        t_errgun         VARCHAR2(6) ,                     /* ���� ó���Ǽ�             */
        t_erramt         VARCHAR2(13) ,                    /* ���� ó���ݾ�             */
        t_fill11         VARCHAR2(91) );                   /* ����                      */
        
    
    
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ���� �ܴ�� �ŷ��� ������ RECORD                          */
    /*----------------------------------------------------------------------------*/       
    TYPE FB_KIUP_SUPPLIER_HEAD_RECORD IS RECORD (
        h_gubun          VARCHAR2(2) := '10',              /* ���ڵ屸�� : 10           */
        h_UPCHENO        VARCHAR2(8) ,                     /* ��ü��ȣ                  */
        h_bankcd         VARCHAR2(2) := '03' ,             /* �����ڵ� : 03             */
        h_gubun01        VARCHAR2(1) ,                     /* ����                      */
        h_jendate        VARCHAR2(8) ,                     /* ��������                  */
        h_jobsijak       VARCHAR2(8) ,                     /* ����                      */
        h_jobend         VARCHAR2(8) ,                     /* ����                      */
        h_saupja         VARCHAR2(10) ,                    /* CJ���� ����ڹ�ȣ         */
        h_filler         VARCHAR2(101) ,                   /* ����                      */
        h_fi0d25         VARCHAR2(2) ,                     /* ����                      */
        h_fil_48         VARCHAR2(48) ,                    /* ����                      */
        h_fil_end        VARCHAR2(2) );                    /* ����                      */
        
    TYPE FB_KIUP_SUPPLIER_DATA_RECORD IS RECORD (
        d_gubun          VARCHAR2(2) := '20',              /* ���ڵ屸�� : 20            */
        d_seqno          VARCHAR2(11) ,                    /* �Ϸù�ȣ                   */
        d_saupno         VARCHAR2(10) ,                    /* ����ڹ�ȣ                 */
        d_juminno        VARCHAR2(13) ,                    /* �ֹι�ȣ                   */
        d_sangho         VARCHAR2(30) ,                    /* ��ȣ                       */
        d_gyeoje         VARCHAR2(1) ,                     /* ����                       */
        d_newilja        VARCHAR2(8) ,                     /* �ű�����                   */
        d_cloilja        VARCHAR2(8) ,                     /* ��������                   */
        d_adjilja        VARCHAR2(12) ,                    /* ����                       */
        d_iacctno        VARCHAR2(15) ,                    /* �������¹�ȣ (���¾�ü)    */    
        d_brno           VARCHAR2(3) ,                     /* ����                       */
        d_filler         VARCHAR2(25) ,                    /* ����                       */
        d_fi0d25         VARCHAR2(2) ,                     /* ����                       */
        d_fil_48         VARCHAR2(48) ,                    /* ����                       */
        d_fil_end        VARCHAR2(2) );                    /* ����                       */
        
    TYPE FB_KIUP_SUPPLIER_TAIL_RECORD IS RECORD (
        t_gubun          VARCHAR2(2) := '30' ,             /* ���ڵ屸�� : 30            */
        t_totgun         VARCHAR2(6) ,                     /* �� ���۰Ǽ�                */
        t_newgun         VARCHAR2(6) ,                     /* �ű԰Ǽ�                   */
        t_adjgun         VARCHAR2(6) ,                     /* ����Ǽ�                   */
        t_clogun         VARCHAR2(6) ,                     /* �����Ǽ�                   */
        t_filler         VARCHAR2(122) ,                   /* ��ü�ڵ�                   */
        d_fi0d25         VARCHAR2(2) ,                     /* ����                       */
        d_fil_49         VARCHAR2(48) ,                    /* ����                       */
        d_fil_end        VARCHAR2(2) );                    /* ����                       */        
    
    
    /******************************************************************************/
    /****                                                                      ****/
    /****                                                                      ****/
    /****           LG CNS VAN�� [��������]�� Batchó���� ���� ��������        ****/
    /****                                                                      ****/    
    /****                                                                      ****/
    /******************************************************************************/
    
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ���� �뷮��ü�� RECORD                                    */
    /*----------------------------------------------------------------------------*/               
    TYPE FB_KUKMIN_CASH_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'S',                /* �ĺ��ڵ� : S             */
        transfer_gubun        VARCHAR2(2) := 'C2',               /* �ۼ��ű��� ����۽�:C2 ����:2C */
        bank_code             VARCHAR2(2) := '04',               /* �����ڵ� : 04            */
        ente_code             VARCHAR2(8) ,                      /* ����ڵ�                 */
        dummy1                VARCHAR2(6) ,                      /* ����                     */
        pay_date              VARCHAR2(6) ,                      /* ��ü ó����(YYMMDD)6�ڸ� */        
        dummy2                VARCHAR2(6) ,                      /* ����                     */
        out_account_pwd       VARCHAR2(8) ,                      /* ����� ��й�ȣ          */        
        out_account_no        VARCHAR2(14) ,                     /* ����¹�ȣ               */
        dummy3                VARCHAR2(26));                     /* ����                     */
        
    TYPE FB_KUKMIN_CASH_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'D',                /* �ĺ��ڵ� : D             */
        data_seq              VARCHAR2(5) ,                      /* ������ �Ϸù�ȣ          */ 
        bank_code             VARCHAR2(2) ,                      /* �Ա������ڵ�             */
        in_account_no         VARCHAR2(14) ,                     /* �Աݰ��¹�ȣ             */
        pay_amt               VARCHAR2(10) ,                     /* ��ü��û�ݾ�             */
        result_yn             VARCHAR2(1) ,                      /* ó����� Y Ȥ�� N        */        
        result_code           VARCHAR2(4),                       /* ó������ڵ�             */
        paid_amt              VARCHAR2(10) := '0000000000',      /* ������ü�ݾ�:�������    */
        ente_use_field        VARCHAR2(10) ,                     /* ��ü�������             */
        remark                VARCHAR2(8) ,                      /* ��������                 */
        dummy1                VARCHAR2(12) ,                     /* ����                     */
        remark_gubun          VARCHAR2(1) ,                      /* �������ڱ���:����� ���� */
        dummy2                VARCHAR2(2) );                     /* ����                     */
                
    TYPE FB_KUKMIN_CASH_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'E',                /* �ĺ��ڵ� : E             */
        total_request_cnt     VARCHAR2(7) ,                      /* �� �ǷڰǼ�              */
        total_request_amt     VARCHAR2(13) ,                     /* �� �Ƿڱݾ�              */
        success_cnt           VARCHAR2(7)  := '0000000',         /* ����ó���Ǽ�             */
        success_amt           VARCHAR2(13) := '0000000000000' ,  /* ����ó���ݾ�             */
        fail_cnt              VARCHAR2(7)  := '0000000',         /* �Ҵ�ó���Ǽ�             */
        fail_amt              VARCHAR2(13) := '0000000000000',   /* �Ҵ�ó���ݾ�             */
        sign_no               VARCHAR2(4) ,                      /* �����ȣ                 */
        dummy                 VARCHAR2(8));                      /* ����                     */    

    
    
    /******************************************************************************/
    /****                                                                      ****/
    /****                                                                      ****/
    /****           LG CNS VAN�� [�츮����]�� Batchó���� ���� ��������        ****/
    /****                                                                      ****/    
    /****                                                                      ****/
    /******************************************************************************/
    
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ���� �뷮��ü�� RECORD                                    */
    /*----------------------------------------------------------------------------*/               
    TYPE FB_WOORI_CASH_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'S',                /* �ĺ��ڵ� : S             */
        transfer_gubun        VARCHAR2(2) := 'C2',               /* �ۼ��ű��� ����۽�:C2 ����:2C */
        ente_code             VARCHAR2(10) ,                     /* ��ü�ڵ�                 */
        bank_code             VARCHAR2(2) := '20',               /* �����ڵ� : 20            */
        transfer_date         VARCHAR2(6) ,                      /* �������� YYMMDD          */
        pay_date              VARCHAR2(6) ,                      /* ��ü ó����(YYMMDD)6�ڸ� */                
        out_account_no        VARCHAR2(14) ,                     /* ����¹�ȣ               */
        out_account_pwd       VARCHAR2(8) ,                      /* ����� ��й�ȣ          */        
        return_trx            VARCHAR2(1) ,                      /* ��üȸ��                 */
        info_gubun            VARCHAR2(1) := '1',                /* �뺸���� 1:��ü 2:�Ҵ� 3:�뺸���ʿ� */
        dummy1                VARCHAR2(5) ,                      /* ��ó������,�ŷ����ڵ�    */
        van                   VARCHAR2(6) := 'LGEDS',            /* VAN�ڵ�                  */
        dummy2                VARCHAR2(17));                     /* ����                     */
                
    TYPE FB_WOORI_CASH_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'D',                /* �ĺ��ڵ� : D             */
        bank_code             VARCHAR2(2) ,                      /* �Ա������ڵ�             */
        in_account_no         VARCHAR2(15) ,                     /* �Աݰ��¹�ȣ             */
        trx_gubun             VARCHAR2(2) ,                      /* �Ա���ü 31:�޿�,32:��,40:��Ÿ , ����� ���� ���� */
        pay_amt               VARCHAR2(11) ,                     /* ��ü��û�ݾ�             */                 
        pay_date              VARCHAR2(2) ,                      /* ��ü���� - ������      */
        result_yn             VARCHAR2(1) ,                      /* ó����� Y(����) N(�Ҵ�) , Z(�Ϻ���ü) */                
        result_code           VARCHAR2(4) ,                      /* ó������ڵ�             */
        fail_amt              VARCHAR2(10) ,                     /* ��ó���ݾ�               */
        ente_use_field        VARCHAR2(24) ,                     /* ��ü��뿵��             */
        dummy                 VARCHAR2(8));                      /* ����                     */
                
    TYPE FB_WOORI_CASH_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'E',                /* �ĺ��ڵ� : E             */
        total_transfer_cnt    VARCHAR2(7) ,                      /* �� ���۰Ǽ� DATA�Ǽ�+2   */
        total_request_cnt     VARCHAR2(7) ,                      /* �� �ǷڰǼ�              */
        total_request_amt     VARCHAR2(13) ,                     /* �� �Ƿڱݾ�              */
        success_cnt           VARCHAR2(7)  := '0000000',         /* ����ó���Ǽ�             */
        success_amt           VARCHAR2(13) := '0000000000000' ,  /* ����ó���ݾ�             */
        fail_cnt              VARCHAR2(7)  := '0000000',         /* �Ҵ�ó���Ǽ�             */
        fail_amt              VARCHAR2(13) := '0000000000000',   /* �Ҵ�ó���ݾ�             */
        sign_no               VARCHAR2(6) ,                      /* �����ȣ                 */
        dummy                 VARCHAR2(6));                      /* ����                     */       
    


    /******************************************************************************/
    /****                                                                      ****/
    /****                                                                      ****/
    /****           LG CNS VAN�� [�ϳ�����]�� Batchó���� ���� ��������        ****/
    /****                                                                      ****/    
    /****                                                                      ****/
    /******************************************************************************/
    
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ���� �뷮��ü�� RECORD                                    */
    /*----------------------------------------------------------------------------*/               
    TYPE FB_HANA_CASH_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'S',                /* �ĺ��ڵ� : S             */
        upmu_gubun            VARCHAR2(2) := '10',               /* �������� : 10            */
        bank_code             VARCHAR2(2) := '81',               /* �����ڵ� : 81            */
        transfer_date         VARCHAR2(8) ,                      /* ������ ������(YYYYMMDD)  */
        pay_date              VARCHAR2(6) ,                      /* ��ü ó����(YYMMDD)6�ڸ� */
        out_account_no        VARCHAR2(14) ,                     /* ����¹�ȣ               */
        transfer_type         VARCHAR2(2),                       /* ��ü����                 */
        comp_no               VARCHAR2(6) := '000000',           /* ȸ���ȣ/��ü��'0'����   */
        result_gubun          VARCHAR2(1) := '1',                /* ó������뺸���� 1:���� 2:������ 3:����� */
        transfer_seq          VARCHAR2(1) := '1',                /* ��������                 */
        out_account_pwd       VARCHAR2(8) ,                      /* ����� ��й�ȣ          */
        dummy                 VARCHAR2(20) ,                     /* ����                     */
        format                VARCHAR2(1) := '1',                /* ����                     */
        van                   VARCHAR2(2) := 'LG');              /* VAN�� : LG               */
        
    TYPE FB_HANA_CASH_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'D',                /* �ĺ��ڵ� : D             */
        data_seq              VARCHAR2(7) ,                      /* ������ �Ϸù�ȣ          */ 
        bank_code             VARCHAR2(2) ,                      /* �Ա������ڵ�             */
        in_account_no         VARCHAR2(14) ,                     /* �Աݰ��¹�ȣ             */
        pay_amt               VARCHAR2(11) ,                     /* ��ü��û�ݾ�             */
        paid_amt              VARCHAR2(11) := '00000000000',     /* ������ü�ݾ�:������� */
        biz_ss_no             VARCHAR2(13) ,                     /* �ֹ�/����ڹ�ȣ          */
        result_yn             VARCHAR2(1) ,                      /* ó����� Y Ȥ�� N        */
        result_code           VARCHAR2(4) ,                      /* �Ҵ��ڵ�                 */
        remark                VARCHAR2(12) ,                     /* ������峻��:���ǻ���    */
        dummy                 VARCHAR2(4));                      /* ����                     */
        
    TYPE FB_HANA_CASH_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'E',                /* �ĺ��ڵ� : E             */
        total_request_cnt     VARCHAR2(7) ,                      /* �� �ǷڰǼ�              */
        total_request_amt     VARCHAR2(13) ,                     /* �� �Ƿڱݾ�              */
        success_cnt           VARCHAR2(7)  := '0000000',         /* ����ó���Ǽ�             */
        success_amt           VARCHAR2(13) := '0000000000000' ,  /* ����ó���ݾ�             */
        fail_cnt              VARCHAR2(7)  := '0000000',         /* �Ҵ�ó���Ǽ�             */
        fail_amt              VARCHAR2(13) := '0000000000000',   /* �Ҵ�ó���ݾ�             */
        sign_no               VARCHAR2(8) ,                      /* �����ȣ                 */
        dummy                 VARCHAR2(11));                     /* ����                     */
    

    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ����ī��� RECORD                                         */
    /*----------------------------------------------------------------------------*/      
    
    TYPE FB_HANA_BILL_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'S',                /* ���� : S                        */
        upmu_gubun            VARCHAR2(4) := 'R351',             /* �������� : ����ī�� ���ο�û    */
        bill_ente_code        VARCHAR2(4) ,                      /* �ϳ������� �ο��� ��ü�����ڵ�  */
        service_gubun         VARCHAR2(1) := '1',                /* ���񽺱��� 1:����  2:������     */
        approval_req_date     VARCHAR2(8) ,                      /* ���ο�û����                    */
        transfer_seq          VARCHAR2(1) := '1',                /* ��������                        */
        branch_no             VARCHAR2(3) := '001',              /* ����� ��ȣ                     */
        transfer_time         VARCHAR2(6) ,                      /* ���۽ð� HHMMSS                 */
        test_gubun            VARCHAR2(1) := 'R',                /* R : REAL                        */
        biz_no                VARCHAR2(13) ,                     /* ����ڹ�ȣ : "999"+����ڹ�ȣ   */
        dummy                 VARCHAR2(158) );                   /* ����                            */
        
    TYPE FB_HANA_BILL_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'D',                /* ���� : D                        */
        trade_seq             VARCHAR2(5) ,                      /* �ŷ���ȣ:���ں� Sequence No     */
        transfer_date         VARCHAR2(8) ,                      /* �ŷ����� : ��������             */
        card_no               VARCHAR2(16) ,                     /* ī���ȣ                        */
        member_no             VARCHAR2(11) ,                     /* ������ ��ȣ                     */
        approval_amt          VARCHAR2(11) ,                     /* ���αݾ�                        */
        installment_period    VARCHAR2(3) ,                      /* �ҺαⰣ                        */
        unredeemed_fee_gubun  VARCHAR2(1) := '1' ,               /* ��ġ������ �δ� 1:ī�� 2:������ */
        unredeemed_period     VARCHAR2(3) ,                      /* ����Աݰ�ġ�Ⱓ                */
        installment_fee_gubun VARCHAR2(1) := '1' ,               /* ���Ҽ����� �δ� 1:ī�� 2:������ */
        due_pay_date          VARCHAR2(8) ,                      /* �������� : ���� ������          */
        remark                VARCHAR2(12) ,                     /* ���, ��ü�� ���� ���          */
        approval_no           VARCHAR2(10) ,                     /* ���ι�ȣ                        */
        result_code           VARCHAR2(4) ,                      /* �����ڵ�                        */
        member_fee            VARCHAR2(9) ,                      /* ������ �δ� ������              */
        member_total_amt      VARCHAR2(11) ,                     /* ������ �Ա� �Ѿ�                */
        bill_discount_date    VARCHAR2(8) ,                      /* �����Աݽ������� : ���ΰ�����   */
        bill_date             VARCHAR2(8) ,                      /* ���ݰ�꼭 ����                 */
        description           VARCHAR2(15) ,                     /* ����                            */
        dummy                 VARCHAR2(44));                     /* ����                            */
        
    TYPE FB_HANA_BILL_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'E',                /* ���� : E                        */
        record_cnt            VARCHAR2(5) ,                      /* ���ڵ� ���� :HEAD & TAIL ����   */
        approval_req_cnt      VARCHAR2(5) ,                      /* ���ο�û�ڷ� ����               */        
        approval_req_amt      VARCHAR2(15) ,                     /* ���ο�û�ݾ�                    */
        success_cnt           VARCHAR2(5) ,                      /* ������ΰǼ�                    */
        success_amt           VARCHAR2(15) ,                     /* ������αݾ�                    */
        member_total_fee      VARCHAR2(15) ,                     /* ������ �δ� �� ������           */
        member_total_amt      VARCHAR2(15) ,                     /* ������ �Ա� �Ѿ�                */
        fail_cnt              VARCHAR2(5) ,                      /* ���ο����Ǽ�                    */
        fail_amt              VARCHAR2(15) ,                     /* ���ο����ݾ�                    */
        sign_no               VARCHAR2(11) ,                     /* �����ȣ                        */
        dummy                 VARCHAR2(93));                     /* ����                            */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ����ī�� �ŷ��� ������ RECORD                             */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_HANA_SUPPLIER_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'S',                /* ���� : S                        */
        seq                   VARCHAR2(5) ,                      /* �Ϸù�ȣ                        */
        bill_ente_code        VARCHAR2(4) ,                      /* ��ü�ڵ�                        */
        upmu_gubun            VARCHAR2(4) := 'R390',             /* �������� : ����ī��/����������  */
        service_gubun         VARCHAR2(1) ,                      /* ���񽺱��� 1:���� 2:������      */
        trade_date            VARCHAR2(8) ,                      /* �ŷ�����                        */
        transfer_seq          VARCHAR2(1) ,                      /* ��������                        */
        branch_no             VARCHAR2(3) ,                      /* ����� ��ȣ                     */
        dummy                 VARCHAR2(473));                    /* ����                            */
        
    TYPE FB_HANA_SUPPLIER_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'D' ,               /* ���� : D                        */
        seq                   VARCHAR2(5) ,                      /* ���ں� Sequence No              */
        bill_ente_code        VARCHAR2(4) ,                      /* �ϳ������� �ο��� ��ü�ڵ�      */
        ente_name             VARCHAR2(32),                      /* �ϳ������� �ο��� ��ü��        */
        service_gubun         VARCHAR2(1) ,                      /* ���񽺱��� 1:���� , 2:������    */
        memeber_gubun         VARCHAR2(1) ,                      /* ȸ������  1:ī�� , 2:������     */
        card_member_no        VARCHAR2(16) ,                     /* ī��/������ ��ȣ                */
        memeber_kor_name      VARCHAR2(32) ,                     /* ȸ���ѱ۸�                      */
        info_gubun            VARCHAR2(1) ,                      /* �̵����� 0:����  9:����         */
        new_issue_date        VARCHAR2(8) ,                      /* �ű�����                        */
        cancel_date           VARCHAR2(8) ,                      /* ����/�������                   */
        member_tel_no         VARCHAR2(19) ,                     /* ȸ�� ��ȭ��ȣ                   */
        home_zip_code         VARCHAR2(6) ,                      /* ����/������ �����ȣ            */
        home_addr1            VARCHAR2(42) ,                     /* ����/������ �ּ�1               */
        home_sub_addr         VARCHAR2(82) ,                     /* ����/������ �μ� �ּ�           */
        home_tel_1            VARCHAR2(19) ,                     /* ����/������ ��ȭ��ȣ 1          */
        home_tel_2            VARCHAR2(14) ,                     /* ����/������ ��ȭ��ȣ 2          */
        home_mng_division     VARCHAR2(22) ,                     /* ����/������ �����μ�            */
        comp_zip_code         VARCHAR2(6) ,                      /* ȸ��/������ �����ȣ            */
        comp_addr1            VARCHAR2(42) ,                     /* ȸ��/������ �ּ�1               */
        comp_sub_addr         VARCHAR2(82) ,                     /* ȸ��/������ �μ� �ּ�           */
        comp_tel_no           VARCHAR2(19) ,                     /* ȸ�� ��ȭ��ȣ                   */
        biz_ss_no             VARCHAR2(13) ,                     /* �ֹ�(�����) ��ȣ               */
        mng_no                VARCHAR2(12) ,                     /* ������ȣ                        */
        bank_code             VARCHAR2(2) ,                      /* �����ڵ� : 81                   */
        dummy                 VARCHAR2(11));                     /* ����                            */
        
    TYPE FB_HANA_SUPPLIER_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'E' ,               /* ���� : E                        */
        seq                   VARCHAR2(5) ,                      /* �Ϸù�ȣ : 99999                */
        bill_ente_code        VARCHAR2(4) ,                      /* ��ü ���� �ڵ�                  */
        record_cnt            VARCHAR2(5) ,                      /* ���ڵ尹��, DATA RECORD �� ���� */
        memeber_person_cnt    VARCHAR2(5) ,                      /* ī��ȸ������ �Ǽ�               */
        memeber_biz_cnt       VARCHAR2(5) ,                      /* ������ ȸ������ �Ǽ�            */
        dummy                 VARCHAR2(475));                    /* ����                            */    
         
    


    /******************************************************************************/
    /****                                                                      ****/    
    /****                                                                      ****/
    /****       LG CNS VAN�� [ REALTIME �ۼ��� ] ������ ���� ����              ****/
    /****                                                                      ****/
    /****                                                                      ****/        
    /******************************************************************************/

    
    
    /*----------------------------------------------------------------------------*/
    /* �����ڵ�                                                                   */
    /*----------------------------------------------------------------------------*/    
    KIUP_BANK_CD                   VARCHAR2(2) := '03';   -- ������� 
    KUKMIN_BANK_CD                 VARCHAR2(2) := '04';   -- ��������     
    WOORI_BANK_CD                  VARCHAR2(2) := '20';   -- �츮����     
    HANA_BANK_CD                   VARCHAR2(2) := '81';   -- �ϳ�����        

    /*----------------------------------------------------------------------------*/    
    /* ��ü��, ���ھ��� realtimeó���� �ִ� ���ð� ���� (����:��)               */
    /*----------------------------------------------------------------------------*/    
    DEFAULT_TIMEOUT NUMBER(10)   := 60;        
    
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
      
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ���ݰŷ�������(0200300) ������ ����                     */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_DEPO_TR_RECORD IS RECORD (
        account_no             VARCHAR2(15),     /* �Աݰ��¹�ȣ               */
        trade_gb               VARCHAR2(2),      /* �ŷ�����                   */
        bank_cd                VARCHAR2(2),      /* �ŷ����������ڵ�           */
        trade_amt              VARCHAR2(13),     /* �ŷ��ݾ�                   */
        remain_amt             VARCHAR2(13),     /* �ŷ� ��, �ܾ�              */
        giro_cd                VARCHAR2(6),      /* �����ڵ�                   */
        depo_nm                VARCHAR2(16),     /* �Ա��� ����                */
        check_no               VARCHAR2(10),     /* ���� �� ��ǥ��ȣ           */
        cms                    VARCHAR2(16),     /* CMS�ڵ�(�ŷ�ó�ڵ�)        */
        trade_dt               VARCHAR2(8),      /* �ŷ�����                   */
        trade_time             VARCHAR2(6),      /* �ŷ��ð�                   */
        cash_amt               VARCHAR2(13),     /* ����                       */
        check_amt              VARCHAR2(13),     /* �����ǥ                   */
        ta_check_amt           VARCHAR2(13),     /* ��ȯ��, ���Ⱑ�ɱݾ�       */
        trade_no               VARCHAR2(6),      /* �ŷ��� �Ϸù�ȣ �߰�       */
        cancel_trade_no        VARCHAR2(6),      /* ��ҽ� �ηù�ȣ �߰�       */
        cancel_trade_dt        VARCHAR2(8),      /* ��ҽ� �ŷ����� �߰�       */
        remain_sign            VARCHAR2(1),      /* �����(�ܾ׺�ȣ)           */     
        loan_yn                VARCHAR2(1),      /* �����(���ܴ��⿩��)(����) */  
        dong_ho                VARCHAR2(8),      /* ����(��ȣ)                 */         
        dummy                  VARCHAR2(24));    /* DUMMY SPACE 24��           */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ���ݰŷ�������䱸����(0200600) ������ ����             */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_DEPO_MISS_RECORD IS RECORD (        
        account_no             VARCHAR2(15),     /* �Աݰ��¹�ȣ               */
        trade_gb               VARCHAR2(2),      /* �ŷ�����                   */
        bank_cd                VARCHAR2(2),      /* �ŷ����������ڵ�           */
        trade_amt              VARCHAR2(13),     /* �ŷ��ݾ�                   */
        remain_amt             VARCHAR2(13),     /* �ŷ� ��, �ܾ�              */
        giro_cd                VARCHAR2(6),      /* �����ڵ�                   */
        depo_nm                VARCHAR2(16),     /* �Ա��� ����                */
        check_no               VARCHAR2(10),     /* ���� �� ��ǥ��ȣ           */
        cms                    VARCHAR2(16),     /* CMS�ڵ�(�ŷ�ó�ڵ�)        */
        trade_dt               VARCHAR2(8),      /* �ŷ�����                   */
        trade_time             VARCHAR2(6),      /* �ŷ��ð�                   */
        cash_amt               VARCHAR2(13),     /* ����                       */
        check_amt              VARCHAR2(13),     /* �����ǥ                   */
        ta_check_amt           VARCHAR2(13),     /* ��ȯ��, ���Ⱑ�ɱݾ�       */
        org_docu_numc          VARCHAR2(6),      /* ���ŷ�������ȣ �߰�        */
        trade_no               VARCHAR2(6),      /* �ŷ��� �Ϸù�ȣ �߰�       */
        cancel_trade_no        VARCHAR2(6),      /* ��ҽ� �ηù�ȣ �߰�       */
        cancel_trade_dt        VARCHAR2(8),      /* ��ҽ� �ŷ����� �߰�       */
        remain_sign            VARCHAR2(1),      /* �����(�ܾ׺�ȣ)           */  
        loan_yn                VARCHAR2(1),      /* �����(���ܴ��⿩��)       */    
        dong_ho                VARCHAR2(8),      /* ����(��ȣ)                 */                          
        dummy                  VARCHAR2(18));    /* DUMMY SPACE 18��           */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ������ü(0100100) / Ÿ����ü(0100200) ������ ����         */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_TR_RECORD IS RECORD (  
        out_account_no         VARCHAR2(15),     /* ���ް���                   */
        account_pw             VARCHAR2(8),      /* ������(4)+��ü���(4)    */
        sign_no                VARCHAR2(6),      /* �����ȣ                   */
        trade_amt              VARCHAR2(13),     /* ��ݱݾ�                   */
        remain_sign            VARCHAR2(1),      /* ��� ��, �ܾ׺�ȣ          */
        remain_amt             VARCHAR2(13),     /* ���� �ܾ�                  */
        in_bank_cd             VARCHAR2(2),      /* �Ա������ڵ�               */
        in_account_no          VARCHAR2(15),     /* �Աݰ���                   */
        commission             VARCHAR2(13),     /* ��ü������                 */
        cms                    VARCHAR2(16),     /* CMS�ڵ�(�ŷ�ó�ڵ�)        */
        depo_nm                VARCHAR2(22),     /* �Ա��� ����(������)      */
        remark                 VARCHAR2(14),     /* �Ա��� ��������(���)      */
        dummy                  VARCHAR2(72));    /* DUMMY SPACE 72��           */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ��üó�������ȸ(0600100,0600200) ������ ����             */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_TR_RE_RECORD IS RECORD (     
        docu_numc              VARCHAR2(6),      /* ������ȣ                   */
        out_account_no         VARCHAR2(15),     /* ���ް��¹�ȣ               */
        in_account_no          VARCHAR2(15),     /* �Աݰ��¹�ȣ               */
        trade_amt              VARCHAR2(13),     /* �ݾ�                       */
        commission             VARCHAR2(13),     /* ������                     */
        sub_seq_no             VARCHAR2(4),      /* SUB SEQ NO                 */
        trade_date             VARCHAR2(8),      /* ��ü����                   */
        trade_time             VARCHAR2(6),      /* ��ü�ð�                   */
        result_cd              VARCHAR2(4),      /* ó�����                   */
        in_bank_cd             VARCHAR2(2),      /* �Ա������ڵ�               */
        dummy                  VARCHAR2(111));   /* DUMMY SPOACE 111��         */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : �ܾ���ȸ(0600300) ������ ����                             */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_REMAIN_RECORD IS RECORD (                     
        account_no             VARCHAR2(15),     /* ���¹�ȣ                   */
        remain_sign            VARCHAR2(1),      /* ��ȣ                       */
        remain_amt             VARCHAR2(13),     /* �����ܾ�                   */
        out_enable_amt         VARCHAR2(13),     /* ���ް��ɱݾ�               */
        account_pw             VARCHAR2(4),      /* ��й�ȣ                   */
        dummy                  VARCHAR2(154));   /* DUMMY SPACE 154��          */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ����ó��(0700100) ������ ����                             */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_SUM_RECORD IS RECORD (          
        da_account_no          VARCHAR2(15),     /* ���� ��ݰ��¹�ȣ          */
        da_req_cnt             VARCHAR2(5),      /* ���� �Ƿ� �� �Ǽ�          */
        da_req_amt             VARCHAR2(13),     /* ���� �Ƿ� �� �ݾ�          */
        da_normal_cnt          VARCHAR2(5),      /* ���� ���� �Ǽ�             */
        da_normal_amt          VARCHAR2(13),     /* ���� ���� �ݾ�             */
        da_fail_cnt            VARCHAR2(5),      /* ���� �Ҵ� �Ǽ�             */
        da_fail_amt            VARCHAR2(13),     /* ���� �Ҵ� �ݾ�             */
        da_commission          VARCHAR2(9),      /* ���� ������                */
        ta_req_cnt             VARCHAR2(5),      /* Ÿ�� �Ƿ� �� �Ǽ�          */
        ta_req_amt             VARCHAR2(13),     /* Ÿ�� �Ƿ� �� �ݾ�          */
        ta_normal_cnt          VARCHAR2(5),      /* Ÿ�� ���� �Ǽ�             */
        ta_normal_amt          VARCHAR2(13),     /* Ÿ�� ���� �ݾ�             */
        ta_fail_cnt            VARCHAR2(5),      /* Ÿ�� �Ҵ� �Ǽ�             */
        ta_fail_amt            VARCHAR2(13),     /* Ÿ�� �Ҵ� �ݾ�             */
        ta_commission          VARCHAR2(9),      /* Ÿ�� ������                */
        dummy                  VARCHAR2(59));    /* DUMMY SPACE 59��           */           
         
         
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : �������(0200100) / ������°��(2000200) ������ ����     */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_VIRTUAL_RECORD IS RECORD (          
        account_no             VARCHAR2(15),     /* �Աݰ��¹�ȣ               */
        trade_gb               VARCHAR2(2),      /* �ŷ�����                   */
        bank_cd                VARCHAR2(2),      /* �ŷ����������ڵ�           */
        trade_amt              VARCHAR2(13),     /* �ŷ��ݾ�                   */
        remain_amt             VARCHAR2(13),     /* �ŷ� ��, �ܾ�              */
        giro_cd                VARCHAR2(6),      /* �����ڵ�                   */
        depo_nm                VARCHAR2(16),     /* �Ա��� ����                */
        check_no               VARCHAR2(10),     /* ���� �� ��ǥ��ȣ           */
        cms                    VARCHAR2(16),     /* CMS�ڵ�(�ŷ�ó�ڵ�)        */
        trade_dt               VARCHAR2(8),      /* �ŷ�����                   */
        trade_time             VARCHAR2(6),      /* �ŷ��ð�                   */
        cash_amt               VARCHAR2(13),     /* ����                       */
        check_amt              VARCHAR2(13),     /* �����ǥ                   */
        ta_check_amt           VARCHAR2(13),     /* Ÿ����                     */
        trade_no               VARCHAR2(6),      /* �ŷ��� �Ϸù�ȣ �߰�       */
        cancel_trade_no        VARCHAR2(6),      /* ��ҽ� �ηù�ȣ �߰�       */
        cancel_trade_dt        VARCHAR2(8),      /* ��ҽ� �ŷ����� �߰�       */
        remain_sign            VARCHAR2(1),      /* �ܾ׺�ȣ                   */
        jumin_no               VARCHAR2(13),     /* �ֹι�ȣ                   */
        loan_yn                VARCHAR2(1),      /* �����(���ܴ��⿩��)       */        
        dummy                  VARCHAR2(19));    /* DUMMY SPACE 19��           */      
         
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : �����μ�����ȸ(0400400/0410400) ������ ����               */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_NAME_CHECK_RECORD IS RECORD (                     
        bank_code              VARCHAR2(2),      /* �����ڵ�                   */
        account_num            VARCHAR2(15),     /* ���¹�ȣ                   */
        ssn                    VARCHAR2(14),     /* �ֹι�ȣ                   */
        account_name           VARCHAR2(14),     /* �����ָ�                   */
        dummy                  VARCHAR2(155));   /* DUMMY SPACE 155��          */         

    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : �����ŷ���(0200400/0210400) ������ ����                 */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_BILL_TRX_RECORD IS RECORD (
        trade_gb               VARCHAR2(2),      /* �ŷ�����                   */
        account_no             VARCHAR2(15),     /* ���¹�ȣ                   */
        trade_dt               VARCHAR2(8),      /* �ŷ�����                   */
        trade_time             VARCHAR2(6),      /* �ŷ��ð�                   */
        bill_no                VARCHAR2(10),     /* ������ȣ                   */
        trade_amt              VARCHAR2(13),     /* �ݾ�                       */
        issue_name             VARCHAR2(14),     /* ������                     */
        pay_due_dt             VARCHAR2(8),      /* ������                     */
        pay_bank_cd            VARCHAR2(16),     /* ����� ��������            */
        cms                    VARCHAR2(16),     /* CMS�ڵ�                    */
        item_change_cd         VARCHAR2(3),      /* �׸񺯰��ڵ�               */
        remain_amt             VARCHAR2(13),     /* �ܾ�                       */
        giro_cd                VARCHAR2(6),      /* �����ڵ�                   */
        org_docu_numc          VARCHAR2(6),      /* ���ŷ�������ȣ             */
        trade_no               VARCHAR2(6),      /* �ŷ��Ϸù�ȣ               */
        cancel_trade_no        VARCHAR2(6),      /* ��ҽ� �ηù�ȣ �߰�       */
        cancel_trade_dt        VARCHAR2(8),      /* ��ҽ� �ŷ����� �߰�       */
        dummy                  VARCHAR2(44));    /* DUMMY SPACE 44��           */        
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : �����ŷ�������䱸(0200500/0210500) ������ ����         */
    /*----------------------------------------------------------------------------*/           
    TYPE FB_BILL_MISS_RECORD IS RECORD (
        trade_gb               VARCHAR2(2),      /* �ŷ�����                   */
        account_no             VARCHAR2(15),     /* ���¹�ȣ                   */
        trade_dt               VARCHAR2(8),      /* �ŷ�����                   */
        trade_time             VARCHAR2(6),      /* �ŷ��ð�                   */
        bill_no                VARCHAR2(10),     /* ������ȣ                   */
        trade_amt              VARCHAR2(13),     /* �ݾ�                       */
        issue_name             VARCHAR2(14),     /* ������                     */
        future_pay_due_dt      VARCHAR2(8),      /* ������                     */
        future_pay_bank_cd     VARCHAR2(16),     /* ����� ��������            */
        cms                    VARCHAR2(16),     /* CMS�ڵ�                    */
        item_change_cd         VARCHAR2(3),      /* �׸񺯰��ڵ�               */
        remain_amt             VARCHAR2(13),     /* �ܾ�                       */
        giro_cd                VARCHAR2(6),      /* �����ڵ�                   */
        org_docu_numc          VARCHAR2(6),      /* ���ŷ�������ȣ             */
        trade_no               VARCHAR2(6),      /* �ŷ��Ϸù�ȣ               */
        cancel_trade_no        VARCHAR2(6),      /* ��ҽ� �ηù�ȣ �߰�       */
        cancel_trade_dt        VARCHAR2(8),      /* ��ҽ� �ŷ����� �߰�       */
        dummy                  VARCHAR2(44));    /* DUMMY SPACE 44��           */               
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : ���������ڷ�(0100310/0110310) ������ ����                 */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_BILL_ISSUE_RECORD IS RECORD (
        transfer_dt            VARCHAR2(8),      /* ��������                   */            
        transfer_gb            VARCHAR2(2),      /* ���۱���                   */                 
        pay_confirm_gb         VARCHAR2(1),      /* ��������                   */
        biz_no                 VARCHAR2(10),     /* ����ڹ�ȣ                 */
        docu_no                VARCHAR2(14),     /* ������ȣ                   */
        trade_gb               VARCHAR2(2),      /* �ŷ�����                   */                         
        future_pay_due_dt      VARCHAR2(8),      /* ��������                   */
        bank_cd                VARCHAR2(2),      /* �����ڵ�                   */
        account_no             VARCHAR2(15),     /* ���¹�ȣ                   */
        pay_amt                VARCHAR2(13),     /* ó���ݾ�                   */
        bank_client_no         VARCHAR2(10),     /* �������ȣ               */
        vendor_name            VARCHAR2(20),     /* ��������                   */
        result_gb              VARCHAR2(2),      /* �������                   */
        company_etc            VARCHAR2(20),     /* ȸ����������               */
        dummy                  VARCHAR2(72));    /* DUMMY SPACE 72��           */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : �ŷ�ó����(0100320/0110320) ������ ����                   */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_VENDOR_RECORD IS RECORD (
        transfer_dt            VARCHAR2(8),      /* ��������                   */            
        transfer_gb            VARCHAR2(2),      /* ���۱���                   */              
        bank_client_no         VARCHAR2(10),     /* �������ȣ               */
        gb                     VARCHAR2(2),      /* ����                       */
        current_biz_no         VARCHAR2(10),     /* �� ����� ��ȣ             */
        previous_biz_no        VARCHAR2(10),     /* �� ����� ��ȣ             */
        president_name         VARCHAR2(10),     /* ��ǥ�ڸ�                   */
        biz_name               VARCHAR2(40),     /* ���θ�                     */
        address                VARCHAR2(59),     /* �ּ�                       */
        dummy                  VARCHAR2(50));    /* DUMMY SPACE 50��           */
        
        
        
        
        
    /******************************************************************************/
    /*  ��� : ���Ͼ�ħ �������ð��� ��ϵ� ���ະ�� ���������� �۽��մϴ�.       */
    /******************************************************************************/
    FUNCTION send_start_document( p_comp_code     IN VARCHAR2 ,       -- ����� �ڵ�
                                  p_bank_code     IN VARCHAR2 ,       -- �����ڵ�
                                  p_resp_code     OUT VARCHAR2,       -- �����ڵ�
                                  p_resp_msg      OUT VARCHAR2 )      -- �����ڵ��                                   
        RETURN VARCHAR2;                                              -- �Լ� ó����� �޽���         
        
        
    /******************************************************************************/
    /*  ��� : ���Ͼ�ħ �������ð��� FBS�ý��ۿ� ���� �������˸����� �߼�         */
    /******************************************************************************/        
    FUNCTION send_fbs_status_mail( p_recv_list  IN VARCHAR2 DEFAULT NULL )   -- �߰����� ���ϼ����� 
        RETURN VARCHAR2;                                                     -- �Լ� ó����� �޽���            
        

    /******************************************************************************/
    /*  ��� : ��üó�������û ó�����                                          */
    /******************************************************************************/ 
    PROCEDURE retieve_pay_summation( p_bank_code       IN VARCHAR2 ,       -- �����ڵ�
                                     p_acct_number     IN VARCHAR2 ,       -- ���¹�ȣ 
                                     p_da_req_cnt      OUT NUMBER ,        -- ���� ��û �Ǽ� 
                                     p_da_req_amt      OUT NUMBER ,        -- ���� ��û �ݾ� 
                                     p_da_success_cnt  OUT NUMBER ,        -- ���� ����ó�� �Ǽ� 
                                     p_da_success_amt  OUT NUMBER ,        -- ���� ����ó�� �ݾ� 
                                     p_da_commission   OUT NUMBER ,        -- ���� ������ 
                                     p_ta_req_cnt      OUT NUMBER ,        -- Ÿ�� ��û �Ǽ� 
                                     p_ta_req_amt      OUT NUMBER ,        -- Ÿ�� ��û �ݾ� 
                                     p_ta_success_cnt  OUT NUMBER ,        -- Ÿ�� ����ó�� �Ǽ� 
                                     p_ta_success_amt  OUT NUMBER ,        -- Ÿ�� ����ó�� �ݾ� 
                                     p_ta_commission   OUT NUMBER ,        -- Ÿ�� ������ 
                                     p_resp_code       OUT VARCHAR2,       -- �����ڵ�
                                     p_resp_msg        OUT VARCHAR2 ) ;    -- �����ڵ��         
                                     
                                     
    /******************************************************************************/
    /*  ��� : 1�� ���¿� ���� �ܾ���ȸ                                           */
    /******************************************************************************/
    FUNCTION retieve_acct_remains( p_bank_code     IN VARCHAR2 ,       -- �����ڵ�
                                   p_acct_number   IN VARCHAR2 ,       -- ���¹�ȣ 
                                   p_remain_amt    OUT NUMBER  ,       -- �����ܾ� 
                                   p_enable_amt    OUT NUMBER  ,       -- ��ݰ��ɾ� 
                                   p_resp_code     OUT VARCHAR2,       -- �����ڵ�
                                   p_resp_msg      OUT VARCHAR2 )      -- �����ڵ�� 
        RETURN VARCHAR2;                                               -- �Լ� ó����� �޽���         
        
        
    /******************************************************************************/
    /*  ��� : ������ü ����� ȹ�� �� ���ó�� ����                              */
    /******************************************************************************/        
    FUNCTION cash_pay_window_check( p_pay_seq     IN NUMBER ,          -- �����Ϸù�ȣ   
                                    p_job_gubun   IN VARCHAR2 ,        -- ó������ [ CHECK:Ȯ�� , CANCEL:Ȯ����� ]   
                                    p_emp_no      IN VARCHAR2 )        -- ���   
        RETURN VARCHAR2;                                               -- �Լ� ó����� �޽���   
        
        
    /******************************************************************************/
    /*  ��� : ������ü���� ����                                                  */
    /******************************************************************************/        
    FUNCTION create_cash_edi_file( p_comp_code         IN VARCHAR2 ,        -- ������ڵ�  
                                   p_bank_code         IN VARCHAR2 ,        -- �����ڵ� 
                                   p_row_cnt           IN NUMBER ,          -- ó���� ���� ���� (üũ��) 
                                   p_emp_no            IN VARCHAR2 ,        -- ���   
                                   p_edi_history_seq   OUT NUMBER )         -- EDI����_�ۼ���HISTORY�Ϸù�ȣ (������ ���, NULL)    
        RETURN VARCHAR2;                                                    -- �Լ� ó����� �޽���           
        

    /******************************************************************************/
    /*  ��� : ���ھ������� ����                                                  */
    /******************************************************************************/        
    FUNCTION create_bill_edi_file(  p_comp_code         IN VARCHAR2 ,        -- ������ڵ�  
                                    p_bank_code         IN VARCHAR2 ,        -- �����ڵ� 
                                    p_row_cnt           IN NUMBER ,          -- ó���� ���� ���� (üũ��) 
                                    p_emp_no            IN VARCHAR2 ,        -- ���   
                                    p_edi_history_seq   OUT NUMBER )         -- EDI����_�ۼ���HISTORY�Ϸù�ȣ (������ ���, NULL)    
        RETURN VARCHAR2;                                                     -- �Լ� ó����� �޽���              
        

    /******************************************************************************/
    /*  ��� : ���ҰǺ� ������ü ����                                             */
    /******************************************************************************/        
    FUNCTION send_cash_each_transfer( p_pay_seq         IN NUMBER ,        -- �����Ϸù�ȣ
                                      p_div_seq         IN NUMBER ,        -- �����Ϸù�ȣ  
                                      p_emp_no          IN VARCHAR2 ,      -- ���   
                                      p_resp_code       OUT VARCHAR2,      -- �����ڵ�
                                      p_resp_msg        OUT VARCHAR2 )     -- �����ڵ��  
        RETURN VARCHAR2;                                                   -- �Լ� ó����� �޽���             
        
        
    /******************************************************************************/
    /*  ��� : ���ްǺ� ������ü ����                                             */
    /******************************************************************************/        
    FUNCTION send_cash_transfer( p_pay_seq         IN NUMBER ,        -- �����Ϸù�ȣ
                                 p_emp_no          IN VARCHAR2 )      -- ���   
        RETURN VARCHAR2;                                              -- �Լ� ó����� �޽���               
        
        
    /******************************************************************************/
    /*  ��� : ���ްǺ� ���ھ��� realtime �۽�                                    */
    /******************************************************************************/        
    FUNCTION send_bill_transfer( p_pay_seq         IN NUMBER ,        -- �����Ϸù�ȣ
                                 p_emp_no          IN VARCHAR2 )      -- ���   
        RETURN VARCHAR2;                                              -- �Լ� ó����� �޽���             
        
    /******************************************************************************/
    /*  ��� : �����ָ� ��ȸ                                                      */
    /******************************************************************************/
    FUNCTION retieve_acct_holder_name( p_bank_code     IN VARCHAR2 ,       -- �����ڵ�
                                       p_acct_number   IN VARCHAR2 ,       -- ���¹�ȣ 
                                       p_holder_name   OUT VARCHAR2 ,      -- �����ָ� 
                                       p_resp_code     OUT VARCHAR2,       -- �����ڵ�
                                       p_resp_msg      OUT VARCHAR2 )      -- �����ڵ�� 
        RETURN VARCHAR2;                                                   -- �Լ� ó����� �޽���           
        
        
    /******************************************************************************/
    /*  ��� : ���ھ��� �ŷ������� ���� ó��                                      */
    /******************************************************************************/        
    FUNCTION read_bill_vendor_info( p_edi_history_seq  IN NUMBER )            -- EDI�ۼ����̷� �Ϸù�ȣ 
        RETURN VARCHAR2;                                                      -- �Լ� ó����� �޽���     

                
    /******************************************************************************/
    /*  ��� : ���ھ��� ó����� ���� ó��                                       */
    /******************************************************************************/        
    FUNCTION read_bill_result ( p_edi_history_seq   IN NUMBER ,               -- EDI�ۼ����̷� �Ϸù�ȣ 
                                p_emp_no            IN VARCHAR2 )             -- ���  
        RETURN VARCHAR2;                                                      -- �Լ� ó����� �޽���                                          

        
    /******************************************************************************/
    /*  ��� : ������ü���� ó����� ���� ó��                                    */
    /******************************************************************************/        
    FUNCTION read_cash_result ( p_edi_history_seq   IN NUMBER ,               -- EDI�ۼ����̷� �Ϸù�ȣ 
                                p_emp_no            IN VARCHAR2 )             -- ���  
        RETURN VARCHAR2;                                                      -- �Լ� ó����� �޽���             
        
    /******************************************************************************/
    /*  ��� : �����ֱ⺰�� ����Ǵ� job�� ���� �Ѱ� ȣ�� �Լ�                    */
    /******************************************************************************/        
    PROCEDURE do_job_task;

    
    /******************************************************************************/
    /*  ��� : Ÿ����ü�Ҵ� �������� �߼�                                         */
    /******************************************************************************/        
    FUNCTION send_tran_fail_mail( p_comp_code         IN VARCHAR2 ,        -- ������ڵ�  
                                  p_bank_code         IN VARCHAR2 ,        -- �����ڵ� 
                                  p_docu_numc         IN VARCHAR2 )        -- ������ȣ 
        RETURN VARCHAR2;                                                   -- �Լ� ó����� �޽���                                          

    
    /******************************************************************************/
    /*  ��� : ���޿��� ���ϵ���Ÿ ����                                           */
    /******************************************************************************/        
    FUNCTION create_paydue_mail_data( p_comp_code         IN VARCHAR2 ,        -- ������ڵ�   
                                      p_pay_ymd           IN VARCHAR2 ,        -- ���޿������� 
                                      p_vendor_seq        IN NUMBER )          -- �ŷ�ó�Ϸù�ȣ 
        RETURN VARCHAR2;                                                       -- �Լ� ó����� �޽���                                          
        
        
    /******************************************************************************/
    /*  ��� : ���޿��� ���� �߼�                                                 */
    /******************************************************************************/        
    FUNCTION send_paydue_mail( p_mail_seq         IN NUMBER ,                  -- �����Ϸù�ȣ  
                               p_emp_no           IN VARCHAR2 )                -- ��� 
        RETURN VARCHAR2;                                                       -- �Լ� ó����� �޽���     
        
                
    /******************************************************************************/
    /*  ��� : ������ü ��ǥ����/��ü����Ÿ ����                                  */
    /******************************************************************************/        
    FUNCTION create_transfer_slip_data( p_transfer_seq   IN NUMBER ,            -- ������ü�Ϸù�ȣ  
                                        p_emp_no         IN VARCHAR2 )          -- ��� 
        RETURN VARCHAR2;                                                        -- �Լ� ó����� �޽���                     
                
                
    /******************************************************************************/
    /*  ��� : �λ����޵���Ÿ ����                                                */
    /******************************************************************************/        
    FUNCTION extract_hr_pay_data( p_comp_code         IN VARCHAR2 ,        -- ������ڵ�   
                                  p_pay_ym            IN VARCHAR2 ,        -- ���޿��� ��� 
                                  p_gubun             IN VARCHAR2 ,        -- ���� 
                                  p_emp_no            IN VARCHAR2 ,        -- ���  
                                  p_extract_cnt       OUT NUMBER  ,        -- �� ���� �Ǽ�  
                                  p_extract_amt       OUT NUMBER  )        -- �� ���� �ݾ� 
        RETURN VARCHAR2;                                                   -- �Լ� ó����� �޽���                     

        
    /******************************************************************************/
    /*  ��� : ȸ��ý��ۿ��� ��ü��Ͻ� ���ھ����ŷ�ó�� ��ϵ� ��ü���� Ȯ��    */
    /******************************************************************************/        
    FUNCTION check_bill_vendor( p_comp_code         IN VARCHAR2 ,        -- ������ڵ�   
                                p_bank_code         IN VARCHAR2 ,        -- �����ڵ� 
                                p_bizno             IN VARCHAR2 )        -- ����ڹ�ȣ 
        RETURN VARCHAR2;                                                 -- �Լ� ó����� �޽���    
        
                
        
    /******************************************************************************/
    /*  ��� : RealTimeó����, VAN�۽�Table�� �ְ�,�����ð����� ���Ŵ��ó��      */
    /******************************************************************************/        
    FUNCTION send_realtime_document( p_rec_send          IN FB_VAN_SEND_RECORD ,   -- �۽�RECORD  
                                     p_timeout           IN NUMBER ,               -- �ִ���ð� 
                                     p_rec_recv          OUT FB_VAN_RECV_RECORD ,  -- ����RECORD 
                                     p_result_code       OUT VARCHAR2  ,           -- ó������ڵ� 
                                     p_result_msg        OUT VARCHAR2  )           -- ó������޽���  
        RETURN VARCHAR2;                                                           -- �Լ� ó����� �޽���     
                
                
END FBS_MAIN_PKG;
/
CREATE OR REPLACE PACKAGE BODY FBS_MAIN_PKG IS


    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : send_start_document                                   */
    /*  2. ����̸�  : ���Ͼ�ħ �������� ���������� �۽��մϴ�.              */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ���� �������ð�(����8:30)�� FBS�������°� �輳�� �����������  */
    /*        ���������� �ڵ����� �߼��մϴ�.                                */
    /*        �� �Լ��� �����/������ �Է¹޾Ƽ�, ��������1���� �����ϴ�     */
    /*        ����� �����ϸ�, �����/����LIST�� SELECT�� ��ȸ��, �� �Լ���  */
    /*        ���� ȣ���Ͽ� ó���Ѵ�. (���Ͼ�ħ ���� ��)                     */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���󰳽� ��                                             */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/         
    FUNCTION send_start_document( p_comp_code     IN VARCHAR2 ,       -- ����� �ڵ�
                                  p_bank_code     IN VARCHAR2 ,       -- �����ڵ�
                                  p_resp_code     OUT VARCHAR2,       -- �����ڵ�
                                  p_resp_msg      OUT VARCHAR2 )      -- �����ڵ��                                   
        RETURN VARCHAR2 IS                                            -- �Լ� ó����� �޽���    
            
    BEGIN
    
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );
    
    END send_start_document;    
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : send_fbs_status_mail                                  */
    /*  2. ����̸�  : �����������ð��� FBS�ý��ۿ� ���� �������˸����� �߼� */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ���� �������ð�(����9:00)�� FBS�ý��ۿ� ���� ���¸� �����Ͽ�   */
    /*        �� ��ϵ� ������ �� �߰������� PARAMETER�� �Էµ� �ο�����     */
    /*        FBS�ý��ۻ��¸� ���� ������ �߼��մϴ�.                        */
    /*        �����ڴ� T_FB_LOOKUP_VALUES�� LOOKUP_TYPE�� "FBS_RECEIVE_EMP"  */
    /*        �� ��ϵ� �ο����� �߼��Ѵ�.                                   */
    /*                                                                       */
    /*      - üũ�ϴ� ������ �Ʒ��� ����                                    */
    /*         (1) ����PROGRAM�� VALID���� Ȯ��                              */
    /*         (2) ����PROCESS�� �⵿���� Ȯ��                               */
    /*         (3) JOB���࿩�� Ȯ��                                          */
    /*         (4) ���ະ ���ÿ��� Ȯ��                                      */
    /*         (5) ���ŵ� ���ھ��� �����ŷ��� ����                           */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ���Ϲ߼� ��                                        */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
    FUNCTION send_fbs_status_mail( p_recv_list  IN VARCHAR2 DEFAULT NULL )   -- �߰����� ���ϼ����� (DEFAULT�� NULL) 
        RETURN VARCHAR2 IS    
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_fbs_status_mail;
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : retieve_acct_remains                                  */
    /*  2. ����̸�  : 1�� ���¿� ���� �ܾ���ȸ                              */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �Էµ� �����ڵ� �� ���¹�ȣ�� ���� �ܾ��� VAN��� �ܾ���ȸ���� */
    /*        �� �ۼ����Ͽ�, ���ؿɴϴ�.                                     */
    /*        ���������� ó���� ���, RESP_CODE�� "0000"���� ��ȯ�� ��츸   */
    /*        ���������� ��ȸ�� �����.                                      */
    /*                                                                       */    
    /*      - �ܾ׵���Ÿ�� ���Ͽ� "�����ܾ׵���Ÿ(T_FB_ACCT_REMAIN_DATA)"��  */
    /*        ������ INSERT Ȥ�� UPDATE�����մϴ�                            */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
    FUNCTION retieve_acct_remains( p_bank_code     IN VARCHAR2 ,       -- �����ڵ�
                                   p_acct_number   IN VARCHAR2 ,       -- ���¹�ȣ 
                                   p_remain_amt    OUT NUMBER  ,       -- �����ܾ� 
                                   p_enable_amt    OUT NUMBER  ,       -- ��ݰ��ɾ� 
                                   p_resp_code     OUT VARCHAR2,       -- �����ڵ�
                                   p_resp_msg      OUT VARCHAR2 )      -- �����ڵ�� 
        RETURN VARCHAR2 IS                                             -- �Լ� ó����� �޽���    
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END retieve_acct_remains;  
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : cash_pay_window_check                                 */
    /*  2. ����̸�  : ������ü ����� ȹ�� �� ���ó�� ����                 */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ������ü�� ����� Ȯ��/Ȯ����ҿ� ���Ͽ� ������ ó����ƾ       */
    /*        Ȯ������, Ȯ�����ó�������� GUBUN�ڵ�� �����Ѵ�.             */
    /*                                                                       */
    /*        (1) Ȯ��ó�� ��                                                */
    /*          : T_FB_CASH_PAY_DATA�� ��� �ش� ����RECORD�� ���Ͽ� Ÿ��    */
    /*            ��ü���θ� Ȯ���Ͽ�, T_FB_LOOKUP_VALUES���̺��� ���ະ     */
    /*            ��ü�ѵ��ݾ��� Ȯ���Ͽ�, T_FB_CASH_PAY_DIVIDED_DATA��      */
    /*            �������ްǿ� ���Ͽ� RECORD�� ������Ų��.                   */
    /*            ��ü�ѵ��� �Ȱɸ��� ���� 1���� ��������RECORD������        */
    /*            ������Ų ��, PAY_STATUS�� ����� Ȯ�λ��·� UPDATE�Ѵ�.    */
    /*                                                                       */
    /*        (2) Ȯ����� ó�� ��                                           */ 
    /*          : �� Ȯ�� �� ���̾����Ƿ�, �����������̺� ������ RECORD��  */
    /*            DELETE�ϰ�, PAY_STATUS�� ����� ��Ȯ�� ���·� �����Ų��.  */
    /*                                                                       */
    /*      - �����Ȯ��/Ȯ�����ó���� �������/���޿Ϸ�/����/��ǥ��� �ø� */
    /*         ������ ���¿����� ó���� ������                               */
    /*                                                                       */
    /*      - ���޵���Ÿ�� ��ó�� "������ü"�� ���� Ȯ��/Ȯ����ҿ� ���� */
    /*        STATUS�� ��������ش�. T_FB_CASH_TRANSFER_DATA��               */
    /*        FUND_TRANSFER_STATUS�� Ȯ�νô� '1'�� �����ϸ�, ��ҽô� '0'�� */
    /*        ���� UPDATE�Ѵ�.                                               */
    /*                                                                       */    
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
    FUNCTION cash_pay_window_check( p_pay_seq     IN NUMBER ,          -- �����Ϸù�ȣ
                                    p_job_gubun   IN VARCHAR2 ,        -- ó������ [ CHECK:Ȯ�� , CANCEL:Ȯ����� ]
                                    p_emp_no      IN VARCHAR2 )        -- ���                                       
        RETURN VARCHAR2 IS                                             -- �Լ� ó����� �޽���                          
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END cash_pay_window_check;    
  
  
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : create_cash_edi_file                                  */
    /*  2. ����̸�  : ������ü���� ����                                     */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ������ ȭ��ܿ��� UPDATE�Ͽ��ִ� EDI_CREATE_REQ_YN �÷��� 'Y'  */
    /*        �� ���� ������� EDI������ �����մϴ�.                         */    
    /*                                                                       */
    /*      - ������ü������ �����ϸ�, ���ະ/����庰�� �����ȴ�.           */
    /*        ���������� ������ ���, RETURN���� OK�� ��ȯ�Ǹ�, ������ �ۼ�  */
    /*        ���̷����̺�(T_FB_EDI_HISTORY)�� Ű(SEQ)�� ��ȯ�ȴ�.           */
    /*        ������ �� ���� NULL���� ��ȯ�ȴ�.                            */
    /*                                                                       */
    /*      - ��ü������ ������ ��Ģ�� �ǰ� ������ �ϴ� function�� ȣ���Ͽ�  */
    /*        ���ϰ��/���ϸ��� ���ؼ� ������Ų��.                           */
    /*                                                                       */
    /*      - ���ϸ� ����Ģ�� ������ ���� ��                               */
    /*         CS_������ڵ�(2)_�����ڵ�(2)_��¥(8)_�Ϸù�ȣ(3).dat          */
    /*                                                                       */    
    /*      - ���ü� üũ�� ���ؼ� ȭ��������� ȣ���, ������ ���� ������   */
    /*        �� �Լ��� parameter�� �Է��Ͽ�, ���� ó���Ϸ���� ���� ������  */
    /*        �񱳸� �Ͽ� �ٸ� ���� ������ ��ȯ�Ѵ�.                       */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
    FUNCTION create_cash_edi_file( p_comp_code         IN VARCHAR2 ,        -- ������ڵ�  
                                   p_bank_code         IN VARCHAR2 ,        -- �����ڵ� 
                                   p_row_cnt           IN NUMBER ,          -- ó���� ���� ���� (üũ��) 
                                   p_emp_no            IN VARCHAR2 ,        -- ���   
                                   p_edi_history_seq   OUT NUMBER )         -- EDI����_�ۼ���HISTORY�Ϸù�ȣ (������ ���, NULL)    
        RETURN VARCHAR2 IS                                                  -- �Լ� ó����� �޽���            
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END create_cash_edi_file;    

  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : create_bill_edi_file                                  */
    /*  2. ����̸�  : ���ھ������� ����                                     */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ������ ȭ��ܿ��� UPDATE�Ͽ��ִ� EDI_CREATE_REQ_YN �÷��� 'Y'  */
    /*        �� ���� ������� EDI������ �����մϴ�.                         */    
    /*                                                                       */
    /*      - ���ھ��������� �����ϸ�, ���ະ/����庰�� �����ȴ�.           */
    /*        ���������� ������ ���, RETURN���� OK�� ��ȯ�Ǹ�, ������ �ۼ�  */
    /*        ���̷����̺�(T_FB_EDI_HISTORY)�� Ű(SEQ)�� ��ȯ�ȴ�.           */
    /*        ������ �� ���� NULL���� ��ȯ�ȴ�.                            */
    /*                                                                       */
    /*      - ��ü������ ������ ��Ģ�� �ǰ� ������ �ϴ� function�� ȣ���Ͽ�  */
    /*        ���ϰ��/���ϸ��� ���ؼ� ������Ų��.                           */
    /*                                                                       */
    /*      - ���ϸ� ����Ģ�� ������ ���� ��                               */
    /*         BS_������ڵ�(2)_�����ڵ�(2)_��¥(8)_�Ϸù�ȣ(3).dat          */    
    /*                                                                       */
    /*      - ���ü� üũ�� ���ؼ� ȭ��������� ȣ���, ������ ���� ������   */
    /*        �� �Լ��� parameter�� �Է��Ͽ�, ���� ó���Ϸ���� ���� ������  */
    /*        �񱳸� �Ͽ� �ٸ� ���� ������ ��ȯ�Ѵ�.                       */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
    FUNCTION create_bill_edi_file(  p_comp_code         IN VARCHAR2 ,        -- ������ڵ�  
                                    p_bank_code         IN VARCHAR2 ,        -- �����ڵ� 
                                    p_row_cnt           IN NUMBER ,          -- ó���� ���� ���� (üũ��) 
                                    p_emp_no            IN VARCHAR2 ,        -- ���   
                                    p_edi_history_seq   OUT NUMBER )         -- EDI����_�ۼ���HISTORY�Ϸù�ȣ (������ ���, NULL)    
        RETURN VARCHAR2 IS                                                   -- �Լ� ó����� �޽���            
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END create_bill_edi_file;    
  
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : send_cash_each_transfer                               */
    /*  2. ����̸�  : ���ҰǺ� ������ü ����                                */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ����� Ȯ�� ������ ���ؼ� ������ �������ް� ������ ���� ����� */
    /*        VAN�� ���ؼ� ����(��Ÿ����ü)�ۼ����� �����Ѵ�.                */
    /*        ó�����HISTORY�� HISTORY TABLE(T_FB_CASH_PAY_HISTORY)�� ����  */
    /*        �Ǹ�, ó������� RESP_CODE, RESP_MSG�� ��ȯ�ȴ�.               */
    /*                                                                       */
    /*      - �� �Լ��� �ܵ����� ����ġ ������, SEND_CASH_TRANSFER�� ���ؼ�  */
    /*         ȣ��Ǿ� ���ȴ�.                                            */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
    FUNCTION send_cash_each_transfer( p_pay_seq         IN NUMBER ,        -- �����Ϸù�ȣ
                                      p_div_seq         IN NUMBER ,        -- �����Ϸù�ȣ  
                                      p_emp_no          IN VARCHAR2 ,      -- ���   
                                      p_resp_code       OUT VARCHAR2,      -- �����ڵ�
                                      p_resp_msg        OUT VARCHAR2 )     -- �����ڵ��  
        RETURN VARCHAR2 IS                                                 -- �Լ� ó����� �޽���             
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_cash_each_transfer;          
        
        
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : send_cash_transfer                                    */
    /*  2. ����̸�  : ���ްǺ� ������ü ����                                */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ���ް�(T_FB_CASH_PAY_DATA) ������ ó���Ǹ�, ���� ����ڰ� ȭ�� */
    /*        �� ���ؼ� ȣ��Ǵ� �����̸�, ���������� ���ҵ� ���� ������ ��  */
    /*        �Ͽ�, DIV_SEQ�� �߰�PARAMETER�� �Ͽ�, SEND_CASH_EACH_TRANSFER  */
    /*        �Լ��� ȣ���Ͽ� ó���Ѵ�.                                      */
    /*                                                                       */
    /*      - �Լ����������� DIVIDE�� �Ǽ��� üũ�ϰ�, ������ �ǿ� ���Ͽ�    */
    /*        ó���Ϸ� ��, �������ó���� ��� Ȥ�� �Ϻν���, ��ü���п� ��  */
    /*        �� �̷��� ������ �ִٰ� ó������� RETURN�Ѵ�.                 */
    /*                                                                       */
    /*      - �����۽ÿ��� �� �Լ��� ����ϸ�, ���޽���/�Ϻ����޽����� ���  */
    /*        �ش� ���޽��а��� ã�Ƽ� SEND_CASH_EACH_TRANSFER�� ��ȣ���Ͽ�  */
    /*        ó���Ѵ�.                                                      */
    /*                                                                       */
    /*      - �Լ����������� SEND_CASH_EACH_TRANSFER�� ȣ���Ͽ� ����         */
    /*        ó������� ���Ͽ� PAY_STATUS�� UPDATE�Ѵ�.                     */
    /*          4: ���޿Ϸ�                                                  */
    /*          5: ���޽���                                                  */
    /*          6: �Ϻ����޽��� => �������Ұ��϶�, �����Ϻΰ� ������ ���    */    
    /*          7: ��ǥ���                                                  */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          ����ó�� => ���� ��üó�� �Ϸ� ��                            */
    /*          �Ϻ����޽���:[�����޽���]                                    */
    /*                   => �������Ұ��� ���, �Ϻ� ���޽��н� ù��° ����   */
    /*          ���޽���:[�����޽���]                                        */
    /*                   => ���Ұ���1���� ���, ���޽��н� ����              */
    /*          ��ǥ��� => ��ǥ��ҵ� ���                                  */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/          
    FUNCTION send_cash_transfer( p_pay_seq         IN NUMBER ,        -- �����Ϸù�ȣ
                                 p_emp_no          IN VARCHAR2 )      -- ���   
        RETURN VARCHAR2 IS                                            -- �Լ� ó����� �޽���       
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_cash_transfer;    
  
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : send_bill_transfer                                    */
    /*  2. ����̸�  : ���ްǺ� ���ھ��� realtime �۽�                       */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - Realtime���� ���ھ����� �����ϴ� ����� �����մϴ�.            */ 
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          ����ó�� => ���� ����ó�� �Ϸ� ��                            */
    /*          ���޽��� => ���޽��� ����                                    */
    /*          ��ǥ��� => ��ǥ��ҵ� ���                                  */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/          
    FUNCTION send_bill_transfer( p_pay_seq         IN NUMBER ,        -- �����Ϸù�ȣ
                                 p_emp_no          IN VARCHAR2 )      -- ���   
        RETURN VARCHAR2 IS                                            -- �Լ� ó����� �޽���       
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_bill_transfer;    
    
      
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : retieve_pay_summation                                 */
    /*  2. ����̸�  : ��ü�����û ó��                                     */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �����ڵ�� ���¹�ȣ�� �Է¹޾�, ��üó�������û�� �Ͽ� ���   */
    /*        �� ��ȯ�մϴ�.                                                 */
    /*      - ���аǼ�,���бݾ��� �ѰǼ�/�ѱݾ׿��� �����Ǽ��� �����ݾ���    */
    /*        �����Ͽ� ����մϴ�.                                           */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
    PROCEDURE retieve_pay_summation( p_bank_code       IN VARCHAR2 ,       -- �����ڵ�
                                     p_acct_number     IN VARCHAR2 ,       -- ���¹�ȣ 
                                     p_da_req_cnt      OUT NUMBER ,        -- ���� ��û �Ǽ� 
                                     p_da_req_amt      OUT NUMBER ,        -- ���� ��û �ݾ� 
                                     p_da_success_cnt  OUT NUMBER ,        -- ���� ����ó�� �Ǽ� 
                                     p_da_success_amt  OUT NUMBER ,        -- ���� ����ó�� �ݾ� 
                                     p_da_commission   OUT NUMBER ,        -- ���� ������ 
                                     p_ta_req_cnt      OUT NUMBER ,        -- Ÿ�� ��û �Ǽ� 
                                     p_ta_req_amt      OUT NUMBER ,        -- Ÿ�� ��û �ݾ� 
                                     p_ta_success_cnt  OUT NUMBER ,        -- Ÿ�� ����ó�� �Ǽ� 
                                     p_ta_success_amt  OUT NUMBER ,        -- Ÿ�� ����ó�� �ݾ� 
                                     p_ta_commission   OUT NUMBER ,        -- Ÿ�� ������ 
                                     p_resp_code       OUT VARCHAR2,       -- �����ڵ�
                                     p_resp_msg        OUT VARCHAR2 ) IS   -- �����ڵ�� 
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        
		p_da_req_cnt := 1000;
		p_da_req_amt := 1001;
		p_da_success_cnt := 1002;
		p_da_success_amt := 1003;
		p_da_commission := 1004;
		p_ta_req_cnt := 1005;
		p_ta_req_amt := 1006;
		p_ta_success_cnt := 1007;
		p_ta_commission := 1008;
		p_resp_code := '200';
		p_resp_msg := 'dddd';

        NULL;
  
  
  
  
    END retieve_pay_summation;    
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : retieve_acct_holder_name                              */
    /*  2. ����̸�  : �����ָ� ��ȸ                                         */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �Էµ� �����ڵ� �� ���¹�ȣ�� ���� �����ָ��� VAN�� ������     */
    /*        �ۼ����Ͽ�, ���ؿɴϴ�.                                        */
    /*        ���������� ó���� ���, RESP_CODE�� "0000"���� ��ȯ�� ��츸   */
    /*        ���������� ��ȸ�� �����.                                      */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/    
    FUNCTION retieve_acct_holder_name( p_bank_code     IN VARCHAR2 ,       -- �����ڵ�
                                       p_acct_number   IN VARCHAR2 ,       -- ���¹�ȣ 
                                       p_holder_name   OUT VARCHAR2 ,      -- �����ָ� 
                                       p_resp_code     OUT VARCHAR2,       -- �����ڵ�
                                       p_resp_msg      OUT VARCHAR2 )      -- �����ڵ�� 
        RETURN VARCHAR2 IS                                                 -- �Լ� ó����� �޽���     
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END retieve_acct_holder_name;     
  
  
  

    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : read_bill_vendor_info                                 */
    /*  2. ����̸�  : ���ھ��� �ŷ������� ���� ó��                         */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �������κ��� ���ŵ� ���ھ��� �ŷ����������ϸ�(�������)�� ��   */
    /*        �, ���ھ������¾�ü(T_FB_CHECK_VENDORS)�� �ݿ��Ѵ�.         */
    /*        �������ϸ��� EDI�ۼ����̷��� SEQ�� �ش��ϴ� RECORD�� ��ȸ�Ͽ�  */
    /*        �������ϸ��� ã�Ƽ� , �ش� ������ �����Ͽ� ó���Ѵ�.           */
    /*                                                                       */
    /*      - ���ϸ� ����Ģ�� ������ ���� �� (�ۼ����̷����̺� ����)     */
    /*         V_������ڵ�(2)_�����ڵ�(2)_��¥(8)_�Ϸù�ȣ(3).dat           */      
    /*                                                                       */    
    /*      - �ű�/����/���� ��� �ش� TABLE�� INSERT�� �����ϸ�, ������     */
    /*        VIEW�� ���ؼ� ���� ��ü�� ���¸� Ȯ���� �� �ֵ��� �Ѵ�.        */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/  
    FUNCTION read_bill_vendor_info( p_edi_history_seq  IN NUMBER )            -- EDI�ۼ����̷� �Ϸù�ȣ 
        RETURN VARCHAR2 IS                                                    -- �Լ� ó����� �޽���       
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END read_bill_vendor_info;   
    
    
    
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : read_bill_result                                      */
    /*  2. ����̸�  : ���ھ��� ó����� ���� ó��                           */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ����� ȭ�����κ��� �ش� EDI�ۼ����̷��� SEQ�� �޾�, ��������  */
    /*        ���� ��ȸ�Ͽ�, ������ ������ ��, ä�ǹ�ȣ�� �ش��ϴ� ���ް���  */
    /*        ã�Ƽ� ó������� UPDATE�Ѵ�.                                  */
    /*                                                                       */    
    /*      - ���ϸ� ����Ģ�� ������ ���� �� (�ۼ����̷����̺� ����)     */
    /*         BR_������ڵ�(2)_�����ڵ�(2)_��¥(8)_�Ϸù�ȣ(3).dat           */      
    /*                                                                       */
    /*      - ó������� ���� �� ���ްǿ� ���Ͽ� ����(PAY_STATUS)�� UPDATE */
    /*          4: ����Ϸ�                                                  */
    /*          5: �������                                                  */
    /* 
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/  
    FUNCTION read_bill_result(  p_edi_history_seq  IN NUMBER ,                -- EDI�ۼ����̷� �Ϸù�ȣ 
                                p_emp_no           IN VARCHAR2 )              -- ���  
        RETURN VARCHAR2 IS                                                    -- �Լ� ó����� �޽���      
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END read_bill_result;   
        
    
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : read_cash_result                                      */
    /*  2. ����̸�  : ������ü���� ó����� ���� ó��                       */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ����� ȭ�����κ��� �ش� EDI�ۼ����̷��� SEQ�� �޾�, ��������  */
    /*        ���� ��ȸ�Ͽ�, ������ ������ ��, �ش��ϴ� ���ް���             */
    /*        ã�Ƽ� ó������� UPDATE�Ѵ�.                                  */
    /*                                                                       */    
    /*      - ���ϸ� ����Ģ�� ������ ���� �� (�ۼ����̷����̺� ����)     */
    /*         CR_������ڵ�(2)_�����ڵ�(2)_��¥(8)_�Ϸù�ȣ(3).dat          */      
    /*                                                                       */
    /*      - ó������� ���� �� ���ްǿ� ���Ͽ� ����(PAY_STATUS)�� UPDATE */
    /*          4: ���޼���                                                  */
    /*          5: ���޽���                                                  */
    /* 
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2006��1��10��                                         */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/  
    FUNCTION read_cash_result(  p_edi_history_seq  IN NUMBER ,                -- EDI�ۼ����̷� �Ϸù�ȣ 
                                p_emp_no           IN VARCHAR2 )              -- ���  
        RETURN VARCHAR2 IS                                                    -- �Լ� ó����� �޽���      
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END read_cash_result;       
    
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : do_job_task                                           */
    /*  2. ����̸�  : �����ֱ⺰�� ����Ǵ� job�� ���� �Ѱ� ȣ�� �Լ�       */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ������ �ֱ⺰�� ����Ǵ� JOB�� ��ϵ� TASK�� ���Ͽ� ������     */
    /*        ��ȸ���� �� �ʿ�PARAMETER�� �����Ͽ� ȣ���ϴ� �Ѱ��Լ�         */
    /*                                                                       */
    /*      - JOB�� ���Ͽ� ó���Ǵ� ������ �Ʒ��� ����                       */
    /*                                                                       */
    /*        (1) ���������߼�                                               */
    /*           : ���Ͼ�ħ�� FBS�������¿� �ش��ϴ� ������ SELECT�� �� ,    */
    /*             send_start_document�� ȣ���Ͽ�, ���������� �۽��Ѵ�.      */
    /*                                                                       */    
    /*        (2) FBS���¸��� �߼�                                           */    
    /*           : ��ϵ� ����ڿ��� FBS���¸� üũ�ϴ� ������ ������ ����� */
    /*             ���Ͽ� ��Ƽ� �߼��Ѵ�.                                   */
    /*                                                                       */
    /*        (3) ���ھ��� �ŷ������� ���� �� ó��                           */
    /*           : ���Ͼ�ħ�� �������κ��� �ŷ��� ������ ������ ��, ó��     */
    /*                                                                       */
    /*        (4) ���ݰŷ��� ��� ó��                                     */
    /*           : ���ݰŷ�����, ��������� �ڵ����� üũ�Ͽ� �����û ��  */
    /*             ���信 ���� ó���� �����Ѵ�. 1�ð� ���� ����              */
    /*                                                                       */
    /*        (5) ������� �ŷ��� ��� ó��                                */
    /*           : ������� �ŷ��� ��, ��������� �ڵ����� üũ�Ͽ� ���   */
    /*             ��û �� ���信 ���� ó���� �����Ѵ�. 1�ð� ���� ����      */
    /*                                                                       */
    /*        (6) �� ���¿� ���� �ϰ� �ϸ��ܾ� ��ȸ                          */
    /*           : ������ �ð��� FBS���·� ��ϵ� ��� ���¿� ���Ͽ� �ϰ���  */
    /*             ���� �ý����� �ڵ����� �ܾ���ȸ ������ �ۼ��� �Ѵ�.       */
    /*                                                                       */    
    /*        (7) �о����۵���Ÿ  ����Ȯ��                                   */
    /*           : �Ա�/�Ա���ҳ����� ���Ͽ� �о�ý������� �����Ҷ�, ����  */
    /*             �̷��� Ȯ���Ͽ�, �������̷³����� �����۽õ��ϸ�, �ٽ�    */
    /*             ������ �߻��ô�, �� ��ϵ� �ο����� ������ �߼��Ѵ�.      */   
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/      
    PROCEDURE do_job_task IS
    
    BEGIN
    
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        
        NULL;    
    
    END  do_job_task;   
    
    
    
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : send_tran_fail_mail                                   */
    /*  2. ����̸�  : Ÿ����ü�Ҵ� �������� �߼�                            */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �� �Լ��� TRIGGER���� ȣ��Ǹ�, Ÿ����ü���� ��, ��ü�Ҵ� ���� */
    /*        �� ������, T_FB_LOOKUP_VALUES�� LOOKUP_TYPE=TRAN_FAIL_MAIL_TO  */
    /*        �׸����� ��ϵ� ����ڿ��� ������ �߼��մϴ�.                  */
    /*                                                                       */
    /*      - �������κ��� �� ������ȣ�� �ش��ϴ� ���ް��� ã�Ƽ� ���޳����� */
    /*        ���� ������ �����Ͽ� ������ �߼��Ѵ�.                          */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/  
    FUNCTION send_tran_fail_mail( p_comp_code         IN VARCHAR2 ,        -- ������ڵ�  
                                  p_bank_code         IN VARCHAR2 ,        -- �����ڵ� 
                                  p_docu_numc         IN VARCHAR2 )        -- ������ȣ 
        RETURN VARCHAR2 IS                                                 -- �Լ� ó����� �޽���     
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_tran_fail_mail;       

    
      
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : create_paydue_mail_data                               */
    /*  2. ����̸�  : ���޿��� ���ϵ���Ÿ ����                              */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ��ݰ����� ��ü�� ���ްǿ� ���Ͽ� ���޿��������� �߼��� �ڷḦ */
    /*        �����մϴ�. ������ �����/���޿�������/����� �� �������� ��   */
    /*                                                                       */
    /*      - �����/���޿������� �ʼ������̸�, �ŷ�ó�� ���û����          */
    /*                                                                       */
    /*      - ������ T_FB_PAYDUE_MAIL_MASTER�� T_FB_PAYDUE_MAIL_DETAIL��     */
    /*        ���� RECORD�� �����ϰ�, INSERT�ϸ�, �� �߼۵� �̷��� �ִ� ��� */
    /*        MASTER�� ��������� ������, DETAIL�� �� ���� ��, �߼��̷���    */
    /*        �̹߼� ���·� UPDATE�Ѵ�.                                      */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/        
    FUNCTION create_paydue_mail_data( p_comp_code         IN VARCHAR2 ,        -- ������ڵ�   
                                      p_pay_ymd           IN VARCHAR2 ,        -- ���޿������� 
                                      p_vendor_seq        IN NUMBER )          -- �ŷ�ó�Ϸù�ȣ 
        RETURN VARCHAR2 IS                                                     -- �Լ� ó����� �޽���         
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END create_paydue_mail_data;    
  
  

    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : send_paydue_mail                                      */
    /*  2. ����̸�  : ���޿��� ���� �߼�                                    */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ���Ϲ߼۵���Ÿ�� SEQ(�Ϸù�ȣ)�� �Է¹޾�, �������˿� ���缭   */
    /*        ����Ÿ�� �����Ͽ� ������ �߼��մϴ�.                           */
    /*                                                                       */
    /*      - ���� �����ڴ� �ŷ�ó�ڵ�(T_CUST_CODE)���̺��� �ŷ�ó�� �ⳳ    */
    /*        ����ڸ� �� ����� �̸��� �ּҸ� SELECT�Ͽ� �����Ѵ�.          */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���� ó�� ��                                            */
    /*          �����޽��� : ��Ÿ ���� �߻��� (DEFAULT��:ERROR)              */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/   
    FUNCTION send_paydue_mail( p_mail_seq         IN NUMBER ,                  -- �����Ϸù�ȣ  
                               p_emp_no           IN VARCHAR2 )                -- ��� 
        RETURN VARCHAR2 IS                                                     -- �Լ� ó����� �޽���       
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_paydue_mail;   

    
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : create_transfer_slip_data                             */
    /*  2. ����̸�  : ������ü ��ǥ����/��ü����Ÿ ����                     */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ����� ������ü ������ ���Ͽ� ��ǥ���� �� ��ü�� ������ �� ��  */
    /*        �� ��ü����Ÿ(T_FB_CASH_PAY_DATA�� RECORD)�� �����մϴ�        */
    /*                                                                       */
    /*      - ��ǥ�� ȸ�������� �ڵ���ǥ�� �����ϸ�, �������� ��ǥ��ȣ��     */
    /*        ������ü�������̺�(T_FB_CASH_TRANSFER_DATA)�� UPDATE�Ѵ�.      */
    /*                                                                       */
    /*      - ��ü����Ÿ�� ���������� �����Ǹ�, �����Ϸù�ȣ(PAY_SEQ)�� �޾� */
    /*        ������ü�������̺�(T_FB_CASH_TRANSFER_DATA)�� UPDATE�Ѵ�.      */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���������� ��ǥ����/��ü����Ÿ���� �Ϸ� ó�� ��         */
    /*          �����޽��� : ��Ÿ ���� �߻���                                */
    /*               => ��ǥ�������� , ��ü����Ÿ ���� ���� ��               */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/       
    FUNCTION create_transfer_slip_data( p_transfer_seq   IN NUMBER ,            -- ������ü�Ϸù�ȣ  
                                        p_emp_no         IN VARCHAR2 )          -- ��� 
        RETURN VARCHAR2 IS                                                      -- �Լ� ó����� �޽���        
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END create_transfer_slip_data;      
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : extract_hr_pay_data                                   */
    /*  2. ����̸�  : �λ����޵���Ÿ ����                                   */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - ����ȭ���� ��ȸ����(�����,���޳��,���ޱ���)�� ���Ͽ� ������  */
    /*        �Է¹޾�, HR���� VIEW�� ���ؼ� ����Ÿ�� FBS�� �̰��۾��� ����  */
    /*                                                                       */    
    /*      - HR�ʿ����� "�޿��̷�-�޻󿩽���(�����̷�MASTER)"(GLIS002TT)��  */
    /*        SELECT�Ͽ�, �ʿ䵥��Ÿ�� ��ȸ�� ��, "�������̽�_�λ�"���̺�    */
    /*        (T_FB_INTERFACE_HR)�� INSERT�� �����Ѵ�.                       */
    /*                                                                       */
    /*      - ���ÿ� �������޵���Ÿ(T_FB_CASH_PAY_DATA)���� ���޳����� ����  */
    /*        INSERT�۾��� �����ϸ�, ������ PAY_SEQ�� T_FB_INTERFACE_PH��    */
    /*        RECORD�� UPDATE�ϴ� �۾��� �Ͽ�, ����� ������ �Ѵ�.         */
    /*                                                                       */    
    /*      - ������ ����� ����Ÿ�� �ִ� ���, ������°� "��������(T)' ��  */
    /*        '��ǥ���(C)'�� ���¿����� �ű� �������� �����ϴ�.             */ 
    /*        '���޴����(W)' �̳� '���޿Ϸ�(P)'�� ���¿����� �������� �Ұ�  */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���������� ����Ϸ�� => '��������(T)'����              */
    /*          �����޽��� : ��Ÿ ���� �߻���  ���� �޽���                   */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 12. ����������:                                                       */
    /* 13. ����������:                                                       */
    /*************************************************************************/     
    FUNCTION extract_hr_pay_data( p_comp_code         IN VARCHAR2 ,        -- ������ڵ�   
                                  p_pay_ym            IN VARCHAR2 ,        -- ���޿��� ��� 
                                  p_gubun             IN VARCHAR2 ,        -- ���� 
                                  p_emp_no            IN VARCHAR2 ,        -- ���  
                                  p_extract_cnt       OUT NUMBER  ,        -- �� ���� �Ǽ�  
                                  p_extract_amt       OUT NUMBER  )        -- �� ���� �ݾ� 
        RETURN VARCHAR2 IS                                                 -- �Լ� ó����� �޽���     
    BEGIN
  
  
        -- >>>>>>>>>>>>>   ó������    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END extract_hr_pay_data;    
  
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : check_bill_vendor                                     */
    /*  2. ����̸�  : ��ü��Ͻ� ���ھ����ŷ�ó�� ��ϵ� ��ü���� Ȯ��      */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - �繫ȸ��ý��ۿ��� ��ü��Ͻ�, �ش� ��ü�� Ư�������,���࿡   */
    /*        ���ھ��� �ŷ�ó�� ��ϵǾ� �ִ��� Ȯ���ϴ� �Լ�                */
    /*                                                                       */
    /*      - ���������� "���ھ������¾�ü(T_FB_BILL_VENDORS)"���̺��� ��ȸ  */
    /*        �Ͽ�, �����ֱ��� ���� ������� ��ȯ�մϴ�                      */
    /*                                                                       */    
    /*      - ��ȯ��                                                         */
    /*          OK : ���������� ������ ��ü�� ���                           */
    /*          �����޽��� : ��Ÿ ���� �߻���  ���� �޽���                   */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2006�� 1�� 5��                                        */
    /* 10. ����������: LG CNS ����ö                                         */
    /* 11. ����������: 2006�� 1�� 5��                                        */
    /*************************************************************************/     
    FUNCTION check_bill_vendor( p_comp_code         IN VARCHAR2 ,        -- ������ڵ�   
                                p_bank_code         IN VARCHAR2 ,        -- �����ڵ� 
                                p_bizno             IN VARCHAR2 )        -- ����ڹ�ȣ 
        RETURN VARCHAR2 IS                                               -- �Լ� ó����� �޽���     
  
        v_return_msg            VARCHAR2(300) := 'OK';
        rec_fb_bill_vendors     T_FB_BILL_VENDORS%ROWTYPE;
        
        ERR_PARAM_ERROR         EXCEPTION;     --�Է¹��� PARAMTER�� ������ ���.
        
    BEGIN
    
        -- �Է¹��� PARAMETER�� ���� VALID�� üũ�մϴ�.
        IF p_comp_code IS NULL or LENGTH(p_comp_code) = 0 THEN
            v_return_msg := '������ڵ尡 NULL�̰ų�, �߸��� ���Դϴ�.';
            
        ELSIF p_bank_code IS NULL or LENGTH(p_bank_code) = 0 THEN
            v_return_msg := '�����ڵ尡 NULL�̰ų�, �߸��� ���Դϴ�.';
            
        ELSIF p_bizno IS NULL or LENGTH(p_bizno) = 0 THEN
            v_return_msg := '����ڹ�ȣ�� NULL�̰ų�, �߸��� ���Դϴ�.';
        END IF;    
           
        -- �ش� �����/����/����ڹ�ȣ�� �ش��ϴ� ��ü���¸� ��ȸ�մϴ�.
        BEGIN
            SELECT *
              INTO rec_fb_bill_vendors
              FROM T_FB_BILL_VENDORS
             WHERE BANK_CODE = p_bank_code
               AND COMP_CODE = p_comp_code
               AND VAT_REGISTRATION_NUM = REPLACE(p_bizno,'-','')
               AND SEQ = (  SELECT MAX(SEQ)
                              FROM T_FB_BILL_VENDORS
                             WHERE BANK_CODE = p_bank_code
                               AND COMP_CODE = p_comp_code
                               AND VAT_REGISTRATION_NUM = REPLACE(p_bizno,'-','') );
  
            IF rec_fb_bill_vendors.contract_gubun = 'C' THEN
                v_return_msg := '�ش� ��ü�� ���������� ��ü�Դϴ�.(������:' || rec_fb_bill_vendors.change_ymd || ')';
            END IF;
  
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_return_msg := '�̾����̰ų�, ���������� �����ϴ�.';
                
            WHEN OTHERS THEN
                v_return_msg := fbs_util_pkg.format_msg( sqlerrm );
        END;
        
        RETURN( v_return_msg );  
  
    EXCEPTION
        WHEN ERR_PARAM_ERROR THEN
            RETURN( v_return_msg );
            
        WHEN OTHERS THEN
            RETURN( fbs_util_pkg.format_msg( sqlerrm ) );
  
    END check_bill_vendor;        
    
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. ���ID    : send_realtime_document                                */
    /*  2. ����̸�  : RealTimeVAN�۽�Table�� �ְ�,�����ð����� ���Ŵ��ó�� */
    /*  3. �ý���    : ȸ��ý���                                            */
    /*  4. ����ý���: FBS                                                   */
    /*  5. �������  :                                                       */
    /*  6. �����  : PL/SQL                                                */
    /*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. ���DBMS  : Oracle                                                */
    /*  9. ����� ���� �� �ֿ���                                           */
    /*                                                                       */
    /*      - parameter�� �Ѱܹ��� ����RECORD�� VAN�۽�TABLE�� INSERT�� ���� */
    /*        REALTIME_TEMP_DIR�� ���������� ������ ��, REALTIME_SEND_DIR��  */
    /*        FILE MOVE�� ��Ų �Ŀ�, �����ð����� ����Ͽ�, ����TABLE��      */
    /*        ���RECORD�� ���� ���, ����RECORD�� ������ ��Ƽ� ��ȯ�Ѵ�.   */
    /*                                                                       */
    /*      - ������Ű�� ������ ���� ���� ������ ���Ͽ� 1�� ������ �����Ǹ�  */
    /*        �� ������ 1�� �ٿ� 300Byte�� ������ü������ ���� ���� ����     */
    /*                                                                       */        
    /*      - ���ϸ� ����Ģ�� �Ʒ��� �����ϴ�. Ȯ���ڴ� .rec ��� ���δ�   */
    /*     ������ڵ�(2)_�����ڵ�(2)_���������ڵ�(6)_��¥(8)_������ȣ(6).rec */
    /*                                                                       */    
    /*      - ����MOVE�� FBS_UTIL_PKG�� exec_os_command �Լ��� ����Ͽ�      */
    /*        ó���Ѵ�.                                                      */
    /*                                                                       */        
    /*      - timeout���� ���� ���,(�ʴ���) �̰��� �����ϸ�, NULL���� �Է�  */
    /*        �Ǵ� ���, DEFAULT_TIMEOUT ���� ����ȴ�.                      */
    /*                                                                       */
    /*      - ��ȯ��                                                         */
    /*          OK : ���������� ����Ϸ�� => '��������(T)'����              */
    /*          �����޽��� : ��Ÿ ���� �߻���  ���� �޽���                   */
    /*                                                                       */
    /* 10. �����ۼ���: LG CNS ����ö                                         */
    /* 11. �����ۼ���: 2005��12��21��                                        */
    /* 10. ����������: LG CNS ����ö                                         */
    /* 11. ����������: 2006�� 1�� 3��                                        */
    /*************************************************************************/   
    FUNCTION send_realtime_document( p_rec_send          IN FB_VAN_SEND_RECORD ,   -- �۽�RECORD  
                                     p_timeout           IN NUMBER ,               -- �ִ���ð� 
                                     p_rec_recv          OUT FB_VAN_RECV_RECORD ,  -- ����RECORD 
                                     p_result_code       OUT VARCHAR2  ,           -- ó������ڵ� 
                                     p_result_msg        OUT VARCHAR2  )           -- ó������޽���  
        RETURN VARCHAR2 IS                                                         -- �Լ� ó����� �޽���    
        
        v_return_msg           VARCHAR2(200) := 'OK';        -- ��ȯ�޽���  
        v_file_name            VARCHAR2(100);                -- ���������̸�
        v_temp_file_path       VARCHAR2(200);                -- �ӽ�������ġ��� 
        v_send_file_path       VARCHAR2(200);                -- �۽�������ġ���  
        v_document_buffer      VARCHAR2(400);                -- �������ϳ���(BUFFER) 
        v_dummy_return         VARCHAR2(100); 
        
        d_start_dt             DATE;                         -- ���Ŵ�� ���۽ð�  
        n_start_time           NUMBER(20) := 0;              -- ���α׷��� ������ �ð�(�ʴ����� ȯ��� ��)
        n_curr_time            NUMBER(20) := 0;              -- �����⸦ ���Ͽ� ���� �ð�(�ʴ����� ȯ��� ��)        
        
        v_output_file                 UTL_FILE.FILE_TYPE;        
        
        ERR_INVALID_OPERATION         EXCEPTION;             -- �߸��� �����ΰ��...
        ERR_MAKE_TEMP_FILE_ERR        EXCEPTION;             -- �������ϻ��� �� ������ �߻��� ���...
        
    BEGIN
    
       -- 0) �Էµ� parameter���� ���� validation�� �����մϴ�.
       ---------------------------------------------------------
       
       IF p_timeout IS NULL or p_timeout < 1 THEN
           v_return_msg := 'TIMEOUT���� �Էµ� ���� ���ڷ� 0 �̻��� ���̾�� �մϴ�.';
           RAISE ERR_INVALID_OPERATION;
           
       ELSIF p_rec_send.ente_code IS NULL or LENGTH(p_rec_send.ente_code) = 0 THEN
           v_return_msg := '��ü�ڵ�(ENTE_CODE)�� ���õ��� �ʾҽ��ϴ�.';
           RAISE ERR_INVALID_OPERATION;
  
       ELSIF p_rec_send.bank_code IS NULL or LENGTH(p_rec_send.bank_code) != 2 THEN
           v_return_msg := '�����ڵ�(BANK_CODE)�� ���õ��� �ʾҰų�, NULL���� �ԷµǾ����ϴ�.';
           RAISE ERR_INVALID_OPERATION;
           
       ELSIF p_rec_send.docu_code IS NULL or LENGTH(p_rec_send.docu_code) != 4 THEN
           v_return_msg := '���������ڵ�(DOCU_CODE)�� ���õ��� �ʾҰų�, �߸��� ���� �ԷµǾ����ϴ�.';
           RAISE ERR_INVALID_OPERATION;

       ELSIF p_rec_send.upmu_code IS NULL or LENGTH(p_rec_send.upmu_code) != 3 THEN
           v_return_msg := '���α����ڵ�(UPMU_CODE)�� ���õ��� �ʾҰų�, �߸��� ���� �ԷµǾ����ϴ�.';
           RAISE ERR_INVALID_OPERATION;

       ELSIF p_rec_send.docu_numc IS NULL or LENGTH(p_rec_send.docu_numc) != 6 THEN
           v_return_msg := '������ȣ(DOCU_NUMC)�� ���õ��� �ʾҰų�, �߸��� ���� �ԷµǾ����ϴ�.';
           RAISE ERR_INVALID_OPERATION;

       ELSIF p_rec_send.send_date IS NULL or LENGTH(p_rec_send.send_date) != 8 THEN
           v_return_msg := '�۽�����(SEND_DATE)�� ���õ��� �ʾҰų�, �߸��� ���� �ԷµǾ����ϴ�.';
           RAISE ERR_INVALID_OPERATION;           

       ELSIF p_rec_send.gaeb_area IS NULL or LENGTH(p_rec_send.gaeb_area) = 0 THEN
           v_return_msg := '������(GAEB_AREA)�� ���õ��� �ʾҰų�, �߸��� ���� �ԷµǾ����ϴ�.';
           RAISE ERR_INVALID_OPERATION;           
           
       END IF;
  
  
        -- 1) �Ѱܹ��� SEND_RECORD�� �۽����̺�(T_FB_VAN_SEND)�� INSERT�մϴ�.
        ----------------------------------------------------------------------
        
        BEGIN

            INSERT INTO T_FB_VAN_SEND VALUES p_rec_send;
            
        EXCEPTION
            WHEN OTHERS THEN
                v_return_msg := '�۽����̺�(T_FB_VAN_SEND)�� INSERT�ϴ��� �����߻�';
                RAISE ERR_INVALID_OPERATION;
        END;
        
        
        -- 2) ���������� ����Ģ�� ���Ͽ�, �ӽõ��丮�� �����մϴ�. 
        -- ����Ģ :  ������ڵ�_�����ڵ�(2)_���������ڵ�(6)_��¥(8)_������ȣ(6).rec 
        ------------------------------------------------------------------------------
        
        /* �������� OS���� directory�� �����ɴϴ�.(from DBA_DIRECTORIES ) */
        BEGIN
            SELECT DIRECTORY_PATH || '\'
              INTO v_temp_file_path
              FROM DBA_DIRECTORIES
             WHERE DIRECTORY_NAME = FBS_REALTIME_TEMP_DIR;
        
            SELECT DIRECTORY_PATH || '\'
              INTO v_send_file_path
              FROM DBA_DIRECTORIES
             WHERE DIRECTORY_NAME = FBS_REALTIME_SEND_DIR;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_return_msg := '��ü���������� �����ϱ����� OS path������ �߸��Ǿ����ϴ�';
                RAISE ERR_INVALID_OPERATION;
        END;          
        
        /* 300byte�� ���������� buffer�� �ۼ��մϴ�. */
        v_document_buffer := fbs_util_pkg.sprintf('%-9.9s', p_rec_send.tran_code ) ||
                             fbs_util_pkg.sprintf('%-8.8s', p_rec_send.ente_code ) ||
                             fbs_util_pkg.sprintf('%-2.2s', p_rec_send.bank_code ) ||
                             fbs_util_pkg.sprintf('%-4.4s', p_rec_send.docu_code ) ||
                             fbs_util_pkg.sprintf('%-3.3s', p_rec_send.upmu_code ) ||
                             fbs_util_pkg.sprintf('%-1.1s', p_rec_send.send_cont ) ||
                             fbs_util_pkg.sprintf('%-6.6s', p_rec_send.docu_numc ) ||
                             fbs_util_pkg.sprintf('%-8.8s', p_rec_send.send_date ) ||
                             fbs_util_pkg.sprintf('%-6.6s', p_rec_send.send_time ) ||
                             fbs_util_pkg.sprintf('%-4.4s', NVL(p_rec_send.resp_code,'') ) ||
                             fbs_util_pkg.sprintf('%-49.49s', '' ) ||
                             fbs_util_pkg.sprintf('%-200.200s', p_rec_send.gaeb_area );
        
        /* ���ϸ��� ����ϴ�. */
        v_file_name := v_file_name || p_rec_send.ente_code || '_' ||
                                      p_rec_send.bank_code || '_' ||
                                      p_rec_send.docu_code || p_rec_send.upmu_code || '_' ||                                                
                                      p_rec_send.send_date || '_' ||
                                      p_rec_send.docu_numc || '.rec';
                                                
        /* ������ OPEN �մϴ� .*/
        BEGIN
        
            v_output_file := UTL_FILE.FOPEN('FBS_REALTIME_TEMP_DIR', v_file_name, 'w');
            
        EXCEPTION
            WHEN UTL_FILE.INVALID_OPERATION THEN
                v_return_msg := '�����������ϻ����� ���� ������ OPEN�ϴ��� �����߻�';
                RAISE ERR_INVALID_OPERATION;
        END;                                                        
        
        /* ���ϳ����� WRITE �մϴ�. */
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_document_buffer );
        EXCEPTION
            WHEN OTHERS THEN
                v_return_msg := '�������ϳ��� ������ ������ �߻��Ͽ�, ���ϻ����� ���� �ʾҽ��ϴ�.';
                RAISE ERR_MAKE_TEMP_FILE_ERR;
        END;                    

        /* ������ �ݽ��ϴ�. */
        BEGIN
            UTL_FILE.FCLOSE( v_output_file );
        EXCEPTION
            WHEN OTHERS THEN
                v_return_msg := '�������ϳ��� ������ ������ �߻��Ͽ�, ���ϻ����� ���� �ʾҽ��ϴ�.';            
                RAISE ERR_MAKE_TEMP_FILE_ERR;
        END;   
        
        
        -- 3) OS��ɾ ����Ͽ�, SEND_DIRECTORY�� MOVE �մϴ�.
        v_dummy_return := fbs_util_pkg.exec_os_command( 'move /Y '|| v_temp_file_path || v_file_name || ' ' || v_send_file_path || v_file_name );
        
        
        -- 4) �����ð����� ����ϰ� �ִٰ�, ����table�� record�� ������, RECORD�� ������ ������ �����Ѵ�.

        /* ���α׷��� ������ �ð��� ����մϴ�. */
        SELECT TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))*3600 +
               TO_NUMBER(TO_CHAR(SYSDATE,'MI'))*60 +
               TO_NUMBER(TO_CHAR(SYSDATE,'SS')) 
          INTO n_start_time
          FROM DUAL;   
                
        LOOP
            BEGIN
            
               /* �����ð����� ���Ű���� �Դ��� Ȯ���մϴ�. */
               SELECT *
                 INTO p_rec_recv
                 FROM T_FB_VAN_RECV
                WHERE ENTE_CODE = p_rec_send.ente_code
                  AND BANK_CODE = p_rec_send.bank_code
                  AND DOCU_CODE = SUBSTR( p_rec_send.docu_code , 1 , 2 ) || '10'
                  AND UPMU_CODE = p_rec_send.upmu_code
                  AND SEND_DATE = p_rec_send.send_date
                  AND SEND_CONT = p_rec_send.send_cont
                  AND DOCU_NUMC = p_rec_send.docu_numc;
            
               /* ���ŵ� ����� �ִ� ���, �۽�RECORD�� 'Y'��� UPDATE����, */
               /* �����ڵ忡 �ش��ϴ� �����ڵ���� ���ؼ� ��ȯ�Ѵ�.         */
               UPDATE T_FB_VAN_SEND
                  SET RESP_CODE = TRIM( p_rec_recv.resp_code ) ,
                      RESP_YEBU = 'Y'  
                WHERE ENTE_CODE = p_rec_send.ente_code
                  AND BANK_CODE = p_rec_send.bank_code
                  AND DOCU_CODE = p_rec_send.docu_code 
                  AND UPMU_CODE = p_rec_send.upmu_code
                  AND SEND_DATE = p_rec_send.send_date
                  AND SEND_CONT = p_rec_send.send_cont
                  AND DOCU_NUMC = p_rec_send.docu_numc;            
               
               BEGIN
                   SELECT RESP_CODE , RESP_CODE_NAME
                     INTO p_result_code , p_result_msg
                     FROM T_FB_REAL_RESP_CODE
                    WHERE BANK_CODE = TRIM(p_rec_recv.bank_code)
                      AND RESP_CODE = TRIM(p_rec_recv.resp_code)
                      AND USE_YN = 'Y';
               
               EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                       v_return_msg := '��������ڵ�['||p_rec_recv.resp_code ||']�� �̵�ϵǾ� �ֽ��ϴ�.';
                       
                   WHEN OTHERS THEN
                       v_return_msg := '��������ڵ���ȸ�� ��Ÿ�����߻�';                   
               END;
               
            
               EXIT;  -- ���������� ����� ���ŵǰ�, UPDATE�� �Ϸ�Ǹ� LOOP�� ����������.
            
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                
                    -- timeout�ð��� �ʰ��ϴ� ���, ����������� ����������.
                    SELECT TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))*3600 +
                           TO_NUMBER(TO_CHAR(SYSDATE,'MI'))*60 +
                           TO_NUMBER(TO_CHAR(SYSDATE,'SS')) 
                      INTO n_curr_time
                      FROM DUAL;                     
                    IF ( n_curr_time - n_start_time ) > p_timeout THEN
                        v_return_msg := '[�������] timeout�ð�('|| p_timeout ||'��)���� ������� ����Ͽ�����, �������κ��� �������';
                        EXIT;
                    END IF;
                    
                WHEN OTHERS THEN
                    -- ��Ÿ ������ �߻��ϴ� ���..
                    v_return_msg := '[��Ÿ����] �������ó���� ��Ÿ���� �߻�';
                    EXIT;
            END;        
        END LOOP;     
  
        -- ���������� ����ó���� ���, 'OK'���ڿ��� ��ȯ�Ǹ�, ��Ÿ ������ ���, �����޽��� ��ȯ       
        RETURN( v_return_msg );
        
    EXCEPTION
        WHEN ERR_INVALID_OPERATION THEN
            RETURN( v_return_msg );

        WHEN ERR_MAKE_TEMP_FILE_ERR THEN     
            
            -- ������ �̹� ������ ���� ������ EXCEPTION�̹Ƿ�, �� ������ �����ϴ� ���� 
            BEGIN
                UTL_FILE.FCLOSE( v_output_file );
                v_dummy_return := fbs_util_pkg.exec_os_command( 'del ' || v_temp_file_path || v_file_name );
            EXCEPTION
                WHEN OTHERS THEN
                    fbs_util_pkg.write_log('FBS',v_return_msg || fbs_util_pkg.format_msg( sqlerrm ) );
            END;
            
            RETURN( v_return_msg );
            
            
        WHEN OTHERS THEN
            RETURN( FBS_UTIL_PKG.format_msg( sqlerrm ) );
  
  
    END send_realtime_document;    
  
  
END FBS_MAIN_PKG;
/
