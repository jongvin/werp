<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class = req.getParameter("arg_class");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("pos_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("pos_tag1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT a.class,   " + 
     "                       a.code,   " + 
     "                       a.pos_tag,   " + 
     "                       a.pos_tag pos_tag1,	" +
     "                       a.name,   " + 
     "                       a.remark  " + 
     "                   FROM a_as_comm_code a " + 
     "                   WHERE a.class = '" + arg_class  + "' " + 
     "                   ORDER BY a.class ASC,   " + 
     "                            a.code ASC        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>