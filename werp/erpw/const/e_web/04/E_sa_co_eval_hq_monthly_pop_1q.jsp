<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
   
	 String arg_dept_code = req.getParameter("arg_dept_code");
    String arg_order_number = req.getParameter("arg_order_number");
	 String arg_yymm = req.getParameter("arg_yymm");
	 String arg_part = req.getParameter("arg_part");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("part_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("item_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("or_item",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("or_point",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("d_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contents",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("ol_point",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("select_type",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = " select a.dept_code, " +
				   "		a.order_number, " +
				   "		to_char(a.yymm,'yyyymmdd') yymm, " +
				   "		a.part_code, " +
				   "		a.item_code, " +
				   "		a.seq, " +
				   "		a.part_name, " +
				   "		a.item_name, " +
				   "		a.or_item, " +
				   "		a.or_point, " +
				   "		b.d_seq, " +
				   "		b.contents, " +
				   "		b.or_point ol_point, " +
				   "		b.select_type, " +
				   "		b.remark  " +
				   " from e_comp_opinion_list a, e_comp_opinion_detail b " +
				   " where a.item_code=b.item_code and a.seq=b.seq and " +
				   "       a.dept_code = b.dept_code and a.yymm = b.yymm and " +
				   "       a.dept_code = '" + arg_dept_code + "' and " +
				   "	   a.yymm = '" + arg_yymm + "' and " +
				   "       a.order_number = b.order_number and " + 
				   "	   a.order_number = '" + arg_order_number + "' and " + 
				   "     a.part_code ='" + arg_part + "' " +
				   " order by a.item_code ASC, a.seq ASC, b.d_seq ASC ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>