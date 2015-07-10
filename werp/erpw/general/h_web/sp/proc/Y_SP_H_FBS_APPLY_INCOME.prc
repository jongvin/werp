CREATE OR REPLACE PROCEDURE Y_Sp_H_Fbs_Apply_Income(AS_FB_SEQ IN NUMBER) IS
    
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
     SELECT FB_ACCOUNT_NUM, 
            FB_GUBUN_CD, 
            FB_BANK_CD, 
            FB_RECV_AMT, 
            FB_REMAIN_AMT, 
            FB_ACCOUNT_NAME, 
            FB_CMS, 
            FB_RECV_DATE, 
            FB_RECV_TIME, 
            FB_DOCU_NUMC, 
            FB_JUMIN_NO, 
            TRANSFER_DATE
       INTO rec_h_fb_intf_income.FB_ACCOUNT_NUM, 
            rec_h_fb_intf_income.FB_GUBUN_CD, 
            rec_h_fb_intf_income.FB_BANK_CD, 
            rec_h_fb_intf_income.FB_RECV_AMT, 
            rec_h_fb_intf_income.FB_REMAIN_AMT, 
            rec_h_fb_intf_income.FB_ACCOUNT_NAME, 
            rec_h_fb_intf_income.FB_CMS, 
            rec_h_fb_intf_income.FB_RECV_DATE, 
            rec_h_fb_intf_income.FB_RECV_TIME, 
            rec_h_fb_intf_income.FB_DOCU_NUMC, 
            rec_h_fb_intf_income.FB_JUMIN_NO, 
            rec_h_fb_intf_income.TRANSFER_DATE
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
   Y_Sp_H_Fbs_Apply_Income_Map(rec_h_fb_intf_income.FB_SEQ ,
                                rec_h_fb_intf_income.FB_ACCOUNT_NUM , 
                                rec_h_fb_intf_income.FB_GUBUN_CD , 
                                rec_h_fb_intf_income.FB_BANK_CD , 
                                rec_h_fb_intf_income.FB_RECV_AMT , 
                                rec_h_fb_intf_income.FB_REMAIN_AMT , 
                                rec_h_fb_intf_income.FB_ACCOUNT_NAME , 
                                rec_h_fb_intf_income.FB_CMS , 
                                rec_h_fb_intf_income.FB_RECV_DATE , 
                                rec_h_fb_intf_income.FB_RECV_TIME , 
                                rec_h_fb_intf_income.FB_DOCU_NUMC , 
                                rec_h_fb_intf_income.FB_JUMIN_NO , 
                                rec_h_fb_intf_income.TRANSFER_DATE ,
                                rec_h_fb_intf_income.APPLY_DATE ,
                                rec_h_fb_intf_income.APPLY_OK ,
                                rec_h_fb_intf_income.DEPT_CODE , 
                                rec_h_fb_intf_income.SELL_CODE ,
                                rec_h_fb_intf_income.DONGHO    ,
                                rec_h_fb_intf_income.SEQ       ,
                                rec_h_fb_intf_income.RECEIPT_DATE ,
                                rec_h_fb_intf_income.DAILY_SEQ    ,
                                rec_h_fb_intf_income.DEPOSIT_NO   ,
                                rec_h_fb_intf_income.V_ACCOUNT_NO ,
                                rec_h_fb_intf_income.ERROR_CODE ,
                                rec_h_fb_intf_income.ERROR_MSG,
                                rec_h_fb_intf_income.EX_COL1);
  
   
   UPDATE H_FB_INTF_INCOME
      SET APPLY_DATE = rec_h_fb_intf_income.APPLY_DATE,
          APPLY_OK   = rec_h_fb_intf_income.APPLY_OK,
          DEPT_CODE  = rec_h_fb_intf_income.DEPT_CODE, 
          SELL_CODE  = rec_h_fb_intf_income.SELL_CODE, 
          DONGHO     = rec_h_fb_intf_income.DONGHO,
          SEQ        = rec_h_fb_intf_income.SEQ,
          RECEIPT_DATE = rec_h_fb_intf_income.RECEIPT_DATE, 
          DAILY_SEQ    = rec_h_fb_intf_income.DAILY_SEQ, 
          DEPOSIT_NO   = rec_h_fb_intf_income.DEPOSIT_NO,
          V_ACCOUNT_NO = rec_h_fb_intf_income.V_ACCOUNT_NO,
          ERROR_CODE = rec_h_fb_intf_income.ERROR_CODE,
          ERROR_MSG  = rec_h_fb_intf_income.ERROR_MSG
    WHERE FB_SEQ = rec_h_fb_intf_income.FB_SEQ;
   
                
   <<ERROR_ROUTINE>>
   
   UPDATE H_FB_INTF_INCOME
      SET MAN_APPLY_DATE = rec_h_fb_intf_income.APPLY_DATE,
          MAN_APPLY_OK   = rec_h_fb_intf_income.APPLY_OK,
          MAN_ERROR_CODE = rec_h_fb_intf_income.ERROR_CODE,
          MAN_ERROR_MSG  = rec_h_fb_intf_income.ERROR_MSG,
          ERROR_CODE = rec_h_fb_intf_income.ERROR_CODE,
          ERROR_MSG  = rec_h_fb_intf_income.ERROR_MSG
    WHERE FB_SEQ = rec_h_fb_intf_income.FB_SEQ;
          
   
    
EXCEPTION
  WHEN OTHERS THEN
    rec_h_fb_intf_income.ERROR_CODE := SQLCODE;
    rec_h_fb_intf_income.ERROR_MSG  := SQLERRM;
    
    UPDATE H_FB_INTF_INCOME
       SET APPLY_DATE = rec_h_fb_intf_income.APPLY_DATE,
           APPLY_OK   = rec_h_fb_intf_income.APPLY_OK,
           MAN_ERROR_CODE = rec_h_fb_intf_income.ERROR_CODE,
           MAN_ERROR_MSG  = rec_h_fb_intf_income.ERROR_MSG,
           ERROR_CODE = rec_h_fb_intf_income.ERROR_CODE,
           ERROR_MSG  = rec_h_fb_intf_income.ERROR_MSG
     WHERE FB_SEQ = rec_h_fb_intf_income.FB_SEQ;
    
END Y_Sp_H_Fbs_Apply_Income;
/

