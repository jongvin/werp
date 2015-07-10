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
	 
    String query = "select d.dongho,"+
	 "        d.seq,"+
	 "        to_char(d.receipt_date,'yyyy.mm.dd') receipt_date," + 
	 "        d.daily_seq, "+
     "        d.amt," +
	 "       '입금표' prt, "+
	 "        (SELECT CASE WHEN SUM(NVL(i.work_no,-1)) >= 0 THEN '' ELSE '삭제' END    "+
	 "              FROM H_SALE_INCOME i 																																	 "+
	 "          WHERE  i.dept_code = d.dept_code   																												 "+
    "                                                             AND i.sell_code = d.sell_code	 		                                     "+
    "                                                              AND i.dongho    = d.dongho						 										 "+
    "                                                              AND i.seq       = d.seq											   								 "+
    "                                                              AND i.receipt_date = d.receipt_date					  							 "+
    "                                                              AND i.daily_seq    = d.daily_seq) del								  "+
	  "  from h_sale_income_daily d" + 
	  " where d.dept_code = '" + arg_dept_code + "'" +
     "   and d.sell_code = '" + arg_sell_code + "'" +
     "	and d.dongho    = '" + arg_dongho + "'" +
     "	and d.seq       = '" + arg_seq + "'" +
	  " order by d.receipt_date, d.daily_seq     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>