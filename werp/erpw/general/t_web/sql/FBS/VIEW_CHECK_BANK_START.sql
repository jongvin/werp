/*************************************************************************/
/*                                                                       */
/*  1. 모듈ID    : VIEW_CHECK_BANK_START                                 */
/*  2. 모듈이름  : FBS약정 사업장 및 은행에 대하여 개시여부를 확인한다.  */
/*  3. 시스템    : 회계시스템                                            */
/*  4. 서브시스템: FBS                                                   */
/*  5. 모듈유형  : VIEW                                                  */
/*  6. 모듈언어  : PL/SQL                                                */
/*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
/*  8. 모듈DBMS  : Oracle                                                */
/*  9. 모듈의 목적 및 주요기능                                           */
/*                                                                       */
/*     - 은행-사업장이 MAPPING되어 있는 T_FB_ORG_BANK 테이블의 내역을    */
/*       기준으로 VAN수신테이블(T_FB_VAN_RECV)에 있는 개시응답전문을     */
/*       확인하여, 개시여부에 대한 LIST를 QUERY합니다                    */
/*                                                                       */
/* 10. 최초작성자: LG CNS 신인철                                         */
/* 11. 최초작성일: 2006년1월5일                                          */
/* 12. 최종수정자:                                                       */
/* 13. 최종수정일:                                                       */
/*************************************************************************/ 
CREATE OR REPLACE VIEW VIEW_CHECK_BANK_START AS
    SELECT  CC.COMPANY_NAME , DD.BANK_MAIN_NAME ,
            DECODE(NVL(BB.RESP_CODE,'미 개시'),'0000','정상 개시' , '000' , '정상 개시' ,'미 개시') AS STATUS ,
            BB.SEND_DATETIME 
      FROM   (SELECT BANK_MAIN_CODE , ENTE_CODE , COMP_CODE
                FROM T_FB_ORG_BANK 
               WHERE ENTE_CODE IS NOT NULL
             ) AA ,
             (SELECT ENTE_CODE,BANK_CODE,MIN(RESP_CODE) AS RESP_CODE,MAX(SEND_DATE||SEND_TIME) AS SEND_DATETIME
                FROM T_FB_VAN_RECV
               WHERE SEND_DATE = TO_CHAR(SYSDATE,'YYYYMMDD')
                 AND DOCU_CODE IN ( '0810' , '0800' )
                 AND UPMU_CODE = '100'
               GROUP BY ENTE_CODE,BANK_CODE  
             ) BB ,
             T_COMPANY_ORG CC ,
             T_BANK_MAIN DD             
    WHERE AA.BANK_MAIN_CODE = BB.BANK_CODE (+)
      AND AA.ENTE_CODE = BB.ENTE_CODE (+)
      AND AA.COMP_CODE = CC.COMP_CODE
      AND AA.BANK_MAIN_CODE = DD.BANK_MAIN_CODE
    ORDER BY CC.COMPANY_NAME , DD.BANK_MAIN_CODE;      

/
