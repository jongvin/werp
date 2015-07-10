<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("union_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_id",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("t_cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("union_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.UNION_CODE,   " + 
     "                       a.UNION_ID,   " + 
     "                       a.UNION_SEQ,   " + 
     "                       a.CUST_CODE,   " + 
     "                       a.cust_code t_cust_code,   " + 
     "                       to_char(a.CONTRACT_DATE,'YYYY.MM.DD') contract_date,   " + 
     "                       b.CUST_NAME,   " + 
     "                       c.UNION_NAME  " + 
     "                  FROM H_UNIN_MEMBER a,   " + 
     "                       H_CODE_CUST b,   " + 
     "                       H_UNIN_LEDGER c " + 
     "                 WHERE a.CUST_CODE = b.CUST_CODE " + 
     "                   AND a.DEPT_CODE = c.DEPT_CODE " + 
     "                   AND a.SELL_CODE = c.SELL_CODE " + 
     "                   AND a.UNION_CODE = c.UNION_CODE " + 
     "                   AND a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   AND a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "              ORDER BY a.UNION_CODE ASC,   " + 
     "                       a.UNION_ID ASC,   " + 
     "                       a.UNION_SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>