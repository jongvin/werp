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
     dSet.addDataColumn(new GauceDataColumn("unique_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_unique_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("effect_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("key_effect_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("delivery_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("creditor",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("bond_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cancel_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cancel_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("input_id",GauceDataColumn.TB_STRING,12));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SELL_CODE,   " + 
     "                       DONGHO,   " + 
     "                       SEQ,   " + 
     "                       UNIQUE_DIV,   " + 
     "                       UNIQUE_DIV   key_unique_div,   " + 
     "                       EFFECT_NO,   " + 
     "                       EFFECT_NO    key_effect_no,   " + 
     "                       to_char(DELIVERY_DATE,'YYYY.MM.DD') delivery_date,   " + 
     "                       CREDITOR,   " + 
     "                       BOND_AMT,   " + 
     "                       CANCEL_YN,   " + 
     "                       to_char(CANCEL_DATE,'YYYY.MM.DD') cancel_date,   " + 
     "                       REMARK , " + 
     "                       INPUT_ID " +
     "                  FROM H_SALE_ETC  " + 
     "                 WHERE ( DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "                       ( SELL_CODE = " + "'" + arg_sell_code + "'" + " ) AND  " + 
     "                       ( DONGHO = " + "'" + arg_dongho + "'" + " ) AND  " + 
     "                       ( SEQ = " + "'" + arg_seq + "'" + " )   " + 
     "              ORDER BY UNIQUE_DIV ASC,   " + 
     "                       EFFECT_NO ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>