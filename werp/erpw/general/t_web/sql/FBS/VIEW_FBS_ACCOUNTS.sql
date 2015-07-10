/*************************************************************************/
/*                                                                       */
/*  1. ���ID    : VIEW_FBS_ACCOUNTS                                     */
/*  2. ����̸�  : FBS�����Ǿ� �ִ� ���¸���Ʈ ��ȸ��VIEW                */
/*  3. �ý���    : ȸ��ý���                                            */
/*  4. ����ý���: FBS & ����ī��                                        */
/*  5. �������  : VIEW                                                  */
/*  6. �����  : PL/SQL                                                */
/*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
/*  8. ���DBMS  : Oracle                                                */
/*  9. ����� ���� �� �ֿ���                                           */
/*                                                                       */
/*     - ��������(T_FB_ORG_BANK)�� ��ü������ ��ϵǾ� �ְ�,             */
/*       ����(T_ACCNO_CODE)�� FBS�������ο� T�� ���õǾ� �ִ� ������ȸ   */
/*     - FBS���α׷��� ������������ ������ȸ������ ����                */
/*                                                                       */
/* 10. �����ۼ���: LG CNS ����ö                                         */
/* 11. �����ۼ���: 2005��12��21��                                        */
/* 12. ����������:                                                       */
/* 13. ����������:                                                       */
/*************************************************************************/ 
CREATE OR REPLACE VIEW VIEW_FBS_ACCOUNTS AS
        SELECT AA.ACCNO AS ACCOUNT_NUMBER,                            -- FULL���¹�ȣ 
               REPLACE(AA.ACCNO,'-','') AS NAIVE_ACCOUNT_NUMBER,      -- �����ڵ�(-)�� ���� ���¹�ȣ 
               CC.BANK_MAIN_CODE AS BANK_MAIN_CODE,                   -- �����ڵ�  
               CC.BANK_MAIN_NAME AS BANK_MAIN_NAME,                   -- ����� 
               DD.BANK_CODE AS BANK_CODE,                             -- ���������ڵ� 
               DD.BANK_NAME ,                                         -- ���������� 
               AA.COMP_CODE AS COMP_CODE,                             -- ������ڵ� 
               EE.COMPANY_NAME AS COMP_NAME ,                         -- ������ 
               AA.HSMS_USE_CLS AS HSMS_USE_CLS ,                      -- �о��뿩�� 
               AA.FBS_TRANSFER_CLS AS FBS_TRANSFER_CLS,               -- ��ü���ɰ��¿��� 
               AA.VIRTUAL_ACCOUNT_CLS AS FBS_VITUAL_ACCT_CLS,         -- ������¸���� ����  
               AA.FBS_DISPLAY_ORDER AS FBS_DISPLAY_ORDER              -- �ܾ׸�ǥ ����  
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
