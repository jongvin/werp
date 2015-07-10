/*************************************************************************/
/*                                                                       */
/*  1. 모듈ID    : VIEW_CHECK_OBJECT_VALID                               */
/*  2. 모듈이름  : FBS상태메일발송용 관련OBJECT VALID체크 VIEW           */
/*  3. 시스템    : 회계시스템                                            */
/*  4. 서브시스템: FBS & 법인카드                                        */
/*  5. 모듈유형  : VIEW                                                  */
/*  6. 모듈언어  : PL/SQL                                                */
/*  7. 모듈환경  : Windows2003 Server+ Oracle 9.2.0                      */
/*  8. 모듈DBMS  : Oracle                                                */
/*  9. 모듈의 목적 및 주요기능                                           */
/*                                                                       */
/*     - FBS상태메일발송시, OBJECT의 상태를 확인하는 SQL VIEW            */
/*                                                                       */
/* 10. 최초작성자: LG CNS 신인철                                         */
/* 11. 최초작성일: 2005년12월21일                                        */
/* 12. 최종수정자:                                                       */
/* 13. 최종수정일:                                                       */
/*************************************************************************/ 
CREATE OR REPLACE VIEW VIEW_CHECK_OBJECT_VALID AS
        SELECT OBJECT_TYPE,OBJECT_NAME,LAST_DDL_TIME,STATUS 
          FROM USER_OBJECTS 
         WHERE ( OBJECT_TYPE = 'TRIGGER' AND OBJECT_NAME = 'T_FB_VAN_RECV_TRG' )
            OR ( OBJECT_TYPE = 'PACKAGE' AND OBJECT_NAME = 'FBS_MAIN_PKG' )
            OR ( OBJECT_TYPE = 'PACKAGE' AND OBJECT_NAME = 'FBS_UTIL_PKG' )
            OR ( OBJECT_TYPE = 'PACKAGE' AND OBJECT_NAME = 'CARD_MAIN_PKG' )    
        ORDER BY OBJECT_TYPE,OBJECT_NAME;
/
