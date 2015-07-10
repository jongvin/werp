<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)-
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
	 String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("receipt_seq",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("col_1",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("col_2",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("col_3",GauceDataColumn.TB_STRING,20));
	 dSet.addDataColumn(new GauceDataColumn("process",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("error_process",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("error_data",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("error_data_message",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     
    String query = "select dept_code," + 
     "       sell_code," + 
     "		 to_char(receipt_date,'yyyy.mm.dd') receipt_date," + 
     "		 receipt_seq," + 
     "		 dongho," + 
     "		 seq," + 
     "		 amt," + 
     "		 col_1," + 
     "		 col_2," + 
     "		 col_3," + 
      "            process, " + 
     "            error_process, " + 
     "            error_data, " + 
     "            error_data_message " + 
     "  from h_batch_loan_interest" + 
     " where dept_code = '"+arg_dept_code+"'" + 
     "   and sell_code = '"+arg_sell_code+"'" + 
     "	and to_char(receipt_date,'yyyy.mm.dd') like '"+arg_date+"'  order by receipt_date, receipt_seq";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>