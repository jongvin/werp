<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //      String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("pay_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("union_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("union_id",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("union_seq",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("pay_degree",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("remarks",GauceDataColumn.TB_STRING,15));
    String query = "  SELECT  " + 
     "          ' '  cust_code, " + 
     "          ' '  cust_name, " + 
     "          ' '  dongho, " + 
     "          0    pay_degree, " + 
     "          '1000.01.01' agree_date, " + 
     "          '1000.01.01' receipt_date, " + 
     "          0 amt, " + 
     "          ' ' union_code, " + 
     "          ' ' union_id, " + 
     "          ' ' union_seq, " + 
     "          ' ' pay_degree, " + 
     "          ' ' degree_code, " + 
     "          ' ' remarks " + 
     "            from dual  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>