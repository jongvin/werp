<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
  String arg_work_seq     = req.getParameter("arg_work_seq");
     
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
     stmt = conn.prepareCall("{call Y_Sp_H_Batch_income_imp_data(?)}");
	  stmt.setString(1,arg_work_seq);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>



