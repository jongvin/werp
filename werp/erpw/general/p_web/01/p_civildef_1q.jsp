<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("civildef_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("civildef_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT  p_code_civildef.civildef_code ," + 
     "          p_code_civildef.civildef_name     FROM p_code_civildef        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>