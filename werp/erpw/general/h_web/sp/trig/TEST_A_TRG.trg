CREATE OR REPLACE TRIGGER "ERPW".TEST_A_TRG
   AFTER INSERT
   ON TEST_A
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
    tmpvar INTEGER;
       
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
      UPDATE TEST_A
         SET NAME = 'TEST'
       WHERE CODE = :NEW.CODE;    
   
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END A_FB_INTERFACE_PH_TRG;
/

