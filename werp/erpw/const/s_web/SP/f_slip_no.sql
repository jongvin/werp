CREATE OR REPLACE
FUNCTION f_slip_no
(
	ai_invoice_num      NUMBER
) 

RETURN  VARCHAR2 Is ls_process	VARCHAR2(200);  
    li_cnt		   					INTEGER;
	 ls_approval_num  VARCHAR2(200);

BEGIN
	select approval_num
	  into ls_approval_num
	  from efin_invoice_header_itf
	 where invoice_group_id = ai_invoice_num;


	ls_process := ls_approval_num;

   RETURN ls_process;
END;
