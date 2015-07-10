<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_section = req.getParameter("arg_section");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("waste_matter_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("key_waste_matter_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("waste_matter_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT a.waste_matter_code,														" + 
     "                       a.waste_matter_code key_waste_matter_code,							" + 
     "                       a.section,																	" + 
     "                       a.waste_matter_name        												" +
     "                  FROM v_waste_matter_code a    												" +
     "                 WHERE a.section='" + arg_section + "' 										" +
     "              ORDER BY a.section ASC,																" + 
     "                       a.waste_matter_code ASC         										";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>