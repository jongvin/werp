<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
      String arg_dept_code = req.getParameter("arg_dept_code");
      String arg_sbcr_kind_tag = req.getParameter("arg_sbcr_kind_tag");
      String arg_sbcr_name = req.getParameter("arg_sbcr_name");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_useq",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("contract_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chrg_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("chrg_phone",GauceDataColumn.TB_STRING,20));

    String query = "select													" +
						"	a.sbcr_useq ,										" +
						"	a.sbcr_code ,										" +
						"	a.sbcr_name ,										" +
						"	a.contract_name ,									" +
						"	a.chrg_name ,										" +
						"	a.chrg_phone 										" +
						" from a_as_sbcr a									" +
						" where dept_code = '"+arg_dept_code+"' and	" +
						" sbcr_name like '%"+arg_sbcr_name+"%'	and   " +
						" sbcr_kind_tag = "+arg_sbcr_kind_tag+"		" ;
	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>