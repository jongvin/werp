CREATE OR REPLACE PROCEDURE Y_Sp_H_Fbs_Apply_Income_Core(AS_FB_SEQ IN NUMBER,
                                                    AS_FB_ACCOUNT_NUM IN VARCHAR2 , 
                                                    AS_FB_GUBUN_CD IN VARCHAR2, 
                                                    AS_FB_BANK_CD IN VARCHAR2, 
                                                    AS_FB_RECV_AMT IN NUMBER, 
                                                    AS_FB_REMAIN_AMT IN NUMBER, 
                                                    AS_FB_ACCOUNT_NAME IN VARCHAR2, 
                                                    AS_FB_CMS IN VARCHAR2, 
                                                    AS_FB_RECV_DATE IN VARCHAR2, 
                                                    AS_FB_RECV_TIME IN VARCHAR2, 
                                                    AS_FB_DOCU_NUMC IN VARCHAR2, 
                                                    AS_FB_JUMIN_NO IN VARCHAR2, 
                                                    AS_TRANSFER_DATE IN DATE,
                                                    AS_APPLY_DATE OUT DATE,
                                                    AS_APPLY_OK OUT   VARCHAR2,
                                                    AS_DEPT_CODE OUT  VARCHAR2, 
                                                    AS_SELL_CODE OUT  VARCHAR2,
                                                    AS_DONGHO    OUT  VARCHAR2,
                                                    AS_SEQ       OUT  NUMBER,
                                                    AS_RECEIPT_DATE OUT DATE,
                                                    AS_DAILY_SEQ    OUT NUMBER,
                                                    AS_DEPOSIT_NO   OUT VARCHAR2,
                                                    AS_V_ACCOUNT_NO OUT VARCHAR2,
                                                    AS_ERROR_CODE OUT VARCHAR2,
                                                    AS_ERROR_MSG OUT VARCHAR2) IS
    
    tmpvar INTEGER;
    C_CNT INTEGER;
    rec_h_fb_intf_income H_FB_INTF_INCOME%ROWTYPE;
    
    V_DEPOSIT_NO H_CODE_V_ACCOUNT.DEPOSIT_NO%TYPE;
    V_DEPT_CODE H_SALE_MASTER.DEPT_CODE%TYPE;
    V_SELL_CODE H_SALE_MASTER.SELL_CODE%TYPE;
    V_DONGHO H_SALE_MASTER.DONGHO%TYPE;
    V_SEQ H_SALE_MASTER.SEQ%TYPE;
    V_DAILY_SEQ H_SALE_INCOME_DAILY.DAILY_SEQ%TYPE;
    V_AMT       H_SALE_INCOME_DAILY.AMT%TYPE; 
    
BEGIN
   rec_h_fb_intf_income.fb_seq :=as_fb_seq;  
   
   IF LENGTH(TRIM(rec_h_fb_intf_income.fb_seq)) IS NULL THEN
      AS_ERROR_CODE := '10000';
      AS_ERROR_MSG  := '���۹�ȣ(SEQ)�� �����ϴ�/ó���Ұ�';
      GOTO ERROR_ROUTINE;
   END IF;
   
   SELECT SYSDATE INTO AS_APPLY_DATE FROM DUAL;
   AS_APPLY_OK     := 'N';
   
   rec_h_fb_intf_income.FB_SEQ := AS_FB_SEQ;
   rec_h_fb_intf_income.FB_ACCOUNT_NUM := AS_FB_ACCOUNT_NUM ; --cms:����� fbs:�������
   rec_h_fb_intf_income.FB_GUBUN_CD := AS_FB_GUBUN_CD ;
   rec_h_fb_intf_income.FB_BANK_CD := AS_FB_BANK_CD ;
   rec_h_fb_intf_income.FB_RECV_AMT := AS_FB_RECV_AMT; 
   rec_h_fb_intf_income.FB_REMAIN_AMT := AS_FB_REMAIN_AMT; 
   rec_h_fb_intf_income.FB_ACCOUNT_NAME := AS_FB_ACCOUNT_NAME; 
   rec_h_fb_intf_income.FB_CMS := AS_FB_CMS ;
   rec_h_fb_intf_income.FB_RECV_DATE := AS_FB_RECV_DATE; 
   rec_h_fb_intf_income.FB_RECV_TIME := AS_FB_RECV_TIME ;
   rec_h_fb_intf_income.FB_DOCU_NUMC := AS_FB_DOCU_NUMC ;
   rec_h_fb_intf_income.FB_JUMIN_NO := AS_FB_JUMIN_NO ;
   rec_h_fb_intf_income.TRANSFER_DATE := AS_TRANSFER_DATE;
    
   /**************************
   �������/CMS�ڵ� �� �о� �������
   ***************************/
   IF rec_h_fb_intf_income.FB_GUBUN_CD = '1' THEN  --CMS
      IF LENGTH(TRIM(rec_h_fb_intf_income.FB_CMS)) IS NULL THEN --������ cms ������ cms �ڵ尡 ���� ��� �Ϲݰ��� 
                                                                --���� ó�� ������ ������ �Ա� ���°� �о� ���·� ��� ���մ��� Ȯ���Ͽ�
                                                                --�����ڵ带 �����Ѵ� 
         V_DEPOSIT_NO := rec_h_fb_intf_income.FB_ACCOUNT_NUM;
         
         BEGIN
           SELECT dept_code , sell_code
             INTO v_dept_code, v_sell_code
             FROM H_CODE_DEPOSIT
            WHERE deposit_no = v_deposit_no ;
           
         EXCEPTION
           WHEN OTHERS THEN
           AS_ERROR_CODE := '00099';
           AS_ERROR_MSG  := '�Ϲ� �Ա�(��Ͼȵ� �о����)';
           GOTO ERROR_ROUTINE;
         END;
         
         BEGIN
           SELECT m.DONGHO, MAX(m.SEQ)
             INTO V_DONGHO, V_SEQ
             FROM H_SALE_MASTER M,
                  H_CODE_CUST C
            WHERE M.DEPT_CODE = V_DEPT_CODE
              AND M.SELL_CODE = V_SELL_CODE
              AND M.CONTRACT_YN = 'Y'
              AND M.CUST_CODE = C.CUST_CODE
              AND c.cust_name = rec_h_fb_intf_income.FB_ACCOUNT_NAME
           GROUP BY dongho;
           AS_DEPT_CODE    := V_DEPT_CODE;
           AS_SELL_CODE    := V_SELL_CODE;
           AS_DONGHO       := V_DONGHO;
           AS_SEQ          := V_SEQ;
           GOTO ERROR_ROUTINE;
         EXCEPTION
           WHEN NO_DATA_FOUND THEN
           AS_ERROR_CODE := '00097';
           AS_ERROR_MSG  := '�Ϲ��Ա�(�����ã�� ����-�Ա��� ����)';
           AS_DEPT_CODE    := V_DEPT_CODE;
           AS_SELL_CODE    := V_SELL_CODE;
           GOTO ERROR_ROUTINE;
           WHEN TOO_MANY_ROWS THEN
           AS_ERROR_CODE := '00096';
           AS_ERROR_MSG  := '�Ϲ��Ա�(�����ã�� ����-��������)';
           AS_DEPT_CODE    := V_DEPT_CODE;
           AS_SELL_CODE    := V_SELL_CODE;
           GOTO ERROR_ROUTINE;
         END;
      END IF;
      --CMS �Ա� ó�� 
      V_DEPT_CODE := SUBSTR(TRIM(rec_h_fb_intf_income.FB_CMS), 1,6);
      V_SELL_CODE := SUBSTR(TRIM(rec_h_fb_intf_income.FB_CMS), 7,2);
      V_DONGHO    := SUBSTR(TRIM(rec_h_fb_intf_income.FB_CMS), 9,8);
      V_DEPOSIT_NO := rec_h_fb_intf_income.FB_ACCOUNT_NUM; --CMS �ΰ��� �Աݰ��� ����..(��������ΰ��� ������¹�ȣ ����)
      
      BEGIN
        SELECT MAX(SEQ)
          INTO V_SEQ 
          FROM H_SALE_MASTER
         WHERE DEPT_CODE = V_DEPT_CODE
           AND SELL_CODE = V_SELL_CODE
           AND DONGHO    = V_DONGHO
           AND CONTRACT_YN = 'Y';
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
        AS_ERROR_CODE := '00021';
        AS_ERROR_MSG  := '�ش絿ȣ�� ������ڰ� �����ϴ�.';
        GOTO ERROR_ROUTINE;
      END;    
      
   ELSIF rec_h_fb_intf_income.FB_GUBUN_CD = '2' THEN  --�������
      
      BEGIN
        SELECT DEPOSIT_NO
          INTO V_DEPOSIT_NO
          FROM H_CODE_V_ACCOUNT
         WHERE V_ACCOUNT_NO = rec_h_fb_intf_income.FB_ACCOUNT_NUM;
         -- V_ACCOUNT_NO IS UNIQUE
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
        --���� �ش簡����� H_CODE_V_ACCOUNT �� ��� �ȵ�
        AS_ERROR_CODE := '00001';
        AS_ERROR_MSG  := '�ش簡����� H_CODE_V_ACCOUNT �� ��� �ȵ�'||'('||rec_h_fb_intf_income.FB_ACCOUNT_NUM||')';
        GOTO ERROR_ROUTINE;
      END;
      
      BEGIN
        SELECT DEPT_CODE, SELL_CODE, DONGHO, SEQ
          INTO V_DEPT_CODE, V_SELL_CODE, V_DONGHO, V_SEQ
          FROM H_SALE_MASTER
         WHERE V_ACCOUNT_NO = rec_h_fb_intf_income.FB_ACCOUNT_NUM
           AND DEPOSIT_NO = V_DEPOSIT_NO;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
        --���� �ش簡����� H_SALE_MASTER �� ��� �ȵ� 
        AS_ERROR_CODE := '00002';
        AS_ERROR_MSG  := '�ش簡����� H_SALE_MASTER �� ��� �ȵ�'||'('||rec_h_fb_intf_income.FB_ACCOUNT_NUM||')';
        GOTO ERROR_ROUTINE;
      END;
      
      
         
   ELSE
      AS_ERROR_CODE := '00003';
      AS_ERROR_MSG  := '�̵�� ���۱����ڵ�h_fb_intf_income.FB_GUBUN_CD '||'('||rec_h_fb_intf_income.FB_GUBUN_CD||')';  
      GOTO ERROR_ROUTINE;
   END IF;  
   
   
   /******************************
   ���ص� ����� �Ա� ó�� 
   ******************************/
   BEGIN
     IF LENGTH(trim(v_dept_code)) IS NULL OR LENGTH(trim(v_sell_code)) IS NULL OR LENGTH(trim(v_dongho)) IS NULL OR
        NOT v_seq > 0 THEN
        AS_ERROR_CODE := '00099'||SQLCODE;
        AS_ERROR_MSG  := '��ȣ���ο���'||V_DEPT_CODE||'/'||V_SELL_CODE||'/'||V_DONGHO||'/'||V_SEQ||SQLERRM;
        GOTO ERROR_ROUTINE;
     END IF;   
     H_Calc_Income.y_sp_h_income_cmpt(V_DEPT_CODE, 
                                      V_SELL_CODE, 
                                      V_DONGHO, 
                                      V_SEQ,
                                      --TO_DATE(rec_h_fb_intf_income.fb_recv_date||rec_h_fb_intf_income.fb_recv_time, 'YYYYMMDDHH24MISS'),
                                      TO_DATE(rec_h_fb_intf_income.fb_recv_date, 'YYYYMMDD'), 
                                      rec_h_fb_intf_income.FB_RECV_AMT,              
                                      '99',
  											   V_DEPOSIT_NO,                         --����� 
                                      '', 
                                      '', 
                                      '',
                                      '', 
                                      '',
                                     rec_h_fb_intf_income.FB_ACCOUNT_NUM, --������� 
                                     rec_h_fb_intf_income.FB_SEQ);
   EXCEPTION
     WHEN OTHERS THEN
     --�о���Ա�ó�� ����(H_Calc_Income.y_sp_h_income_cmpt)
     AS_ERROR_CODE := '00004'||SQLCODE;
     AS_ERROR_MSG  := '�о���Ա�ó�� ����(H_Calc_Income.y_sp_h_income_cmpt)'||V_DEPT_CODE||'/'||V_SELL_CODE||'/'||V_DONGHO||'/'||V_SEQ||SQLERRM;
     GOTO ERROR_ROUTINE;
   END;
                                   
   
   BEGIN
     SELECT DAILY_SEQ,
            AMT
       INTO V_DAILY_SEQ,
            V_AMT 
       FROM H_SALE_INCOME_DAILY
      WHERE DEPT_CODE = V_DEPT_CODE
        AND SELL_CODE = V_SELL_CODE
        AND DONGHO    = V_DONGHO
        AND SEQ       = V_SEQ
        AND RECEIPT_DATE = TO_DATE(rec_h_fb_intf_income.fb_recv_date, 'YYYYMMDD')
        AND DEPOSIT_NO = V_DEPOSIT_NO
        AND V_ACCOUNT_NO = rec_h_fb_intf_income.FB_ACCOUNT_NUM
        AND FB_SEQ       = rec_h_fb_intf_income.FB_SEQ;
     
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
     --���� �ش簡����� H_SALE_MASTER �� ��� �ȵ� 
     AS_ERROR_CODE := '00005';
     AS_ERROR_MSG  := '�о���Ա�ó�� ����-���ں����Աݿ� ��Ͼȵ�(H_SALE_INCOME_DAILY)'||V_DEPT_CODE||'/'||V_SELL_CODE||'/'||V_DONGHO||'/'||V_SEQ;
     GOTO ERROR_ROUTINE;
     WHEN TOO_MANY_ROWS THEN
     AS_ERROR_CODE := '00006';
     AS_ERROR_MSG  := '�о���Ա�ó�� ����-���ں����Աݿ� ��Ͼȵ�(H_SALE_INCOME_DAILY)'||V_DEPT_CODE||'/'||V_SELL_CODE||'/'||V_DONGHO||'/'||V_SEQ||'/'||TO_DATE(rec_h_fb_intf_income.fb_recv_date, 'YYYYMMDD');
     GOTO ERROR_ROUTINE;
   END;   
   
   SELECT SYSDATE INTO AS_APPLY_DATE FROM DUAL;
   AS_APPLY_OK     := 'Y';  
   AS_DEPT_CODE    := V_DEPT_CODE;
   AS_SELL_CODE    := V_SELL_CODE;
   AS_DONGHO       := V_DONGHO;
   AS_SEQ          := V_SEQ;
   AS_RECEIPT_DATE := TO_DATE(rec_h_fb_intf_income.fb_recv_date||rec_h_fb_intf_income.fb_recv_time, 'YYYYMMDDHH24MISS');
   AS_DAILY_SEQ    := V_DAILY_SEQ;
   AS_DEPOSIT_NO   := V_DEPOSIT_NO;
   IF rec_h_fb_intf_income.FB_GUBUN_CD = '2' THEN  --������ ��������϶��� 
      AS_V_ACCOUNT_NO := rec_h_fb_intf_income.FB_ACCOUNT_NUM;
   END IF;
    
   RETURN;
   <<ERROR_ROUTINE>>
   RETURN; 
EXCEPTION
  WHEN OTHERS THEN
    AS_ERROR_CODE := SQLCODE;
    AS_ERROR_MSG  := SQLERRM;
    RETURN;
    
END Y_Sp_H_Fbs_Apply_Income_Core;
/

