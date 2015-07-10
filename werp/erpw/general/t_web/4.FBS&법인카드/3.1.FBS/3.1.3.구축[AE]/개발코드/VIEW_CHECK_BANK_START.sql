/*************************************************************************/
/*                                                                       */
/*  1. ���ID    : VIEW_CHECK_BANK_START                                 */
/*  2. ����̸�  : FBS���� ����� �� ���࿡ ���Ͽ� ���ÿ��θ� Ȯ���Ѵ�.  */
/*  3. �ý���    : ȸ��ý���                                            */
/*  4. ����ý���: FBS                                                   */
/*  5. �������  : VIEW                                                  */
/*  6. �����  : PL/SQL                                                */
/*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
/*  8. ���DBMS  : Oracle                                                */
/*  9. ����� ���� �� �ֿ���                                           */
/*                                                                       */
/*     - ����-������� MAPPING�Ǿ� �ִ� T_FB_ORG_BANK ���̺��� ������    */
/*       �������� VAN�������̺�(T_FB_VAN_RECV)�� �ִ� ��������������     */
/*       Ȯ���Ͽ�, ���ÿ��ο� ���� LIST�� QUERY�մϴ�                    */
/*                                                                       */
/* 10. �����ۼ���: LG CNS ����ö                                         */
/* 11. �����ۼ���: 2006��1��5��                                          */
/* 12. ����������:                                                       */
/* 13. ����������:                                                       */
/*************************************************************************/ 
CREATE OR REPLACE VIEW VIEW_CHECK_BANK_START AS
    SELECT  CC.COMPANY_NAME , DD.BANK_MAIN_NAME ,
            DECODE(NVL(BB.RESP_CODE,'�� ����'),'0000','���� ����' , '000' , '���� ����' ,'�� ����') AS STATUS ,
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
