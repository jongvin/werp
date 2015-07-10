<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
   String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
	 String arg_yyyymm = req.getParameter("arg_yyyymm");
	 String arg_proc_yn = req.getParameter("arg_proc_yn");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("receipt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("discount_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     
	  dSet.addDataColumn(new GauceDataColumn("imp_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("process",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("error_process",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("error_data",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("error_data_message",GauceDataColumn.TB_STRING,100));
	  dSet.addDataColumn(new GauceDataColumn("col_1",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("work_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "SELECT imp_id," + 
     "       dept_code," + 
     "       sell_code," + 
     "       dongho," + 
     "       seq," + 
     "       degree_code," + 
     "       to_char(receipt_date,'yyyy.mm.dd') receipt_date ," + 
     "       receipt_amt," + 
     "       delay_days," + 
     "       delay_amt," + 
	  "       discount_days," + 
     "       discount_amt," + 
     "       deposit_no," + 
     "       receipt_code," + 
     "       process," + 
     "       error_process," + 
     "       error_data," + 
     "       error_data_message, col_1, work_seq " + 
     "  FROM H_BATCH_INCOME_IMP_DATA" + 
     " WHERE dept_code = '"+arg_dept_code+"'" + 
     "   AND sell_code = '"+arg_sell_code+"'" + 
     "   AND TO_CHAR(receipt_date, 'yyyy.mm') = '"+arg_yyyymm+"'" + 
     "   AND process = '"+arg_proc_yn+"'" + 
     "ORDER BY COL_1" + 
     "        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>