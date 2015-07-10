<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_name = req.getParameter("arg_name");
     arg_name = "%" + arg_name + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("res_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("mat_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("high_detail_code",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT  y_stand_detail.detail_code ," + 
     "          res_class ," + 
     "          mat_code ," + 
     "          name ," + 
     "          ssize ," + 
     "          unit,high_detail_code     FROM y_stand_detail  " + 
     "       WHERE NAME like " + "'" + arg_name + "' " + 
     "        or   detail_code like " + "'" + arg_name + "' " + 
     "       order by y_stand_detail.detail_code";  
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>