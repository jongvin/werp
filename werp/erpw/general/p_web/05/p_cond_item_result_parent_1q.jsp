<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
    String arg_no_seq = req.getParameter("arg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  p_cond_item_result_parent.no_seq ," + 
     "          p_cond_item_result_parent.name     FROM p_cond_item_result_parent        " + 
     "         where no_seq > " + arg_no_seq + " " + 
     "   order by no_seq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>