CREATE OR REPLACE PACKAGE CARD_MAIN_PKG IS

        
    /******************************************************************************/
    /*  기능 : 매입(국내/국외)을 기준으로 카드소지자&대리인에게 메일 발송         */
    /******************************************************************************/
    FUNCTION send_job_data_mail( p_send_ymd    IN VARCHAR2 )                -- 메일발송 데이타 기준일자(년월일)
        RETURN VARCHAR2;                                                    -- 메일발송결과 처리 메시지 
        
    /******************************************************************************/
    /*  기능 : 청구 도착 시, 정산기본정보생성&카드소지자&대리인에게 메일발송      */
    /******************************************************************************/
    FUNCTION send_adjust_data_mail( p_adjust_ym  IN VARCHAR2 )              -- 청구 기준일(년월)
        RETURN VARCHAR2;                                                    -- 메일발송결과 처리 메시지
        
    /******************************************************************************/
    /*  기능 : 카드소지자&대리인이 정산완료를 할때, 처리하는 로직                 */
    /******************************************************************************/
    FUNCTION finish_adjust_all( p_adjust_ym   IN VARCHAR2 ,                  -- 정산기준일(년월)
                                p_card_number IN VARCHAR2 ,                  -- 카드번호  
                                p_emp_no      IN VARCHAR2 )                  -- 카드소지자 사번 
        RETURN VARCHAR2;                                                     -- 처리결과 메시지 
        
        
END CARD_MAIN_PKG;
/
CREATE OR REPLACE PACKAGE BODY CARD_MAIN_PKG IS

    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : send_job_data_mail                                    */
    /*  2. 모듈이름  : 매입(국내/국외)을 기준으로 메일 발송                  */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: 법인카드                                              */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - JOB에 등록되어, 매일아침 정해진시간(7시)에 수행되어, BC카드사  */
    /*        로부터 수신된 매입기준(국내/국외)의 데이타에 대하여  카드 소지 */
    /*        자 및 대리인으로 등록된 사우에게 통보메일을 발송한다.          */
    /*                                                                       */
    /*      - 카드 소지자 및 대리인은 카드이력TB(T_CARD_MEMBER_HISTORY)를    */
    /*        근거로 산정하여 발송한다.                                      */
    /*                                                                       */
    /*      - RETURN값은 모든 내역이 정상발송시, "발송성공" 문자열이 반환되  */
    /*        며, 일부 실패한 경우는 "일부발송실패"라고 반환된다.            */
    /*        메일발송에 대한 이력은 LOG_DIR 에 발송이력이 년월일별로 분리   */
    /*        되어, 각 항목별로 발송결과가 LOGGING되어 확인가능하다.         */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/    
    FUNCTION send_job_data_mail( p_send_ymd    IN VARCHAR2 )       -- 메일발송 데이타 기준일자(년월일)
        RETURN VARCHAR2 IS                                         -- 메일발송결과 처리 메시지 
    BEGIN
    
    
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );       
    
    END send_job_data_mail;    
        
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : send_job_data_mail                                    */
    /*  2. 모듈이름  : 청구도착시,정산기본정보생성&소지자&대리인에게 메일발송*/
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: 법인카드                                              */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 매일 결제일 3~5일전에 BC카드에서 수신되는 청구내역이 도착시에  */
    /*        JOB에 등록되어 매일매일 체크하여 수신된 경우, 정해진시간(7시)  */
    /*        청구내역과 그동안 MARKING해둔 내역을 포함하여 카드소지자 및    */
    /*        대리인에게 청구내역을 담은 메일을 발송한다.                    */
    /*                                                                       */    
    /*      - 청구내역이 있는 경우, 청구정산을 위한 기본정보를 가져와서      */
    /*        비용정산마스터(T_CARD_ACCOUNTING_MASTER) 및                    */
    /*        비용정산상세내역(T_CARD_ACCOUNTING_DETAIL)에 INSERT를 합니다.  */
    /*                                                                       */
    /*      - 월중에 카드 소지자가 변경될 수 있으므로, 카드이력TB을 참조하여 */
    /*        (T_CARD_MEMBER_HISTORY 참조) 해당 매입건의 사용자 별로 청구내  */
    /*        역을 산정하여 메일내용에 담아 발송한다.                        */
    /*                                                                       */
    /*      - RETURN값은 모든 내역이 정상발송시, "발송성공" 문자열이 반환되  */
    /*        며, 일부 실패한 경우는 "일부발송실패"라고 반환된다.            */
    /*        메일발송에 대한 이력은 LOG_DIR 에 발송이력이 년월일별로 분리   */
    /*        되어, 각 항목별로 발송결과가 LOGGING되어 확인가능하다.         */
    /*                                                                       */    
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/            
    FUNCTION send_adjust_data_mail( p_adjust_ym  IN VARCHAR2 )       -- 청구 기준일(년월)
        RETURN VARCHAR2 IS                                           -- 메일발송결과 처리 메시지
    BEGIN

        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );       
    
    
    END send_adjust_data_mail;
        
    /*************************************************************************/
    /*                                                                       */
    /*  1. 모듈ID    : finish_adjust_all                                     */
    /*  2. 모듈이름  : 카드소지자&대리인이 정산완료를 할때, 처리하는 로직    */
    /*  3. 시스템    : 회계시스템                                            */
    /*  4. 서브시스템: 법인카드                                              */
    /*  5. 모듈유형  :                                                       */
    /*  6. 모듈언어  : PL/SQL                                                */
    /*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
    /*  8. 모듈DBMS  : Oracle                                                */
    /*  9. 모듈의 목적 및 주요기능                                           */
    /*                                                                       */
    /*      - 카드소지자 혹은 대리인이 "정산완료" ACTION을 취하는 경우, 해당 */
    /*        청구건에 대한 개인분마킹,법인분마킹, 법인분에 대하여는 전표입  */
    /*        력이 완료되었는지 확인 후, 회계시스템으로 자동전표를 생성하고  */
    /*        전표번호(ID,SEQ)를 UPDATE하는 기능을 한다.                     */
    /*                                                                       */
    /*      - RETURN값은 정상적으로 처리완료된 경우, "처리완료"라고 반환되며 */
    /*        오류가 발생한 경우는 "ORA-"오류코드가 만들어지나, 반환되는 값  */
    /*        은 fbs_util_pkg의 format_msg 함수에 의해서 정리된 오류문자열이 */
    /*        반환이 된다.                                                   */
    /*                                                                       */
    /* 10. 최초작성자: LG CNS 신인철                                         */
    /* 11. 최초작성일: 2005년12월21일                                        */
    /* 12. 최종수정자:                                                       */
    /* 13. 최종수정일:                                                       */
    /*************************************************************************/ 
    FUNCTION finish_adjust_all( p_adjust_ym   IN VARCHAR2 ,        -- 정산기준일(년월)
                                p_card_number IN VARCHAR2 ,        -- 카드번호  
                                p_emp_no      IN VARCHAR2 )        -- 카드소지자 사번 
        RETURN VARCHAR2 IS                                         -- 처리결과 메시지   
    BEGIN
    
        -- >>>>>>>>>>>>>   처리로직    <<<<<<<<<<<<<<<<<<        


        RETURN( NULL );    
    
    END finish_adjust_all;  
 
  
END CARD_MAIN_PKG;
/
