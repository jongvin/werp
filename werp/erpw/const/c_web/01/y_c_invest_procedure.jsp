<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code 	= req.getParameter("arg_dept_code");
     String arg_ad_date 	= req.getParameter("arg_ad_date");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_c_invest_process(?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_ad_date);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>