<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("process_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       to_char(YYMMDD,'YYYY.MM.DD') yymmdd,   " + 
     "                       MTRCODE,   " + 
     "                       DITAG,   " + 
     "                       NAME,    " +
     "                       SSIZE, " +
     "                       UNITCODE, " +
     "                       QTY,   " + 
     "                       UNITPRICE,   " + 
     "                       AMT,  " + 
     "                       PROCESS_YN " +
     "                  FROM M_INVEST_PARENT  " + 
     "                 WHERE DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   AND YYMMDD = " + "'" + arg_date + "'" + 
     "              ORDER BY DITAG ASC,   " + 
     "                       MTRCODE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>