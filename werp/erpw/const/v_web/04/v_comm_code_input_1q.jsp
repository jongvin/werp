<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_section = req.getParameter("arg_section");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("comm_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("comm_name",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT a.comm_code,														" + 
     "                       a.section,													   " +
     "                       a.part_code,        											" + 
     "                       a.comm_name        											" +
     "                  FROM v_comm_code a   												" +
     "                 WHERE a.section ='" + arg_section + "'							" +
     "              ORDER BY a.section ASC,                              			" + 
     "                       a.comm_code ASC         										";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>