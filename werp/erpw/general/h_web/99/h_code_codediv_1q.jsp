<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("code_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code_div_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT  h_code_codediv.code_div ," + 
     "          h_code_codediv.code_div_name     FROM h_code_codediv         " + 
     "          ORDER BY h_code_codediv.code_div         " ;  
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>