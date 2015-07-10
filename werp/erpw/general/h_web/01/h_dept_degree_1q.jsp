<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("degree_amt_rate",GauceDataColumn.TB_DECIMAL,13,0));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SELL_CODE,   " + 
     "                       CODE,   " + 
     "                       CODE   key_code,   " + 
     "                       CODE_NAME,   " + 
     "                       CLASS,  " + 
	  "                       to_char( AGREE_DATE, 'yyyy.mm.dd') agree_date, "+
	  "                       degree_amt_rate "+
     "                  FROM H_DEPT_DEGREE  " + 
     "                 WHERE DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "              	  AND SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "              ORDER BY CODE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>