<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_dept_code = req.getParameter("arg_dept_code");
	String arg_order_number = req.getParameter("arg_order_number");
	String arg_sbcr_code_0 = req.getParameter("arg_sbcr_code_0");
	String arg_sbcr_code_1 = req.getParameter("arg_sbcr_code_1");
	String arg_sbcr_code_2 = req.getParameter("arg_sbcr_code_2");
	String arg_sbcr_code_3 = req.getParameter("arg_sbcr_code_3");
	String arg_sbcr_code_4 = req.getParameter("arg_sbcr_code_4");
	String arg_sbcr_code_5 = req.getParameter("arg_sbcr_code_5");
	String arg_sbcr_code_6 = req.getParameter("arg_sbcr_code_6");
	String arg_sbcr_code_7 = req.getParameter("arg_sbcr_code_7");
	String arg_sbcr_code_8 = req.getParameter("arg_sbcr_code_8");
	String arg_sbcr_code_9 = req.getParameter("arg_sbcr_code_9");
 //----------------------------------------------------------
	dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
	stmt = conn.prepareCall("{call y_sp_s_re_estimate(?,?,?,?,?,?,?,?,?,?,?,?)}");
	stmt.setString(1,arg_dept_code);
	stmt.setString(2,arg_order_number);
	stmt.setString(3,arg_sbcr_code_0);
	stmt.setString(4,arg_sbcr_code_1);
	stmt.setString(5,arg_sbcr_code_2);
	stmt.setString(6,arg_sbcr_code_3);
	stmt.setString(7,arg_sbcr_code_4);
	stmt.setString(8,arg_sbcr_code_5);
	stmt.setString(9,arg_sbcr_code_6);
	stmt.setString(10,arg_sbcr_code_7);
	stmt.setString(11,arg_sbcr_code_8);
	stmt.setString(12,arg_sbcr_code_9);
%><%@
include file="../../../comm_function/conn_procedure_end.jsp"%>