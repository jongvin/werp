/*************************************************************************/
/*                                                                       */
/*  1. 모듈ID    : VIEW_FBS_ACCOUNTS                                     */
/*  2. 모듈이름  : FBS약정되어 있는 계좌리스트 조회용VIEW                */
/*  3. 시스템    : 회계시스템                                            */
/*  4. 서브시스템: FBS & 법인카드                                        */
/*  5. 모듈유형  : VIEW                                                  */
/*  6. 모듈언어  : PL/SQL                                                */
/*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
/*  8. 모듈DBMS  : Oracle                                                */
/*  9. 모듈의 목적 및 주요기능                                           */
/*                                                                       */
/*     - 약정내역(T_FB_ORG_BANK)에 업체은행이 등록되어 있고,             */
/*       계좌(T_ACCNO_CODE)의 FBS약정여부에 T로 셋팅되어 있는 계좌조회   */
/*     - FBS프로그램의 여러군데에서 계좌조회용으로 사용됨                */
/*                                                                       */
/* 10. 최초작성자: LG CNS 신인철                                         */
/* 11. 최초작성일: 2005년12월21일                                        */
/* 12. 최종수정자:                                                       */
/* 13. 최종수정일:                                                       */
/*************************************************************************/ 
CREATE OR REPLACE VIEW VIEW_FBS_ACCOUNTS AS
        SELECT AA.ACCNO AS ACCOUNT_NUMBER,                            -- FULL계좌번호 
               REPLACE(AA.ACCNO,'-','') AS NAIVE_ACCOUNT_NUMBER,      -- 구분코드(-)가 없는 계좌번호 
               CC.BANK_MAIN_CODE AS BANK_MAIN_CODE,                   -- 은행코드  
               CC.BANK_MAIN_NAME AS BANK_MAIN_NAME,                   -- 은행명 
               DD.BANK_CODE AS BANK_CODE,                             -- 은행지점코드 
               DD.BANK_NAME ,                                         -- 은행지점명 
               AA.COMP_CODE AS COMP_CODE,                             -- 사업장코드 
               EE.COMPANY_NAME AS COMP_NAME ,                         -- 사업장명 
               AA.HSMS_USE_CLS AS HSMS_USE_CLS ,                      -- 분양사용여부 
               AA.FBS_TRANSFER_CLS AS FBS_TRANSFER_CLS,               -- 이체가능계좌여부 
               AA.VIRTUAL_ACCOUNT_CLS AS FBS_VITUAL_ACCT_CLS,         -- 가상계좌모계좌 여부  
               AA.FBS_DISPLAY_ORDER AS FBS_DISPLAY_ORDER              -- 잔액명세표 순서  
          FROM T_ACCNO_CODE AA , 
               T_FB_ORG_BANK BB ,
               T_BANK_MAIN CC ,
               T_BANK_CODE DD ,
               T_COMPANY_ORG EE
         WHERE AA.FBS_ACCOUNT_CLS = 'T'
           AND AA.USE_CLS = 'T'
           AND AA.COMP_CODE = BB.COMP_CODE
           AND AA.BANK_CODE = DD.BANK_CODE
           AND CC.BANK_MAIN_CODE = DD.BANK_MAIN_CODE
           AND CC.BANK_MAIN_CODE = BB.BANK_MAIN_CODE
           AND AA.COMP_CODE = EE.COMP_CODE
        ORDER BY CC.BANK_MAIN_CODE,AA.ACCNO;
/
