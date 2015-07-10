<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("key_mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("key_ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bd_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("bd_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.MTRCODE,   " + 
     "                       a.MTRCODE  key_mtrcode,   " + 
     "                       a.DITAG,   " + 
     "                       a.DITAG    key_ditag,   " + 
     "                       a.BD_QTY,   " + 
     "                       a.BD_AMT,   " + 
     "                       decode(a.mtrcode,'00100510','레미콘류',decode(a.mtrcode,'00100110','철근류',b.NAME)) name,   " + 
     "                       b.SSIZE,   " + 
     "                       b.UNITCODE  " + 
     "                  FROM M_PLAN  a,   " + 
     "                       M_CODE_MATERIAL  b" + 
     "                 WHERE a.MTRCODE = b.MTRCODE (+)" + 
     "                   AND a.dept_code = " + "'" + arg_dept_code + "'" +
     "              ORDER BY a.MTRCODE ASC ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>