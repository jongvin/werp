<%@ page session="true" contentType="text/html;charset=EUC_KR"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
  String arg_dept_code = req.getParameter("arg_dept_code");
  String arg_sell_code = req.getParameter("arg_sell_code");
  String arg_dongho = req.getParameter("arg_dongho");
  String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
	 dSet.addDataColumn(new GauceDataColumn("daily_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("del",GauceDataColumn.TB_STRING,8));
	 dSet.addDataColumn(new GauceDataColumn("prt",GauceDataColumn.TB_STRING,8));
    String query = "select dongho,"+
	 "        seq,"+
	 "        to_char(receipt_date,'yyyy.mm.dd') receipt_date," + 
	 "        daily_seq, "+
     "       amt," +
	 "       '삭제' del, " +
	  "       '입금표' prt "+
     "  from h_sale_ontime_income_daily " + 
     " where dept_code = '" + arg_dept_code + "'" +
     "   and sell_code = '" + arg_sell_code + "'" +
     "	and dongho    = '" + arg_dongho + "'" +
     "	and seq       = '" + arg_seq + "'" +
     " order by receipt_date, daily_seq     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>