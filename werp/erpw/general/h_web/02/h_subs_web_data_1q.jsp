<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //      String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("seq_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("subs_no",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("subs_order",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_code1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_code2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("zip_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("addr2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("home_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("in_cust_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("head_bank_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("depositor",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("in_confirm",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  " +
	  "          ' '  seq_no , "+
     "          ' '  subs_no, " + 
     "          ' '  pyong, " + 
     "          ' '  subs_order, " + 
     "          ' '  cust_name, " + 
     "          ' '  cust_code1, " + 
     "          ' '  cust_code2, " + 
     "          ' '  zip_code, " + 
     "          ' '  addr1, " + 
     "          ' '  addr2, " + 
     "          ' '  home_phone, " + 
     "          ' '  cell_phone, " + 
     "          ' '  in_cust_name, " + 
     "          ' '  head_bank_name, " + 
     "          ' '  deposit_no, " + 
     "          ' '  depositor, " + 
     "          ' '  in_confirm " + 
     "            from dual  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>