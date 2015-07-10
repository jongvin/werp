drop sequence T_FB_CASH_PAY_DATA_SEQ;        
drop sequence T_FB_CASH_DIVIDED_DATA_SEQ;    
drop sequence T_FB_CASH_PAY_TRX_SEQ;         
drop sequence T_FB_BILL_PAY_DATA_SEQ;       
drop sequence T_FB_BILL_PAY_TRX_SEQ;        
drop sequence T_FB_MAIL_SEQ;                 
drop sequence T_FB_MAIL_SUB_SEQ;             
drop sequence T_FB_BILL_VENDOR_SEQ;         
drop sequence T_FB_CASH_TRANSFER_DATA_SEQ;   
drop sequence T_EDI_HISTORY_SEQ;             
drop sequence T_FB_INTERFACE_HR_SEQ;         
drop sequence T_FB_INTERFACE_PH_SEQ;
drop sequence T_FB_EDI_FILE_NAME_SEQ; 

create sequence T_FB_CASH_PAY_DATA_SEQ         start with 1 increment by 1 nocycle;     
create sequence T_FB_CASH_DIVIDED_DATA_SEQ     start with 1 increment by 1 nocycle; 
create sequence T_FB_CASH_PAY_TRX_SEQ          start with 1 increment by 1 nocycle;
create sequence T_FB_BILL_PAY_DATA_SEQ         start with 1 increment by 1 nocycle;
create sequence T_FB_BILL_PAY_TRX_SEQ          start with 1 increment by 1 nocycle;
create sequence T_FB_MAIL_SEQ                  start with 1 increment by 1 nocycle;
create sequence T_FB_MAIL_SUB_SEQ              start with 1 increment by 1 nocycle;
create sequence T_FB_BILL_VENDOR_SEQ           start with 1 increment by 1 nocycle;
create sequence T_FB_CASH_TRANSFER_DATA_SEQ    start with 1 increment by 1 nocycle;
create sequence T_EDI_HISTORY_SEQ              start with 1 increment by 1 nocycle;
create sequence T_FB_INTERFACE_HR_SEQ          start with 1 increment by 1 nocycle;   
create sequence T_FB_INTERFACE_PH_SEQ          start with 1 increment by 1 nocycle;   
create sequence T_FB_EDI_FILE_NAME_SEQ
  start with 5
  maxvalue 999
  minvalue 1
  cycle
  cache 20
  noorder;
