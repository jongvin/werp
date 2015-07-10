<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_from = req.getParameter("arg_from");
 String arg_to = req.getParameter("arg_to");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,17));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("option_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("degree_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("receipt_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("receipt_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("print_deposit_no",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,40));
	 dSet.addDataColumn(new GauceDataColumn("income_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_land_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_build_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("r_vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_class_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("receipt_class_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("receipt_number",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("card_app_num",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("card_bank_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("card_bank_head_name",GauceDataColumn.TB_STRING,20));
    String query = " SELECT a.pyong,"   +
"        SUBSTR (a.dongho, 1, 4) || '-' || SUBSTR (a.dongho, 5, 4) dongho,"   +
"        a.style,"   +
"        c.class_name,"   +
"        d.option_name,"   +
"        e.cust_name,"   +
"        e.cust_code,"   +
"        contract_code.code_name,"   +
"        TO_CHAR (contract_date, 'yyyy.mm.dd') contract_date,"   +
"        f.degree_code,"   +
"        degree_code.code_name degree_name,"   +
"        TO_CHAR (f.receipt_date, 'yyyy.mm.dd') receipt_date,"   +
"        f.receipt_code,"   +
"        receipt_code.code_name receipt_name,"   +
"        f.deposit_no,"   +
"        deposit_no.print_deposit_no,"   +
"        deposit_no.bank_name,"   +
"        f.r_amt+ f.delay_amt- f.discount_amt income_amt, "+
"        f.r_amt,"   +
"        f.r_land_amt,"   +
"        f.r_build_amt,"   +
"        f.r_vat_amt,"   +
"        f.delay_days,"   +
"        f.delay_amt,"   +
"        f.discount_days,"   +
"        f.discount_amt,"   +
"        f.receipt_class_code,"   +
"        receipt_class_code.code_name receipt_class_name,"   +
"        f.receipt_number,"   +
"        f.card_app_num,"   +
"        f.card_bank_code,"   +
"        g.bank_main_name card_bank_head_name"   +
"   FROM h_sale_master a,"   +
"        (SELECT   MAX (dongho) dongho,"   +
"                  MAX (seq) seq"   +
"             FROM h_sale_master"   +
"            WHERE dept_code = '"+arg_dept_code+"' AND sell_code = '"+arg_sell_code+"'"   +
"         GROUP BY dept_code, sell_code, dongho) b,"   +
"        h_code_class c,"   +
"        h_code_option d,"   +
"        h_code_cust e,"   +
"        h_sale_income f,"   +
"        t_bank_main g,"   +
"        (SELECT code,"   +
"                code_name"   +
"           FROM h_code_common"   +
"          WHERE code_div = '04') contract_code,"   +
"        (SELECT code,"   +
"                code_name"   +
"           FROM h_code_common"   +
"          WHERE code_div = '02') degree_code,"   +
"        (SELECT code,"   +
"                code_name"   +
"           FROM h_code_common"   +
"          WHERE code_div = '05') receipt_code,"   +
"        (SELECT code,"   +
"                code_name"   +
"           FROM h_code_common"   +
"          WHERE code_div = '26') receipt_class_code,"   +
"        (SELECT deposit_no,"   +
"                bank_name,"   +
"                print_deposit_no"   +
"           FROM h_code_deposit"   +
"          WHERE dept_code = '"+arg_dept_code+"' AND sell_code = '"+arg_sell_code+"') deposit_no"   +
"  WHERE a.dept_code = c.dept_code(+)"   +
"    AND a.sell_code = c.sell_code(+)"   +
"    AND a.CLASS = c.CLASS(+)"   +
"    AND a.dept_code = d.dept_code(+)"   +
"    AND a.sell_code = d.sell_code(+)"   +
"    AND a.option_code = d.option_code(+)"   +
"    AND a.cust_code = e.cust_code(+)"   +
"    AND a.contract_yn = 'Y'"   +
"    AND a.dongho = b.dongho"   +
"    AND a.seq = b.seq"   +
"    AND a.contract_code = contract_code.code(+)"   +
"    AND a.dept_code = '"+arg_dept_code+"'"   +
"    AND a.sell_code = '"+arg_sell_code+"'"   +
"    AND a.dept_code = f.dept_code"   +
"    AND a.sell_code = f.sell_code"   +
"    AND a.dongho = f.dongho"   +
"    AND a.seq = f.seq"   +
"    AND f.degree_code = degree_code.code(+)"   +
"    AND f.receipt_class_code = receipt_class_code.code(+)"   +
"    AND f.receipt_code = receipt_code.code(+)"   +
"    AND f.deposit_no = deposit_no.deposit_no(+)"   +
"    AND f.card_bank_code = g.bank_main_code(+)"   +
"    AND f.receipt_date BETWEEN '"+arg_from+"'"   +
"                           AND '"+arg_to+"'"   +
" order by a.dongho, f.degree_code, f.degree_seq"  ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>