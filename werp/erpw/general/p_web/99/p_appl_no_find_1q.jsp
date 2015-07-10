<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_employ_degree = req.getParameter("arg_employ_degree");
     String arg_appl_no = req.getParameter("arg_appl_no") + "%";
     String arg_where = req.getParameter("arg_where");
//     String arg_interview_degree = req.getParameter("arg_interview_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("appl_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("appl_name",GauceDataColumn.TB_STRING,20));     
     dSet.addDataColumn(new GauceDataColumn("appl_part",GauceDataColumn.TB_STRING,50));     
    String query = "  SELECT  distinct a.employ_degree ," + 
     "          a.appl_no ," + 
     "          a.appl_name ," + 
     "          a.appl_part  " +
     "    FROM p_emp_applicant a,  " +
     "         p_emp_pass b        " + 	
     "   where a.employ_degree = b.employ_degree(+) " +
     "     and a.appl_no       = b.appl_no(+) " +
     "     and a.employ_degree = '" + arg_employ_degree + "' " +
     "     and ( a.appl_no like '" + arg_appl_no + "' " +
     "      or a.appl_name like '" + arg_appl_no + "'   )   " +
     " " +  arg_where + " " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>