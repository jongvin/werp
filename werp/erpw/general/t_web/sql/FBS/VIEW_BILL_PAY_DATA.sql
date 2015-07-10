/*************************************************************************/
/*                                                                       */
/*  1. 모듈ID    : VIEW_BILL_PAY_DATA                                    */
/*  2. 모듈이름  : 전자어음기준의 지급데이타 조회용 VIEW                 */
/*  3. 시스템    : 회계시스템                                            */
/*  4. 서브시스템: FBS & 법인카드                                        */
/*  5. 모듈유형  : VIEW                                                  */
/*  6. 모듈언어  : PL/SQL                                                */
/*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
/*  8. 모듈DBMS  : Oracle                                                */
/*  9. 모듈의 목적 및 주요기능                                           */
/*                                                                       */
/*     - 전자어음관련 화면(출납확인/팀장승인/출납지급등) 및 출력물에서   */
/*       공통적으로 사용하는 VIEW                                        */
/*                                                                       */
/*     - MAIN으로 "어음지급데이타(T_FB_BILL_PAY_DATA)"를 기준으로 이력   */
/*       에 대한 정보 및 관련 기준정보테이블을 JOIN하여 정보를 조회      */
/*       DRIVING TABLE은 T_FB_BILL_PAY_DATA이며, 나머지는 OUTER JOIN     */
/*                                                                       */
/*     - 유관TABLE                                                       */
/*                                                                       */
/*         . 어음지급이력(T_FB_BILL_PAY_HISTORY)                         */
/*         . 코드_은행본점(T_BANK_MAIN)                                  */
/*         . 코드_사업장_ORG (T_COMPANY_ORG)                             */
/*         . 거래처코드(T_CUST_CODE)                                     */
/*         . 공통코드(T_FB_LOOKUP_VALUES)                                */
/*                                                                       */
/* 10. 최초작성자: LG CNS 신인철                                         */
/* 11. 최초작성일: 2006년1월5일                                          */
/* 12. 최종수정자:                                                       */
/* 13. 최종수정일:                                                       */
/*************************************************************************/ 
CREATE OR REPLACE VIEW VIEW_BILL_PAY_DATA AS
    SELECT M1.PAY_SEQ ,                                                     -- 지급일련번호
           M1.PAY_METHOD_GUBUN ,                                            -- 지급방법구분코드
           M1.PAY_KIND_GUBUN ,                                              -- 지급대상구분코드
           M7.LOOKUP_VALUE AS PAY_KIND_GUBUN_NAME ,                         -- 지급대상구분코드명 
           M1.COMP_CODE ,                                                   -- 사업장코드
           M4.COMPANY_NAME ,                                                -- 사업장명 
           M1.PAY_AMT ,                                                     -- 지급금액 
           M1.PAY_DUE_YMD ,                                                 -- 발행(지급)예정일 
           M1.FUTURE_PAY_DUE_YMD ,                                          -- 만기일자 
           M1.PAY_YMD ,                                                     -- 발행(지급)일 
           M1.PAY_STATUS ,                                                  -- 지급처리상태 
           M6.LOOKUP_VALUE AS PAY_STATUS_NAME ,                             -- 지급처리상태명 
           M1.CHECK_NO ,                                                    -- 수표(어음) 번호   
           M1.DESCRIPTION ,                                                 -- 적요사항 
           M1.VAT_REGISTRATION_NUM ,                                        -- 거래처사업자번호 
           M1.CUST_SEQ ,                                                    -- 거래처일련번호 
           M5.CUST_NAME ,                                                   -- 거래처명  
           M1.OUT_BANK_CODE ,                                               -- 출금은행코드 (MAIN_BANK_CODE)
           M3.BANK_MAIN_NAME AS OUT_BANK_CODE_NAME ,                        -- 출금은행명 
           M1.OUT_ACCOUNT_NO ,                                              -- 출금은행계좌 
           REPLACE(M1.OUT_ACCOUNT_NO,'-','') AS NAIVE_OUT_ACCOUNT_NO ,      -- 출금은행계좌(-문자 제외) 
           M1.MAIL_SEND_YN ,                                                -- 메일발송여부
           M1.SLIP_ID , M1.SLIP_IDSEQ ,                                     -- 전표ID와 SEQ 
           M1.CASHIER_CONFIRM_DATE ,                                        -- 출납확인일시 
           M1.RESULT_TEXT ,                                                 -- 처리결과메시지 
           M1.EDI_CREATE_REQ_YN ,                                           -- EDI생성요청여부 
           M1.PAY_CANCEL_DATE ,                                             -- 지급취소일시 
           M1.PAY_CANCEL_REASON ,                                           -- 지급취소사유 
           M1.LAST_MODIFY_DATE ,                                            -- 최종수정일자 
           M1.LAST_MODIFY_EMP_NO ,                                          -- 최종수정사원번호 
           M1.EDI_CREATE_YN ,                                               -- 전송 : EDI생성여부 
           M1.TRANSFER_YN ,                                                 -- 전송 : 전송여부 
           M1.PAY_SUCCESS_YN ,                                              -- 전송 : 지급성공여부 
           M1.DOCU_NUMC AS LAST_DOCU_NUMC,                                  -- 전송 : 최종 전문번호  
           M1.SEND_DATE AS LAST_SEND_DATE,                                  -- 전송 : 최종 송신일시 
           M1.RECV_DATE AS LAST_RECV_DATE,                                  -- 전송 : 최종 수신일시 
           M1.APPROVAL_NO ,                                                 -- 전송 : 승인번호 (구매카드)
           M1.COMMISSION_AMT ,                                              -- 전송 : 수수료 
           M1.RESULT_CODE AS TRX_RESULT_CODE,                               -- 전송 : 처리결과코드   
           M1.TRX_RESULT_TEXT ,                                             -- 전송 : 처리결과메시지 
           M1.EDI_HISTORY_SEQ                                               -- 전송 : EDI이력일련번호 
      FROM (SELECT X.* , 
                   Y.EDI_CREATE_YN , Y.TRANSFER_YN , Y.PAY_SUCCESS_YN , Y.DOCU_NUMC , Y.SEND_DATE , Y.RECV_DATE ,
                   Y.APPROVAL_NO , Y.COMMISSION_AMT , Y.RESULT_CODE , Y.RESULT_TEXT AS TRX_RESULT_TEXT ,
                   Y.EDI_HISTORY_SEQ
              FROM T_FB_BILL_PAY_DATA X ,
                   (SELECT A.*
                      FROM T_FB_BILL_PAY_HISTORY A ,
                          (SELECT PAY_SEQ , MAX(TRX_SEQ) AS MAX_TRX_SEQ
                             FROM T_FB_BILL_PAY_HISTORY
                            GROUP BY PAY_SEQ ) B
                     WHERE A.PAY_SEQ = B.PAY_SEQ 
                       AND A.TRX_SEQ = B.MAX_TRX_SEQ ) Y
             WHERE X.PAY_SEQ = Y.PAY_SEQ (+) ) M1 ,
            T_BANK_MAIN M3 ,
            T_COMPANY_ORG M4 ,
            T_CUST_CODE M5 ,
            (SELECT * FROM T_FB_LOOKUP_VALUES WHERE LOOKUP_TYPE = 'CASH_PAY_STATUS') M6 ,
            (SELECT * FROM T_FB_LOOKUP_VALUES WHERE LOOKUP_TYPE = 'PAY_KIND_GUBUN') M7   
     WHERE  M1.OUT_BANK_CODE = M3.BANK_MAIN_CODE (+)
       AND  M1.COMP_CODE = M4.COMP_CODE (+)
       AND  M1.CUST_SEQ = M5.CUST_SEQ (+)          
       AND  M1.PAY_STATUS = M6.LOOKUP_CODE (+)
       AND  M1.PAY_KIND_GUBUN = M7.LOOKUP_CODE (+)  ;
/