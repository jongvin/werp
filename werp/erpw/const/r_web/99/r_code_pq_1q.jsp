<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pq_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("key_pq_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("pq_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("received_usetag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  pq_code ," + 
     "								pq_code key_pq_code, " +
     "          					pq_name ," +
     "         					received_usetag " +
     "    					 FROM r_code_pq     " + 
     "          		order by  pq_code asc  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>