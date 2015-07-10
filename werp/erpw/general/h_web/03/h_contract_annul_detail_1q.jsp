<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_dongho     = req.getParameter("arg_dongho");
 String arg_seq            = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ap_cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("ap_cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ap_cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("ap_pay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("col1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("col2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("col3",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("date1",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("date2",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("num1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("num2",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "SELECT DEPT_CODE, " + 
     "       SELL_CODE, " + 
     "       DONGHO, " + 
     "       SEQ, " + 
     "       DETAIL_SEQ, " + 
     "       AP_CUST_CODE, " + 
     "       AP_CUST_NAME, " + 
     "       AP_CUST_DIV, " + 
     "       AP_PAY_AMT, " + 
     "       COL1, " + 
     "       COL2, " + 
     "       COL3, " + 
     "       DATE1, " + 
     "       DATE2, " + 
     "       NUM1, " + 
     "       NUM2" + 
     "  FROM H_SALE_ANNUL_DETAIL" + 
     " WHERE dept_code = '"+arg_dept_code+"'" + 
     "   AND sell_code = '"+arg_sell_code+"'" + 
     "   AND dongho    = '"+arg_dongho+"'" + 
     "   AND seq       = '"+arg_seq+"'"+
	  " order by detail_seq" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>