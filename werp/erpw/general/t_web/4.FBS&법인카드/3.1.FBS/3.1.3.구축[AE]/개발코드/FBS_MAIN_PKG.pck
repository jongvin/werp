CREATE OR REPLACE PACKAGE FBS_MAIN_PKG IS

    /******************************************************************************/
    /****                                                                      ****/
    /****                                                                      ****/
    /****           LG CNS VAN과 [기업은행]과 Batch처리를 위한 설정사항        ****/
    /****                                                                      ****/    
    /****                                                                      ****/
    /******************************************************************************/

    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 현금 대량이체용 RECORD                                    */
    /*----------------------------------------------------------------------------*/   
    TYPE FB_KIUP_CASH_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(2) := '11',               /* 식별코드 : 11            */
        bank_code             VARCHAR2(2) := '03',               /* 은행코드 : 03            */
        upmu_code             VARCHAR2(2) := '82',               /* 업무코드 : 82            */
        pay_date              VARCHAR2(6) ,                      /* 이체 처리일(YYMMDD)6자리 */        
        dummy1                VARCHAR2(6) ,                      /* 공란(SPACE)              */
        out_account_no        VARCHAR2(14) ,                     /* 출금계좌번호             */
        dummy2                VARCHAR2(1) ,                      /* 공란(SPACE)              */        
        ente_code             VARCHAR2(7) ,                      /* 기관코드                 */
        dummy3                VARCHAR2(40));                     /* 공란(SPACE)              */
        
    TYPE FB_KIUP_CASH_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(2) := '22',               /* 식별코드 : 22            */
        bank_code             VARCHAR2(2) ,                      /* 입금은행코드             */
        upmu_code             VARCHAR2(2) := '82',               /* 업무코드 : 82            */        
        data_seq              VARCHAR2(6) ,                      /* 데이터 일련번호          */ 
        in_account_no         VARCHAR2(14) ,                     /* 입금계좌번호             */
        pay_amt               VARCHAR2(10) ,                     /* 이체요청금액             */
        ente_use_field        VARCHAR2(10) ,                     /* 업체사용정보             */
        result_yebu           VARCHAR2(1) ,                      /* 처리결과 1:정상 2:불능   */        
        result_code           VARCHAR2(4),                       /* 처리결과코드             */
        money_gubun           VARCHAR2(1),                       /* 자금구분                 */
        dummy                 VARCHAR2(3) );                     /* 공란(SPACE)              */
                
    TYPE FB_KIUP_CASH_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(2) := '33',               /* 식별코드 : 33            */
        bank_code             VARCHAR2(2) ,                      /* 입금은행코드             */
        upmu_code             VARCHAR2(2) := '82',               /* 업무코드 : 82            */        
        total_request_cnt     VARCHAR2(7) ,                      /* 총 의뢰건수              */
        total_request_amt     VARCHAR2(13) ,                     /* 총 의뢰금액              */
        success_cnt           VARCHAR2(7)  := '0000000',         /* 정상처리건수             */
        success_amt           VARCHAR2(13) := '0000000000000' ,  /* 정상처리금액             */
        fail_cnt              VARCHAR2(7)  := '0000000',         /* 불능처리건수             */
        fail_amt              VARCHAR2(13) := '0000000000000',   /* 불능처리금액             */
        dummy1                VARCHAR2(6),                       /* 공란(SPACE)              */
        sign_no               VARCHAR2(4) ,                      /* 복기부호                 */
        dummy2                VARCHAR2(4));                      /* 공란(SPACE)              */   
    

    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 전자외상매출채권담보대출 용  RECORD                       */
    /*----------------------------------------------------------------------------*/           
    TYPE FB_KIUP_BILL_HEAD_RECORD IS RECORD (
        h_gubun          VARCHAR2(2) := '10',              /* 레코드구분 : 10           */    
        h_filename       VARCHAR2(6) ,                     /* 예비1                     */
        h_filecd         VARCHAR2(4) ,                     /* 예비2                     */
        h_fill11         VARCHAR2(4) ,                     /* 예비3                     */
        h_procdate       VARCHAR2(8) ,                     /* 전송일자                  */
        h_upchecd        VARCHAR2(12) ,                    /* 업체코드                  */
        h_bankcd         VARCHAR2(2) := '03' ,             /* 은행코드                  */
        h_culacc         VARCHAR2(13) ,                    /* 결제 계좌번호             */
        h_fill12         VARCHAR2(13) ,                    /* 예비4                     */
        h_procgb         VARCHAR2(1) := '1',               /* 처리구분 1:이체요구(업체->은행)  2:처리결과(은행->업체) */
        h_filler         VARCHAR2(82) ,                    /* 예비5                     */
        h_filler_2       VARCHAR2(2) );                    /* 예비6                     */
        
    TYPE FB_KIUP_BILL_DATA_RECORD IS RECORD (
        d_gubun          VARCHAR2(2) := '20' ,             /* 레코드구분 : 20           */
        d_nor_can        VARCHAR2(2) := '00' ,             /* 거래구분 00:정상  99:취소 */
        d_docno          VARCHAR2(14) ,                    /* 채권번호                  */
        d_cash_trx_yn    VARCHAR2(1) := '2' ,              /* 결제구분 1:현금 , 2:채권  */
        d_bil_amt        VARCHAR2(13) ,                    /* 채권금액                  */
        d_slco_bzno      VARCHAR2(10) ,                    /* 납품업체 사업자번호       */
        d_fill11         VARCHAR2(12) ,                    /* 예비1                     */
        d_gtext          VARCHAR2(20) ,                    /* 지급사업장                */
        d_chulgail       VARCHAR2(8) ,                     /* 출금가능일(발행일자)      */
        d_aummanki       VARCHAR2(8) ,                     /* 채권만기일                */
        d_result         VARCHAR2(4) ,                     /* 처리결과                  */
        d_paymentdate    VARCHAR2(8) ,                     /* 예비2                     */
        d_paymentid      VARCHAR2(6) ,                     /* 예비3                     */
        d_indate         VARCHAR2(8) ,                     /* 남품일자:세금계산서일자   */
        d_pummok         VARCHAR2(20) ,                    /* 품목                      */
        d_fill12         VARCHAR2(9) ,                     /* 예비4                     */
        d_dbrtcd         VARCHAR2(2) ,                     /* 처리RETURN CODE           */
        d_cheriy         VARCHAR2(1) ,                     /* 은행처리여부              */
        d_filler         VARCHAR2(2) );                    /* 예비5                     */
        
    TYPE FB_KIUP_BILL_TAIL_RECORD IS RECORD (
        t_gubun          VARCHAR2(2) := '30',              /* 레코드구분 : 30           */
        t_totgun         VARCHAR2(6) ,                     /* 총 전송건수               */
        t_totamt         VARCHAR2(13) ,                    /* 총 전송금액               */
        t_norgun         VARCHAR2(6) ,                     /* 정상처리건수              */
        t_noramt         VARCHAR2(13) ,                    /* 정상처리금액              */
        t_errgun         VARCHAR2(6) ,                     /* 에러 처리건수             */
        t_erramt         VARCHAR2(13) ,                    /* 에러 처리금액             */
        t_fill11         VARCHAR2(91) );                   /* 공란                      */
        
    
    
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 전자 외담대 거래선 정보용 RECORD                          */
    /*----------------------------------------------------------------------------*/       
    TYPE FB_KIUP_SUPPLIER_HEAD_RECORD IS RECORD (
        h_gubun          VARCHAR2(2) := '10',              /* 레코드구분 : 10           */
        h_UPCHENO        VARCHAR2(8) ,                     /* 업체번호                  */
        h_bankcd         VARCHAR2(2) := '03' ,             /* 은행코드 : 03             */
        h_gubun01        VARCHAR2(1) ,                     /* 예비                      */
        h_jendate        VARCHAR2(8) ,                     /* 전송일자                  */
        h_jobsijak       VARCHAR2(8) ,                     /* 예비                      */
        h_jobend         VARCHAR2(8) ,                     /* 예비                      */
        h_saupja         VARCHAR2(10) ,                    /* CJ개발 사업자번호         */
        h_filler         VARCHAR2(101) ,                   /* 예비                      */
        h_fi0d25         VARCHAR2(2) ,                     /* 예비                      */
        h_fil_48         VARCHAR2(48) ,                    /* 예비                      */
        h_fil_end        VARCHAR2(2) );                    /* 예비                      */
        
    TYPE FB_KIUP_SUPPLIER_DATA_RECORD IS RECORD (
        d_gubun          VARCHAR2(2) := '20',              /* 레코드구분 : 20            */
        d_seqno          VARCHAR2(11) ,                    /* 일련번호                   */
        d_saupno         VARCHAR2(10) ,                    /* 사업자번호                 */
        d_juminno        VARCHAR2(13) ,                    /* 주민번호                   */
        d_sangho         VARCHAR2(30) ,                    /* 상호                       */
        d_gyeoje         VARCHAR2(1) ,                     /* 구분                       */
        d_newilja        VARCHAR2(8) ,                     /* 신규일자                   */
        d_cloilja        VARCHAR2(8) ,                     /* 해지일자                   */
        d_adjilja        VARCHAR2(12) ,                    /* 예비                       */
        d_iacctno        VARCHAR2(15) ,                    /* 결제계좌번호 (협력업체)    */    
        d_brno           VARCHAR2(3) ,                     /* 예비                       */
        d_filler         VARCHAR2(25) ,                    /* 예비                       */
        d_fi0d25         VARCHAR2(2) ,                     /* 예비                       */
        d_fil_48         VARCHAR2(48) ,                    /* 예비                       */
        d_fil_end        VARCHAR2(2) );                    /* 예비                       */
        
    TYPE FB_KIUP_SUPPLIER_TAIL_RECORD IS RECORD (
        t_gubun          VARCHAR2(2) := '30' ,             /* 레코드구분 : 30            */
        t_totgun         VARCHAR2(6) ,                     /* 총 전송건수                */
        t_newgun         VARCHAR2(6) ,                     /* 신규건수                   */
        t_adjgun         VARCHAR2(6) ,                     /* 변경건수                   */
        t_clogun         VARCHAR2(6) ,                     /* 해지건수                   */
        t_filler         VARCHAR2(122) ,                   /* 업체코드                   */
        d_fi0d25         VARCHAR2(2) ,                     /* 예비                       */
        d_fil_49         VARCHAR2(48) ,                    /* 예비                       */
        d_fil_end        VARCHAR2(2) );                    /* 예비                       */        
    
    
    /******************************************************************************/
    /****                                                                      ****/
    /****                                                                      ****/
    /****           LG CNS VAN과 [국민은행]과 Batch처리를 위한 설정사항        ****/
    /****                                                                      ****/    
    /****                                                                      ****/
    /******************************************************************************/
    
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 현금 대량이체용 RECORD                                    */
    /*----------------------------------------------------------------------------*/               
    TYPE FB_KUKMIN_CASH_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'S',                /* 식별코드 : S             */
        transfer_gubun        VARCHAR2(2) := 'C2',               /* 송수신구분 은행송신:C2 수신:2C */
        bank_code             VARCHAR2(2) := '04',               /* 은행코드 : 04            */
        ente_code             VARCHAR2(8) ,                      /* 기관코드                 */
        dummy1                VARCHAR2(6) ,                      /* 예비                     */
        pay_date              VARCHAR2(6) ,                      /* 이체 처리일(YYMMDD)6자리 */        
        dummy2                VARCHAR2(6) ,                      /* 예비                     */
        out_account_pwd       VARCHAR2(8) ,                      /* 모계좌 비밀번호          */        
        out_account_no        VARCHAR2(14) ,                     /* 모계좌번호               */
        dummy3                VARCHAR2(26));                     /* 예비                     */
        
    TYPE FB_KUKMIN_CASH_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'D',                /* 식별코드 : D             */
        data_seq              VARCHAR2(5) ,                      /* 데이터 일련번호          */ 
        bank_code             VARCHAR2(2) ,                      /* 입금은행코드             */
        in_account_no         VARCHAR2(14) ,                     /* 입금계좌번호             */
        pay_amt               VARCHAR2(10) ,                     /* 이체요청금액             */
        result_yn             VARCHAR2(1) ,                      /* 처리결과 Y 혹은 N        */        
        result_code           VARCHAR2(4),                       /* 처리결과코드             */
        paid_amt              VARCHAR2(10) := '0000000000',      /* 실제이체금액:은행셋팅    */
        ente_use_field        VARCHAR2(10) ,                     /* 업체사용정보             */
        remark                VARCHAR2(8) ,                      /* 통장인자                 */
        dummy1                VARCHAR2(12) ,                     /* 예비                     */
        remark_gubun          VARCHAR2(1) ,                      /* 통장인자구분:은행과 협의 */
        dummy2                VARCHAR2(2) );                     /* 예비                     */
                
    TYPE FB_KUKMIN_CASH_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'E',                /* 식별코드 : E             */
        total_request_cnt     VARCHAR2(7) ,                      /* 총 의뢰건수              */
        total_request_amt     VARCHAR2(13) ,                     /* 총 의뢰금액              */
        success_cnt           VARCHAR2(7)  := '0000000',         /* 정상처리건수             */
        success_amt           VARCHAR2(13) := '0000000000000' ,  /* 정상처리금액             */
        fail_cnt              VARCHAR2(7)  := '0000000',         /* 불능처리건수             */
        fail_amt              VARCHAR2(13) := '0000000000000',   /* 불능처리금액             */
        sign_no               VARCHAR2(4) ,                      /* 복기부호                 */
        dummy                 VARCHAR2(8));                      /* 공란                     */    

    
    
    /******************************************************************************/
    /****                                                                      ****/
    /****                                                                      ****/
    /****           LG CNS VAN과 [우리은행]과 Batch처리를 위한 설정사항        ****/
    /****                                                                      ****/    
    /****                                                                      ****/
    /******************************************************************************/
    
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 현금 대량이체용 RECORD                                    */
    /*----------------------------------------------------------------------------*/               
    TYPE FB_WOORI_CASH_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'S',                /* 식별코드 : S             */
        transfer_gubun        VARCHAR2(2) := 'C2',               /* 송수신구분 은행송신:C2 수신:2C */
        ente_code             VARCHAR2(10) ,                     /* 업체코드                 */
        bank_code             VARCHAR2(2) := '20',               /* 은행코드 : 20            */
        transfer_date         VARCHAR2(6) ,                      /* 전송일자 YYMMDD          */
        pay_date              VARCHAR2(6) ,                      /* 이체 처리일(YYMMDD)6자리 */                
        out_account_no        VARCHAR2(14) ,                     /* 모계좌번호               */
        out_account_pwd       VARCHAR2(8) ,                      /* 모계좌 비밀번호          */        
        return_trx            VARCHAR2(1) ,                      /* 이체회수                 */
        info_gubun            VARCHAR2(1) := '1',                /* 통보구분 1:전체 2:불능 3:통보불필요 */
        dummy1                VARCHAR2(5) ,                      /* 재처리구분,거래점코드    */
        van                   VARCHAR2(6) := 'LGEDS',            /* VAN코드                  */
        dummy2                VARCHAR2(17));                     /* 공란                     */
                
    TYPE FB_WOORI_CASH_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'D',                /* 식별코드 : D             */
        bank_code             VARCHAR2(2) ,                      /* 입금은행코드             */
        in_account_no         VARCHAR2(15) ,                     /* 입금계좌번호             */
        trx_gubun             VARCHAR2(2) ,                      /* 입금이체 31:급여,32:상여,40:기타 , 출금은 별도 협의 */
        pay_amt               VARCHAR2(11) ,                     /* 이체요청금액             */                 
        pay_date              VARCHAR2(2) ,                      /* 이체일자 - 사용안함      */
        result_yn             VARCHAR2(1) ,                      /* 처리결과 Y(정상) N(불능) , Z(일부이체) */                
        result_code           VARCHAR2(4) ,                      /* 처리결과코드             */
        fail_amt              VARCHAR2(10) ,                     /* 미처리금액               */
        ente_use_field        VARCHAR2(24) ,                     /* 업체사용영역             */
        dummy                 VARCHAR2(8));                      /* 공란                     */
                
    TYPE FB_WOORI_CASH_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'E',                /* 식별코드 : E             */
        total_transfer_cnt    VARCHAR2(7) ,                      /* 총 전송건수 DATA건수+2   */
        total_request_cnt     VARCHAR2(7) ,                      /* 총 의뢰건수              */
        total_request_amt     VARCHAR2(13) ,                     /* 총 의뢰금액              */
        success_cnt           VARCHAR2(7)  := '0000000',         /* 정상처리건수             */
        success_amt           VARCHAR2(13) := '0000000000000' ,  /* 정상처리금액             */
        fail_cnt              VARCHAR2(7)  := '0000000',         /* 불능처리건수             */
        fail_amt              VARCHAR2(13) := '0000000000000',   /* 불능처리금액             */
        sign_no               VARCHAR2(6) ,                      /* 복기부호                 */
        dummy                 VARCHAR2(6));                      /* 공란                     */       
    


    /******************************************************************************/
    /****                                                                      ****/
    /****                                                                      ****/
    /****           LG CNS VAN과 [하나은행]과 Batch처리를 위한 설정사항        ****/
    /****                                                                      ****/    
    /****                                                                      ****/
    /******************************************************************************/
    
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 현금 대량이체용 RECORD                                    */
    /*----------------------------------------------------------------------------*/               
    TYPE FB_HANA_CASH_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'S',                /* 식별코드 : S             */
        upmu_gubun            VARCHAR2(2) := '10',               /* 업무구분 : 10            */
        bank_code             VARCHAR2(2) := '81',               /* 은행코드 : 81            */
        transfer_date         VARCHAR2(8) ,                      /* 데이터 전송일(YYYYMMDD)  */
        pay_date              VARCHAR2(6) ,                      /* 이체 처리일(YYMMDD)6자리 */
        out_account_no        VARCHAR2(14) ,                     /* 모계좌번호               */
        transfer_type         VARCHAR2(2),                       /* 이체종류                 */
        comp_no               VARCHAR2(6) := '000000',           /* 회사번호/업체는'0'셋팅   */
        result_gubun          VARCHAR2(1) := '1',                /* 처리결과통보구분 1:모든것 2:에러분 3:정상분 */
        transfer_seq          VARCHAR2(1) := '1',                /* 전송차수                 */
        out_account_pwd       VARCHAR2(8) ,                      /* 모계좌 비밀번호          */
        dummy                 VARCHAR2(20) ,                     /* 공란                     */
        format                VARCHAR2(1) := '1',                /* 포맷                     */
        van                   VARCHAR2(2) := 'LG');              /* VAN사 : LG               */
        
    TYPE FB_HANA_CASH_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'D',                /* 식별코드 : D             */
        data_seq              VARCHAR2(7) ,                      /* 데이터 일련번호          */ 
        bank_code             VARCHAR2(2) ,                      /* 입금은행코드             */
        in_account_no         VARCHAR2(14) ,                     /* 입금계좌번호             */
        pay_amt               VARCHAR2(11) ,                     /* 이체요청금액             */
        paid_amt              VARCHAR2(11) := '00000000000',     /* 실제이체금액:은행셋팅 */
        biz_ss_no             VARCHAR2(13) ,                     /* 주민/사업자번호          */
        result_yn             VARCHAR2(1) ,                      /* 처리결과 Y 혹은 N        */
        result_code           VARCHAR2(4) ,                      /* 불능코드                 */
        remark                VARCHAR2(12) ,                     /* 통장기장내역:협의사항    */
        dummy                 VARCHAR2(4));                      /* 공란                     */
        
    TYPE FB_HANA_CASH_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'E',                /* 식별코드 : E             */
        total_request_cnt     VARCHAR2(7) ,                      /* 총 의뢰건수              */
        total_request_amt     VARCHAR2(13) ,                     /* 총 의뢰금액              */
        success_cnt           VARCHAR2(7)  := '0000000',         /* 정상처리건수             */
        success_amt           VARCHAR2(13) := '0000000000000' ,  /* 정상처리금액             */
        fail_cnt              VARCHAR2(7)  := '0000000',         /* 불능처리건수             */
        fail_amt              VARCHAR2(13) := '0000000000000',   /* 불능처리금액             */
        sign_no               VARCHAR2(8) ,                      /* 복기부호                 */
        dummy                 VARCHAR2(11));                     /* 공란                     */
    

    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 구매카드용 RECORD                                         */
    /*----------------------------------------------------------------------------*/      
    
    TYPE FB_HANA_BILL_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'S',                /* 구분 : S                        */
        upmu_gubun            VARCHAR2(4) := 'R351',             /* 업무구분 : 구매카드 승인요청    */
        bill_ente_code        VARCHAR2(4) ,                      /* 하나은행이 부여한 업체고유코드  */
        service_gubun         VARCHAR2(1) := '1',                /* 서비스구분 1:구매  2:역구매     */
        approval_req_date     VARCHAR2(8) ,                      /* 승인요청일자                    */
        transfer_seq          VARCHAR2(1) := '1',                /* 전송차수                        */
        branch_no             VARCHAR2(3) := '001',              /* 사업장 번호                     */
        transfer_time         VARCHAR2(6) ,                      /* 전송시간 HHMMSS                 */
        test_gubun            VARCHAR2(1) := 'R',                /* R : REAL                        */
        biz_no                VARCHAR2(13) ,                     /* 사업자번호 : "999"+사업자번호   */
        dummy                 VARCHAR2(158) );                   /* 공란                            */
        
    TYPE FB_HANA_BILL_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'D',                /* 구분 : D                        */
        trade_seq             VARCHAR2(5) ,                      /* 거래번호:일자별 Sequence No     */
        transfer_date         VARCHAR2(8) ,                      /* 거래일자 : 전송일자             */
        card_no               VARCHAR2(16) ,                     /* 카드번호                        */
        member_no             VARCHAR2(11) ,                     /* 가맹점 번호                     */
        approval_amt          VARCHAR2(11) ,                     /* 승인금액                        */
        installment_period    VARCHAR2(3) ,                      /* 할부기간                        */
        unredeemed_fee_gubun  VARCHAR2(1) := '1' ,               /* 거치수수료 부담 1:카드 2:가맹점 */
        unredeemed_period     VARCHAR2(3) ,                      /* 대금입금거치기간                */
        installment_fee_gubun VARCHAR2(1) := '1' ,               /* 분할수수료 부담 1:카드 2:가맹점 */
        due_pay_date          VARCHAR2(8) ,                      /* 결제일자 : 보통 만기일          */
        remark                VARCHAR2(12) ,                     /* 비고, 업체별 별도 사용          */
        approval_no           VARCHAR2(10) ,                     /* 승인번호                        */
        result_code           VARCHAR2(4) ,                      /* 에러코드                        */
        member_fee            VARCHAR2(9) ,                      /* 가맹점 부담 수수료              */
        member_total_amt      VARCHAR2(11) ,                     /* 가맹점 입금 총액                */
        bill_discount_date    VARCHAR2(8) ,                      /* 최초입금시작일자 : 할인가능일   */
        bill_date             VARCHAR2(8) ,                      /* 세금계산서 일자                 */
        description           VARCHAR2(15) ,                     /* 적요                            */
        dummy                 VARCHAR2(44));                     /* 공란                            */
        
    TYPE FB_HANA_BILL_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'E',                /* 구분 : E                        */
        record_cnt            VARCHAR2(5) ,                      /* 레코드 갯수 :HEAD & TAIL 포함   */
        approval_req_cnt      VARCHAR2(5) ,                      /* 승인요청자료 갯수               */        
        approval_req_amt      VARCHAR2(15) ,                     /* 승인요청금액                    */
        success_cnt           VARCHAR2(5) ,                      /* 정상승인건수                    */
        success_amt           VARCHAR2(15) ,                     /* 정상승인금액                    */
        member_total_fee      VARCHAR2(15) ,                     /* 가맹점 부담 총 수수료           */
        member_total_amt      VARCHAR2(15) ,                     /* 가맹점 입금 총액                */
        fail_cnt              VARCHAR2(5) ,                      /* 승인에러건수                    */
        fail_amt              VARCHAR2(15) ,                     /* 승인에러금액                    */
        sign_no               VARCHAR2(11) ,                     /* 복기부호                        */
        dummy                 VARCHAR2(93));                     /* 공란                            */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 구매카드 거래선 정보용 RECORD                             */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_HANA_SUPPLIER_HEAD_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'S',                /* 구분 : S                        */
        seq                   VARCHAR2(5) ,                      /* 일련번호                        */
        bill_ente_code        VARCHAR2(4) ,                      /* 업체코드                        */
        upmu_gubun            VARCHAR2(4) := 'R390',             /* 업무구분 : 구매카드/가맹점정보  */
        service_gubun         VARCHAR2(1) ,                      /* 서비스구분 1:구매 2:역구매      */
        trade_date            VARCHAR2(8) ,                      /* 거래일자                        */
        transfer_seq          VARCHAR2(1) ,                      /* 전송차수                        */
        branch_no             VARCHAR2(3) ,                      /* 사업장 번호                     */
        dummy                 VARCHAR2(473));                    /* 공란                            */
        
    TYPE FB_HANA_SUPPLIER_DATA_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'D' ,               /* 구분 : D                        */
        seq                   VARCHAR2(5) ,                      /* 일자별 Sequence No              */
        bill_ente_code        VARCHAR2(4) ,                      /* 하나은행이 부여한 업체코드      */
        ente_name             VARCHAR2(32),                      /* 하나은행이 부여한 업체명        */
        service_gubun         VARCHAR2(1) ,                      /* 서비스구분 1:구매 , 2:역구매    */
        memeber_gubun         VARCHAR2(1) ,                      /* 회원구분  1:카드 , 2:가맹점     */
        card_member_no        VARCHAR2(16) ,                     /* 카드/가맹점 번호                */
        memeber_kor_name      VARCHAR2(32) ,                     /* 회원한글명                      */
        info_gubun            VARCHAR2(1) ,                      /* 이동구분 0:정상  9:해지         */
        new_issue_date        VARCHAR2(8) ,                      /* 신규일자                        */
        cancel_date           VARCHAR2(8) ,                      /* 해지/취소일자                   */
        member_tel_no         VARCHAR2(19) ,                     /* 회원 전화번호                   */
        home_zip_code         VARCHAR2(6) ,                      /* 자택/가맹점 우편번호            */
        home_addr1            VARCHAR2(42) ,                     /* 자택/가맹점 주소1               */
        home_sub_addr         VARCHAR2(82) ,                     /* 자택/가맹점 부속 주소           */
        home_tel_1            VARCHAR2(19) ,                     /* 자택/가맹점 전화번호 1          */
        home_tel_2            VARCHAR2(14) ,                     /* 자택/가맹점 전화번호 2          */
        home_mng_division     VARCHAR2(22) ,                     /* 자택/가맹점 관리부서            */
        comp_zip_code         VARCHAR2(6) ,                      /* 회사/가맹점 우편번호            */
        comp_addr1            VARCHAR2(42) ,                     /* 회사/가맹점 주소1               */
        comp_sub_addr         VARCHAR2(82) ,                     /* 회사/가맹점 부속 주소           */
        comp_tel_no           VARCHAR2(19) ,                     /* 회사 전화번호                   */
        biz_ss_no             VARCHAR2(13) ,                     /* 주민(사업자) 번호               */
        mng_no                VARCHAR2(12) ,                     /* 관리번호                        */
        bank_code             VARCHAR2(2) ,                      /* 은행코드 : 81                   */
        dummy                 VARCHAR2(11));                     /* 공란                            */
        
    TYPE FB_HANA_SUPPLIER_TAIL_RECORD IS RECORD (
        record_gubun          VARCHAR2(1) := 'E' ,               /* 구분 : E                        */
        seq                   VARCHAR2(5) ,                      /* 일련번호 : 99999                */
        bill_ente_code        VARCHAR2(4) ,                      /* 업체 고유 코드                  */
        record_cnt            VARCHAR2(5) ,                      /* 레코드갯수, DATA RECORD 총 갯수 */
        memeber_person_cnt    VARCHAR2(5) ,                      /* 카드회원정보 건수               */
        memeber_biz_cnt       VARCHAR2(5) ,                      /* 가맹점 회원정보 건수            */
        dummy                 VARCHAR2(475));                    /* 공란                            */    
         
    


    /******************************************************************************/
    /****                                                                      ****/    
    /****                                                                      ****/
    /****       LG CNS VAN과 [ REALTIME 송수신 ] 전문에 대한 설정              ****/
    /****                                                                      ****/
    /****                                                                      ****/        
    /******************************************************************************/

    
    
    /*----------------------------------------------------------------------------*/
    /* 은행코드                                                                   */
    /*----------------------------------------------------------------------------*/    
    KIUP_BANK_CD                   VARCHAR2(2) := '03';   -- 기업은행 
    KUKMIN_BANK_CD                 VARCHAR2(2) := '04';   -- 국민은행     
    WOORI_BANK_CD                  VARCHAR2(2) := '20';   -- 우리은행     
    HANA_BANK_CD                   VARCHAR2(2) := '81';   -- 하나은행        

    /*----------------------------------------------------------------------------*/    
    /* 이체나, 전자어음 realtime처리시 최대 대기시간 지정 (단위:초)               */
    /*----------------------------------------------------------------------------*/    
    DEFAULT_TIMEOUT NUMBER(10)   := 60;        
    
    /*----------------------------------------------------------------------------*/    
    /* 기타 상수 선언                                                             */
    /*----------------------------------------------------------------------------*/    
    CRLF                VARCHAR2(2)  := CHR(10)||CHR(13);          

    -- OS상의 DIRECTORY PATH를 알기위한 ORACLE의 DIRECTORY NAME 
    FBS_REALTIME_SEND_DIR    VARCHAR2(100) := 'FBS_REALTIME_SEND_DIR';      -- 실시간 처리 전문파일 송신폴더  
    FBS_REALTIME_TEMP_DIR    VARCHAR2(100) := 'FBS_REALTIME_TEMP_DIR';      -- 실시간 처리 전문파일 임시폴더       
    
   
    
    /*----------------------------------------------------------------------------*/
    /*   실시간 펌뱅킹 전문번호 DEFINE                                            */
    /*----------------------------------------------------------------------------*/         
    FB_DOCU_OPEN_T          VARCHAR2(7) := '0810100'; /*  개시전문        (업체=>은행)  */          
    FB_DOCU_OPEN_B          VARCHAR2(7) := '0800100'; /*  개시전문        (은행=>업체)  */          

    FB_DOCU_DEPO_TR_T       VARCHAR2(7) := '0210300'; /*  예금거래명세통지(업체=>은행)  */          
    FB_DOCU_DEPO_TR_B       VARCHAR2(7) := '0200300'; /*  예금거래명세통지(은행=>업체)  */          
                                                                             
    FB_DOCU_DEPO_MISS_T     VARCHAR2(7) := '0200600'; /*  예금거래결번    (업체=>은행)  */          
    FB_DOCU_DEPO_MISS_B     VARCHAR2(7) := '0210600'; /*  예금거래결번    (은행=>업체)  */          
                                               
    FB_DOCU_VIRT_TR_T       VARCHAR2(7) := '0210100'; /*  가상계좌거래명세(업체=>은행)  */                                               
    FB_DOCU_VIRT_TR_B       VARCHAR2(7) := '0200100'; /*  가상계좌거래명세(은행=>업체)  */
    
    FB_DOCU_VIRT_MISS_T     VARCHAR2(7) := '0200200'; /*  가상계좌결번요청(업체=>은행)  */
    FB_DOCU_VIRT_MISS_B     VARCHAR2(7) := '0210200'; /*  가상계좌결번요청(은행=>업체)  */
                                                                             
    FB_DOCU_DATR_T          VARCHAR2(7) := '0100100'; /*  당행이체        (업체=>은행)  */          
    FB_DOCU_DATR_B          VARCHAR2(7) := '0110100'; /*  당행이체        (은행=>업체)  */          
                                                                             
    FB_DOCU_TATR_T          VARCHAR2(7) := '0100200'; /*  타행이체        (업체=>은행)  */          
    FB_DOCU_TATR_B          VARCHAR2(7) := '0110200'; /*  타행이체        (은행=>업체)  */          
                                                                             
    FB_DOCU_TR_RE_T         VARCHAR2(7) := '0600100'; /*  이체처리결과조회(업체=>은행)  */          
    FB_DOCU_TR_RE_B         VARCHAR2(7) := '0610100'; /*  이체처리결과조회(은행=>업체)  */          
                                                                             
    FB_DOCU_REMAIN_T        VARCHAR2(7) := '0600300'; /*  잔액조회        (업체=>은행)  */          
    FB_DOCU_REMAIN_B        VARCHAR2(7) := '0610300'; /*  잔액조회        (은행=>업체)  */          
                                                                             
    FB_DOCU_SUM_T           VARCHAR2(7) := '0700100'; /*  집계처리        (업체=>은행)  */          
    FB_DOCU_SUM_B           VARCHAR2(7) := '0710000'; /*  집계처리        (은행=>업체)  */          
                                                                             
    FB_DOCU_TATR_RE_T       VARCHAR2(7) := '0410100'; /*  타행이체결과통지(업체=>은행)  */          
    FB_DOCU_TATR_RE_B       VARCHAR2(7) := '0400100'; /*  타행이체결과통지(은행=>업체)  */          

    FB_DOCU_NAME_CHECK_T    VARCHAR2(7) := '0400400'; /*  수취인 성명조회 (업체=>은행)  */          
    FB_DOCU_NAME_CHECK_B    VARCHAR2(7) := '0410400'; /*  수취인 성명조회 (은행=>업체)  */  
                                                                             
    FB_DOCU_BILL_ISSUE_T    VARCHAR2(7) := '0100310'; /*  어음지불        (업체=>은행)  */
    FB_DOCU_BILL_ISSUE_B    VARCHAR2(7) := '0110310'; /*  어음지불        (은행=>업체)  */
    
    FB_DOCU_VENDOR_T        VARCHAR2(7) := '0110320'; /*  어음거래선정보  (업체=>은행)  */
    FB_DOCU_VENDOR_B        VARCHAR2(7) := '0100320'; /*  어음거래선정보  (은행=>업체)  */
    
    FB_DOCU_BILL_TRX_T      VARCHAR2(7) := '0210400'; /*  어음거래명세     (업체=>은행) */
    FB_DOCU_BILL_TRX_B      VARCHAR2(7) := '0200400'; /*  어음거래명세     (은행=>업체) */
    
    FB_DOCU_BILL_MISS_T     VARCHAR2(7) := '0200500'; /*  어음명세결번요청 (업체=>은행) */
    FB_DOCU_BILL_MISS_B     VARCHAR2(7) := '0210500'; /*  어음명세결번요청 (은행=>업체) */
          

    
    
    
    
    
    
    
    
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 실시간 펌뱅킹 송신테이블 RECORD                           */
    /*----------------------------------------------------------------------------*/               
    TYPE FB_VAN_SEND_RECORD IS RECORD (
        tran_code             VARCHAR2(9),         /* 식별코드                  */
        ente_code             VARCHAR2(8),         /* 업체코드                  */
        bank_code             VARCHAR2(2),         /* 은행코드                  */
        docu_code             VARCHAR2(4),         /* 전문코드                  */
        upmu_code             VARCHAR2(3),         /* 업무코드                  */
        send_cont             VARCHAR2(1),         /* 송신횟수                  */
        docu_numc             VARCHAR2(6),         /* 전문번호                  */
        send_date             VARCHAR2(8),         /* 전송일자                  */
        send_time             VARCHAR2(6),         /* 전송시간                  */
        resp_code             VARCHAR2(4),         /* 응답코드                  */
        gaeb_area             VARCHAR2(200),       /* 개별부 영역               */
        resp_yebu             VARCHAR2(1));        /* 응답여부                  */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 실시간 펌뱅킹 수신테이블 RECORD                           */
    /*----------------------------------------------------------------------------*/               
    TYPE FB_VAN_RECV_RECORD IS RECORD (
        tran_code             VARCHAR2(9),         /* 식별코드                  */
        ente_code             VARCHAR2(8),         /* 업체코드                  */
        bank_code             VARCHAR2(2),         /* 은행코드                  */
        docu_code             VARCHAR2(4),         /* 전문코드                  */
        upmu_code             VARCHAR2(3),         /* 업무코드                  */
        send_cont             VARCHAR2(1),         /* 송신횟수                  */
        docu_numc             VARCHAR2(6),         /* 전문번호                  */
        send_date             VARCHAR2(8),         /* 전송일자                  */
        send_time             VARCHAR2(6),         /* 전송시간                  */
        resp_code             VARCHAR2(4),         /* 응답코드                  */
        gaeb_area             VARCHAR2(200),       /* 개별부 영역               */
        resp_yebu             VARCHAR2(1));        /* 응답여부                  */            
      
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 예금거래명세통지(0200300) 개별부 전문                     */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_DEPO_TR_RECORD IS RECORD (
        account_no             VARCHAR2(15),     /* 입금계좌번호               */
        trade_gb               VARCHAR2(2),      /* 거래구분                   */
        bank_cd                VARCHAR2(2),      /* 거래발행은행코드           */
        trade_amt              VARCHAR2(13),     /* 거래금액                   */
        remain_amt             VARCHAR2(13),     /* 거래 후, 잔액              */
        giro_cd                VARCHAR2(6),      /* 지로코드                   */
        depo_nm                VARCHAR2(16),     /* 입금인 성명                */
        check_no               VARCHAR2(10),     /* 어음 및 수표번호           */
        cms                    VARCHAR2(16),     /* CMS코드(거래처코드)        */
        trade_dt               VARCHAR2(8),      /* 거래일자                   */
        trade_time             VARCHAR2(6),      /* 거래시간                   */
        cash_amt               VARCHAR2(13),     /* 현금                       */
        check_amt              VARCHAR2(13),     /* 가계수표                   */
        ta_check_amt           VARCHAR2(13),     /* 교환후, 인출가능금액       */
        trade_no               VARCHAR2(6),      /* 거래시 일련번호 추가       */
        cancel_trade_no        VARCHAR2(6),      /* 취소시 인련번호 추가       */
        cancel_trade_dt        VARCHAR2(8),      /* 취소시 거래일자 추가       */
        remain_sign            VARCHAR2(1),      /* 예비부(잔액부호)           */     
        loan_yn                VARCHAR2(1),      /* 예비비(집단대출여부)(예비) */  
        dong_ho                VARCHAR2(8),      /* 예비(동호)                 */         
        dummy                  VARCHAR2(24));    /* DUMMY SPACE 24개           */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 예금거래명세결번요구통지(0200600) 개별부 전문             */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_DEPO_MISS_RECORD IS RECORD (        
        account_no             VARCHAR2(15),     /* 입금계좌번호               */
        trade_gb               VARCHAR2(2),      /* 거래구분                   */
        bank_cd                VARCHAR2(2),      /* 거래발행은행코드           */
        trade_amt              VARCHAR2(13),     /* 거래금액                   */
        remain_amt             VARCHAR2(13),     /* 거래 후, 잔액              */
        giro_cd                VARCHAR2(6),      /* 지로코드                   */
        depo_nm                VARCHAR2(16),     /* 입금인 성명                */
        check_no               VARCHAR2(10),     /* 어음 및 수표번호           */
        cms                    VARCHAR2(16),     /* CMS코드(거래처코드)        */
        trade_dt               VARCHAR2(8),      /* 거래일자                   */
        trade_time             VARCHAR2(6),      /* 거래시간                   */
        cash_amt               VARCHAR2(13),     /* 현금                       */
        check_amt              VARCHAR2(13),     /* 가계수표                   */
        ta_check_amt           VARCHAR2(13),     /* 교환후, 인출가능금액       */
        org_docu_numc          VARCHAR2(6),      /* 원거래전문번호 추가        */
        trade_no               VARCHAR2(6),      /* 거래시 일련번호 추가       */
        cancel_trade_no        VARCHAR2(6),      /* 취소시 인련번호 추가       */
        cancel_trade_dt        VARCHAR2(8),      /* 취소시 거래일자 추가       */
        remain_sign            VARCHAR2(1),      /* 예비부(잔액부호)           */  
        loan_yn                VARCHAR2(1),      /* 예비비(집단대출여부)       */    
        dong_ho                VARCHAR2(8),      /* 예비(동호)                 */                          
        dummy                  VARCHAR2(18));    /* DUMMY SPACE 18개           */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 당행이체(0100100) / 타행이체(0100200) 개별부 전문         */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_TR_RECORD IS RECORD (  
        out_account_no         VARCHAR2(15),     /* 지급계좌                   */
        account_pw             VARCHAR2(8),      /* 통장비번(4)+이체비번(4)    */
        sign_no                VARCHAR2(6),      /* 복기부호                   */
        trade_amt              VARCHAR2(13),     /* 출금금액                   */
        remain_sign            VARCHAR2(1),      /* 출금 후, 잔액부호          */
        remain_amt             VARCHAR2(13),     /* 원장 잔액                  */
        in_bank_cd             VARCHAR2(2),      /* 입금은행코드               */
        in_account_no          VARCHAR2(15),     /* 입금계좌                   */
        commission             VARCHAR2(13),     /* 이체수수료                 */
        cms                    VARCHAR2(16),     /* CMS코드(거래처코드)        */
        depo_nm                VARCHAR2(22),     /* 입금인 성명(사용안함)      */
        remark                 VARCHAR2(14),     /* 입금인 통장적요(사용)      */
        dummy                  VARCHAR2(72));    /* DUMMY SPACE 72개           */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 이체처리결과조회(0600100,0600200) 개별부 전문             */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_TR_RE_RECORD IS RECORD (     
        docu_numc              VARCHAR2(6),      /* 전문번호                   */
        out_account_no         VARCHAR2(15),     /* 지급계좌번호               */
        in_account_no          VARCHAR2(15),     /* 입금계좌번호               */
        trade_amt              VARCHAR2(13),     /* 금액                       */
        commission             VARCHAR2(13),     /* 수수료                     */
        sub_seq_no             VARCHAR2(4),      /* SUB SEQ NO                 */
        trade_date             VARCHAR2(8),      /* 이체일자                   */
        trade_time             VARCHAR2(6),      /* 이체시간                   */
        result_cd              VARCHAR2(4),      /* 처리결과                   */
        in_bank_cd             VARCHAR2(2),      /* 입금은행코드               */
        dummy                  VARCHAR2(111));   /* DUMMY SPOACE 111개         */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 잔액조회(0600300) 개별부 전문                             */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_REMAIN_RECORD IS RECORD (                     
        account_no             VARCHAR2(15),     /* 계좌번호                   */
        remain_sign            VARCHAR2(1),      /* 부호                       */
        remain_amt             VARCHAR2(13),     /* 현재잔액                   */
        out_enable_amt         VARCHAR2(13),     /* 지급가능금액               */
        account_pw             VARCHAR2(4),      /* 비밀번호                   */
        dummy                  VARCHAR2(154));   /* DUMMY SPACE 154개          */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 집계처리(0700100) 개별부 전문                             */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_SUM_RECORD IS RECORD (          
        da_account_no          VARCHAR2(15),     /* 당행 출금계좌번호          */
        da_req_cnt             VARCHAR2(5),      /* 당행 의뢰 총 건수          */
        da_req_amt             VARCHAR2(13),     /* 당행 의뢰 총 금액          */
        da_normal_cnt          VARCHAR2(5),      /* 당행 정상 건수             */
        da_normal_amt          VARCHAR2(13),     /* 당행 정상 금액             */
        da_fail_cnt            VARCHAR2(5),      /* 당행 불능 건수             */
        da_fail_amt            VARCHAR2(13),     /* 당행 불능 금액             */
        da_commission          VARCHAR2(9),      /* 당행 수수료                */
        ta_req_cnt             VARCHAR2(5),      /* 타행 의뢰 총 건수          */
        ta_req_amt             VARCHAR2(13),     /* 타행 의뢰 총 금액          */
        ta_normal_cnt          VARCHAR2(5),      /* 타행 정상 건수             */
        ta_normal_amt          VARCHAR2(13),     /* 타행 정상 금액             */
        ta_fail_cnt            VARCHAR2(5),      /* 타행 불능 건수             */
        ta_fail_amt            VARCHAR2(13),     /* 타행 불능 금액             */
        ta_commission          VARCHAR2(9),      /* 타행 수수료                */
        dummy                  VARCHAR2(59));    /* DUMMY SPACE 59개           */           
         
         
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 가상계좌(0200100) / 가상계좌결번(2000200) 개별부 전문     */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_REAL_VIRTUAL_RECORD IS RECORD (          
        account_no             VARCHAR2(15),     /* 입금계좌번호               */
        trade_gb               VARCHAR2(2),      /* 거래구분                   */
        bank_cd                VARCHAR2(2),      /* 거래발행은행코드           */
        trade_amt              VARCHAR2(13),     /* 거래금액                   */
        remain_amt             VARCHAR2(13),     /* 거래 후, 잔액              */
        giro_cd                VARCHAR2(6),      /* 지로코드                   */
        depo_nm                VARCHAR2(16),     /* 입금인 성명                */
        check_no               VARCHAR2(10),     /* 어음 및 수표번호           */
        cms                    VARCHAR2(16),     /* CMS코드(거래처코드)        */
        trade_dt               VARCHAR2(8),      /* 거래일자                   */
        trade_time             VARCHAR2(6),      /* 거래시간                   */
        cash_amt               VARCHAR2(13),     /* 현금                       */
        check_amt              VARCHAR2(13),     /* 가계수표                   */
        ta_check_amt           VARCHAR2(13),     /* 타점권                     */
        trade_no               VARCHAR2(6),      /* 거래시 일련번호 추가       */
        cancel_trade_no        VARCHAR2(6),      /* 취소시 인련번호 추가       */
        cancel_trade_dt        VARCHAR2(8),      /* 취소시 거래일자 추가       */
        remain_sign            VARCHAR2(1),      /* 잔액부호                   */
        jumin_no               VARCHAR2(13),     /* 주민번호                   */
        loan_yn                VARCHAR2(1),      /* 예비비(집단대출여부)       */        
        dummy                  VARCHAR2(19));    /* DUMMY SPACE 19개           */      
         
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 수취인성명조회(0400400/0410400) 개별부 전문               */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_NAME_CHECK_RECORD IS RECORD (                     
        bank_code              VARCHAR2(2),      /* 은행코드                   */
        account_num            VARCHAR2(15),     /* 계좌번호                   */
        ssn                    VARCHAR2(14),     /* 주민번호                   */
        account_name           VARCHAR2(14),     /* 예금주명                   */
        dummy                  VARCHAR2(155));   /* DUMMY SPACE 155개          */         

    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 어음거래명세(0200400/0210400) 개별부 전문                 */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_BILL_TRX_RECORD IS RECORD (
        trade_gb               VARCHAR2(2),      /* 거래구분                   */
        account_no             VARCHAR2(15),     /* 계좌번호                   */
        trade_dt               VARCHAR2(8),      /* 거래일자                   */
        trade_time             VARCHAR2(6),      /* 거래시간                   */
        bill_no                VARCHAR2(10),     /* 어음번호                   */
        trade_amt              VARCHAR2(13),     /* 금액                       */
        issue_name             VARCHAR2(14),     /* 발행인                     */
        pay_due_dt             VARCHAR2(8),      /* 만기일                     */
        pay_bank_cd            VARCHAR2(16),     /* 만기시 지급은행            */
        cms                    VARCHAR2(16),     /* CMS코드                    */
        item_change_cd         VARCHAR2(3),      /* 항목변경코드               */
        remain_amt             VARCHAR2(13),     /* 잔액                       */
        giro_cd                VARCHAR2(6),      /* 지로코드                   */
        org_docu_numc          VARCHAR2(6),      /* 원거래전문번호             */
        trade_no               VARCHAR2(6),      /* 거래일련번호               */
        cancel_trade_no        VARCHAR2(6),      /* 취소시 인련번호 추가       */
        cancel_trade_dt        VARCHAR2(8),      /* 취소시 거래일자 추가       */
        dummy                  VARCHAR2(44));    /* DUMMY SPACE 44개           */        
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 어음거래명세결번요구(0200500/0210500) 개별부 전문         */
    /*----------------------------------------------------------------------------*/           
    TYPE FB_BILL_MISS_RECORD IS RECORD (
        trade_gb               VARCHAR2(2),      /* 거래구분                   */
        account_no             VARCHAR2(15),     /* 계좌번호                   */
        trade_dt               VARCHAR2(8),      /* 거래일자                   */
        trade_time             VARCHAR2(6),      /* 거래시간                   */
        bill_no                VARCHAR2(10),     /* 어음번호                   */
        trade_amt              VARCHAR2(13),     /* 금액                       */
        issue_name             VARCHAR2(14),     /* 발행인                     */
        future_pay_due_dt      VARCHAR2(8),      /* 만기일                     */
        future_pay_bank_cd     VARCHAR2(16),     /* 만기시 지급은행            */
        cms                    VARCHAR2(16),     /* CMS코드                    */
        item_change_cd         VARCHAR2(3),      /* 항목변경코드               */
        remain_amt             VARCHAR2(13),     /* 잔액                       */
        giro_cd                VARCHAR2(6),      /* 지로코드                   */
        org_docu_numc          VARCHAR2(6),      /* 원거래전문번호             */
        trade_no               VARCHAR2(6),      /* 거래일련번호               */
        cancel_trade_no        VARCHAR2(6),      /* 취소시 인련번호 추가       */
        cancel_trade_dt        VARCHAR2(8),      /* 취소시 거래일자 추가       */
        dummy                  VARCHAR2(44));    /* DUMMY SPACE 44개           */               
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 어음지불자료(0100310/0110310) 개별부 전문                 */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_BILL_ISSUE_RECORD IS RECORD (
        transfer_dt            VARCHAR2(8),      /* 전송일자                   */            
        transfer_gb            VARCHAR2(2),      /* 전송구분                   */                 
        pay_confirm_gb         VARCHAR2(1),      /* 결제구분                   */
        biz_no                 VARCHAR2(10),     /* 사업자번호                 */
        docu_no                VARCHAR2(14),     /* 문서번호                   */
        trade_gb               VARCHAR2(2),      /* 거래구분                   */                         
        future_pay_due_dt      VARCHAR2(8),      /* 만기일자                   */
        bank_cd                VARCHAR2(2),      /* 은행코드                   */
        account_no             VARCHAR2(15),     /* 계좌번호                   */
        pay_amt                VARCHAR2(13),     /* 처리금액                   */
        bank_client_no         VARCHAR2(10),     /* 은행고객번호               */
        vendor_name            VARCHAR2(20),     /* 지급지명                   */
        result_gb              VARCHAR2(2),      /* 결과구분                   */
        company_etc            VARCHAR2(20),     /* 회사임의정보               */
        dummy                  VARCHAR2(72));    /* DUMMY SPACE 72개           */
        
    /*----------------------------------------------------------------------------*/
    /*   REC   NAME   : 거래처정보(0100320/0110320) 개별부 전문                   */
    /*----------------------------------------------------------------------------*/          
    TYPE FB_VENDOR_RECORD IS RECORD (
        transfer_dt            VARCHAR2(8),      /* 전송일자                   */            
        transfer_gb            VARCHAR2(2),      /* 전송구분                   */              
        bank_client_no         VARCHAR2(10),     /* 은행고객번호               */
        gb                     VARCHAR2(2),      /* 구분                       */
        current_biz_no         VARCHAR2(10),     /* 현 사업자 번호             */
        previous_biz_no        VARCHAR2(10),     /* 구 사업자 번호             */
        president_name         VARCHAR2(10),     /* 대표자명                   */
        biz_name               VARCHAR2(40),     /* 법인명                     */
        address                VARCHAR2(59),     /* 주소                       */
        dummy                  VARCHAR2(50));    /* DUMMY SPACE 50개           */
        
        
        
        
        
    /******************************************************************************/
    /*  기능 : 매일아침 정해진시간에 등록된 은행별로 개시전문을 송신합니다.       */
    /******************************************************************************/
    FUNCTION send_start_document( p_comp_code     IN VARCHAR2 ,       -- 사업장 코드
                                  p_bank_code     IN VARCHAR2 ,       -- 은행코드
                                  p_resp_code     OUT VARCHAR2,       -- 응답코드
                                  p_resp_msg      OUT VARCHAR2 )      -- 응답코드명                                   
        RETURN VARCHAR2;                                              -- 함수 처리결과 메시지         
        
        
    /******************************************************************************/
    /*  기능 : 매일아침 정해진시간에 FBS시스템에 대한 상태점검메일을 발송         */
    /******************************************************************************/        
    FUNCTION send_fbs_status_mail( p_recv_list  IN VARCHAR2 DEFAULT NULL )   -- 추가적인 메일수신자 
        RETURN VARCHAR2;                                                     -- 함수 처리결과 메시지            
        

    /******************************************************************************/
    /*  기능 : 이체처리집계요청 처리결과                                          */
    /******************************************************************************/ 
    PROCEDURE retieve_pay_summation( p_bank_code       IN VARCHAR2 ,       -- 은행코드
                                     p_acct_number     IN VARCHAR2 ,       -- 계좌번호 
                                     p_da_req_cnt      OUT NUMBER ,        -- 당행 요청 건수 
                                     p_da_req_amt      OUT NUMBER ,        -- 당행 요청 금액 
                                     p_da_success_cnt  OUT NUMBER ,        -- 당행 정상처리 건수 
                                     p_da_success_amt  OUT NUMBER ,        -- 당행 정상처리 금액 
                                     p_da_commission   OUT NUMBER ,        -- 당행 수수료 
                                     p_ta_req_cnt      OUT NUMBER ,        -- 타행 요청 건수 
                                     p_ta_req_amt      OUT NUMBER ,        -- 타행 요청 금액 
                                     p_ta_success_cnt  OUT NUMBER ,        -- 타행 정상처리 건수 
                                     p_ta_success_amt  OUT NUMBER ,        -- 타행 정상처리 금액 
                                     p_ta_commission   OUT NUMBER ,        -- 타행 수수료 
                                     p_resp_code       OUT VARCHAR2,       -- 응답코드
                                     p_resp_msg        OUT VARCHAR2 ) ;    -- 응답코드명         
                                     
                                     
    /******************************************************************************/
    /*  기능 : 1개 계좌에 대한 잔액조회                                           */
    /******************************************************************************/
    FUNCTION retieve_acct_remains( p_bank_code     IN VARCHAR2 ,       -- 은행코드
                                   p_acct_number   IN VARCHAR2 ,       -- 계좌번호 
                                   p_remain_amt    OUT NUMBER  ,       -- 계좌잔액 
                                   p_enable_amt    OUT NUMBER  ,       -- 출금가능액 
                                   p_resp_code     OUT VARCHAR2,       -- 응답코드
                                   p_resp_msg      OUT VARCHAR2 )      -- 응답코드명 
        RETURN VARCHAR2;                                               -- 함수 처리결과 메시지         
        
        
    /******************************************************************************/
    /*  기능 : 현금이체 담당자 획인 및 취소처리 로직                              */
    /******************************************************************************/        
    FUNCTION cash_pay_window_check( p_pay_seq     IN NUMBER ,          -- 지급일련번호   
                                    p_job_gubun   IN VARCHAR2 ,        -- 처리구분 [ CHECK:확인 , CANCEL:확인취소 ]   
                                    p_emp_no      IN VARCHAR2 )        -- 사번   
        RETURN VARCHAR2;                                               -- 함수 처리결과 메시지   
        
        
    /******************************************************************************/
    /*  기능 : 현금이체파일 생성                                                  */
    /******************************************************************************/        
    FUNCTION create_cash_edi_file( p_comp_code         IN VARCHAR2 ,        -- 사업장코드  
                                   p_bank_code         IN VARCHAR2 ,        -- 은행코드 
                                   p_row_cnt           IN NUMBER ,          -- 처리할 행의 갯수 (체크용) 
                                   p_emp_no            IN VARCHAR2 ,        -- 사번   
                                   p_edi_history_seq   OUT NUMBER )         -- EDI생성_송수신HISTORY일련번호 (실패한 경우, NULL)    
        RETURN VARCHAR2;                                                    -- 함수 처리결과 메시지           
        

    /******************************************************************************/
    /*  기능 : 전자어음파일 생성                                                  */
    /******************************************************************************/        
    FUNCTION create_bill_edi_file(  p_comp_code         IN VARCHAR2 ,        -- 사업장코드  
                                    p_bank_code         IN VARCHAR2 ,        -- 은행코드 
                                    p_row_cnt           IN NUMBER ,          -- 처리할 행의 갯수 (체크용) 
                                    p_emp_no            IN VARCHAR2 ,        -- 사번   
                                    p_edi_history_seq   OUT NUMBER )         -- EDI생성_송수신HISTORY일련번호 (실패한 경우, NULL)    
        RETURN VARCHAR2;                                                     -- 함수 처리결과 메시지              
        

    /******************************************************************************/
    /*  기능 : 분할건별 현금이체 지급                                             */
    /******************************************************************************/        
    FUNCTION send_cash_each_transfer( p_pay_seq         IN NUMBER ,        -- 지급일련번호
                                      p_div_seq         IN NUMBER ,        -- 분할일련번호  
                                      p_emp_no          IN VARCHAR2 ,      -- 사번   
                                      p_resp_code       OUT VARCHAR2,      -- 응답코드
                                      p_resp_msg        OUT VARCHAR2 )     -- 응답코드명  
        RETURN VARCHAR2;                                                   -- 함수 처리결과 메시지             
        
        
    /******************************************************************************/
    /*  기능 : 지급건별 현금이체 지급                                             */
    /******************************************************************************/        
    FUNCTION send_cash_transfer( p_pay_seq         IN NUMBER ,        -- 지급일련번호
                                 p_emp_no          IN VARCHAR2 )      -- 사번   
        RETURN VARCHAR2;                                              -- 함수 처리결과 메시지               
        
        
    /******************************************************************************/
    /*  기능 : 지급건별 전자어음 realtime 송신                                    */
    /******************************************************************************/        
    FUNCTION send_bill_transfer( p_pay_seq         IN NUMBER ,        -- 지급일련번호
                                 p_emp_no          IN VARCHAR2 )      -- 사번   
        RETURN VARCHAR2;                                              -- 함수 처리결과 메시지             
        
    /******************************************************************************/
    /*  기능 : 예금주명 조회                                                      */
    /******************************************************************************/
    FUNCTION retieve_acct_holder_name( p_bank_code     IN VARCHAR2 ,       -- 은행코드
                                       p_acct_number   IN VARCHAR2 ,       -- 계좌번호 
                                       p_holder_name   OUT VARCHAR2 ,      -- 예금주명 
                                       p_resp_code     OUT VARCHAR2,       -- 응답코드
                                       p_resp_msg      OUT VARCHAR2 )      -- 응답코드명 
        RETURN VARCHAR2;                                                   -- 함수 처리결과 메시지           
        
        
    /******************************************************************************/
    /*  기능 : 전자어음 거래선정보 수신 처리                                      */
    /******************************************************************************/        
    FUNCTION read_bill_vendor_info( p_edi_history_seq  IN NUMBER )            -- EDI송수신이력 일련번호 
        RETURN VARCHAR2;                                                      -- 함수 처리결과 메시지     

                
    /******************************************************************************/
    /*  기능 : 전자어음 처리결과 수신 처리                                       */
    /******************************************************************************/        
    FUNCTION read_bill_result ( p_edi_history_seq   IN NUMBER ,               -- EDI송수신이력 일련번호 
                                p_emp_no            IN VARCHAR2 )             -- 사번  
        RETURN VARCHAR2;                                                      -- 함수 처리결과 메시지                                          

        
    /******************************************************************************/
    /*  기능 : 현금이체파일 처리결과 수신 처리                                    */
    /******************************************************************************/        
    FUNCTION read_cash_result ( p_edi_history_seq   IN NUMBER ,               -- EDI송수신이력 일련번호 
                                p_emp_no            IN VARCHAR2 )             -- 사번  
        RETURN VARCHAR2;                                                      -- 함수 처리결과 메시지             
        
    /******************************************************************************/
    /*  기능 : 일정주기별로 수행되는 job에 대한 총괄 호출 함수                    */
    /******************************************************************************/        
    PROCEDURE do_job_task;

    
    /******************************************************************************/
    /*  기능 : 타행이체불능 통지메일 발송                                         */
    /******************************************************************************/        
    FUNCTION send_tran_fail_mail( p_comp_code         IN VARCHAR2 ,        -- 사업장코드  
                                  p_bank_code         IN VARCHAR2 ,        -- 은행코드 
                                  p_docu_numc         IN VARCHAR2 )        -- 전문번호 
        RETURN VARCHAR2;                                                   -- 함수 처리결과 메시지                                          

    
    /******************************************************************************/
    /*  기능 : 지급예정 메일데이타 생성                                           */
    /******************************************************************************/        
    FUNCTION create_paydue_mail_data( p_comp_code         IN VARCHAR2 ,        -- 사업장코드   
                                      p_pay_ymd           IN VARCHAR2 ,        -- 지급예정일자 
                                      p_vendor_seq        IN NUMBER )          -- 거래처일련번호 
        RETURN VARCHAR2;                                                       -- 함수 처리결과 메시지                                          
        
        
    /******************************************************************************/
    /*  기능 : 지급예정 메일 발송                                                 */
    /******************************************************************************/        
    FUNCTION send_paydue_mail( p_mail_seq         IN NUMBER ,                  -- 메일일련번호  
                               p_emp_no           IN VARCHAR2 )                -- 사번 
        RETURN VARCHAR2;                                                       -- 함수 처리결과 메시지     
        
                
    /******************************************************************************/
    /*  기능 : 예금이체 전표생성/이체데이타 생성                                  */
    /******************************************************************************/        
    FUNCTION create_transfer_slip_data( p_transfer_seq   IN NUMBER ,            -- 예금이체일련번호  
                                        p_emp_no         IN VARCHAR2 )          -- 사번 
        RETURN VARCHAR2;                                                        -- 함수 처리결과 메시지                     
                
                
    /******************************************************************************/
    /*  기능 : 인사지급데이타 추출                                                */
    /******************************************************************************/        
    FUNCTION extract_hr_pay_data( p_comp_code         IN VARCHAR2 ,        -- 사업장코드   
                                  p_pay_ym            IN VARCHAR2 ,        -- 지급예정 년월 
                                  p_gubun             IN VARCHAR2 ,        -- 구분 
                                  p_emp_no            IN VARCHAR2 ,        -- 사번  
                                  p_extract_cnt       OUT NUMBER  ,        -- 총 추출 건수  
                                  p_extract_amt       OUT NUMBER  )        -- 총 추출 금액 
        RETURN VARCHAR2;                                                   -- 함수 처리결과 메시지                     

        
    /******************************************************************************/
    /*  기능 : 회계시스템에서 업체등록시 전자어음거래처로 등록된 업체인지 확인    */
    /******************************************************************************/        
    FUNCTION check_bill_vendor( p_comp_code         IN VARCHAR2 ,        -- 사업장코드   
                                p_bank_code         IN VARCHAR2 ,        -- 은행코드 
                                p_bizno             IN VARCHAR2 )        -- 사업자번호 
        RETURN VARCHAR2;                                                 -- 함수 처리결과 메시지    
        
                
        
    /******************************************************************************/
    /*  기능 : RealTime처리시, VAN송신Table에 넣고,일정시간동안 수신대기처리      */
    /******************************************************************************/        
    FUNCTION send_realtime_document( p_rec_send          IN FB_VAN_SEND_RECORD ,   -- 송신RECORD  
                                     p_timeout           IN NUMBER ,               -- 최대대기시간 
                                     p_rec_recv          OUT FB_VAN_RECV_RECORD ,  -- 수신RECORD 
                                     p_result_code       OUT VARCHAR2  ,           -- 처리결과코드 
                                     p_result_msg        OUT VARCHAR2  )           -- 처리결과메시지  
        RETURN VARCHAR2;                                                           -- 함수 처리결과 메시지     
                
                
END FBS_MAIN_PKG;
/
CREATE OR REPLACE PACKAGE BODY FBS_MAIN_PKG IS


    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : send_start_document                                   */
    /*  2. 모듈이름  : 매일아침 은행으로 개시전문을 송신합니다.              */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 매일 정해진시간(오전8:30)에 FBS약정계좌가 계설된 모든은행으로  */
    /*        개시전문을 자동으로 발송합니다.                                */
    /*        본 함수는 사업장/은행을 입력받아서, 개시전문1개를 전송하는     */
    /*        기능을 수행하며, 사업장/은행LIST를 SELECT로 조회후, 본 함수를  */
    /*        각각 호출하여 처리한다. (매일아침 개시 시)                     */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상개시 시                                             */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/         
    FUNCTION send_start_document( p_comp_code     IN VARCHAR2 ,       -- 사업장 코드
                                  p_bank_code     IN VARCHAR2 ,       -- 은행코드
                                  p_resp_code     OUT VARCHAR2,       -- 응답코드
                                  p_resp_msg      OUT VARCHAR2 )      -- 응답코드명                                   
        RETURN VARCHAR2 IS                                            -- 함수 처리결과 메시지    
            
    BEGIN
    
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );
    
    END send_start_document;    
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : send_fbs_status_mail                                  */
    /*  2. 모듈이름  : 매일정해진시간에 FBS시스템에 대한 상태점검메일을 발송 */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 매일 정해진시간(오전9:00)에 FBS시스템에 대한 상태를 점검하여   */
    /*        기 등록된 수신자 및 추가적으로 PARAMETER로 입력된 인원에게     */
    /*        FBS시스템상태를 담은 메일을 발송합니다.                        */
    /*        수신자는 T_FB_LOOKUP_VALUES의 LOOKUP_TYPE이 "FBS_RECEIVE_EMP"  */
    /*        에 등록된 인원에게 발송한다.                                   */
    /*                                                                       */
    /*      - 체크하는 내용은 아래와 같음                                    */
    /*         (1) 관련PROGRAM의 VALID여부 확인                              */
    /*         (2) 관련PROCESS의 기동여부 확인                               */
    /*         (3) JOB수행여부 확인                                          */
    /*         (4) 은행별 개시여부 확인                                      */
    /*         (5) 수신된 전자어음 약정거래선 정보                           */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 메일발송 시                                        */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
    FUNCTION send_fbs_status_mail( p_recv_list  IN VARCHAR2 DEFAULT NULL )   -- 추가적인 메일수신자 (DEFAULT는 NULL) 
        RETURN VARCHAR2 IS    
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_fbs_status_mail;
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : retieve_acct_remains                                  */
    /*  2. 모듈이름  : 1개 계좌에 대한 잔액조회                              */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 입력된 은행코드 및 계좌번호에 대한 잔액을 VAN사로 잔액조회전문 */
    /*        을 송수신하여, 구해옵니다.                                     */
    /*        정상적으로 처리된 경우, RESP_CODE가 "0000"으로 반환된 경우만   */
    /*        정상적으로 조회된 경우임.                                      */
    /*                                                                       */    
    /*      - 잔액데이타에 대하여 "계좌잔액데이타(T_FB_ACCT_REMAIN_DATA)"의  */
    /*        내용을 INSERT 혹은 UPDATE수행합니다                            */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
    FUNCTION retieve_acct_remains( p_bank_code     IN VARCHAR2 ,       -- 은행코드
                                   p_acct_number   IN VARCHAR2 ,       -- 계좌번호 
                                   p_remain_amt    OUT NUMBER  ,       -- 계좌잔액 
                                   p_enable_amt    OUT NUMBER  ,       -- 출금가능액 
                                   p_resp_code     OUT VARCHAR2,       -- 응답코드
                                   p_resp_msg      OUT VARCHAR2 )      -- 응답코드명 
        RETURN VARCHAR2 IS                                             -- 함수 처리결과 메시지    
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END retieve_acct_remains;  
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : cash_pay_window_check                                 */
    /*  2. 모듈이름  : 현금이체 담당자 획인 및 취소처리 로직                 */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 현금이체시 담당자 확인/확인취소에 대하여 각각의 처리루틴       */
    /*        확인인지, 확인취소처리인지는 GUBUN코드로 구분한다.             */
    /*                                                                       */
    /*        (1) 확인처리 시                                                */
    /*          : T_FB_CASH_PAY_DATA에 담긴 해당 지급RECORD에 대하여 타행    */
    /*            이체여부를 확인하여, T_FB_LOOKUP_VALUES테이블의 은행별     */
    /*            이체한도금액을 확인하여, T_FB_CASH_PAY_DIVIDED_DATA에      */
    /*            분할지급건에 대하여 RECORD를 생성시킨다.                   */
    /*            이체한도에 안걸리면 보통 1개의 분할지급RECORD생성됨        */
    /*            생성시킨 후, PAY_STATUS를 담당자 확인상태로 UPDATE한다.    */
    /*                                                                       */
    /*        (2) 확인취소 처리 시                                           */ 
    /*          : 기 확인 된 건이었으므로, 분할지급테이블에 생성된 RECORD를  */
    /*            DELETE하고, PAY_STATUS를 담당자 미확인 상태로 변경시킨다.  */
    /*                                                                       */
    /*      - 담당자확인/확인취소처리는 팀장승인/지급완료/실패/전표취소 시를 */
    /*         제외한 상태에서만 처리가 가능함                               */
    /*                                                                       */
    /*      - 지급데이타의 출처가 "예금이체"인 경우는 확인/확인취소에 따라서 */
    /*        STATUS를 변경시켜준다. T_FB_CASH_TRANSFER_DATA의               */
    /*        FUND_TRANSFER_STATUS를 확인시는 '1'로 변경하며, 취소시는 '0'으 */
    /*        으로 UPDATE한다.                                               */
    /*                                                                       */    
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
    FUNCTION cash_pay_window_check( p_pay_seq     IN NUMBER ,          -- 지급일련번호
                                    p_job_gubun   IN VARCHAR2 ,        -- 처리구분 [ CHECK:확인 , CANCEL:확인취소 ]
                                    p_emp_no      IN VARCHAR2 )        -- 사번                                       
        RETURN VARCHAR2 IS                                             -- 함수 처리결과 메시지                          
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END cash_pay_window_check;    
  
  
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : create_cash_edi_file                                  */
    /*  2. 모듈이름  : 현금이체파일 생성                                     */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 생성은 화면단에서 UPDATE하여주는 EDI_CREATE_REQ_YN 컬럼이 'Y'  */
    /*        인 것을 대상으로 EDI파일을 생성합니다.                         */    
    /*                                                                       */
    /*      - 현금이체파일을 생성하며, 은행별/사업장별로 생성된다.           */
    /*        정상적으로 생성된 경우, RETURN값은 OK가 반환되며, 생성된 송수  */
    /*        신이력테이블(T_FB_EDI_HISTORY)의 키(SEQ)가 반환된다.           */
    /*        오류가 난 경우는 NULL값이 반환된다.                            */
    /*                                                                       */
    /*      - 이체파일은 정해진 규칙에 의거 생성을 하는 function을 호출하여  */
    /*        파일경로/파일명을 구해서 생성시킨다.                           */
    /*                                                                       */
    /*      - 파일명 명명규칙은 다음과 같이 함                               */
    /*         CS_사업장코드(2)_은행코드(2)_날짜(8)_일련번호(3).dat          */
    /*                                                                       */    
    /*      - 동시성 체크를 위해서 화면단위에서 호출시, 선택한 행의 갯수를   */
    /*        본 함수의 parameter로 입력하여, 추후 처리완료시의 행의 갯수와  */
    /*        비교를 하여 다른 경우는 오류로 반환한다.                       */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
    FUNCTION create_cash_edi_file( p_comp_code         IN VARCHAR2 ,        -- 사업장코드  
                                   p_bank_code         IN VARCHAR2 ,        -- 은행코드 
                                   p_row_cnt           IN NUMBER ,          -- 처리할 행의 갯수 (체크용) 
                                   p_emp_no            IN VARCHAR2 ,        -- 사번   
                                   p_edi_history_seq   OUT NUMBER )         -- EDI생성_송수신HISTORY일련번호 (실패한 경우, NULL)    
        RETURN VARCHAR2 IS                                                  -- 함수 처리결과 메시지            
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END create_cash_edi_file;    

  
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : create_bill_edi_file                                  */
    /*  2. 모듈이름  : 전자어음파일 생성                                     */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 생성은 화면단에서 UPDATE하여주는 EDI_CREATE_REQ_YN 컬럼이 'Y'  */
    /*        인 것을 대상으로 EDI파일을 생성합니다.                         */    
    /*                                                                       */
    /*      - 전자어음파일을 생성하며, 은행별/사업장별로 생성된다.           */
    /*        정상적으로 생성된 경우, RETURN값은 OK가 반환되며, 생성된 송수  */
    /*        신이력테이블(T_FB_EDI_HISTORY)의 키(SEQ)가 반환된다.           */
    /*        오류가 난 경우는 NULL값이 반환된다.                            */
    /*                                                                       */
    /*      - 이체파일은 정해진 규칙에 의거 생성을 하는 function을 호출하여  */
    /*        파일경로/파일명을 구해서 생성시킨다.                           */
    /*                                                                       */
    /*      - 파일명 명명규칙은 다음과 같이 함                               */
    /*         BS_사업장코드(2)_은행코드(2)_날짜(8)_일련번호(3).dat          */    
    /*                                                                       */
    /*      - 동시성 체크를 위해서 화면단위에서 호출시, 선택한 행의 갯수를   */
    /*        본 함수의 parameter로 입력하여, 추후 처리완료시의 행의 갯수와  */
    /*        비교를 하여 다른 경우는 오류로 반환한다.                       */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
    FUNCTION create_bill_edi_file(  p_comp_code         IN VARCHAR2 ,        -- 사업장코드  
                                    p_bank_code         IN VARCHAR2 ,        -- 은행코드 
                                    p_row_cnt           IN NUMBER ,          -- 처리할 행의 갯수 (체크용) 
                                    p_emp_no            IN VARCHAR2 ,        -- 사번   
                                    p_edi_history_seq   OUT NUMBER )         -- EDI생성_송수신HISTORY일련번호 (실패한 경우, NULL)    
        RETURN VARCHAR2 IS                                                   -- 함수 처리결과 메시지            
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END create_bill_edi_file;    
  
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : send_cash_each_transfer                               */
    /*  2. 모듈이름  : 분할건별 현금이체 지급                                */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 담당자 확인 과정을 통해서 생성된 분할지급건 단위로 실제 은행과 */
    /*        VAN을 통해서 전문(당타행이체)송수신을 수행한다.                */
    /*        처리결과HISTORY는 HISTORY TABLE(T_FB_CASH_PAY_HISTORY)에 저장  */
    /*        되며, 처리결과는 RESP_CODE, RESP_MSG로 반환된다.               */
    /*                                                                       */
    /*      - 본 함수는 단독으로 수행치 않으며, SEND_CASH_TRANSFER에 의해서  */
    /*         호출되어 사용된다.                                            */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
    FUNCTION send_cash_each_transfer( p_pay_seq         IN NUMBER ,        -- 지급일련번호
                                      p_div_seq         IN NUMBER ,        -- 분할일련번호  
                                      p_emp_no          IN VARCHAR2 ,      -- 사번   
                                      p_resp_code       OUT VARCHAR2,      -- 응답코드
                                      p_resp_msg        OUT VARCHAR2 )     -- 응답코드명  
        RETURN VARCHAR2 IS                                                 -- 함수 처리결과 메시지             
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_cash_each_transfer;          
        
        
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : send_cash_transfer                                    */
    /*  2. 모듈이름  : 지급건별 현금이체 지급                                */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 지급건(T_FB_CASH_PAY_DATA) 단위로 처리되며, 실제 사용자가 화면 */
    /*        을 통해서 호출되는 단위이며, 내부적으로 분할된 내역 각각에 대  */
    /*        하여, DIV_SEQ를 추가PARAMETER로 하여, SEND_CASH_EACH_TRANSFER  */
    /*        함수를 호출하여 처리한다.                                      */
    /*                                                                       */
    /*      - 함수내부적으로 DIVIDE된 건수를 체크하고, 각각의 건에 대하여    */
    /*        처리완료 후, 모두정상처리된 경우 혹은 일부실패, 전체실패에 대  */
    /*        한 이력을 가지고 있다가 처리결과를 RETURN한다.                 */
    /*                                                                       */
    /*      - 재전송시에도 본 함수를 사용하며, 지급실패/일부지급실패인 경우  */
    /*        해당 지급실패건을 찾아서 SEND_CASH_EACH_TRANSFER를 재호출하여  */
    /*        처리한다.                                                      */
    /*                                                                       */
    /*      - 함수내부적으로 SEND_CASH_EACH_TRANSFER를 호출하여 받은         */
    /*        처리결과에 대하여 PAY_STATUS를 UPDATE한다.                     */
    /*          4: 지급완료                                                  */
    /*          5: 지급실패                                                  */
    /*          6: 일부지급실패 => 여러분할건일때, 그중일부가 실패한 경우    */    
    /*          7: 전표취소                                                  */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          정상처리 => 정상 이체처리 완료 시                            */
    /*          일부지급실패:[오류메시지]                                    */
    /*                   => 여러분할것인 경우, 일부 지급실패시 첫번째 오류   */
    /*          지급실패:[오류메시지]                                        */
    /*                   => 분할건이1건인 경우, 지급실패시 오류              */
    /*          전표취소 => 전표취소된 경우                                  */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/          
    FUNCTION send_cash_transfer( p_pay_seq         IN NUMBER ,        -- 지급일련번호
                                 p_emp_no          IN VARCHAR2 )      -- 사번   
        RETURN VARCHAR2 IS                                            -- 함수 처리결과 메시지       
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_cash_transfer;    
  
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : send_bill_transfer                                    */
    /*  2. 모듈이름  : 지급건별 전자어음 realtime 송신                       */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - Realtime으로 전자어음을 발행하는 기능을 수행합니다.            */ 
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          정상처리 => 정상 발행처리 완료 시                            */
    /*          지급실패 => 지급실패 오류                                    */
    /*          전표취소 => 전표취소된 경우                                  */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/          
    FUNCTION send_bill_transfer( p_pay_seq         IN NUMBER ,        -- 지급일련번호
                                 p_emp_no          IN VARCHAR2 )      -- 사번   
        RETURN VARCHAR2 IS                                            -- 함수 처리결과 메시지       
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_bill_transfer;    
    
      
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : retieve_pay_summation                                 */
    /*  2. 모듈이름  : 이체집계요청 처리                                     */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 은행코드와 계좌번호를 입력받아, 이체처리집계요청을 하여 결과   */
    /*        를 반환합니다.                                                 */
    /*      - 실패건수,실패금액은 총건수/총금액에서 성공건수와 성공금액을    */
    /*        차감하여 계산합니다.                                           */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
    PROCEDURE retieve_pay_summation( p_bank_code       IN VARCHAR2 ,       -- 은행코드
                                     p_acct_number     IN VARCHAR2 ,       -- 계좌번호 
                                     p_da_req_cnt      OUT NUMBER ,        -- 당행 요청 건수 
                                     p_da_req_amt      OUT NUMBER ,        -- 당행 요청 금액 
                                     p_da_success_cnt  OUT NUMBER ,        -- 당행 정상처리 건수 
                                     p_da_success_amt  OUT NUMBER ,        -- 당행 정상처리 금액 
                                     p_da_commission   OUT NUMBER ,        -- 당행 수수료 
                                     p_ta_req_cnt      OUT NUMBER ,        -- 타행 요청 건수 
                                     p_ta_req_amt      OUT NUMBER ,        -- 타행 요청 금액 
                                     p_ta_success_cnt  OUT NUMBER ,        -- 타행 정상처리 건수 
                                     p_ta_success_amt  OUT NUMBER ,        -- 타행 정상처리 금액 
                                     p_ta_commission   OUT NUMBER ,        -- 타행 수수료 
                                     p_resp_code       OUT VARCHAR2,       -- 응답코드
                                     p_resp_msg        OUT VARCHAR2 ) IS   -- 응답코드명 
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        
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
    /*  1. 모듈ID    : retieve_acct_holder_name                              */
    /*  2. 모듈이름  : 예금주명 조회                                         */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 입력된 은행코드 및 계좌번호에 대한 예금주명을 VAN과 전문을     */
    /*        송수신하여, 구해옵니다.                                        */
    /*        정상적으로 처리된 경우, RESP_CODE가 "0000"으로 반환된 경우만   */
    /*        정상적으로 조회된 경우임.                                      */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
    FUNCTION retieve_acct_holder_name( p_bank_code     IN VARCHAR2 ,       -- 은행코드
                                       p_acct_number   IN VARCHAR2 ,       -- 계좌번호 
                                       p_holder_name   OUT VARCHAR2 ,      -- 예금주명 
                                       p_resp_code     OUT VARCHAR2,       -- 응답코드
                                       p_resp_msg      OUT VARCHAR2 )      -- 응답코드명 
        RETURN VARCHAR2 IS                                                 -- 함수 처리결과 메시지     
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END retieve_acct_holder_name;     
  
  
  

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : read_bill_vendor_info                                 */
    /*  2. 모듈이름  : 전자어음 거래선정보 수신 처리                         */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 은행으로부터 수신된 전자어음 거래선정보파일명(경로포함)을 읽   */
    /*        어서, 전자어음협력업체(T_FB_CHECK_VENDORS)에 반영한다.         */
    /*        실제파일명은 EDI송수신이력의 SEQ에 해당하는 RECORD를 조회하여  */
    /*        수신파일명을 찾아서 , 해당 파일을 오픈하여 처리한다.           */
    /*                                                                       */
    /*      - 파일명 명명규칙은 다음과 같이 함 (송수신이력테이블에 있음)     */
    /*         V_사업장코드(2)_은행코드(2)_날짜(8)_일련번호(3).dat           */      
    /*                                                                       */    
    /*      - 신규/변경/해지 모두 해당 TABLE에 INSERT를 수행하며, 별도의     */
    /*        VIEW를 통해서 현재 업체의 상태를 확인할 수 있도록 한다.        */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/  
    FUNCTION read_bill_vendor_info( p_edi_history_seq  IN NUMBER )            -- EDI송수신이력 일련번호 
        RETURN VARCHAR2 IS                                                    -- 함수 처리결과 메시지       
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END read_bill_vendor_info;   
    
    
    
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : read_bill_result                                      */
    /*  2. 모듈이름  : 전자어음 처리결과 수신 처리                           */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 사용자 화면으로부터 해당 EDI송수신이력의 SEQ를 받아, 수신파일  */
    /*        명을 조회하여, 파일을 오픈한 후, 채권번호에 해당하는 지급건을  */
    /*        찾아서 처리결과를 UPDATE한다.                                  */
    /*                                                                       */    
    /*      - 파일명 명명규칙은 다음과 같이 함 (송수신이력테이블에 있음)     */
    /*         BR_사업장코드(2)_은행코드(2)_날짜(8)_일련번호(3).dat           */      
    /*                                                                       */
    /*      - 처리결과에 따라서 각 지급건에 대하여 상태(PAY_STATUS)를 UPDATE */
    /*          4: 발행완료                                                  */
    /*          5: 발행실패                                                  */
    /* 
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/  
    FUNCTION read_bill_result(  p_edi_history_seq  IN NUMBER ,                -- EDI송수신이력 일련번호 
                                p_emp_no           IN VARCHAR2 )              -- 사번  
        RETURN VARCHAR2 IS                                                    -- 함수 처리결과 메시지      
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END read_bill_result;   
        
    
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : read_cash_result                                      */
    /*  2. 모듈이름  : 현금이체파일 처리결과 수신 처리                       */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 사용자 화면으로부터 해당 EDI송수신이력의 SEQ를 받아, 수신파일  */
    /*        명을 조회하여, 파일을 오픈한 후, 해당하는 지급건을             */
    /*        찾아서 처리결과를 UPDATE한다.                                  */
    /*                                                                       */    
    /*      - 파일명 명명규칙은 다음과 같이 함 (송수신이력테이블에 있음)     */
    /*         CR_사업장코드(2)_은행코드(2)_날짜(8)_일련번호(3).dat          */      
    /*                                                                       */
    /*      - 처리결과에 따라서 각 지급건에 대하여 상태(PAY_STATUS)를 UPDATE */
    /*          4: 지급성공                                                  */
    /*          5: 지급실패                                                  */
    /* 
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2006년1월10일                                         */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/  
    FUNCTION read_cash_result(  p_edi_history_seq  IN NUMBER ,                -- EDI송수신이력 일련번호 
                                p_emp_no           IN VARCHAR2 )              -- 사번  
        RETURN VARCHAR2 IS                                                    -- 함수 처리결과 메시지      
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END read_cash_result;       
    
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : do_job_task                                           */
    /*  2. 모듈이름  : 일정주기별로 수행되는 job에 대한 총괄 호출 함수       */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 일정한 주기별로 수행되는 JOB에 등록된 TASK에 대하여 적절한     */
    /*        조회조건 및 필요PARAMETER를 선정하여 호출하는 총괄함수         */
    /*                                                                       */
    /*      - JOB에 의하여 처리되는 내역을 아래와 같음                       */
    /*                                                                       */
    /*        (1) 개시전문발송                                               */
    /*           : 매일아침에 FBS약정계좌에 해당하는 은행을 SELECT한 후 ,    */
    /*             send_start_document를 호출하여, 개시전문을 송신한다.      */
    /*                                                                       */    
    /*        (2) FBS상태메일 발송                                           */    
    /*           : 등록된 사용자에게 FBS상태를 체크하는 로직을 수행한 결과를 */
    /*             메일에 담아서 발송한다.                                   */
    /*                                                                       */
    /*        (3) 전자어음 거래선정보 수신 및 처리                           */
    /*           : 매일아침에 은행으로부터 거래선 정보를 수신한 후, 처리     */
    /*                                                                       */
    /*        (4) 예금거래명세 결번 처리                                     */
    /*           : 예금거래명세중, 결번내역을 자동으로 체크하여 결번요청 및  */
    /*             응답에 대한 처리를 수행한다. 1시간 단위 수행              */
    /*                                                                       */
    /*        (5) 가상계좌 거래명세 결번 처리                                */
    /*           : 가상계좌 거래명세 중, 결번내역을 자동으로 체크하여 결번   */
    /*             요청 및 응답에 대한 처리를 수행한다. 1시간 단위 수행      */
    /*                                                                       */
    /*        (6) 전 계좌에 대한 일괄 일말잔액 조회                          */
    /*           : 정해진 시간에 FBS계좌로 등록된 모든 계좌에 대하여 일괄적  */
    /*             으로 시스템이 자동으로 잔액조회 전문을 송수신 한다.       */
    /*                                                                       */    
    /*        (7) 분양전송데이타  오류확인                                   */
    /*           : 입금/입금취소내역에 대하여 분양시스템으로 전송할때, 전송  */
    /*             이력을 확인하여, 미전송이력내역을 재전송시도하며, 다시    */
    /*             오류가 발생시는, 기 등록된 인원에게 메일을 발송한다.      */   
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/      
    PROCEDURE do_job_task IS
    
    BEGIN
    
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        
        NULL;    
    
    END  do_job_task;   
    
    
    
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : send_tran_fail_mail                                   */
    /*  2. 모듈이름  : 타행이체불능 통지메일 발송                            */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 본 함수는 TRIGGER에서 호출되며, 타행이체실행 후, 이체불능 통지 */
    /*        가 왔을때, T_FB_LOOKUP_VALUES의 LOOKUP_TYPE=TRAN_FAIL_MAIL_TO  */
    /*        항목으로 등록된 사용자에게 메일을 발송합니다.                  */
    /*                                                                       */
    /*      - 은행으로부터 온 전문번호에 해당하는 지급건을 찾아서 지급내역에 */
    /*        대한 정보를 포함하여 메일을 발송한다.                          */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/  
    FUNCTION send_tran_fail_mail( p_comp_code         IN VARCHAR2 ,        -- 사업장코드  
                                  p_bank_code         IN VARCHAR2 ,        -- 은행코드 
                                  p_docu_numc         IN VARCHAR2 )        -- 전문번호 
        RETURN VARCHAR2 IS                                                 -- 함수 처리결과 메시지     
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_tran_fail_mail;       

    
      
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : create_paydue_mail_data                               */
    /*  2. 모듈이름  : 지급예정 메일데이타 생성                              */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 대금결제할 업체로 지급건에 대하여 지급예정메일을 발송할 자료를 */
    /*        생성합니다. 조건은 사업장/지급예정일자/사업자 를 조건으로 함   */
    /*                                                                       */
    /*      - 사업장/지급예정일은 필수사항이며, 거래처는 선택사양임          */
    /*                                                                       */
    /*      - 생성은 T_FB_PAYDUE_MAIL_MASTER와 T_FB_PAYDUE_MAIL_DETAIL에     */
    /*        기존 RECORD를 삭제하고, INSERT하며, 기 발송된 이력이 있는 경우 */
    /*        MASTER는 재생성하지 않으며, DETAIL만 재 생성 후, 발송이력을    */
    /*        미발송 상태로 UPDATE한다.                                      */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/        
    FUNCTION create_paydue_mail_data( p_comp_code         IN VARCHAR2 ,        -- 사업장코드   
                                      p_pay_ymd           IN VARCHAR2 ,        -- 지급예정일자 
                                      p_vendor_seq        IN NUMBER )          -- 거래처일련번호 
        RETURN VARCHAR2 IS                                                     -- 함수 처리결과 메시지         
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END create_paydue_mail_data;    
  
  

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : send_paydue_mail                                      */
    /*  2. 모듈이름  : 지급예정 메일 발송                                    */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 메일발송데이타의 SEQ(일련번호)를 입력받아, 메일포맷에 맞춰서   */
    /*        데이타를 추출하여 메일을 발송합니다.                           */
    /*                                                                       */
    /*      - 메일 수신자는 거래처코드(T_CUST_CODE)테이블의 거래처별 출납    */
    /*        담당자명 및 담당자 이메일 주소를 SELECT하여 설정한다.          */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상 처리 시                                            */
    /*          오류메시지 : 기타 오류 발생시 (DEFAULT값:ERROR)              */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/   
    FUNCTION send_paydue_mail( p_mail_seq         IN NUMBER ,                  -- 메일일련번호  
                               p_emp_no           IN VARCHAR2 )                -- 사번 
        RETURN VARCHAR2 IS                                                     -- 함수 처리결과 메시지       
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END send_paydue_mail;   

    
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : create_transfer_slip_data                             */
    /*  2. 모듈이름  : 예금이체 전표생성/이체데이타 생성                     */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 등록한 예금이체 내역에 대하여 전표생성 및 이체를 실행할 수 있  */
    /*        는 이체데이타(T_FB_CASH_PAY_DATA의 RECORD)로 생성합니다        */
    /*                                                                       */
    /*      - 전표는 회계쪽으로 자동전표를 생성하며, 생성후의 전표번호를     */
    /*        예금이체정보테이블(T_FB_CASH_TRANSFER_DATA)에 UPDATE한다.      */
    /*                                                                       */
    /*      - 이체데이타가 정상적으로 생성되면, 지급일련번호(PAY_SEQ)를 받아 */
    /*        예금이체정보테이블(T_FB_CASH_TRANSFER_DATA)에 UPDATE한다.      */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상적으로 전표생성/이체데이타생성 완료 처리 시         */
    /*          오류메시지 : 기타 오류 발생시                                */
    /*               => 전표생성실패 , 이체데이타 생성 실패 등               */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/       
    FUNCTION create_transfer_slip_data( p_transfer_seq   IN NUMBER ,            -- 예금이체일련번호  
                                        p_emp_no         IN VARCHAR2 )          -- 사번 
        RETURN VARCHAR2 IS                                                      -- 함수 처리결과 메시지        
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END create_transfer_slip_data;      
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : extract_hr_pay_data                                   */
    /*  2. 모듈이름  : 인사지급데이타 추출                                   */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 추출화면의 조회조건(사업장,지급년월,지급구분)에 대하여 변수로  */
    /*        입력받아, HR쪽의 VIEW를 통해서 데이타를 FBS로 이관작업을 수행  */
    /*                                                                       */    
    /*      - HR쪽에서는 "급여이력-급상여실적(지급이력MASTER)"(GLIS002TT)를  */
    /*        SELECT하여, 필요데이타를 조회한 후, "인터페이스_인사"테이블    */
    /*        (T_FB_INTERFACE_HR)에 INSERT를 수행한다.                       */
    /*                                                                       */
    /*      - 동시에 현금지급데이타(T_FB_CASH_PAY_DATA)에도 지급내역에 대한  */
    /*        INSERT작업을 수행하며, 생성된 PAY_SEQ를 T_FB_INTERFACE_PH의    */
    /*        RECORD에 UPDATE하는 작업을 하여, 연결고리 역할을 한다.         */
    /*                                                                       */    
    /*      - 기존에 추출된 데이타가 있는 경우, 추출상태가 "정상전송(T)' 및  */
    /*        '전표취소(C)'인 상태에서만 신규 재추출이 가능하다.             */ 
    /*        '지급대기중(W)' 이나 '지급완료(P)'인 상태에서는 재추출이 불가  */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상적으로 추출완료시 => '정상전송(T)'상태              */
    /*          오류메시지 : 기타 오류 발생시  오류 메시지                   */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/     
    FUNCTION extract_hr_pay_data( p_comp_code         IN VARCHAR2 ,        -- 사업장코드   
                                  p_pay_ym            IN VARCHAR2 ,        -- 지급예정 년월 
                                  p_gubun             IN VARCHAR2 ,        -- 구분 
                                  p_emp_no            IN VARCHAR2 ,        -- 사번  
                                  p_extract_cnt       OUT NUMBER  ,        -- 총 추출 건수  
                                  p_extract_amt       OUT NUMBER  )        -- 총 추출 금액 
        RETURN VARCHAR2 IS                                                 -- 함수 처리결과 메시지     
    BEGIN
  
  
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );  
  
    END extract_hr_pay_data;    
  
  
  
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : check_bill_vendor                                     */
    /*  2. 모듈이름  : 업체등록시 전자어음거래처로 등록된 업체인지 확인      */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 재무회계시스템에서 업체등록시, 해당 업체가 특정사업장,은행에   */
    /*        전자어음 거래처로 등록되어 있는지 확인하는 함수                */
    /*                                                                       */
    /*      - 내부적으로 "전자어음협력업체(T_FB_BILL_VENDORS)"테이블을 조회  */
    /*        하여, 가장최근의 상태 결과값을 반환합니다                      */
    /*                                                                       */    
    /*      - 반환값                                                         */
    /*          OK : 정상적으로 약정된 업체인 경우                           */
    /*          오류메시지 : 기타 오류 발생시  오류 메시지                   */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2006년 1월 5일                                        */
    /* 10. 최종수정자: LG CNS 신인철                                         */
    /* 11. 최종수정일: 2006년 1월 5일                                        */
    /*************************************************************************/     
    FUNCTION check_bill_vendor( p_comp_code         IN VARCHAR2 ,        -- 사업장코드   
                                p_bank_code         IN VARCHAR2 ,        -- 은행코드 
                                p_bizno             IN VARCHAR2 )        -- 사업자번호 
        RETURN VARCHAR2 IS                                               -- 함수 처리결과 메시지     
  
        v_return_msg            VARCHAR2(300) := 'OK';
        rec_fb_bill_vendors     T_FB_BILL_VENDORS%ROWTYPE;
        
        ERR_PARAM_ERROR         EXCEPTION;     --입력받은 PARAMTER가 오류인 경우.
        
    BEGIN
    
        -- 입력받은 PARAMETER에 대한 VALID를 체크합니다.
        IF p_comp_code IS NULL or LENGTH(p_comp_code) = 0 THEN
            v_return_msg := '사업장코드가 NULL이거나, 잘못된 값입니다.';
            
        ELSIF p_bank_code IS NULL or LENGTH(p_bank_code) = 0 THEN
            v_return_msg := '은행코드가 NULL이거나, 잘못된 값입니다.';
            
        ELSIF p_bizno IS NULL or LENGTH(p_bizno) = 0 THEN
            v_return_msg := '사업자번호가 NULL이거나, 잘못된 값입니다.';
        END IF;    
           
        -- 해당 사업장/은행/사업자번호에 해당하는 업체상태를 조회합니다.
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
                v_return_msg := '해당 업체는 약정해지된 업체입니다.(해지일:' || rec_fb_bill_vendors.change_ymd || ')';
            END IF;
  
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_return_msg := '미약정이거나, 약정정보가 없습니다.';
                
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
    /*  1. 모듈ID    : send_realtime_document                                */
    /*  2. 모듈이름  : RealTimeVAN송신Table에 넣고,일정시간동안 수신대기처리 */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: FBS                                                   */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - parameter로 넘겨받은 전송RECORD를 VAN송신TABLE에 INSERT를 한후 */
    /*        REALTIME_TEMP_DIR에 전문파일을 생성한 후, REALTIME_SEND_DIR에  */
    /*        FILE MOVE를 시킨 후에, 일정시간동안 대기하여, 수신TABLE에      */
    /*        결과RECORD가 오는 경우, 수신RECORD에 내용을 담아서 반환한다.   */
    /*                                                                       */
    /*      - 생성시키는 파일은 전문 개별 각각에 대하여 1개 파일이 생성되며  */
    /*        각 파일은 1개 줄에 300Byte의 전문전체내역을 담은 파일 생성     */
    /*                                                                       */        
    /*      - 파일명 명명규칙은 아래와 같습니다. 확장자는 .rec 라고 붙인다   */
    /*     사업장코드(2)_은행코드(2)_전문구분코드(6)_날짜(8)_전문번호(6).rec */
    /*                                                                       */    
    /*      - 파일MOVE는 FBS_UTIL_PKG의 exec_os_command 함수를 사용하여      */
    /*        처리한다.                                                      */
    /*                                                                       */        
    /*      - timeout값이 오는 경우,(초단위) 이것을 적용하며, NULL값이 입력  */
    /*        되는 경우, DEFAULT_TIMEOUT 값이 적용된다.                      */
    /*                                                                       */
    /*      - 반환값                                                         */
    /*          OK : 정상적으로 추출완료시 => '정상전송(T)'상태              */
    /*          오류메시지 : 기타 오류 발생시  오류 메시지                   */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 10. 최종수정자: LG CNS 신인철                                         */
    /* 11. 최종수정일: 2006년 1월 3일                                        */
    /*************************************************************************/   
    FUNCTION send_realtime_document( p_rec_send          IN FB_VAN_SEND_RECORD ,   -- 송신RECORD  
                                     p_timeout           IN NUMBER ,               -- 최대대기시간 
                                     p_rec_recv          OUT FB_VAN_RECV_RECORD ,  -- 수신RECORD 
                                     p_result_code       OUT VARCHAR2  ,           -- 처리결과코드 
                                     p_result_msg        OUT VARCHAR2  )           -- 처리결과메시지  
        RETURN VARCHAR2 IS                                                         -- 함수 처리결과 메시지    
        
        v_return_msg           VARCHAR2(200) := 'OK';        -- 반환메시지  
        v_file_name            VARCHAR2(100);                -- 전문파일이름
        v_temp_file_path       VARCHAR2(200);                -- 임시파일위치경로 
        v_send_file_path       VARCHAR2(200);                -- 송신파일위치경로  
        v_document_buffer      VARCHAR2(400);                -- 전문파일내용(BUFFER) 
        v_dummy_return         VARCHAR2(100); 
        
        d_start_dt             DATE;                         -- 수신대기 시작시간  
        n_start_time           NUMBER(20) := 0;              -- 프로그램이 시작한 시간(초단위로 환산된 값)
        n_curr_time            NUMBER(20) := 0;              -- 응답대기를 위하여 현재 시간(초단위로 환산된 값)        
        
        v_output_file                 UTL_FILE.FILE_TYPE;        
        
        ERR_INVALID_OPERATION         EXCEPTION;             -- 잘못된 수행인경우...
        ERR_MAKE_TEMP_FILE_ERR        EXCEPTION;             -- 전문파일생성 시 오류가 발생한 경우...
        
    BEGIN
    
       -- 0) 입력된 parameter값에 대한 validation을 수행합니다.
       ---------------------------------------------------------
       
       IF p_timeout IS NULL or p_timeout < 1 THEN
           v_return_msg := 'TIMEOUT으로 입력된 값은 숫자로 0 이상의 값이어야 합니다.';
           RAISE ERR_INVALID_OPERATION;
           
       ELSIF p_rec_send.ente_code IS NULL or LENGTH(p_rec_send.ente_code) = 0 THEN
           v_return_msg := '업체코드(ENTE_CODE)가 셋팅되지 않았습니다.';
           RAISE ERR_INVALID_OPERATION;
  
       ELSIF p_rec_send.bank_code IS NULL or LENGTH(p_rec_send.bank_code) != 2 THEN
           v_return_msg := '은행코드(BANK_CODE)가 셋팅되지 않았거나, NULL값이 입력되었습니다.';
           RAISE ERR_INVALID_OPERATION;
           
       ELSIF p_rec_send.docu_code IS NULL or LENGTH(p_rec_send.docu_code) != 4 THEN
           v_return_msg := '전문구분코드(DOCU_CODE)가 셋팅되지 않았거나, 잘못된 값이 입력되었습니다.';
           RAISE ERR_INVALID_OPERATION;

       ELSIF p_rec_send.upmu_code IS NULL or LENGTH(p_rec_send.upmu_code) != 3 THEN
           v_return_msg := '업부구분코드(UPMU_CODE)가 셋팅되지 않았거나, 잘못된 값이 입력되었습니다.';
           RAISE ERR_INVALID_OPERATION;

       ELSIF p_rec_send.docu_numc IS NULL or LENGTH(p_rec_send.docu_numc) != 6 THEN
           v_return_msg := '전문번호(DOCU_NUMC)가 셋팅되지 않았거나, 잘못된 값이 입력되었습니다.';
           RAISE ERR_INVALID_OPERATION;

       ELSIF p_rec_send.send_date IS NULL or LENGTH(p_rec_send.send_date) != 8 THEN
           v_return_msg := '송신일자(SEND_DATE)가 셋팅되지 않았거나, 잘못된 값이 입력되었습니다.';
           RAISE ERR_INVALID_OPERATION;           

       ELSIF p_rec_send.gaeb_area IS NULL or LENGTH(p_rec_send.gaeb_area) = 0 THEN
           v_return_msg := '개별부(GAEB_AREA)가 셋팅되지 않았거나, 잘못된 값이 입력되었습니다.';
           RAISE ERR_INVALID_OPERATION;           
           
       END IF;
  
  
        -- 1) 넘겨받은 SEND_RECORD를 송신테이블(T_FB_VAN_SEND)에 INSERT합니다.
        ----------------------------------------------------------------------
        
        BEGIN

            INSERT INTO T_FB_VAN_SEND VALUES p_rec_send;
            
        EXCEPTION
            WHEN OTHERS THEN
                v_return_msg := '송신테이블(T_FB_VAN_SEND)에 INSERT하는중 오류발생';
                RAISE ERR_INVALID_OPERATION;
        END;
        
        
        -- 2) 전문파일을 명명규칙에 의하여, 임시디렉토리에 생성합니다. 
        -- 명명규칙 :  사업장코드_은행코드(2)_전문구분코드(6)_날짜(8)_전문번호(6).rec 
        ------------------------------------------------------------------------------
        
        /* 물리적인 OS상의 directory를 가져옵니다.(from DBA_DIRECTORIES ) */
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
                v_return_msg := '이체전문파일을 생성하기위한 OS path정보가 잘못되었습니다';
                RAISE ERR_INVALID_OPERATION;
        END;          
        
        /* 300byte의 전문내역을 buffer에 작성합니다. */
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
        
        /* 파일명을 만듭니다. */
        v_file_name := v_file_name || p_rec_send.ente_code || '_' ||
                                      p_rec_send.bank_code || '_' ||
                                      p_rec_send.docu_code || p_rec_send.upmu_code || '_' ||                                                
                                      p_rec_send.send_date || '_' ||
                                      p_rec_send.docu_numc || '.rec';
                                                
        /* 파일을 OPEN 합니다 .*/
        BEGIN
        
            v_output_file := UTL_FILE.FOPEN('FBS_REALTIME_TEMP_DIR', v_file_name, 'w');
            
        EXCEPTION
            WHEN UTL_FILE.INVALID_OPERATION THEN
                v_return_msg := '전문전문파일생성을 위해 파일을 OPEN하는중 오류발생';
                RAISE ERR_INVALID_OPERATION;
        END;                                                        
        
        /* 파일내용을 WRITE 합니다. */
        BEGIN
             UTL_FILE.PUT_LINE( v_output_file , v_document_buffer );
        EXCEPTION
            WHEN OTHERS THEN
                v_return_msg := '전문파일내용 생성중 오류가 발생하여, 파일생성이 되지 않았습니다.';
                RAISE ERR_MAKE_TEMP_FILE_ERR;
        END;                    

        /* 파일을 닫습니다. */
        BEGIN
            UTL_FILE.FCLOSE( v_output_file );
        EXCEPTION
            WHEN OTHERS THEN
                v_return_msg := '전문파일내용 생성중 오류가 발생하여, 파일생성이 되지 않았습니다.';            
                RAISE ERR_MAKE_TEMP_FILE_ERR;
        END;   
        
        
        -- 3) OS명령어를 사용하여, SEND_DIRECTORY에 MOVE 합니다.
        v_dummy_return := fbs_util_pkg.exec_os_command( 'move /Y '|| v_temp_file_path || v_file_name || ' ' || v_send_file_path || v_file_name );
        
        
        -- 4) 일정시간동안 대기하고 있다가, 수신table에 record가 들어오면, RECORD형 변수에 담은뒤 종료한다.

        /* 프로그램이 시작한 시간을 기록합니다. */
        SELECT TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))*3600 +
               TO_NUMBER(TO_CHAR(SYSDATE,'MI'))*60 +
               TO_NUMBER(TO_CHAR(SYSDATE,'SS')) 
          INTO n_start_time
          FROM DUAL;   
                
        LOOP
            BEGIN
            
               /* 일정시간동안 수신결과가 왔는지 확인합니다. */
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
            
               /* 수신된 결과가 있는 경우, 송신RECORD를 'Y'라고 UPDATE한후, */
               /* 응답코드에 해당하는 응답코드명을 구해서 반환한다.         */
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
                       v_return_msg := '은행오류코드['||p_rec_recv.resp_code ||']가 미등록되어 있습니다.';
                       
                   WHEN OTHERS THEN
                       v_return_msg := '은행오류코드조회시 기타오류발생';                   
               END;
               
            
               EXIT;  -- 정상적으로 결과가 수신되고, UPDATE가 완료되면 LOOP를 빠져나간다.
            
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                
                    -- timeout시간이 초과하는 경우, 응답없음으로 빠져나간다.
                    SELECT TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))*3600 +
                           TO_NUMBER(TO_CHAR(SYSDATE,'MI'))*60 +
                           TO_NUMBER(TO_CHAR(SYSDATE,'SS')) 
                      INTO n_curr_time
                      FROM DUAL;                     
                    IF ( n_curr_time - n_start_time ) > p_timeout THEN
                        v_return_msg := '[응답없음] timeout시간('|| p_timeout ||'초)동안 응답수신 대기하였으나, 은행으로부터 응답없음';
                        EXIT;
                    END IF;
                    
                WHEN OTHERS THEN
                    -- 기타 오류가 발생하는 경우..
                    v_return_msg := '[기타오류] 응답수신처리중 기타오류 발생';
                    EXIT;
            END;        
        END LOOP;     
  
        -- 최종적으로 정상처리된 경우, 'OK'문자열이 반환되며, 기타 오류의 경우, 오류메시지 반환       
        RETURN( v_return_msg );
        
    EXCEPTION
        WHEN ERR_INVALID_OPERATION THEN
            RETURN( v_return_msg );

        WHEN ERR_MAKE_TEMP_FILE_ERR THEN     
            
            -- 파일이 이미 생성된 다음 나오는 EXCEPTION이므로, 이 파일을 삭제하는 로직 
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
