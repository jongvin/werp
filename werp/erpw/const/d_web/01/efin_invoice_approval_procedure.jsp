<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String arg_no = req.getParameter("arg_no");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call efin_invoice_approval_pkg.get_approval_num(?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_date);
      stmt.registerOutParameter(3, java.sql.Types.VARCHAR);
      stmt.executeQuery(); 
      String retult = stmt.getString(3);
      if (true) {
			throw new Exception(retult + "true");
		}
%><%@ 
include file="../../../comm_function/conn_procedure_end_return_value.jsp"%>