<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("text",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  m_code_main_material.mtrcode ," + 
     "          m_code_main_material.name ," + 
     "          m_code_main_material.ssize ," + 
     "          m_code_main_material.unitcode,     " +
     "          ' ' text     						" +
     "      FROM m_code_main_material      " +
     "  order by m_code_main_material.mtrcode  desc";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>