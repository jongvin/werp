<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_gauce_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sysdate1",GauceDataColumn.TB_STRING,20));
    String query = "Select	to_char(sysdate,'yyyy.mm.dd hh24:mi:ss') sysdate1     From	dual        ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>