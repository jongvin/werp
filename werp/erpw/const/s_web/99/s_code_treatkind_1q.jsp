<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)-
//     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("treatkind_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("treatkind_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("key_treatkind_code",GauceDataColumn.TB_STRING,30));    // key를 update하기위한 보조key
    String query = "  SELECT  s_code_treatkind.treatkind_code ," + 
     "          s_code_treatkind.treatkind_name, " +
     "	    s_code_treatkind.treatkind_code key_treatkind_code " +  // key를 update하기위한 보조key
     "    FROM s_code_treatkind " +
     "      ORDER BY s_code_treatkind.treatkind_code          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>