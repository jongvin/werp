<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("subs_no",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("prize_dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("subs_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("refund_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("receiver_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("subs_relation",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("bank_head_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("refund_deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("bank_head_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  h_subs_master.dept_code ," + 
     "          h_subs_master.sell_code ," + 
     "          h_subs_master.pyong ," + 
     "          h_subs_master.subs_no ," + 
     "          h_subs_master.cust_code ," + 
     "          h_code_cust.cust_name ," + 
     "          h_subs_master.prize_dongho ," + 
     "          h_subs_master.subs_amt ," + 
     "          to_char(h_subs_master.refund_date,'yyyymmdd') refund_date ," + 
     "          h_subs_master.receiver_name ," + 
     "          h_subs_master.subs_relation ," + 
     "          h_subs_master.bank_head_code ," + 
     "          nvl(h_subs_master.refund_deposit_no, h_subs_master.deposit_no)  refund_deposit_no ," + 
     "          t_bank_main.bank_main_name bank_head_name   " + 
     "        FROM h_subs_master ," + 
     "             h_code_cust ," + 
     "             t_bank_main  " + 
     "        WHERE ( h_subs_master.bank_head_code = t_bank_main.bank_main_code (+)) and " + 
     "              ( h_code_cust.cust_code = h_subs_master.cust_code ) and  " + 
     "              ( h_subs_master.dept_code = '" + arg_dept_code + "') and " + 
     "              ( h_subs_master.sell_code = '" + arg_sell_code + "') and " + 
     "              ( h_subs_master.preparation_order = 0 ) and " +
     "              ( h_subs_master.subs_amt >= 0 ) and " +
     "              ( h_subs_master.prize_date is null )" +
     "           ORDER BY h_subs_master.pyong          ASC," + 
     "          h_subs_master.subs_no          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>