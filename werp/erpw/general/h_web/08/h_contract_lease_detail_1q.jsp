<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_cont_date = req.getParameter("arg_cont_date");
 String arg_cont_seq = req.getParameter("arg_cont_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cont_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cont_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
    String query = "select d.dept_code," + 
     "       d.sell_code," + 
     "       to_char(d.cont_date,'yyyy.mm.dd') cont_date," + 
     "       d.cont_seq," + 
     "       d.dongho, " + 
     "       d.seq, " +
	  "       d.note, "+
     "       m.pyong" + 
     "  from h_lease_cont_dongho d," + 
     "       h_sale_master m" + 
     " where d.dept_code = '"+arg_dept_code+"'" + 
     "   and d.sell_code = '"+arg_sell_code+"'" + 
     "	and d.cont_date = '"+arg_cont_date+"'" + 
     "	and d.cont_seq  = "+arg_cont_seq+
     "	and d.dept_code = m.dept_code" + 
     "	and d.sell_code = m.sell_code" + 
     "	and d.dongho    = m.dongho" + 
     "	and d.seq       = m.seq     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>