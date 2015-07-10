<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_union_code = req.getParameter("arg_union_code");
     String arg_union_id = req.getParameter("arg_union_id");
     String arg_union_seq = req.getParameter("arg_union_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("union_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_id",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_chg_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SELL_CODE,   " + 
     "                       UNION_CODE,   " + 
     "                       UNION_ID,   " + 
     "                       UNION_SEQ,   " + 
     "                       to_char(CHG_DATE,'YYYY.MM.DD') chg_date,   " + 
     "                       to_char(CHG_DATE,'YYYY.MM.DD') key_chg_date,   " + 
     "                       CHG_AMT  " + 
     "                  FROM H_UNIN_MEMBER_CHANGE  " + 
     "                 WHERE ( DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "                       ( SELL_CODE = " + "'" + arg_sell_code + "'" + " ) AND  " + 
     "                       ( UNION_CODE = " + "'" + arg_union_code + "'" + " ) AND  " + 
     "                       ( UNION_ID = " + "'" + arg_union_id + "'" + " ) AND  " + 
     "                       ( UNION_SEQ = " + "'" + arg_union_seq + "'" + " )   " + 
     "              ORDER BY CHG_DATE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>