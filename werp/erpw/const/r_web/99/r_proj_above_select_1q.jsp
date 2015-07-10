<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("level1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("title_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT z_code_dept_title.dept_seq_key," + 
     "             z_code_dept_title.no_seq," + 
     "             z_code_dept_title.level1," + 
     "             z_code_dept_title.title_name, " + 
     "             z_code_dept_title.comp_code  " + 
     "       FROM z_code_dept_title " + 
     "       ORDER BY z_code_dept_title.no_seq ASC         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>