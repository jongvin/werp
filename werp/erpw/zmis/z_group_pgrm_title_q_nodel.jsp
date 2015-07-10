<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_seq_key  = req.getParameter("arg_seq_key");
	 String arg_group_key  = req.getParameter("arg_group_key");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tot_cnt",GauceDataColumn.TB_DECIMAL, 18, 0));
    String query = "  SELECT  count(z_group_pgrm_content.group_seq_key) tot_cnt    FROM z_group_pgrm_content " + 
                   "   WHERE ( z_group_pgrm_content.group_seq_key = " + arg_seq_key + "  and z_group_pgrm_content.group_key=" + arg_group_key + ")       ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>