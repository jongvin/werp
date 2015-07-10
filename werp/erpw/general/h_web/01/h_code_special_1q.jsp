<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("special_agree",GauceDataColumn.TB_STRING,1000));
	  dSet.addDataColumn(new GauceDataColumn("special_agree2",GauceDataColumn.TB_STRING,1000));
    String query = "  SELECT DEPT_CODE,     " + 
     "                       SELL_CODE,     " + 
     "                       SPECIAL_AGREE,  " + 
	  "                       SPECIAL_AGREE2  " + 
     "                  FROM H_CONTRACT_SPECIAL  " + 
     "                 WHERE DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "              	  AND SELL_CODE = " + "'" + arg_sell_code + "'" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>