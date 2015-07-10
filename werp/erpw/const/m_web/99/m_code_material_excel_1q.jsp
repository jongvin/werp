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
    String query = "select rownum no_seq," + 
     "       a.high_detail_code," + 
     "       a.detail_code," + 
     "       a.name," + 
     "       a.ssize," + 
     "       a.unit" + 
     "   from (" + 
     "      select 1 no_seq," + 
     "             mtrgrand high_detail_code," + 
     "             '     ' detail_code," + 
     "             name," + 
     "             '   ' ssize," + 
     "             '   ' unit" + 
     "         from m_code_material_high " + 
     "         where mtrgrand like '" + arg_part + "' " + 
     "      union all " + 
     "      select 1  no_seq ," + 
     "             a.mtrgrand," + 
     "             b.mtrcode," + 
     "             b.name," + 
     "             b.ssize," + 
     "             b.unitcode unit" + 
     "          from  m_code_material_high a," + 
     "                m_code_material b" + 
     "          where a.mtrgrand = b.mtrgrand " + 
     "            and b.mtrgrand like '" + arg_part + "' ) A" + 
     "  ORDER BY a.no_seq,a.high_detail_code,a.detail_code     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>