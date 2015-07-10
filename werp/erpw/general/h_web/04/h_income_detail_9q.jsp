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
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_input_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_input_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("title",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("contents",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("record_duty_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("identify_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("finish_yn",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("memo_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SELL_CODE,   " + 
     "                       DONGHO,   " + 
     "                       nvl(SEQ,0) seq,   " + 
     "                       to_char(INPUT_DATE,'YYYY.MM.DD') input_date,   " + 
     "                       to_char(INPUT_DATE,'YYYY.MM.DD') key_input_date,   " + 
     "                       nvl(INPUT_SEQ,0)   key_input_seq,   " + 
     "                       nvl(INPUT_SEQ,0) input_seq,   " + 
     "                       TITLE,   " + 
     "                       CONTENTS,   " + 
     "                       RECORD_DUTY_ID,   " + 
     "                       to_char(IDENTIFY_DATE,'YYYY.MM.DD') identify_date,   " + 
     "                       FINISH_YN,  " + 
	 "                       memo_code "+
     "                  FROM H_SALE_MEMO  " + 
     "                 WHERE ( dept_code = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "                       ( sell_code = " + "'" + arg_sell_code + "'" + " ) AND  " + 
     "                       ( DONGHO = " + "'" + arg_dongho + "'" + " ) AND  " + 
     "                       ( SEQ = " + "'" + arg_seq + "'" + " )   " + 
     "              ORDER BY INPUT_DATE ASC,   " + 
     "                       INPUT_SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>