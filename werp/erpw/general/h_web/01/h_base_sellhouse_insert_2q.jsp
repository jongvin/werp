<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
//     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT a.code,   " + 
     "                       a.code_name   " + 
     "                  FROM h_code_common a " + 
     "                 WHERE a.code_div = '04'" + 
     "              ORDER BY a.code ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>