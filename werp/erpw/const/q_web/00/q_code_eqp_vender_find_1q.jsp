<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_vender_name = req.getParameter("arg_vender_name") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("regist_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("temp_regist_no",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("eqp_vender_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("pregident_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("address",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("tel_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("company_no",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT " + 
     "         decode(cust_type,'1',substrb(regist_no,1,3) || '-' || substrb(regist_no,4,2) || '-' || substrb(regist_no,6,5),decode(cust_type,'2',substrb(regist_no,1,6) || '-' || substrb(regist_no,7,7),regist_no)) regist_no,   " + 
     "		regist_no    temp_regist_no," +
     "          eqp_vender_name ," + 
     "          pregident_name ," + 
     "          address ," + 
     "          tel_no ," + 
     "          company_no ," + 
     "          remark     FROM q_code_eqp_vender        " +
     "WHERE eqp_vender_name like " + "'" + arg_vender_name + "'";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>