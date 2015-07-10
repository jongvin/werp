/*************************************************************************/
/*                                                                       */
/*  1. ���ID    : VIEW_BILL_PAY_DATA                                    */
/*  2. ����̸�  : ���ھ��������� ���޵���Ÿ ��ȸ�� VIEW                 */
/*  3. �ý���    : ȸ��ý���                                            */
/*  4. ����ý���: FBS & ����ī��                                        */
/*  5. �������  : VIEW                                                  */
/*  6. �����  : PL/SQL                                                */
/*  7. ���ȯ��  : Windows2003 Server+ Oracle 9.2.0                      */
/*  8. ���DBMS  : Oracle                                                */
/*  9. ����� ���� �� �ֿ���                                           */
/*                                                                       */
/*     - ���ھ������� ȭ��(�ⳳȮ��/�������/�ⳳ���޵�) �� ��¹�����   */
/*       ���������� ����ϴ� VIEW                                        */
/*                                                                       */
/*     - MAIN���� "�������޵���Ÿ(T_FB_BILL_PAY_DATA)"�� �������� �̷�   */
/*       �� ���� ���� �� ���� �����������̺��� JOIN�Ͽ� ������ ��ȸ      */
/*       DRIVING TABLE�� T_FB_BILL_PAY_DATA�̸�, �������� OUTER JOIN     */
/*                                                                       */
/*     - ����TABLE                                                       */
/*                                                                       */
/*         . ���������̷�(T_FB_BILL_PAY_HISTORY)                         */
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
CREATE OR REPLACE VIEW VIEW_BILL_PAY_DATA AS
    SELECT M1.PAY_SEQ ,                                                     -- �����Ϸù�ȣ
           M1.PAY_METHOD_GUBUN ,                                            -- ���޹�������ڵ�
           M1.PAY_KIND_GUBUN ,                                              -- ���޴�󱸺��ڵ�
           M7.LOOKUP_VALUE AS PAY_KIND_GUBUN_NAME ,                         -- ���޴�󱸺��ڵ�� 
           M1.COMP_CODE ,                                                   -- ������ڵ�
           M4.COMPANY_NAME ,                                                -- ������ 
           M1.PAY_AMT ,                                                     -- ���ޱݾ� 
           M1.PAY_DUE_YMD ,                                                 -- ����(����)������ 
           M1.FUTURE_PAY_DUE_YMD ,                                          -- �������� 
           M1.PAY_YMD ,                                                     -- ����(����)�� 
           M1.PAY_STATUS ,                                                  -- ����ó������ 
           M6.LOOKUP_VALUE AS PAY_STATUS_NAME ,                             -- ����ó�����¸� 
           M1.CHECK_NO ,                                                    -- ��ǥ(����) ��ȣ   
           M1.DESCRIPTION ,                                                 -- ������� 
           M1.VAT_REGISTRATION_NUM ,                                        -- �ŷ�ó����ڹ�ȣ 
           M1.CUST_SEQ ,                                                    -- �ŷ�ó�Ϸù�ȣ 
           M5.CUST_NAME ,                                                   -- �ŷ�ó��  
           M1.OUT_BANK_CODE ,                                               -- ��������ڵ� (MAIN_BANK_CODE)
           M3.BANK_MAIN_NAME AS OUT_BANK_CODE_NAME ,                        -- �������� 
           M1.OUT_ACCOUNT_NO ,                                              -- ���������� 
           REPLACE(M1.OUT_ACCOUNT_NO,'-','') AS NAIVE_OUT_ACCOUNT_NO ,      -- ����������(-���� ����) 
           M1.MAIL_SEND_YN ,                                                -- ���Ϲ߼ۿ���
           M1.SLIP_ID , M1.SLIP_IDSEQ ,                                     -- ��ǥID�� SEQ 
           M1.CASHIER_CONFIRM_DATE ,                                        -- �ⳳȮ���Ͻ� 
           M1.RESULT_TEXT ,                                                 -- ó������޽��� 
           M1.EDI_CREATE_REQ_YN ,                                           -- EDI������û���� 
           M1.PAY_CANCEL_DATE ,                                             -- ��������Ͻ� 
           M1.PAY_CANCEL_REASON ,                                           -- ������һ��� 
           M1.LAST_MODIFY_DATE ,                                            -- ������������ 
           M1.LAST_MODIFY_EMP_NO ,                                          -- �������������ȣ 
           M1.EDI_CREATE_YN ,                                               -- ���� : EDI�������� 
           M1.TRANSFER_YN ,                                                 -- ���� : ���ۿ��� 
           M1.PAY_SUCCESS_YN ,                                              -- ���� : ���޼������� 
           M1.DOCU_NUMC AS LAST_DOCU_NUMC,                                  -- ���� : ���� ������ȣ  
           M1.SEND_DATE AS LAST_SEND_DATE,                                  -- ���� : ���� �۽��Ͻ� 
           M1.RECV_DATE AS LAST_RECV_DATE,                                  -- ���� : ���� �����Ͻ� 
           M1.APPROVAL_NO ,                                                 -- ���� : ���ι�ȣ (����ī��)
           M1.COMMISSION_AMT ,                                              -- ���� : ������ 
           M1.RESULT_CODE AS TRX_RESULT_CODE,                               -- ���� : ó������ڵ�   
           M1.TRX_RESULT_TEXT ,                                             -- ���� : ó������޽��� 
           M1.EDI_HISTORY_SEQ                                               -- ���� : EDI�̷��Ϸù�ȣ 
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