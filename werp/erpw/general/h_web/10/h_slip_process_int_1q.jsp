<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_dept_code = req.getParameter("arg_dept_code"); 
 String arg_sell_code = req.getParameter("arg_sell_code"); 
 String arg_fr_date  = req.getParameter("arg_fr_date");
 String arg_to_date = req.getParameter("arg_to_date");				 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("paid_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("biz_status",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("biz_type",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("cur_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cur_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cur_addr2",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("work_no",GauceDataColumn.TB_STRING,50));
    String query = "SELECT a.dongho, " + 
     "         a.seq, " + 
     "         a.contract_code," + 
     "         TO_CHAR(b.paid_date,'yyyy.mm.dd') paid_date," + 
     "         a.cust_code, " + 
     "         c.cust_name, c.cust_div, c.biz_status, c.biz_type, c.cur_zip_code, c.cur_addr1, c.cur_addr2, " + 
     "         b.work_no, "+
     "         SUM (b.amt) amt" + 
     "    FROM H_SALE_MASTER a," + 
     "         H_SALE_LOAN_INTEREST b," + 
     "         H_CODE_CUST c" + 
     "   WHERE (LENGTH(trim(b.work_no)) IS NULL OR             " + 
     "              b.work_no IN (SELECT to_char(invoice_group_id) FROM v_invoice_reject )  " + 
     "             )" + 
     "     AND a.dept_code = b.dept_code" + 
     "     AND a.sell_code = b.sell_code" + 
     "     AND a.dongho = b.dongho" + 
     "     AND a.seq = b.seq" + 
     "     AND a.cust_code = c.cust_code(+)" + 
     "     AND a.dept_code = '"+arg_dept_code+"'" + 
     "     AND a.sell_code = '"+arg_sell_code+"'" + 
     "     AND b.paid_date BETWEEN '"+arg_fr_date+"' AND '"+arg_to_date+"'" + 
     "     AND b.loan_interest_tag = '02'                            " + 
     "     AND b.amt > 0     " + 
     "     AND a.chg_div <> '00'    and (a.contract_date  <= b.paid_date " +
     "          and a.chg_date >= b.paid_date and a.last_contract_date <= b.paid_date ) " +
     " GROUP BY a.dongho," + 
     "         a.seq," + 
     "         a.contract_code," + 
     "         b.paid_date," + 
     "         a.cust_code," + 
     "         c.cust_name," + 
     "         c.cust_div," + 
     "         c.biz_status," + 
     "         c.biz_type," + 
     "         c.cur_zip_code," + 
     "         c.cur_addr1," + 
     "         c.cur_addr2," + 
	  "         b.work_no "+
     " ORDER BY a.dongho, a.seq, " + 
     "         b.paid_date" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>