<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_degree = req.getParameter("arg_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("level1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("title_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT a.dept_seq_key," + 
     "             a.no_seq," + 
     "             a.level1," + 
     "             a.title_name, " + 
     "             a.comp_code  " + 
     "       FROM z_code_chg_dept_title a " + 
     "       where a.degree = " + arg_degree + "  " + 
     "       ORDER BY a.no_seq ASC         ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>