drop sequence T_CARD_MEMBER_DATA_SEQ ;          
drop sequence T_CARD_EXPENSE_DATA_SEQ ;  
drop sequence T_CARD_MEMBER_HISTORY_SEQ;
drop sequence T_CARD_ACCOUNTING_SUB_SEQ; 


create sequence T_CARD_MEMBER_DATA_SEQ         start with 1 increment by 1 nocycle;     
create sequence T_CARD_EXPENSE_DATA_SEQ        start with 1 increment by 1 nocycle;     
create sequence T_CARD_MEMBER_HISTORY_SEQ      start with 1 increment by 1 nocycle;     
create sequence T_CARD_ACCOUNTING_SUB_SEQ      start with 1 increment by 1 nocycle;     
