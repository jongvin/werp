<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("private_sq",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("common_sq",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("etc_sq",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("parking_sq",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("service_sq",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("grand_sq",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("private_py",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("common_py",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("etc_py",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("parking_py",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("service_py",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("grand_py",GauceDataColumn.TB_DECIMAL,10,4));
     
	  String query = "SELECT NVL(e.private_square, 0) private_sq," + 
      " NVL(e.common_square, 0) common_sq, " +
      " NVL(e.etc_square, 0) etc_sq,									  " +
      " NVL(e.parking_square, 0) parking_sq,					" +
      " NVL(e.service_square, 0) service_sq,						 " +
      " NVL(e.grand_square, 0) grand_sq,									  " +
      " ROUND(NVL(e.private_square, 0)*0.3025,4) AS private_py, " +
      " ROUND(NVL(e.common_square, 0)*0.3025,4) AS common_py, " +
      " ROUND(NVL(e.etc_square, 0)*0.3025,4) AS etc_py, " +
      " ROUND(NVL(e.parking_square, 0)*0.3025,4) AS parking_py, " +
      " ROUND(NVL(e.service_square, 0)*0.3025,4) AS service_py,	 " +
      " ROUND(NVL(e.grand_square, 0)*0.3025,4) AS grand_py			" +
      " FROM H_SALE_MASTER a, 																						  " +
       "             H_BASE_PYONG_MASTER e																		" +
      " WHERE a.dept_code   = e.dept_code (+) 																	 " +
      " AND a.sell_code   = e.sell_code (+)																						" +
      " AND a.pyong       = e.pyong (+)																											  " +
      " AND a.style       = e.style (+)																														 " +
      " AND a.CLASS       = e.CLASS (+)																													" +
      " AND a.option_code = e.option_code (+)																										 " +
      " AND a.dept_code = "+"'"+arg_dept_code +"'"+
      " AND a.sell_code = "+"'"+arg_sell_code	+"'"+
      " AND a.dongho    = "+"'"+arg_dongho		  +"'"+
       " AND a.seq       = "+"'"+arg_seq+"'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>