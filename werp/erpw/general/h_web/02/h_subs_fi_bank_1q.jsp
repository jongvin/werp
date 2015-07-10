<%@ page session="true"  contentType="text/html; charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     //String arg_cust_code = req.getParameter("arg_cust_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("bank_code",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,240));
     String query = "  SELECT bank_main_code bank_code , bank_main_name  bank_name  FROM t_bank_main   ORDER BY bank_name";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>