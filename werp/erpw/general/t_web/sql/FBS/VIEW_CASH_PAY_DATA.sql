/*************************************************************************/
/*                                                                       */
/*  1. ���ID    : VIEW_CASH_PAY_DATA                                    */
/*  2. ����̸�  : ���ݱ����� ���޵���Ÿ ��ȸ�� VIEW                     */
/*  3. �ý���    : ȸ��ý���                                            */
/*  4. ����ý���: FBS & ����ī��                                        */
/*  5. �������  : VIEW                                                  */
/*  6. �����  : PL/SQL                                                */
/*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
/*  8. ���DBMS  : Oracle                                                */
/*  9. ����� ���� �� �ֿ���                                           */
/*                                                                       */
/*     - ������ü���� ȭ��(�ⳳȮ��/�������/�ⳳ���޵�) �� ��¹�����   */
/*       ���������� ����ϴ� VIEW                                        */
/*                                                                       */
/*     - MAIN���� "�������޵���Ÿ(T_FB_CASH_PAY_DATA)"�� �������� �̷�   */
/*       �� ���� ���� �� ���� �����������̺��� JOIN�Ͽ� ������ ��ȸ      */
/*       DRIVING TABLE�� T_FB_CASH_PAY_DATA�̸�, �������� OUTER JOIN     */
/*                                                                       */
/*     - ����TABLE                                                       */
/*                                                                       */
/*         . �������޺��ҵ���Ÿ(T_FB_CASH_PAY_DIVIDED_DATA)              */
/*         . ���������̷�(T_FB_CASH_PAY_HISTORY)                         */
/*         . �ڵ�_���ົ��(T_BANK_MAIN)                                  */
/*         . �ڵ�_�����_ORG (T_COMPANY_ORG)                             */
/*         . �ŷ�ó�ڵ�(T_CUST_CODE)                                     */
/*         . �����ڵ�(T_FB_LOOKUP_VALUES)                                */
/*                                                                       */
/* 10. �����ۼ���: LG CNS ����ö                                         */
/* 11. �����ۼ���: 2006��1��5��                                          */
/* 12. ����������:                                                       */
/* 13. ����������:                                                       */
/*************************************************************************/ 
CREATE OR REPLACE VIEW VIEW_CASH_PAY_DATA AS
      SELECT M1.PAY_SEQ ,                                                  -- �����Ϸù�ȣ 
             M1.PAY_METHOD_GUBUN ,                                         -- ���޹�������ڵ�
             M1.PAY_KIND_GUBUN ,                                           -- ���޴�󱸺��ڵ� 
             M7.LOOKUP_VALUE AS PAY_KIND_GUBUN_NAME ,                      -- ���޴�󱸺��ڵ�� 
             M1.COMP_CODE ,                                                -- ������ڵ�
             M4.COMPANY_NAME ,                                             -- ������ 
             M1.PAY_AMT ,                                                  -- ���ޱݾ� 
             M1.PAY_DUE_YMD ,                                              -- ���� ������
             M1.PAY_YMD ,                                                  -- �� ������ 
             M1.PAY_STATUS ,                                               -- ����ó������
             M6.LOOKUP_VALUE AS PAY_STATUS_NAME ,                          -- ����ó�����¸� 
             M1.DESCRIPTION ,                                              -- �������
             M1.IN_BANK_CODE ,                                             -- �Ա������ڵ�   
             M2.BANK_MAIN_NAME AS IN_BANK_CODE_NAME ,                      -- �Ա������ 
             M1.IN_ACCOUNT_NO ,                                            -- �Աݰ��¹�ȣ
             REPLACE(M1.IN_ACCOUNT_NO,'-','') AS NAIVE_IN_ACCOUNT_NO ,     -- �Աݰ��¹�ȣ(-���� ����) 
             M1.ACCT_HOLDER_NAME ,                                         -- �����ָ� 
             M1.OUT_BANK_CODE ,                                            -- ��������ڵ� 
             M3.BANK_MAIN_NAME AS OUT_BANK_CODE_NAME ,                     -- �������� 
             M1.OUT_ACCOUNT_NO ,                                           -- ��ݰ��¹�ȣ 
             REPLACE(M1.OUT_ACCOUNT_NO,'-','') AS NAIVE_OUT_ACCOUNT_NO ,   -- ��ݰ��¹�ȣ(-���� ����)   
             M1.CUST_SEQ ,                                                 -- �ŷ�ó�Ϸù�ȣ  
             M5.CUST_NAME ,                                                -- �ŷ�ó�� 
             M1.PAY_SUCCESS_AMT ,                                          -- ���޼����ݾ� 
             M1.PAY_FAIL_AMT ,                                             -- ���޽��бݾ� 
             M1.MAIL_SEND_YN ,                                             -- ���Ϲ߼ۿ��� 
             M1.SLIP_ID , M1.SLIP_IDSEQ ,                                  -- ��ǥID �� SEQ 
             M1.CASHIER_CONFIRM_DATE ,                                     -- �ⳳȮ���Ͻ� 
             M1.MANAGER_CONFIRM_DATE ,                                     -- ��������Ͻ� 
             M1.RESULT_TEXT ,                                              -- ó���������  
             M1.EDI_CREATE_REQ_YN ,                                        -- EDI������û���� 
             M1.PAY_CANCEL_DATE ,                                          -- ��������Ͻ� 
             M1.PAY_CANCEL_REASON ,                                        -- ������һ��� 
             M1.LAST_MODIFY_DATE ,                                         -- ���������Ͻ� 
             M1.LAST_MODIFY_EMP_NO ,                                       -- �������������ȣ 
             M1.DIV_COUNT ,                                                -- ���� : ����Ÿ ���� 
             M1.DIV_SEQ_MIN ,                                              -- ���� : �Ϸù�ȣ �ּҰ� 
             M1.DIV_SEQ_MAX ,                                              -- ���� : �Ϸù�ȣ �ִ밪 
             M1.DIV_PAY_AMT_SUM ,                                          -- ���� : ���ޱݾ� �� 
             M1.DIV_COMMISSION_AMT_SUM ,                                   -- ���� : ������(�հ�)  
             M1.TRX_EDI_CREATE_CNT ,                                       -- ���� : EDI���� ���� 
             M1.TRX_TRANSFER_CNT ,                                         -- ���� : ���۰���
             M1.TRX_PAY_SUCCESS_CNT ,                                      -- ���� : ó����������
             M1.TRX_DOCU_NUMC AS LAST_TRX_DOCU_NUMC,                       -- ���� : ����������ȣ 
             M1.TRX_SEND_DATE AS LAST_TRX_SEND_DATE,                       -- ���� : �����۽��Ͻ� 
             M1.TRX_RECV_DATE AS LAST_TRX_RECV_DATE,                       -- ���� : ���������Ͻ� 
             M1.TRX_EDI_HISTORY_SEQ AS MAX_TRX_EDI_HISTORY_SEQ,            -- ���� : �ִ�EDI�̷��Ϸù�ȣ 
             M1.TRX_EDI_RECORD_SEQ AS MAX_TRX_EDI_RECORD_SEQ               -- ���� : �ִ�EDI���ڵ� �Ϸù�ȣ 
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
