CREATE OR REPLACE PROCEDURE Y_Sp_H_Fbs_Apply_Mapped(AS_FB_SEQ IN NUMBER) IS
    
    tmpvar INTEGER;
    C_CNT INTEGER;
    rec_h_fb_intf_income H_FB_INTF_INCOME%ROWTYPE;
    
    V_DEPOSIT_NO H_CODE_V_ACCOUNT.DEPOSIT_NO%TYPE;
    V_V_DEPOSIT_NO H_CODE_V_ACCOUNT.DEPOSIT_NO%TYPE;
    V_DEPT_CODE H_SALE_MASTER.DEPT_CODE%TYPE;
    V_SELL_CODE H_SALE_MASTER.SELL_CODE%TYPE;
    V_DONGHO H_SALE_MASTER.DONGHO%TYPE;
    V_SEQ H_SALE_MASTER.SEQ%TYPE;
    V_DAILY_SEQ H_SALE_INCOME_DAILY.DAILY_SEQ%TYPE;
    V_AMT       H_SALE_INCOME_DAILY.AMT%TYPE;
    V_SYS_DATE DATE;
    
BEGIN
   rec_h_fb_intf_income.fb_seq :=as_fb_seq;
   
   SELECT SYSDATE INTO V_SYS_DATE FROM DUAL;
   
   rec_h_fb_intf_income.APPLY_DATE := V_SYS_DATE;
   rec_h_fb_intf_income.APPLY_OK   := 'N';  
   
   IF LENGTH(TRIM(rec_h_fb_intf_income.fb_seq)) IS NULL THEN
      --에러 해당가상계좌 H_CODE_V_ACCOUNT 에 등록 안됨
      rec_h_fb_intf_income.ERROR_CODE := '10000';
      rec_h_fb_intf_income.ERROR_MSG  := '전송번호(SEQ)가 없습니다/처리불가';
      GOTO ERROR_ROUTINE;
   END IF;
   
   BEGIN 
     SELECT FB_RECV_AMT, 
            FB_RECV_DATE, 
            DEPT_CODE,
            SELL_CODE,
            DONGHO,
            SEQ,
            DEPOSIT_NO,
            V_DEPOSIT_NO
       INTO rec_h_fb_intf_income.FB_RECV_AMT, 
            rec_h_fb_intf_income.FB_RECV_DATE, 
            V_DEPT_CODE, 
            V_SELL_CODE, 
            V_DONGHO, 
            V_SEQ,
            V_DEPOSIT_NO,
            V_V_DEPOSIT_NO
       FROM H_FB_INTF_INCOME
      WHERE FB_SEQ = rec_h_fb_intf_income.fb_seq;
   EXCEPTION
       WHEN NO_DATA_FOUND THEN
       --에러 해당가상계좌 H_CODE_V_ACCOUNT 에 등록 안됨
       rec_h_fb_intf_income.ERROR_CODE := '00000';
       rec_h_fb_intf_income.ERROR_MSG  := 'h_fb_intf_income조회불가';
       GOTO ERROR_ROUTINE;
   END;
    
   
   
   
   --수입금처리안하고 맵핑 처리만한다    Y_Sp_H_Fbs_Apply_Income_core( 맵핑+입금처리)
   BEGIN
     IF LENGTH(trim(v_dept_code)) IS NULL OR LENGTH(trim(v_sell_code)) IS NULL OR LENGTH(trim(v_dongho)) IS NULL OR
        NOT v_seq > 0 THEN
        rec_h_fb_intf_income.ERROR_CODE := '00099'||SQLCODE;
        rec_h_fb_intf_income.ERROR_MSG  := '동호맵핑에러'||V_DEPT_CODE||'/'||V_SELL_CODE||'/'||V_DONGHO||'/'||V_SEQ||SQLERRM;
        GOTO ERROR_ROUTINE;
     END IF;
     IF LENGTH(TRIM(V_DEPOSIT_NO)) IS NULL THEN
        rec_h_fb_intf_income.ERROR_CODE := '00098'||SQLCODE;
        rec_h_fb_intf_income.ERROR_MSG  := '계좌가없습니다'||V_DEPOSIT_NO||SQLERRM;
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
  											     V_DEPOSIT_NO,                         --모계좌 
                                      '', 
                                      '', 
                                      '',
                                      '', 
                                      '',
                                     V_V_DEPOSIT_NO, --가상계좌 
                                     AS_FB_SEQ);
   EXCEPTION
     WHEN OTHERS THEN
     --분양수입금처리 에러(H_Calc_Income.y_sp_h_income_cmpt)
     ROLLBACK;
     rec_h_fb_intf_income.ERROR_CODE := '00004'||SQLCODE;
     rec_h_fb_intf_income.ERROR_MSG  := '분양수입금처리 에러(H_Calc_Income.y_sp_h_income_cmpt)'||V_DEPT_CODE||'/'||V_SELL_CODE||'/'||V_DONGHO||'/'||V_SEQ||SQLERRM;
     GOTO ERROR_ROUTINE;
   END;
                                   
   
   /*BEGIN
     SELECT DAILY_SEQ,
            AMT
       INTO V_DAILY_SEQ,
            V_AMT 
       FROM H_SALE_INCOME_DAILY
      WHERE DEPT_CODE = V_DEPT_CODE
        AND SELL_CODE = V_SELL_CODE
        AND DONGHO    = V_DONGHO
        AND SEQ       = V_SEQ
        --AND RECEIPT_DATE = TO_DATE(rec_h_fb_intf_income.fb_recv_date, 'YYYYMMDD')
        --AND DEPOSIT_NO = V_DEPOSIT_NO
        --AND NVL(V_ACCOUNT_NO,'') = NVL(V_V_DEPOSIT_NO,'')
        AND FB_SEQ       = AS_FB_SEQ;
     
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
     --에러 해당가상계좌 H_SALE_MASTER 에 등록 안됨 
     rec_h_fb_intf_income.ERROR_CODE := '00005';
     rec_h_fb_intf_income.ERROR_MSG  := '분양수입금처리 에러-일자별수입금에 등록안됨(H_SALE_INCOME_DAILY)'||V_DEPT_CODE||'/'||V_SELL_CODE||'/'||V_DONGHO||'/'||V_SEQ;
     GOTO ERROR_ROUTINE;
     WHEN TOO_MANY_ROWS THEN
     rec_h_fb_intf_income.ERROR_CODE := '00006';
     rec_h_fb_intf_income.ERROR_MSG  := '분양수입금처리 에러-일자별수입금에 등록안됨(H_SALE_INCOME_DAILY)'||V_DEPT_CODE||'/'||V_SELL_CODE||'/'||V_DONGHO||'/'||V_SEQ||'/'||TO_DATE(rec_h_fb_intf_income.fb_recv_date, 'YYYYMMDD');
     GOTO ERROR_ROUTINE;
   END;*/   
   
   SELECT SYSDATE INTO rec_h_fb_intf_income.APPLY_DATE FROM DUAL;
   rec_h_fb_intf_income.APPLY_OK     := 'Y';  
   rec_h_fb_intf_income.RECEIPT_DATE := TO_DATE(rec_h_fb_intf_income.fb_recv_date||rec_h_fb_intf_income.fb_recv_time, 'YYYYMMDDHH24MISS');
   rec_h_fb_intf_income.DAILY_SEQ    := V_DAILY_SEQ;
   
   UPDATE H_FB_INTF_INCOME
      SET APPLY_DATE = rec_h_fb_intf_income.APPLY_DATE,
          APPLY_OK   = rec_h_fb_intf_income.APPLY_OK,
          RECEIPT_DATE = rec_h_fb_intf_income.RECEIPT_DATE,
          DAILY_SEQ    = rec_h_fb_intf_income.DAILY_SEQ,
          ERROR_CODE   = NULL,
          ERROR_MSG    = NULL,
          MAN_ERROR_CODE   = NULL,
          MAN_ERROR_MSG    = NULL
     WHERE FB_SEQ = AS_FB_SEQ;
   RETURN;
                
   <<ERROR_ROUTINE>>
   UPDATE H_FB_INTF_INCOME
      SET APPLY_DATE = rec_h_fb_intf_income.APPLY_DATE,
          APPLY_OK   = rec_h_fb_intf_income.APPLY_OK,
          ERROR_CODE = rec_h_fb_intf_income.ERROR_CODE,
          ERROR_MSG  = rec_h_fb_intf_income.ERROR_MSG
    WHERE FB_SEQ = AS_FB_SEQ;
   
    
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    rec_h_fb_intf_income.ERROR_CODE := SQLCODE;
    rec_h_fb_intf_income.ERROR_MSG  := SQLERRM;
    
    UPDATE H_FB_INTF_INCOME
       SET APPLY_DATE = rec_h_fb_intf_income.APPLY_DATE,
           APPLY_OK   = rec_h_fb_intf_income.APPLY_OK,
           ERROR_CODE = rec_h_fb_intf_income.ERROR_CODE,
           ERROR_MSG  = rec_h_fb_intf_income.ERROR_MSG
     WHERE FB_SEQ = AS_FB_SEQ;
   COMMIT; 
END Y_Sp_H_Fbs_Apply_Mapped;
/

