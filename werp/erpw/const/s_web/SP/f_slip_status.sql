CREATE OR REPLACE
FUNCTION f_slip_status
(
	ai_invoice_num      NUMBER
) 

RETURN  VARCHAR2 Is ls_process	VARCHAR2(2);  
    li_cnt		   					INTEGER;
	 ls_complete_flag 		      VARCHAR2(2);
	 li_relation_invoice_group_id NUMBER;

BEGIN
	select complete_flag,relation_invoice_group_id
	  into ls_complete_flag,li_relation_invoice_group_id
	  from efin_invoice_header_itf
	 where invoice_group_id = ai_invoice_num;

    if rtrim(ls_complete_flag) = '9' and li_relation_invoice_group_id is not null then
        ls_process := 'C';
	 else
        ls_process := ls_complete_flag;
    end if;

   RETURN ls_process;
END;
