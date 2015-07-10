<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_code      = req.getParameter("arg_code");
     String arg_ditag     = req.getParameter("arg_ditag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("month",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("temp_month",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_month",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pre_bd_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pre_bd_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("this_bd_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("this_bd_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       MTRCODE,   " + 
     "                       DITAG,   " + 
     "                       to_char(MONTH,'YYYY.MM.DD') MONTH,   " + 
     "                       to_char(MONTH,'YYYY.MM') temp_MONTH,   " + 
     "                       to_char(MONTH,'YYYY.MM.DD') KEY_MONTH,   " + 
     "                       PRE_BD_QTY,   " + 
     "                       PRE_BD_AMT,   " + 
     "                       THIS_BD_QTY,   " + 
     "                       THIS_BD_AMT  " + 
     "                  FROM M_MONTH_PLAN  " + 
     "                 WHERE ( DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "                       ( MTRCODE = " + "'" + arg_code + "'" + " ) AND  " + 
     "                       ( DITAG = " + "'" + arg_ditag + "'" + " )   " +
     "               order by month asc";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>