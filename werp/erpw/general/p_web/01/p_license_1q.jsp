<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("license_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("license_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("license_type_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("license_area_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("eval_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("old_license_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("sort_order",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  p_code_license.license_code ," + 
     "          p_code_license.license_name ," + 
     "          p_code_license.license_type_code ," + 
     "          p_code_license.license_area_code ," + 
     "          p_code_license.eval_yn ," + 
     "          p_code_license.old_license_code ," + 
     "          p_code_license.sort_order     FROM p_code_license        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>