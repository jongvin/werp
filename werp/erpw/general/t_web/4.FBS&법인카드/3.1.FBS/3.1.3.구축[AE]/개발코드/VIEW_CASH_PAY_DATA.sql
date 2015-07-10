/*************************************************************************/
/*                                                                       */
/*  1. 모듈ID    : VIEW_CASH_PAY_DATA                                    */
/*  2. 모듈이름  : 현금기준의 지급데이타 조회용 VIEW                     */
/*  3. 시스템    : 회계시스템                                            */
/*  4. 서브시스템: FBS & 법인카드                                        */
/*  5. 모듈유형  : VIEW                                                  */
/*  6. 모듈언어  : PL/SQL                                                */
/*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
/*  8. 모듈DBMS  : Oracle                                                */
/*  9. 모듈의 목적 및 주요기능                                           */
/*                                                                       */
/*     - 현금이체관련 화면(출납확인/팀장승인/출납지급등) 및 출력물에서   */
/*       공통적으로 사용하는 VIEW                                        */
/*                                                                       */
/*     - MAIN으로 "현금지급데이타(T_FB_CASH_PAY_DATA)"를 기준으로 이력   */
/*       에 대한 정보 및 관련 기준정보테이블을 JOIN하여 정보를 조회      */
/*       DRIVING TABLE은 T_FB_CASH_PAY_DATA이며, 나머지는 OUTER JOIN     */
/*                                                                       */
/*     - 유관TABLE                                                       */
/*                                                                       */
/*         . 현급지급분할데이타(T_FB_CASH_PAY_DIVIDED_DATA)              */
/*         . 현금지급이력(T_FB_CASH_PAY_HISTORY)                         */
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
CREATE OR REPLACE VIEW VIEW_CASH_PAY_DATA AS
      SELECT M1.PAY_SEQ ,                                                  -- 지급일련번호 
             M1.PAY_METHOD_GUBUN ,                                         -- 지급방법구분코드
             M1.PAY_KIND_GUBUN ,                                           -- 지급대상구분코드 
             M7.LOOKUP_VALUE AS PAY_KIND_GUBUN_NAME ,                      -- 지급대상구분코드명 
             M1.COMP_CODE ,                                                -- 사업장코드
             M4.COMPANY_NAME ,                                             -- 사업장명 
             M1.PAY_AMT ,                                                  -- 지급금액 
             M1.PAY_DUE_YMD ,                                              -- 지급 예정일
             M1.PAY_YMD ,                                                  -- 실 지급일 
             M1.PAY_STATUS ,                                               -- 지급처리상태
             M6.LOOKUP_VALUE AS PAY_STATUS_NAME ,                          -- 지급처리상태명 
             M1.DESCRIPTION ,                                              -- 적요사항
             M1.IN_BANK_CODE ,                                             -- 입금은행코드   
             M2.BANK_MAIN_NAME AS IN_BANK_CODE_NAME ,                      -- 입금은행명 
             M1.IN_ACCOUNT_NO ,                                            -- 입금계좌번호
             REPLACE(M1.IN_ACCOUNT_NO,'-','') AS NAIVE_IN_ACCOUNT_NO ,     -- 입금계좌번호(-문자 제외) 
             M1.ACCT_HOLDER_NAME ,                                         -- 예금주명 
             M1.OUT_BANK_CODE ,                                            -- 출금은행코드 
             M3.BANK_MAIN_NAME AS OUT_BANK_CODE_NAME ,                     -- 출금은행명 
             M1.OUT_ACCOUNT_NO ,                                           -- 출금계좌번호 
             REPLACE(M1.OUT_ACCOUNT_NO,'-','') AS NAIVE_OUT_ACCOUNT_NO ,   -- 출금계좌번호(-문자 제외)   
             M1.CUST_SEQ ,                                                 -- 거래처일련번호  
             M5.CUST_NAME ,                                                -- 거래처명 
             M1.PAY_SUCCESS_AMT ,                                          -- 지급성공금액 
             M1.PAY_FAIL_AMT ,                                             -- 지급실패금액 
             M1.MAIL_SEND_YN ,                                             -- 메일발송여부 
             M1.SLIP_ID , M1.SLIP_IDSEQ ,                                  -- 전표ID 및 SEQ 
             M1.CASHIER_CONFIRM_DATE ,                                     -- 출납확인일시 
             M1.MANAGER_CONFIRM_DATE ,                                     -- 팀장승인일시 
             M1.RESULT_TEXT ,                                              -- 처리결과내용  
             M1.EDI_CREATE_REQ_YN ,                                        -- EDI생성요청여부 
             M1.PAY_CANCEL_DATE ,                                          -- 지급취소일시 
             M1.PAY_CANCEL_REASON ,                                        -- 지급취소사유 
             M1.LAST_MODIFY_DATE ,                                         -- 최종수정일시 
             M1.LAST_MODIFY_EMP_NO ,                                       -- 최종수정사원번호 
             M1.DIV_COUNT ,                                                -- 분할 : 데이타 갯수 
             M1.DIV_SEQ_MIN ,                                              -- 분할 : 일련번호 최소값 
             M1.DIV_SEQ_MAX ,                                              -- 분할 : 일련번호 최대값 
             M1.DIV_PAY_AMT_SUM ,                                          -- 분할 : 지급금액 합 
             M1.DIV_COMMISSION_AMT_SUM ,                                   -- 분할 : 수수료(합계)  
             M1.TRX_EDI_CREATE_CNT ,                                       -- 전송 : EDI생성 갯수 
             M1.TRX_TRANSFER_CNT ,                                         -- 전송 : 전송갯수
             M1.TRX_PAY_SUCCESS_CNT ,                                      -- 전송 : 처리성공갯수
             M1.TRX_DOCU_NUMC AS LAST_TRX_DOCU_NUMC,                       -- 전송 : 최종전문번호 
             M1.TRX_SEND_DATE AS LAST_TRX_SEND_DATE,                       -- 전송 : 최종송신일시 
             M1.TRX_RECV_DATE AS LAST_TRX_RECV_DATE,                       -- 전송 : 최종수신일시 
             M1.TRX_EDI_HISTORY_SEQ AS MAX_TRX_EDI_HISTORY_SEQ,            -- 전송 : 최대EDI이련일련번호 
             M1.TRX_EDI_RECORD_SEQ AS MAX_TRX_EDI_RECORD_SEQ               -- 전송 : 최대EDI레코드 일련번호 
        FROM (SELECT XX.*,YY.*
                FROM T_FB_CASH_PAY_DATA XX ,
                    ( SELECT AA.PAY_SEQ AS DIV_PAY_SEQ, 
                             COUNT(*) AS DIV_COUNT,
                             MIN(AA.DIV_SEQ) AS DIV_SEQ_MIN,
                             MAX(AA.DIV_SEQ) AS DIV_SEQ_MAX,
                             SUM(AA.PAY_AMT) AS DIV_PAY_AMT_SUM, 
                             SUM(AA.COMMISSION_AMT) AS DIV_COMMISSION_AMT_SUM,
                             MAX(AA.PAY_YMD) AS DIV_PAY_YMD,
                             SUM(DECODE(NVL(BB.EDI_CREATE_YN,'N'),'Y',1,0)) AS TRX_EDI_CREATE_CNT,
                             SUM(DECODE(NVL(BB.TRANSFER_YN,'N'),'Y',1,0)) AS TRX_TRANSFER_CNT,
                             SUM(DECODE(NVL(BB.PAY_SUCCESS_YN,'N'),'Y',1,0)) AS TRX_PAY_SUCCESS_CNT,
                             MAX(BB.DOCU_NUMC) AS TRX_DOCU_NUMC,
                             MAX(BB.SEND_DATE) AS TRX_SEND_DATE,
                             MAX(BB.RECV_DATE) AS TRX_RECV_DATE,
                             MAX(BB.EDI_HISTORY_SEQ) AS TRX_EDI_HISTORY_SEQ,
                             MAX(BB.EDI_RECORD_SEQ) AS TRX_EDI_RECORD_SEQ
                        FROM T_FB_CASH_PAY_DIVIDED_DATA AA,
                             T_FB_CASH_PAY_HISTORY BB,
                             (SELECT X.PAY_SEQ, X.DIV_SEQ ,
                                     MAX(Y.TRX_SEQ) AS MAX_TRX_SEQ
                                FROM T_FB_CASH_PAY_DIVIDED_DATA X ,
                                     T_FB_CASH_PAY_HISTORY Y
                               WHERE X.PAY_SEQ = Y.PAY_SEQ (+)
                                 AND X.DIV_SEQ = Y.DIV_SEQ (+)
                               GROUP BY X.PAY_SEQ,X.DIV_SEQ ) CC
                       WHERE CC.PAY_SEQ = AA.PAY_SEQ (+)
                         AND CC.DIV_SEQ = AA.DIV_SEQ (+)
                         AND CC.PAY_SEQ = BB.PAY_SEQ (+)
                         AND CC.DIV_SEQ = BB.DIV_SEQ (+)
                         AND CC.MAX_TRX_SEQ = BB.TRX_SEQ (+) 
                       GROUP BY AA.PAY_SEQ) YY     
              WHERE XX.PAY_SEQ = YY.DIV_PAY_SEQ (+) ) M1 ,
              T_BANK_MAIN M2 ,
              T_BANK_MAIN M3 ,
              T_COMPANY_ORG M4 ,
              T_CUST_CODE M5 ,
              (SELECT * FROM T_FB_LOOKUP_VALUES WHERE LOOKUP_TYPE = 'CASH_PAY_STATUS') M6 ,
              (SELECT * FROM T_FB_LOOKUP_VALUES WHERE LOOKUP_TYPE = 'PAY_KIND_GUBUN') M7        
       WHERE  M1.IN_BANK_CODE = M2.BANK_MAIN_CODE (+)
         AND  M1.OUT_BANK_CODE = M3.BANK_MAIN_CODE (+)
         AND  M1.COMP_CODE = M4.COMP_CODE (+)
         AND  M1.CUST_SEQ = M5.CUST_SEQ (+)          
         AND  M1.PAY_STATUS = M6.LOOKUP_CODE (+)
         AND  M1.PAY_KIND_GUBUN = M7.LOOKUP_CODE (+) ;
/
