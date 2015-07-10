<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_gauce_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
    String query = " select dept_code  from p_pers_master " + 
     "             where emp_no = '" + arg_emp_no + "' ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>