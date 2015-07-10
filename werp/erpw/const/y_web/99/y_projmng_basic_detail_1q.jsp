<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_code = req.getParameter("arg_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("key_detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("acntcode",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("input_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT WBS_CODE,   " + 
     "                       DETAIL_CODE,   " + 
     "                       DETAIL_CODE key_detail_code,   " + 
     "                       NAME,   " + 
     "                       SSIZE,   " + 
     "                       UNIT,   " + 
     "                       PRICE,   " + 
     "                       REMARK,   " + 
     "                       ACNTCODE,   " + 
     "                       NOTE,   " + 
     "                       to_char(INPUT_DT,'YYYY.MM.DD') INPUT_DT,   " + 
     "                       INPUT_NAME  " + 
     "                  FROM Y_PROJMNG_BASIC   " + 
     "                 WHERE wbs_code = " + "'" + arg_code + "'" +
     "              ORDER BY wbs_code asc,detail_code asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>