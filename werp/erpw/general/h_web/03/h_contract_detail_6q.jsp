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
     dSet.addDataColumn(new GauceDataColumn("rate_kind",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_rate_kind",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cutoff_std",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cutoff_unit",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SELL_CODE,   " + 
     "                       DONGHO,   " + 
     "                       SEQ,   " + 
     "                       RATE_KIND,   " + 
     "                       RATE_KIND   key_rate_kind,   " + 
     "                       to_char(S_DATE,'YYYY.MM.DD') s_date,   " + 
     "                       to_char(S_DATE,'YYYY.MM.DD') key_s_date,   " + 
     "                       to_char(E_DATE,'YYYY.MM.DD') e_date,   " + 
     "                       RATE,   " + 
     "                       CUTOFF_STD,   " + 
     "                       CUTOFF_UNIT  " + 
     "                  FROM H_SALE_DISCOUNT_RATE  " + 
     "                 WHERE ( dept_code = '" + arg_dept_code + "' ) AND  " + 
     "                       ( sell_code = '" + arg_sell_code + "' ) AND  " + 
     "                       ( dongho = '" + arg_dongho + "' ) AND  " + 
     "                       ( seq = '" + arg_seq + "' )   " + 
     "              ORDER BY RATE_KIND ASC,   " + 
     "                       S_DATE ASC,   " + 
     "                       E_DATE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>