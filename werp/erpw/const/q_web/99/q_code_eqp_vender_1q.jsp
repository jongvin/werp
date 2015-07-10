<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
//     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("regist_no",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("temp_regist_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("key_regist_no",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("eqp_vender_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("pregident_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("address",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("tel_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("company_no",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_type",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  regist_no, " +
     "          decode(cust_type,'1',substrb(regist_no,1,3) || '-' || substrb(regist_no,4,2) || '-' || substrb(regist_no,6,5),substrb(regist_no,1,6) || '-' || substrb(regist_no,7,7)) temp_regist_no ," + 
     "          regist_no    key_regist_no," +
     "          eqp_vender_name ," + 
     "          pregident_name ," + 
     "          address ," + 
     "          tel_no ," + 
     "          company_no ," + 
     "          remark   , " +
     "          cust_type " +
     "       FROM q_code_eqp_vender        " +
     "     order by eqp_vender_name asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>