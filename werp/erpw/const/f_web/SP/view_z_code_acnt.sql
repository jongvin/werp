CREATE OR REPLACE VIEW z_code_acnt 
          ( acntcode, 
            acntname,
            entrytag, 
            acnttag) 
        AS SELECT "ERPC"."AM_CODE_ACNT"."ACNT_CODE",   
                  "ERPC"."AM_CODE_ACNT"."ACNT_NAME",  
                  "ERPC"."AM_CODE_ACNT"."USE_YN", 
                  DECODE("ERPC"."AM_CODE_ACNT"."COST_KIND_CODE", '21', '2', "ERPC"."AM_CODE_ACNT"."COST_KIND_CODE") 
             FROM "ERPC"."AM_CODE_ACNT"  
            WHERE "ERPC"."AM_CODE_ACNT"."COST_KIND_CODE" = '21'