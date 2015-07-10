CREATE OR REPLACE TRIGGER "ERPW".H_FB_INTF_INCOME_TRG
   BEFORE INSERT
   ON H_FB_INTF_INCOME 
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
    tmpvar INTEGER;
    ERROR_CODE VARCHAR2(20);
    ERROR_MSG  VARCHAR2(100);
       
/******************************************************************************
   NAME:       A_FB_INTERFACE_PH_TRG
   PURPOSE:    EFIN.A_FB_INTERFACE_PH 와 ERPW.H_FB_INTF_INCOME 인터페이스
     

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005.04.15             1. Created this trigger.

   NOTES:

   
      Object Name:     A_FB_INTERFACE_PH_TRG
      Sysdate:         2005.04.15
      Date and Time:   2005.04.15, 오전 10:49:50, and 2005.04.15 오전 10:49:50
      Username:        EFIN
      Table Name:      A_FB_INTERFACE_PH 
      Trigger Options: AFTER INSERT EFIN.A_FB_INTERFACE_PH ON EACH ROW 
******************************************************************************/
BEGIN
   BEGIN  
    
   Y_Sp_H_Fbs_Apply_Income_Map(
                           :NEW.FB_SEQ,
                           :NEW.FB_ACCOUNT_NUM, 
                           :NEW.FB_GUBUN_CD, 
                           :NEW.FB_BANK_CD, 
                           :NEW.FB_RECV_AMT, 
                           :NEW.FB_REMAIN_AMT, 
                           :NEW.FB_ACCOUNT_NAME, 
                           :NEW.FB_CMS, 
                           :NEW.FB_RECV_DATE, 
                           :NEW.FB_RECV_TIME, 
                           :NEW.FB_DOCU_NUMC, 
                           :NEW.FB_JUMIN_NO, 
                           :NEW.TRANSFER_DATE,
                           :NEW.APPLY_DATE ,
                           :NEW.APPLY_OK ,
                           :NEW.DEPT_CODE , 
                           :NEW.SELL_CODE ,
                           :NEW.DONGHO    ,
                           :NEW.SEQ       ,
                           :NEW.RECEIPT_DATE ,
                           :NEW.DAILY_SEQ    ,
                           :NEW.DEPOSIT_NO   ,
                           :NEW.V_ACCOUNT_NO ,
                           :NEW.ERROR_CODE ,
                           :NEW.ERROR_MSG,
                           :NEW.EX_COL1 );
   
   END;
   
EXCEPTION
  WHEN OTHERS THEN
    -- Consider logging the error and then re-raise
    NULL;

END H_FB_INTF_INCOME_TRG;
/

