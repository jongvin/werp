<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("d_seq",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("item_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("item_size",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("item_qty",GauceDataColumn.TB_DECIMAL,10,3));
     dSet.addDataColumn(new GauceDataColumn("item_price",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("dis_amt",GauceDataColumn.TB_DECIMAL,13,0));
    String query = "  SELECT a.dept_code, " +
      " 							   a.seq, " +
		"	 							a.d_seq, " +
		"	 							a.item_name, " +
		"	 							a.item_size, " +
		"	 							a.item_qty, " +
		"	 							a.item_price, " +
		"	 							a.dis_amt " +
  		"						  FROM e_disaster_report_detail_item a " + 
     "                   WHERE a.dept_code ='" + arg_dept_code + "'  " + 
     "                         and a.seq ='" + arg_seq + "' " +
     "                   ORDER BY a.dept_code ASC,   " + 
     "                            a.seq ASC,   " + 
     "                            a.d_seq ASC        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>