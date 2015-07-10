CREATE OR REPLACE PACKAGE FBS_BANK_PKG IS

    /*----------------------------------------------------------------------------*/
    /* 은행코드                                                                   */
    /*----------------------------------------------------------------------------*/    
    KIUP_BANK_CD                   VARCHAR2(2) := '03';   -- 기업은행 
    KUKMIN_BANK_CD                 VARCHAR2(2) := '04';   -- 국민은행     
    WOORI_BANK_CD                  VARCHAR2(2) := '20';   -- 우리은행     
    HANA_BANK_CD                   VARCHAR2(2) := '81';   -- 하나은행        

    
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


    /******************************************************************************/
    /*  기능 : 전문파일 생성 테스트용                                             */
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
        RETURN VARCHAR2;                                                           -- 함수 처리결과 메시지     
                
                
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
        RETURN VARCHAR2 IS                                                         -- 함수 처리결과 메시지     
  
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
