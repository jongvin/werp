/*************************************************************************/
/*                                                                       */
/*  1. ���ID    : VIEW_CHECK_OBJECT_VALID                               */
/*  2. ����̸�  : FBS���¸��Ϲ߼ۿ� ����OBJECT VALIDüũ VIEW           */
/*  3. �ý���    : ȸ��ý���                                            */
/*  4. ����ý���: FBS & ����ī��                                        */
/*  5. �������  : VIEW                                                  */
/*  6. �����  : PL/SQL                                                */
/*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
/*  8. ���DBMS  : Oracle                                                */
/*  9. ����� ���� �� �ֿ���                                           */
/*                                                                       */
/*     - FBS���¸��Ϲ߼۽�, OBJECT�� ���¸� Ȯ���ϴ� SQL VIEW            */
/*                                                                       */
/* 10. �����ۼ���: LG CNS ����ö                                         */
/* 11. �����ۼ���: 2005��12��21��                                        */
/* 12. ����������:                                                       */
/* 13. ����������:                                                       */
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
