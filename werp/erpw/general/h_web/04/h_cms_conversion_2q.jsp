<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
//  String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tmp_record",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT '                           ' tmp_record   " + 
     "                  FROM dual ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>