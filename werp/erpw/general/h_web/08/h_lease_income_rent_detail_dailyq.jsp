<%@ page session="true" contentType="text/html;charset=EUC_KR"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
  String arg_dept_code = req.getParameter("arg_dept_code");
  String arg_sell_code = req.getParameter("arg_sell_code");
  String arg_cont_date = req.getParameter("arg_cont_date");
  String arg_cont_seq = req.getParameter("arg_cont_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cont_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cont_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
	 dSet.addDataColumn(new GauceDataColumn("daily_seq",GauceDataColumn.TB_DECIMAL,18,0));
    dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("del",GauceDataColumn.TB_STRING,8));
	 dSet.addDataColumn(new GauceDataColumn("prt",GauceDataColumn.TB_STRING,8));
    String query = "select to_char(cont_date,'yyyy.mm.dd') cont_date,"+
	 "        cont_seq,"+
	 "        to_char(receipt_date,'yyyy.mm.dd') receipt_date," + 
	 "        daily_seq, "+
     "       amt," +
	 "       '삭제' del, " +
	 "       '입금표' prt "+
     "  from h_lease_rent_income_daily " + 
     " where dept_code = '" + arg_dept_code + "'" +
     "   and sell_code = '" + arg_sell_code + "'" +
     "	and cont_date    = '" + arg_cont_date + "'" +
     "	and cont_seq       = '" + arg_cont_seq + "'" +
	 " order by receipt_date, daily_seq     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>