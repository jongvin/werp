<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_year = req.getParameter("arg_year");
     String arg_chg_seq = req.getParameter("arg_chg_seq");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call SP_C_PROGRESS_RECALC(?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_year);
      stmt.setString(3,arg_chg_seq);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>