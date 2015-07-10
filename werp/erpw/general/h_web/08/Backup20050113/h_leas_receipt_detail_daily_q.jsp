<%@ page session="true" contentType="text/html;charset=EUC_KR"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
  String arg_dept_code = req.getParameter("arg_dept_code");
  String arg_sell_code = req.getParameter("arg_sell_code");
  String arg_dongho = req.getParameter("arg_dongho");
  String arg_seq = req.getParameter("arg_seq");
  String arg_contract_date = req.getParameter("arg_contract_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
	 dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("del",GauceDataColumn.TB_STRING,8));
    String query = "select income.dongho,"+
	 "        income.seq,"+
	 "        to_char(income.guarantee_receipt_date,'yyyy.mm.dd') receipt_date," + 
	 "        to_char(income.contract_date,'yyyy.mm.dd') contract_date," + 
     "       sum(nvl(income.r_amt, 0)) + sum(nvl(income.delay_amt , 0)) - sum(nvl(income.discount_amt, 0)) amt," +
	 "       '삭제' del " +
     "  from h_leas_guarantee_income income" + 
     " where income.dept_code = '" + arg_dept_code + "'" +
     "   and income.sell_code = '" + arg_sell_code + "'" +
     "	and income.dongho    = '" + arg_dongho + "'" +
     "	and income.seq       = '" + arg_seq + "'" +
	 "  and income.contract_date = '" + arg_contract_date +"'"+
     " group by income.dongho,"+
	 "                income.seq,"+
	 "                income.guarantee_receipt_date," + 
	 "                income.contract_date" +
     " order by income.guarantee_receipt_date     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>