<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("request_r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exchange_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("process_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SELL_CODE,   " + 
     "                       DONGHO,   " + 
     "                       SEQ,   " + 
     "                       REQUEST_DATE,   " + 
     "                       REQUEST_R_AMT,   " + 
     "                       EXCHANGE_DATE,   " + 
     "                       PROCESS_YN  " + 
     "                  FROM H_SALE_FUND  " + 
     "                 WHERE ( dept_code = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "                       ( sell_code = " + "'" + arg_sell_code + "'" + " ) AND  " + 
     "                       ( DONGHO = " + "'" + arg_dongho + "'" + " ) AND  " + 
     "                       ( SEQ = " + "'" + arg_seq + "'" + " )   " + 
     "                 ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>