<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("license_type_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("license_type_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("license_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("eval_score",GauceDataColumn.TB_DECIMAL,18,2));
    String query = "  SELECT  p_code_license_type.license_type_code ," + 
     "          p_code_license_type.license_type_name ," + 
     "          p_code_license_type.license_amt ," + 
     "          p_code_license_type.eval_score     FROM p_code_license_type        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>