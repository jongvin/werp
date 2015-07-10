<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_part = req.getParameter("arg_part");
     arg_part = arg_part + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("high_detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
    String query = "select a.no_seq," + 
     "       a.high_detail_code," + 
     "       a.detail_code," + 
     "       a.name," + 
     "       a.ssize," + 
     "       a.unit" + 
     "   from (" + 
     "      select no_seq * 100000 no_seq," + 
     "             high_detail_code," + 
     "             '     ' detail_code," + 
     "             name," + 
     "             '   ' ssize," + 
     "             '   ' unit" + 
     "         from y_stand_parent" + 
     "         where high_detail_code like '" + arg_part + "' " + 
     "      union all" + 
     "      select a.no_seq * 100000 ," + 
     "             a.high_detail_code," + 
     "             b.detail_code," + 
     "             b.name," + 
     "             b.ssize," + 
     "             b.unit" + 
     "          from  y_stand_parent a," + 
     "                y_stand_detail b" + 
     "          where a.high_detail_code = b.high_detail_code" + 
     "            and b.high_detail_code like '" + arg_part + "' ) A" + 
     "  ORDER BY a.no_seq,a.high_detail_code,a.detail_code     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>