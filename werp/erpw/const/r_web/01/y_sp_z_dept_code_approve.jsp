<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_unq_num = req.getParameter("arg_unq_num");
     String arg_dept_tag = req.getParameter("arg_dept_tag");
     String arg_comp_code = req.getParameter("arg_comp_code");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_z_dept_code_approve(?,?,?)}");
      stmt.setString(1,arg_unq_num);
      stmt.setString(2,arg_dept_tag);
      stmt.setString(3,arg_comp_code);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>