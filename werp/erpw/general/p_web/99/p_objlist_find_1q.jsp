<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_where = req.getParameter("arg_where");     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("work_year",GauceDataColumn.TB_STRING,18));     
    String query = "  SELECT distinct to_char(a.work_year,'yyyy.mm') work_year" + 
     "  						FROM p_order_obj_list a " +
     " " +  arg_where + " " +
     " order by to_char(a.work_year,'yyyy.mm') desc "  ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>