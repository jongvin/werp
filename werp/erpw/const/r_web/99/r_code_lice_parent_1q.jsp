<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("license_class_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("key_license_class_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("license_class_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT  license_class_code ," + 
     "                        license_class_code key_license_class_code, " +
     "          					license_class_name " + 
     "                   FROM r_code_license_class   ORDER BY license_class_code ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>