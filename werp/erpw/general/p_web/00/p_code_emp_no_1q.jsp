<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
     arg_emp_no = "%" + arg_emp_no + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  p_pers_master.emp_no ," + 
     "          p_pers_master.emp_name     FROM p_pers_master        " +
     "   WHERE p_pers_master.emp_no like '" + arg_emp_no + "'  OR "   + 
     "           p_pers_master.emp_name like '" + arg_emp_no + "'  " ;    
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>